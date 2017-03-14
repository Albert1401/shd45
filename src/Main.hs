module Main where
import Tokens
import Grammar
import System.Environment
import Checker
import Data.List
import Data.List.Split
import qualified Data.HashMap.Strict as Map
import Control.Monad.State.Strict as ST

help :: String -> Int -> String -> ([String], String)
help acc _ []  = ([], acc)
help acc 0 (',' : chs) = let
    (a,b) = help "" 0 chs
     in (acc : a, b)
help acc n ('(' : chs) = help (acc ++ "(") (n+1) chs
help acc n (')' : chs) = help (acc ++ ")") (n-1) chs
help acc n (a : chs) = help (acc ++ [a]) n chs

parse :: String -> Expr
parse = parseExpr . scanTokens

main :: IO ()
main = do
    [arg] <- getArgs
    file <- readFile $ "HW4/incorrect" ++ arg ++ ".in"
--    file <- readFile $ "output.out"
    let prfHead = splitOn "|-" $ head $ lines file
    let (assumptions, toright) = help "" 0 $ head prfHead
    if null toright then do
         let (res, arr) = ST.runState (check (map parse assumptions) (map parse $ tail $ lines file)) []
         mapM_ (putStrLn . (++) "\n" . show) (reverse arr)
         print $ length arr
         print res
    else do
        let left = prfHead !! 1
        let (res, (narr, oarr)) = ST.runState (checkDeduction (map parse assumptions) (parse toright) (map parse $ tail $ lines file)) ([],[])
        print res
        let newHead = intercalate "," assumptions ++ "|-" ++ toright ++ "->" ++ left ++ "\n"
        writeFile "output.out" $ newHead ++ concatMap (\x -> show x ++ "\n")  (reverse narr)




