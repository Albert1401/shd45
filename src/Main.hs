module Main where
import Tokens
import Grammar
import System.Environment
import Checker
import Data.List.Split
import qualified Data.HashMap.Strict as Map
import Control.Monad.State.Strict as ST
import qualified Data.Vector as Vect

help :: String -> Int -> String -> [String]
help "" _ []  = []
help acc _ []  = [acc]
help acc 0 (',' : chs) = acc : help "" 0 chs
help acc n ('(' : chs) = help (acc ++ "(") (n+1) chs
help acc n (')' : chs) = help (acc ++ ")") (n-1) chs
help acc n (a : chs) = help (acc ++ [a]) n chs

parse :: String -> Expr
parse = parseExpr . scanTokens

main :: IO ()
main = do
    path <- getLine
    file <- readFile $ "HW4/correct"++ path ++".in"
    let hh = splitOn "|-" $ head $ lines file
    print $ map parse $ help "" 0 $ head hh
    let assumptions = Vect.fromList (zip (map parse $ help "" 0 $ head hh) [1..])
    print assumptions
    --mapM_ (print .
    let (res, (a, b)) = ST.runState (check assumptions (Vect.fromList ( zip (map parse $ tail $ lines file) [1..]))) (Vect.empty, Vect.empty)
    print res
    mapM_ (\((exp, num), str) -> print (exp, str)) $! Vect.zip a b



