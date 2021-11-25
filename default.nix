{ mkDerivation, base, bytestring, cassava, clock, containers
, criterion, deepseq, directory, either, filepath, lib, lifted-base
, monad-loops, mtl, process, tasty, tasty-hunit, time, transformers
, Unique, uuid, vector
}:
mkDerivation {
  pname = "circuitflow";
  version = "0.3.0.1";
  src = ./.;
  libraryHaskellDepends = [
    base bytestring cassava containers deepseq directory either
    filepath lifted-base monad-loops mtl transformers uuid vector
  ];
  testHaskellDepends = [
    base containers lifted-base mtl tasty tasty-hunit
  ];
  benchmarkHaskellDepends = [
    base cassava clock criterion process time transformers Unique
    vector
  ];
  homepage = "https://github.com/RileyEv/project";
  license = lib.licenses.bsd3;
  hydraPlatforms = lib.platforms.none;
}
