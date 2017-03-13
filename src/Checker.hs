module Checker where
import Grammar
import Tokens
import qualified Control.Monad.State.Strict as ST
import qualified Data.HashMap.Strict as Map
import qualified Data.Vector as Vect
import qualified Data.HashSet as Set

data Result = No | Almost String | Matched String
instance Show Result where
    show No = "Error"
    show (Almost s) = s
    show (Matched s) = s

(<>) :: Result -> Result -> Result
a@(Matched s) <> _ = a
_ <> a@(Matched s) = a
a@(Almost s) <> _ = a
_ <> a@(Almost s) = a
_ <> _ = No

-- assumptions -> to check -> state (checked, Result)
check :: Vect.Vector (Expr, Int) -> Vect.Vector (Expr, Int) -> ST.State (Vect.Vector (Expr,Int), Vect.Vector String) Bool
check asmpts tocheck | Vect.null tocheck = return True
check asmpts tocheck = do
    let (e, num) = Vect.head tocheck
    checked <- ST.get
    case isAsmptn e asmpts <> is1_10 e <> is13_20 e <> is21 e <> is11_12 e <> isMP e (fst checked) <> isMP2_3 e (fst checked) of
        (Matched s) -> do
                       ST.modify' (\(a,b) -> (Vect.snoc a (e, num), Vect.snoc b s))
                       check asmpts (Vect.tail tocheck)
        (Almost s) -> do
                       ST.modify' (\(a,b) -> (Vect.snoc a (e, num), Vect.snoc b s))
                       return False
        No -> do
               ST.modify' (\(a,b) -> (Vect.snoc a (e,num) , Vect.snoc b "Error"))
               return False

isAsmptn :: Expr -> Vect.Vector (Expr, Int) -> Result
isAsmptn e asmptns = case Vect.findIndex (\(e', _) -> e' == e) asmptns of
            (Just ind) -> Matched $ "Assumption #" ++ (show $ ind + (1 :: Int))
            Nothing -> No

is1_10 :: Expr -> Result
is1_10 e =  let
         res = map (\x -> ST.evalState (lookAlike x e) Map.empty) schemes1
          in if not $ or res then No
             else Matched $ "Axiom #" ++ (show $ snd $ head (dropWhile (\(res, num) -> not res) (zip res [1..])))

is13_20 :: Expr -> Result
is13_20 e = let
        res = filter (\(ax, num) -> ax == e) axioms
            in if null res then No
            else Matched $ (show . snd . head) res


isMP :: Expr -> Vect.Vector (Expr, Int) -> Result
isMP exp prfV = let
    rMP = Vect.filter isImpl prfV
    res = Vect.dropWhile (Nothing == ) $ Vect.map isLeft rMP
     in if Vect.null res then No
        else Matched $ ((++ "M.P.") . show . Vect.head) res
      where
        isImpl (BinOp '>' _ r, ind) = r == exp
        isImpl _ = False
        isLeft (BinOp '>' l _, sndInd) = case Vect.find (\(l', _) -> l == l') prfV of
                            Just (_, fstInd) -> Just (fstInd, sndInd)
                            Nothing -> Nothing

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
is11_12 (BinOp '>' (Qtfr '@' (Var vname ) e) e') = if isFree1 vname e e' then Matched "Ax 11"
                                                   else Almost "Almost Ax 11"
is11_12 (BinOp '>' e' (Qtfr '?' (Var vname ) e)) = if isFree1 vname e e' then Matched "Ax 12"
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
        = if haveFree name fi then Matched "Axiom 21"
                              else Almost "Almost Ax 21"
is21 _ = No


haveFree vname e = Set.member vname $ ST.execState (getFrees Set.empty e) Set.empty
isMP2_3 :: Expr -> Vect.Vector (Expr, Int) -> Result
isMP2_3 (BinOp '>' l (Qtfr '@' (Var vname) r)) prfV | sat <- Vect.filter (\x -> BinOp '>' l r == fst x) prfV
                                                    , not $ null sat
                                                    = if not $ haveFree vname l then Matched "M.P. 2"
                                                      else Almost "M.P. 2"
isMP2_3 (BinOp '>' (Qtfr '?' (Var vname) l) r) prfV | sat <- Vect.filter (\x -> BinOp '>' l r == fst x) prfV
                                                    , not $ null sat
                                                    = if not $ haveFree vname r then Matched "M.P. 3"
                                                      else Almost "Almost M.P. 3"
isMP2_3 _ _ = No

schemes1 = map (parseExpr . scanTokens)
    [ "A1 -> A2 -> A1"
    , "(A1 -> A2) -> (A1 -> A2 -> A3) -> (A1 -> A3)"
    , "A1 -> A2 -> A1 & A2"
    , "A1 & A2 -> A1"
    , "A1 & A2 -> A2"
    , "A1 -> A1 | A2"
    , "A2 -> A1 | A2"
    , "(A1 -> A3) -> (A2 -> A3) -> (A1 | A2 -> A3)"
    , "(A1 -> A2) -> (A1 -> !A2) -> !A1"
    , "!!A1 -> A1" ]

axioms = zip (map (parseExpr . scanTokens)
    [ "a = b -> a' = b'"
    , "a = b -> a = c -> b = c"
    , "a' = b' -> a = b"
    , "!a' = 0"
    , "a + b' = (a + b)'"
    , "a + 0 = a"
    , "a * 0 = 0"
    , "a * b' = a * b + a" ]) [1..]