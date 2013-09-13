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
      build [] `shouldBe` ["mvn -Dmaven.test.skip.exec=true install"]

    it "a given set of modules without executing tests" $ do
      build ["a", "b", "c"] `shouldBe` ["mvn -Dmaven.test.skip.exec=true install -pl a,b,c"]

    it "and cleans a project without executing tests" $ do
      build ["-c"] `shouldBe` ["mvn clean", "mvn -Dmaven.test.skip.exec=true install"]
