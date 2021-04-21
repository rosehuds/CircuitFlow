module Pipeline.Network.MinimalTests
  ( minimalTests
  ) where

import           Pipeline
import           Pipeline.Network.Helper
import           Pipeline.Network.HelperCircuit
import           Prelude                        hiding (id, replicate, (<>))
import           Test.Tasty
import           Test.Tasty.HUnit

minimalTests :: TestTree
minimalTests = testGroup
  "Minimal Examples"
  [ idTests
  , replicateTests
  , thenTests
  , besideTests
  , swapTests
  , dropLTests
  , dropRTests
  , functionTaskTests
  , multiInputTaskTests
  , mapTests
  ]


-- Tests for the 'Id' constructor
idCircuit
  :: Circuit
       '[VariableStore]
       '[Int]
       '[VariableStore Int]
       '[VariableStore]
       '[Int]
       '[VariableStore Int]
       N1
idCircuit = id

idTests :: TestTree
idTests = testGroup
  "id should"
  [ testCase "return the same value input" $ do
      let i = HCons' (Var 0) HNil'
      o <- singleInputTest idCircuit i
      o @?= Right i
  ]

-- Tests for the 'Replicate' constructor
replicateCircuit
  :: Circuit
       '[VariableStore]
       '[Int]
       '[VariableStore Int]
       '[VariableStore , VariableStore]
       '[Int , Int]
       '[VariableStore Int , VariableStore Int]
       N1
replicateCircuit = replicate

replicateTests :: TestTree
replicateTests = testGroup
  "replicate should"
  [ testCase "return a duplicated input value" $ do
      let i = HCons' (Var 0) HNil'
      o <- singleInputTest replicateCircuit i
      o @?= Right (HCons' (Var 0) (HCons' (Var 0) HNil'))
  ]

-- Tests for the 'Then' constructor
thenCircuit
  :: Circuit
       '[VariableStore]
       '[Int]
       '[VariableStore Int]
       '[VariableStore]
       '[Int]
       '[VariableStore Int]
       N1
thenCircuit = id <-> id

thenTests :: TestTree
thenTests = testGroup
  "<-> should"
  [ testCase "return a return the same input value" $ do
      let i = HCons' (Var 0) HNil'
      o <- singleInputTest thenCircuit i
      o @?= Right i
  ]

-- Tests for the 'Beside' constructor
besideCircuit
  :: Circuit
       '[VariableStore , VariableStore]
       '[Int , String]
       '[VariableStore Int , VariableStore String]
       '[VariableStore , VariableStore]
       '[Int , String]
       '[VariableStore Int , VariableStore String]
       N2
besideCircuit = id <> id

besideTests :: TestTree
besideTests = testGroup
  "<> should"
  [ testCase "return a return the same input value" $ do
      let i = HCons' (Var 0) (HCons' (Var "abc") HNil')
      o <- singleInputTest besideCircuit i
      o @?= Right i
  ]


-- Tests for the 'Swap' constructor
swapCircuit
  :: Circuit
       '[VariableStore , VariableStore]
       '[Int , String]
       '[VariableStore Int , VariableStore String]
       '[VariableStore , VariableStore]
       '[String , Int]
       '[VariableStore String , VariableStore Int]
       N2
swapCircuit = swap

swapTests :: TestTree
swapTests = testGroup
  "swap should"
  [ testCase "return a return the same input value" $ do
      let i = HCons' (Var 0) (HCons' (Var "abc") HNil')
      o <- singleInputTest swapCircuit i
      o @?= Right (HCons' (Var "abc") (HCons' (Var 0) HNil'))
  ]


-- Tests for the 'DropL' constructor
dropLCircuit
  :: Circuit
       '[VariableStore , VariableStore]
       '[Int , String]
       '[VariableStore Int , VariableStore String]
       '[VariableStore]
       '[String]
       '[VariableStore String]
       N2
dropLCircuit = dropL

dropLTests :: TestTree
dropLTests = testGroup
  "dropL should"
  [ testCase "return the input with the left side dropped" $ do
      let i = HCons' (Var 0) (HCons' (Var "abc") HNil')
      o <- singleInputTest dropLCircuit i
      o @?= Right (HCons' (Var "abc") HNil')
  ]

-- Tests for the 'DropR' constructor
dropRCircuit
  :: Circuit
       '[VariableStore , VariableStore]
       '[Int , String]
       '[VariableStore Int , VariableStore String]
       '[VariableStore]
       '[Int]
       '[VariableStore Int]
       N2
dropRCircuit = dropR

dropRTests :: TestTree
dropRTests = testGroup
  "dropR should"
  [ testCase "return a return the same input value" $ do
      let i = HCons' (Var 0) (HCons' (Var "abc") HNil')
      o <- singleInputTest dropRCircuit i
      o @?= Right (HCons' (Var 0) HNil')
  ]


-- Tests for the 'Task' constructor
functionTaskTests :: TestTree
functionTaskTests = testGroup
  "functionTask should"
  [ testCase "apply the function to the input value" $ do
      let i = HCons' (Var 0) HNil'
      o <- singleInputTest functionTaskCircuit i
      o @?= Right (HCons' (Var 1) HNil')
  ]


multiInputTaskTests :: TestTree
multiInputTaskTests = testGroup
  "swap should"
  [ testCase "apply the function to the input values" $ do
      let i = HCons' (Var 3) (HCons' (Var 5) HNil')
      o <- singleInputTest multiInputTaskCircuit i
      o @?= Right (HCons' (Var 8) HNil')
  ]

mapCircuit
  :: Circuit
       '[VariableStore]
       '[[Int]]
       '[VariableStore [Int]]
       '[VariableStore]
       '[[Int]]
       '[VariableStore [Int]]
       N1
mapCircuit = mapC functionTaskCircuit Empty

mapTests :: TestTree
mapTests = testGroup
  "map should"
  [ testCase "map a circuit on the input values" $ do
      let i = HCons' (Var [0, 1, 2, 3, 4, 5, 6, 7, 8]) HNil'
      o <- singleInputTest mapCircuit i
      o @?= Right (HCons' (Var [1, 2, 3, 4, 5, 6, 7, 8, 9]) HNil')
  ]