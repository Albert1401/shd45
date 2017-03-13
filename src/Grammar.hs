{-# OPTIONS_GHC -w #-}
module Grammar where
import Tokens
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn t4 t5 t6 t7
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7

action_0 (8) = happyShift action_5
action_0 (9) = happyShift action_6
action_0 (13) = happyShift action_7
action_0 (19) = happyShift action_8
action_0 (20) = happyShift action_9
action_0 (21) = happyShift action_10
action_0 (22) = happyShift action_11
action_0 (4) = happyGoto action_12
action_0 (5) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 _ = happyFail

action_1 (8) = happyShift action_5
action_1 (9) = happyShift action_6
action_1 (13) = happyShift action_7
action_1 (19) = happyShift action_8
action_1 (20) = happyShift action_9
action_1 (21) = happyShift action_10
action_1 (22) = happyShift action_11
action_1 (4) = happyGoto action_2
action_1 (5) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 _ = happyFail

action_2 (10) = happyShift action_13
action_2 (11) = happyShift action_14
action_2 (12) = happyShift action_15
action_2 _ = happyFail

action_3 _ = happyReduce_4

action_4 (15) = happyShift action_23
action_4 (16) = happyShift action_24
action_4 (17) = happyShift action_25
action_4 (18) = happyShift action_26
action_4 (23) = happyShift action_27
action_4 _ = happyFail

action_5 (13) = happyShift action_22
action_5 _ = happyReduce_21

action_6 (13) = happyShift action_21
action_6 _ = happyReduce_9

action_7 (8) = happyShift action_5
action_7 (9) = happyShift action_6
action_7 (13) = happyShift action_7
action_7 (19) = happyShift action_8
action_7 (20) = happyShift action_9
action_7 (21) = happyShift action_10
action_7 (22) = happyShift action_11
action_7 (4) = happyGoto action_19
action_7 (5) = happyGoto action_3
action_7 (7) = happyGoto action_20
action_7 _ = happyFail

action_8 (8) = happyShift action_5
action_8 (9) = happyShift action_6
action_8 (13) = happyShift action_7
action_8 (19) = happyShift action_8
action_8 (20) = happyShift action_9
action_8 (21) = happyShift action_10
action_8 (22) = happyShift action_11
action_8 (5) = happyGoto action_18
action_8 (7) = happyGoto action_4
action_8 _ = happyFail

action_9 (8) = happyShift action_17
action_9 _ = happyFail

action_10 (8) = happyShift action_16
action_10 _ = happyFail

action_11 _ = happyReduce_22

action_12 (10) = happyShift action_13
action_12 (11) = happyShift action_14
action_12 (12) = happyShift action_15
action_12 (25) = happyAccept
action_12 _ = happyFail

action_13 (8) = happyShift action_5
action_13 (9) = happyShift action_6
action_13 (13) = happyShift action_7
action_13 (19) = happyShift action_8
action_13 (20) = happyShift action_9
action_13 (21) = happyShift action_10
action_13 (22) = happyShift action_11
action_13 (4) = happyGoto action_42
action_13 (5) = happyGoto action_3
action_13 (7) = happyGoto action_4
action_13 _ = happyFail

action_14 (8) = happyShift action_5
action_14 (9) = happyShift action_6
action_14 (13) = happyShift action_7
action_14 (19) = happyShift action_8
action_14 (20) = happyShift action_9
action_14 (21) = happyShift action_10
action_14 (22) = happyShift action_11
action_14 (4) = happyGoto action_41
action_14 (5) = happyGoto action_3
action_14 (7) = happyGoto action_4
action_14 _ = happyFail

action_15 (8) = happyShift action_5
action_15 (9) = happyShift action_6
action_15 (13) = happyShift action_7
action_15 (19) = happyShift action_8
action_15 (20) = happyShift action_9
action_15 (21) = happyShift action_10
action_15 (22) = happyShift action_11
action_15 (4) = happyGoto action_40
action_15 (5) = happyGoto action_3
action_15 (7) = happyGoto action_4
action_15 _ = happyFail

action_16 (8) = happyShift action_5
action_16 (9) = happyShift action_6
action_16 (13) = happyShift action_7
action_16 (19) = happyShift action_8
action_16 (20) = happyShift action_9
action_16 (21) = happyShift action_10
action_16 (22) = happyShift action_11
action_16 (5) = happyGoto action_39
action_16 (7) = happyGoto action_4
action_16 _ = happyFail

action_17 (8) = happyShift action_5
action_17 (9) = happyShift action_6
action_17 (13) = happyShift action_7
action_17 (19) = happyShift action_8
action_17 (20) = happyShift action_9
action_17 (21) = happyShift action_10
action_17 (22) = happyShift action_11
action_17 (5) = happyGoto action_38
action_17 (7) = happyGoto action_4
action_17 _ = happyFail

action_18 _ = happyReduce_10

action_19 (10) = happyShift action_13
action_19 (11) = happyShift action_14
action_19 (12) = happyShift action_15
action_19 (14) = happyShift action_37
action_19 _ = happyFail

action_20 (14) = happyShift action_36
action_20 (15) = happyShift action_23
action_20 (16) = happyShift action_24
action_20 (17) = happyShift action_25
action_20 (18) = happyShift action_26
action_20 (23) = happyShift action_27
action_20 _ = happyFail

action_21 (8) = happyShift action_5
action_21 (13) = happyShift action_29
action_21 (22) = happyShift action_11
action_21 (6) = happyGoto action_35
action_21 (7) = happyGoto action_34
action_21 _ = happyReduce_12

action_22 (8) = happyShift action_5
action_22 (13) = happyShift action_29
action_22 (22) = happyShift action_11
action_22 (6) = happyGoto action_33
action_22 (7) = happyGoto action_34
action_22 _ = happyReduce_12

action_23 (8) = happyShift action_5
action_23 (13) = happyShift action_29
action_23 (22) = happyShift action_11
action_23 (7) = happyGoto action_32
action_23 _ = happyFail

action_24 (8) = happyShift action_5
action_24 (13) = happyShift action_29
action_24 (22) = happyShift action_11
action_24 (7) = happyGoto action_31
action_24 _ = happyFail

action_25 (8) = happyShift action_5
action_25 (13) = happyShift action_29
action_25 (22) = happyShift action_11
action_25 (7) = happyGoto action_30
action_25 _ = happyFail

action_26 _ = happyReduce_18

action_27 (8) = happyShift action_5
action_27 (13) = happyShift action_29
action_27 (22) = happyShift action_11
action_27 (7) = happyGoto action_28
action_27 _ = happyFail

action_28 (18) = happyShift action_26
action_28 _ = happyReduce_17

action_29 (8) = happyShift action_5
action_29 (13) = happyShift action_29
action_29 (22) = happyShift action_11
action_29 (7) = happyGoto action_46
action_29 _ = happyFail

action_30 (15) = happyShift action_23
action_30 (16) = happyShift action_24
action_30 (18) = happyShift action_26
action_30 (23) = happyShift action_27
action_30 _ = happyReduce_5

action_31 (18) = happyShift action_26
action_31 (23) = happyShift action_27
action_31 _ = happyReduce_16

action_32 (18) = happyShift action_26
action_32 (23) = happyShift action_27
action_32 _ = happyReduce_15

action_33 (14) = happyShift action_45
action_33 _ = happyFail

action_34 (15) = happyShift action_23
action_34 (16) = happyShift action_24
action_34 (18) = happyShift action_26
action_34 (23) = happyShift action_27
action_34 (24) = happyShift action_44
action_34 _ = happyReduce_13

action_35 (14) = happyShift action_43
action_35 _ = happyFail

action_36 _ = happyReduce_20

action_37 _ = happyReduce_11

action_38 _ = happyReduce_6

action_39 _ = happyReduce_7

action_40 (10) = happyShift action_13
action_40 (11) = happyShift action_14
action_40 (12) = happyShift action_15
action_40 _ = happyReduce_1

action_41 (10) = happyShift action_13
action_41 _ = happyReduce_2

action_42 _ = happyReduce_3

action_43 _ = happyReduce_8

action_44 (8) = happyShift action_5
action_44 (13) = happyShift action_29
action_44 (22) = happyShift action_11
action_44 (6) = happyGoto action_47
action_44 (7) = happyGoto action_34
action_44 _ = happyReduce_12

action_45 _ = happyReduce_19

action_46 (14) = happyShift action_36
action_46 (15) = happyShift action_23
action_46 (16) = happyShift action_24
action_46 (18) = happyShift action_26
action_46 (23) = happyShift action_27
action_46 _ = happyFail

action_47 _ = happyReduce_14

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp '>' happy_var_1 happy_var_3
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_3  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp '|' happy_var_1 happy_var_3
	)
