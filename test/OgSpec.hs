module OgSpec 
( main
, spec
) where

import Og
import Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "Og builds" $ do
    it "a project without executing tests" $ do
      build Maven [] `shouldBe` ["mvn -Dmaven.test.skip.exec=true install"]

    it "a given set of modules without executing tests" $ do
      build Maven ["a", "b", "c"] `shouldBe` 
        ["mvn -Dmaven.test.skip.exec=true install -pl a,b,c"]

    it "and cleans a project without executing tests" $ do
      build Maven ["-c"] `shouldBe` 
        ["mvn clean", "mvn -Dmaven.test.skip.exec=true install"]

    it "and cleans a given set of modules without executing tests" $ do
      build Maven ["-c", "d", "e"] `shouldBe` 
        ["mvn clean", "mvn -Dmaven.test.skip.exec=true install -pl d,e"]
      