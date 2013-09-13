module Main (main) where

import Og
import System.Environment 

main :: IO [()]
main = do
    (command:args) <- getArgs
    putStrLn "The arguments are:"  
    mapM putStrLn args
    let (Just action) = lookup command dispatch  
    mapM putStrLn $ action args   
