module Expression where
import Prelude hiding ((&&), (||))
data Expression = Var String | Conj Expression Expression | Disj Expression Expression | Impl Expression Expression

instance Show Expression where
    show (Var a) = a
    show (Conj a b ) = show a ++ " & " ++ show b
    show (Disj a b ) = show a ++ " | " ++ show b
    show (Impl a b ) = show a ++ " -> " ++ show b



