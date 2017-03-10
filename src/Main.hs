module Main where
import Data.Monoid
import Tokens
import Grammar

main :: IO ()
main = do
    let a = parseExpr $ scanTokens "x -> a123&y -> h"
    putStrLn $ show a