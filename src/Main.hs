module Main where
import Tokens
import Grammar
import System.Environment
import Checker
import Data.List
import Data.List.Split
import qualified Data.HashMap.Strict as Map
import Control.Monad.State.Strict as ST
import Data.ByteString.UTF8(fromString, toString)
import Prelude hiding (putStrLn)
import Data.ByteString.Char8 (putStrLn)

parseHead :: String -> Int -> String -> ([String], String)
parseHead acc _ []  = ([], acc)
parseHead acc 0 (',' : chs) = let
    (a,b) = parseHead "" 0 chs
     in (acc : a, b)
parseHead acc n ('(' : chs) = parseHead (acc ++ "(") (n+1) chs
parseHead acc n (')' : chs) = parseHead (acc ++ ")") (n-1) chs
parseHead acc n (a : chs) = parseHead (acc ++ [a]) n chs

parse :: String -> Expr
parse = parseExpr . scanTokens

lastCheck res narr te | res /= fromString "ОК" = putStrLn $ fromString $ "Вывод некорректен начиная с формулы № "
                                                   ++ (show $ 1 + length narr) ++ (toString res)
lastCheck res narr te | res == fromString "ОК"
                        && (not $ null narr) = if head narr == te then do
                                                                putStrLn res
                                                                putStrLn $ fromString "Последняя формула совпадает с формулой в заголовке"
                                               else do
                                                  putStrLn res
                                                  putStrLn $ fromString "Последняя формула не совпадает с формулой в заголовке"



main :: IO ()
main = do
    [arg, arg2] <- getArgs
    file <- readFile arg
    let prfHead = splitOn "|-" $ head $ lines file
    let (assumptions, toright) = parseHead "" 0 $ head prfHead
    let toProve = if not $ null (prfHead !! 1) then parse (prfHead !! 1) else Zero
    if null toright then do
        let (res, arr) = ST.runState (check (map parse assumptions) (map parse $ filter (not . null) $ tail $ lines file)) []
        lastCheck res arr toProve
    else do
        let (res, (narr, oarr)) = ST.runState (checkDeduction (map parse assumptions) (parse toright)
                (map parse $ filter (not . null) $ tail $ lines file)) ([],[])
        let newHead = intercalate "," assumptions ++ "|-(" ++ toright ++ ")->(" ++ show toProve ++ ")\n"
        writeFile arg2 $ newHead ++ concatMap (\x -> show x ++ "\n")  (reverse narr)
        lastCheck res oarr toProve







