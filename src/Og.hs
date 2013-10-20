module Og
( build
, dispatch
, Tool(..)
) where

-- import Data.Char
import Data.List

data Tool = Maven | Gradle

-- module Main where

--import System.Environment 

-- main :: IO [()]
-- main = do
-- (command:args) <- getArgs
--    putStrLn "The arguments are:"  
--    mapM putStrLn args
--     let (Just action) = lookup command dispatch  
--     mapM putStrLn $ action args   

dispatch :: [(String, [String] -> [String])]  
dispatch =  [ ("build", build Maven)  
            -- , ("test", view)  
            -- , ("remove-topic", removeTopic)  
            ]  

-- TODO: Check if there's a pom.xml, or a gradle build file and adjuts accordingly
-- TODO: Allow passing native options to build, i.e. -M-PjmxDoc (Maven)
-- TODO: Split individual projects for Maven -pl 

build :: Tool -> [String] -> [String]  
build t [] = [buildAll t]
build t ("-c":[]) = [cleanAll t, buildAll t]
build t ("-c":pl) = [cleanAll t, unwords [buildAll t, listProjects t pl]]
build t (pl) = [unwords [buildAll t, listProjects t pl]]

cleanAll :: Tool -> String
cleanAll Maven = "mvn clean"
cleanAll Gradle = "gradle clean"

buildAll :: Tool -> String  
buildAll Maven = "mvn -Dmaven.test.skip.exec=true install"
buildAll Gradle = "gradle -xtest build"

listProjects :: Tool -> [String] -> String
listProjects Maven [] = ""
listProjects Maven pl = "-pl " ++ intercalate "," pl
listProjects Gradle _ = ""

-- projectList :: [Char] -> [Char]
-- projectList xs = [if isSpace x then ',' else toLower x | x<-xs]

-- command :: [String] -> [String]
-- command args