module Checker where
import Grammar
import Control.Monad.IO.Class
import Tokens
import qualified Control.Monad.State.Strict as ST
import qualified Data.HashMap.Strict as Map
import Data.List
import qualified Data.HashSet as Set
import Patterns

data Result = No | Almost String | Matched Expr deriving Show

(<>) :: Result -> Result -> Result
a@(Matched _) <> _ = a
_ <> a@(Matched _) = a
a@(Almost s) <> _ = a
_ <> a@(Almost s) = a
_ <> _ = No

-- assumptions -> to check -> state (checked, Result)
check :: [] Expr -> [] Expr -> ST.State [Expr] Bool
check asmpts tocheck | null tocheck = return True
check asmpts tocheck = do
    let e = head tocheck
    checked <- ST.get
    case isAsmptn e asmpts <> is1_10 e <> is13_20 e <> is21 e <> is11_12 e <> isMP e checked <> isMP2 e checked <> isMP3 e checked of
        Matched _ -> do
                        ST.modify' ((:) e)
                        check asmpts (tail tocheck)
        (Almost s) -> do
                       --ST.modify' ((:) e)
                       return False
        No -> do
               --ST.modify' ((:) e)
               return False

-- assumptions -> toright -> to check -> state (new, old)
checkDeduction :: [] Expr -> Expr -> [] Expr -> (ST.State ([Expr], [Expr])) String
checkDeduction asmpts re tocheck | null tocheck = return ""
checkDeduction asmpts re tocheck = do
    let e = head tocheck
    (_, checked) <- ST.get
    case isAsmptn e asmpts <> is1_10 e <> is13_20 e <> is21 e <> is11_12 e of
       Matched _ -> do
            let help = map (parse . concatMap (replForAx re e)) helpForAx
            ST.modify' (\(n, o) -> (help ++ n, e : o))
            checkDeduction asmpts re (tail tocheck)
       _ -> if e == re then do
                         let help = map (parse . concatMap (replForEq re)) helpForEq
                         ST.modify' (\(n, o) -> (help ++ n, e : o))
                         checkDeduction asmpts re (tail tocheck)
             else case isMP e checked of
                    Matched l -> do
                      let help = map (parse . concatMap (replForMP re l e)) helpForMP
                      ST.modify' (\(n, o) -> (help ++ n, e : o))
                      checkDeduction asmpts re (tail tocheck)
                    No -> case isMP2 e checked of
                          Matched _ -> do
                              let (BinOp '>' (Qtfr '?' (Var vname) l) r) = e
                              if haveFree vname re then return "err"
                              else do
                                        let help = map (parse . concatMap (replForMP2 vname re l r)) helpForMP2
                                        ST.modify' (\(n, o) -> (help ++ n, e : o))
                                        checkDeduction asmpts re (tail tocheck)
                          Almost s -> return "err"
                          No -> case isMP3 e checked of
                              Matched _ -> do
                                let (BinOp '>' l (Qtfr '@' (Var vname) r)) = e
                                if haveFree vname re then return "err"
                                else do
                                          let help = map (parse . concatMap (replForMP3 vname re l r)) helpForMP3
                                          ST.modify' (\(n, o) -> (help ++ n, e : o))
                                          checkDeduction asmpts re (tail tocheck)
                              Almost s -> return "err"
                              No -> return "err"


isAsmptn :: Expr -> [] Expr -> Result
isAsmptn e asmptns = if elem e asmptns then Matched Zero else No

is1_10 :: Expr -> Result
is1_10 e =  let
         res = map (\x -> ST.evalState (lookAlike x e) Map.empty) schemes1
          in if not $ or res then No
          else Matched Zero

is13_20 :: Expr -> Result
is13_20 e = if elem e axioms then Matched Zero
            else No


isMP :: Expr -> [] Expr -> Result
isMP exp prfV = let
    rMP = filter isImpl prfV
    res = filter isLeft rMP
    extr (BinOp '>' toex _) = toex
     in if not $ null res then Matched $ extr $ head res
        else No
      where
        isImpl (BinOp '>' _ r) = r == exp
        isImpl _ = False
        isLeft (BinOp '>' l _) = elem l prfV
        isLeft _ = False

lookAlike :: Expr -> Expr -> ST.State (Map.HashMap String Expr) Bool
lookAlike (UnOp pch pe) (UnOp ch e) | pch == ch = lookAlike pe e
lookAlike (BinOp pop ple pre) (BinOp op le re) | pop == op = do
    l <- lookAlike ple le
    r <- lookAlike pre re
    return $ l && r
