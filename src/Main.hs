module Main (main) where

import Data.List
import Og
import System.Process
import System.Environment 

main :: IO [()]
main = do
    (command:args) <- getArgs
    putStr $ "$ " ++ command ++ intercalate "," args  
    let (Just action) = lookup command dispatch  
    putStr $ " -> "  
    _ <- mapM putStrLn $ action args
    _ <- system $ concat $ action args
    return [()]