happyReduction_2 _ _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_3  4 happyReduction_3
happyReduction_3 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (BinOp '&' happy_var_1 happy_var_3
	)
happyReduction_3 _ _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  4 happyReduction_4
happyReduction_4 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_3  5 happyReduction_5
happyReduction_5 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (BinOp '=' happy_var_1 happy_var_3
	)
happyReduction_5 _ _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_3  5 happyReduction_6
happyReduction_6 (HappyAbsSyn5  happy_var_3)
	(HappyTerminal (TokenName1 happy_var_2))
	_
	 =  HappyAbsSyn5
		 (Qtfr '@' (Var happy_var_2) happy_var_3
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  5 happyReduction_7
happyReduction_7 (HappyAbsSyn5  happy_var_3)
	(HappyTerminal (TokenName1 happy_var_2))
	_
	 =  HappyAbsSyn5
		 (Qtfr '?' (Var happy_var_2) happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happyReduce 4 5 happyReduction_8
happyReduction_8 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenName2 happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Funct 'P' happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_9 = happySpecReduce_1  5 happyReduction_9
happyReduction_9 (HappyTerminal (TokenName2 happy_var_1))
	 =  HappyAbsSyn5
		 (Funct 'P' happy_var_1 []
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_2  5 happyReduction_10
happyReduction_10 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (UnOp '!' happy_var_2
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  5 happyReduction_11
happyReduction_11 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (happy_var_2
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_0  6 happyReduction_12
happyReduction_12  =  HappyAbsSyn6
		 ([]
	)

happyReduce_13 = happySpecReduce_1  6 happyReduction_13
happyReduction_13 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  6 happyReduction_14
happyReduction_14 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1 : happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  7 happyReduction_15
happyReduction_15 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (BinOp '+' happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  7 happyReduction_16
happyReduction_16 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (BinOp '-' happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  7 happyReduction_17
happyReduction_17 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (BinOp '*' happy_var_1 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_2  7 happyReduction_18
happyReduction_18 _
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (UnOp 'q' happy_var_1
	)
happyReduction_18 _ _  = notHappyAtAll 

happyReduce_19 = happyReduce 4 7 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenName1 happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Funct 'f' happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_20 = happySpecReduce_3  7 happyReduction_20
happyReduction_20 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (happy_var_2
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  7 happyReduction_21
happyReduction_21 (HappyTerminal (TokenName1 happy_var_1))
	 =  HappyAbsSyn7
		 (Var happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  7 happyReduction_22
happyReduction_22 _
	 =  HappyAbsSyn7
		 (Zero
	)

happyNewToken action sts stk [] =
	action 25 25 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenName1 happy_dollar_dollar -> cont 8;
	TokenName2 happy_dollar_dollar -> cont 9;
	TokenConj -> cont 10;
	TokenDisj -> cont 11;
	TokenImpl -> cont 12;
	TokenLParen -> cont 13;
	TokenRParen -> cont 14;
	TokenPlus -> cont 15;
	TokenMinus -> cont 16;
	TokenEq -> cont 17;
	TokenInc -> cont 18;
	TokenNeg -> cont 19;
	TokenQtfrAll -> cont 20;
	TokenQtfrOne -> cont 21;
	TokenZero -> cont 22;
	TokenMult -> cont 23;
	TokenComma -> cont 24;
	_ -> happyError' (tk:tks)
	}

happyError_ 25 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = return
    (<*>) = ap
instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Token)] -> HappyIdentity a
happyError' = HappyIdentity . parseError

parseExpr tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError ts = error $ "Parse error" ++ "\n" ++ show ts

data Expr = BinOp Char Expr Expr
         | UnOp Char Expr
         | Funct Char String [Expr]
         | Qtfr Char Expr Expr
         | Var String
         | Zero
         deriving Eq

instance Show Expr where
    show _ = "0"
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 8 "<command-line>" #-}
# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4











































{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "/home/clitcommander/.stack/programs/x86_64-linux/ghc-ncurses6-8.0.2/lib/ghc-8.0.2/include/ghcversion.h" #-}

















{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "/tmp/ghc18860_0/ghc_2.h" #-}






















































































































































{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates/GenericTemplate.hs" #-}

{-# LINE 46 "templates/GenericTemplate.hs" #-}








{-# LINE 67 "templates/GenericTemplate.hs" #-}

{-# LINE 77 "templates/GenericTemplate.hs" #-}

{-# LINE 86 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 155 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 256 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 322 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
