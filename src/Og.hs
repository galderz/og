module Og
( build
, dispatch
) where

import Data.Char

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
dispatch =  [ ("build", build)  
            -- , ("test", view)  
            -- , ("remove-topic", removeTopic)  
            ]  

-- TODO: Check if there's a pom.xml, or a gradle build file and adjuts accordingly
-- TODO: Allow passing native options to build, i.e. -M-PjmxDoc (Maven)
-- TODO: Split individual projects for Maven -pl 

build :: [String] -> [String]  
build [] = ["mvn -Dmaven.test.skip.exec=true install"]
build ["-c"] = ["mvn clean", "mvn -Dmaven.test.skip.exec=true install"]
build [x:xs] = ["mvn -Dmaven.test.skip.exec=true install -pl " ++ projectList(x:xs)]
build ["-c", projects] = ["mvn clean", "mvn -Dmaven.test.skip.exec=true install -pl " ++ projectList(projects)]
build _ = ["<invalid>"] 
-- build ["-c"] = ["mvn clean", "mvn -Dmaven.test.skip.exec=true install"] 

projectList :: [Char] -> [Char]
projectList xs = [if isSpace x then ',' else toLower x | x<-xs]

-- command :: [String] -> [String]
-- command args