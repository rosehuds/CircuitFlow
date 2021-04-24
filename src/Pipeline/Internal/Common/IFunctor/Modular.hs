{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE PolyKinds             #-}
module Pipeline.Internal.Common.IFunctor.Modular where

import           Pipeline.Internal.Common.IFunctor (IFunctor7 (..))

import           Data.Kind                         (Type)

data (iF :+: iG) (f' :: k -> j -> i -> k -> j -> i -> l -> Type) (a :: k) (b :: j) (c :: i) (d :: k) (e :: j) (f :: i) (g :: l) where
  L ::iF f' a b c d e f g -> (iF :+: iG) f' a b c d e f g
  R ::iG f' a b c d e f g -> (iF :+: iG) f' a b c d e f g

infixr :+:

instance (IFunctor7 iF, IFunctor7 iG) => IFunctor7 (iF :+: iG) where
  imap7 f (L x) = L (imap7 f x)
  imap7 f (R y) = R (imap7 f y)
  imapM7 f (L x) = do
    x' <- imapM7 f x
    return (L x')
  imapM7 f (R y) = do
    y' <- imapM7 f y
    return (R y')


class (IFunctor7 iF, IFunctor7 iG) => iF :<: iG where
  inj :: iF f' a b c d e f g -> iG f' a b c d e f g

instance IFunctor7 iF => iF :<: iF where
  inj = id

instance {-# OVERLAPPING #-} (IFunctor7 iF, IFunctor7 iG) => iF :<: (iF :+: iG) where
  inj = L

instance (IFunctor7 iF, IFunctor7 iG, IFunctor7 iH, iF :<: iG) => iF :<: (iH :+: iG) where
  inj = R . inj