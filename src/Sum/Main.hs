module Main where

import Tokens
import Grammar
import SumPatterns
import System.Environment
import Data.List

repl :: [(Char,String)] -> String -> String
repl arr = concatMap (chStr arr) where
    chStr arr ch = case lookup ch arr of
            (Just s) -> s
            Nothing -> [ch]

help a am = concat [map (repl [('s', a ++ "+" ++ b), ('q', s)]) incEq
            ,map (repl [('s', a ++ "+" ++ b ++ "'"), ('q', "(" ++ a ++ "+" ++ b ++ ")'")]) eq
            ,map (repl [('s', a), ('q', b), ('p', s ++ "'")]) assocLeft
            , [a ++ "+" ++ b ++ "'=" ++ s ++ "'"]]
        where
          b = "0" ++ replicate am '\''
          s = a ++ replicate am '\''

f a "0" = []
f a b = map (repl [('s', a), ('q', (init b))]) extrInc ++ f a (init b)



main = do
    [a, b] <-getArgs
    let head = "|-" ++ a ++ "+"++ b ++ "=" ++ "0" ++ replicate ((-2) + length a + length b) '\''
    let proof = [head]
            ++ allBIncExtract
            ++ f a b
            ++ allImplIncEq
            ++ ["@a(a+0)=a->" ++ a ++ "+0=" ++ a]
            ++ [a ++ "+0=" ++ a]
            ++ concatMap (help a) [0..((-2) + length b)]
    writeFile "sum.txt" (intercalate "\n" proof)
    return ()