lookAlike (Funct 'P' name _) e = do
    mp <- ST.get
    case Map.lookup name mp of
                            (Just e') -> return $ e' == e
                            Nothing -> do
                                       ST.modify' (Map.insert name e)
                                       return True
lookAlike _ _ = return False



--Сет связующих переменных (в каждом узле разный) -> Выражение -> (Сет переменных имеюших св вх, и наоборот)
getFrees :: Set.HashSet String -> Expr -> ST.State (Set.HashSet String) ()
getFrees b (UnOp _ e) = getFrees b e
getFrees b (BinOp _ l r) = do
    getFrees b l
    getFrees b r
getFrees b (Funct _ _ args) = mapM_ (getFrees b) args
getFrees b (Qtfr _ (Var name) pred) = getFrees (Set.insert name b) pred
getFrees b (Var name) = if Set.member name b then return ()
                        else ST.modify' (Set.insert name)
getFrees b Zero = return ()



--Имя переменной -> Выражение исходное -> Выражние с подстановкой -> Сет связующих переменных в паттерне -> State подстановка ли это
isFree :: String -> Expr -> Expr -> Set.HashSet String -> ST.State (Map.HashMap String Expr) Bool
isFree vname pe e set | Set.member vname set = return $ pe == e
isFree vname (UnOp pop pe) (UnOp op e) set | pop == op = isFree vname pe e set
isFree vname (BinOp pop pl pr) (BinOp op l r) set | pop == op = do
    l' <- isFree vname pl l set
    r' <- isFree vname pr r set
    return $ l' && r'
isFree vname (Qtfr pop (Var pname) ppred) (Qtfr op (Var name) pred) set | pname == name && pop == op
    = isFree vname ppred pred (Set.insert pname set)
isFree vname (Funct pop pfname pargs) (Funct op fname args) set | pfname == fname && pop == op && length args == length pargs
    = if null args then return True
                   else do
                         res <- mapM (\(a, b) -> isFree vname a b set) $ zip pargs args
                         return $ and res
isFree vname (Var pname) e set | vname == pname = do
    let efree = ST.execState (getFrees Set.empty e) Set.empty
    if null $ Set.intersection set efree then do
                                                mp <- ST.get
                                                case Map.lookup vname mp of
                                                        (Just e') -> return $ e' == e
                                                        Nothing -> do
                                                                   ST.modify' (Map.insert vname e)
                                                                   return True
                                         else return False

isFree vname pe e _ = return $ pe == e

isFree1 :: String -> Expr -> Expr -> Bool
isFree1 vname l r = ST.evalState (isFree vname l r Set.empty) Map.empty

is11_12 :: Expr -> Result
is11_12 (BinOp '>' (Qtfr '@' (Var vname ) e) e') = if isFree1 vname e e' then Matched Zero
                                                   else Almost "Almost Ax 11"
is11_12 (BinOp '>' e' (Qtfr '?' (Var vname ) e)) = if isFree1 vname e e' then Matched Zero
                                                   else Almost "Almost Ax 12"
is11_12 _ = No

is21 :: Expr -> Result
is21 (BinOp '>' (BinOp '&' fi0 (Qtfr '@' (Var name) (BinOp '>' fi fix'))) fi') |
        (crct, mp) <- ST.runState (isFree name fi fi0 Set.empty) Map.empty
        , ans <- case Map.lookup name mp of
                (Just e) -> e == Zero
                Nothing -> False
        , (crct', mp') <- ST.runState (isFree name fi fix' Set.empty) Map.empty
        , ans' <- case Map.lookup name mp' of
                          (Just e) -> e == UnOp 'q' (Var name)
                          Nothing -> False
        , fi == fi' && crct' && crct && ans && ans'
        = if haveFree name fi then Matched Zero
                              else Almost "Almost Ax 21"
is21 _ = No


haveFree vname e = Set.member vname $ ST.execState (getFrees Set.empty e) Set.empty
isMP2 (BinOp '>' (Qtfr '?' (Var vname) l) r) prfV | any <- filter (\x -> BinOp '>' l r == x) prfV
                                                    = if not $ haveFree vname r then Matched Zero
                                                      else Almost "Almost M.P. 3"
isMP2 _ _ = No
isMP3 (BinOp '>' l (Qtfr '@' (Var vname) r)) prfV | any (\x -> BinOp '>' l r == x) prfV
                                                    = if not $ haveFree vname l then Matched Zero
                                                      else Almost "M.P. 2"
isMP3 _ _ = No

replForAx re e 'A' = show re
replForAx re e 'B' = show e
replForAx _ _ ch = [ch]

replForEq e 'A' = show e
replForEq e ch = [ch]

replForMP re l r 'A' = show re
replForMP re l r 'B' = show l
replForMP re l r 'C' = show r
replForMP _ _ _ ch = [ch]

replForMP2 vname re ql r 'A' = show re
replForMP2 vname re ql r 'B' = show ql
replForMP2 vname re ql r 'C' = show r
replForMP2 vname re ql r 'x' = vname
replForMP2 vname _ _ _ ch = [ch]

replForMP3 vname re l qr 'A' = show re
replForMP3 vname re l qr 'B' = show l
replForMP3 vname re l qr 'C' = show qr
replForMP3 vname re l qr 'x' = vname
replForMP3 _ _ _ _ ch = [ch]
