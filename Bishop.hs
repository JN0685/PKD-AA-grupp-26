import Data.Char

type Board = [Square]

data Square = Empty | White Piece | Black Piece
   deriving (Eq, Show)


data Piece = Pawn | Knight | Bishop | Rook | Queen | King
   deriving (Eq, Show)

{- validMoveBishop
Examples:
validMoveBishop newBoard (1,3) (2,4) == True
validMOveBishop newBoard (1,3) (2,2) == True
-}
validMoveBishop :: Board -> (Int, Int) -> (Int, Int) -> Bool
validMoveBishop board (a,b) (c,d) | isSameColour (tupleToSquare board (a,b)) (tupleToSquare board (c, d)) = False
                                  | (a,b) == (c,d) = False
                                  | abs (a-c) /= abs (b-d) = False
                                  | (a-c)>0 && (b-d)>0 = validMoveBishopAux board (-7) (a-c) (position (a,b)) (position (c,d)) (tupleToSquare board (a, b))  --down left
                                  | (a-c)>0 && (b-d)<0 = validMoveBishopAux board (-9) (a-c) (position (a,b)) (position (c,d)) (tupleToSquare board (a, b)) -- left up
                                  | (a-c)<0 && (b-d)>0 = validMoveBishopAux board (7) (b-d) (position (a,b)) (position (c,d)) (tupleToSquare board (a, b)) -- down right
                                  | (a-c)<0 && (b-d)<0 = validMoveBishopAux board (9) (d-b) (position (a,b)) (position (c,d)) (tupleToSquare board (a, b)) -- up right
                                  | otherwise = False -- maybe not needed. 

validMoveBishopAux :: Board -> Int -> Int -> Int -> Int -> Square -> Bool
validMoveBishopAux b ic 0 ab cd sq = ((onSquare b ab) == Empty) || (isSameColour (onSquare b ab) sq == False)
validMoveBishopAux b ic n ab cd sq | ((onSquare b cd) /= Empty) = False -- does this work, compare with my RookAux
                                   | n>0       = validMoveBishopAux b ic (n-1) (ab+ic) cd sq -- otherwise
                                   | otherwise = validMoveBishopAux b ic (n-1) (ab-ic) cd sq -- remove this line not needed


newBoard :: Board
newBoard = [White Rook, White Knight, White Bishop, White Queen, White King, White Bishop, White Knight, White Rook, White Pawn, Empty, White Pawn, Empty, White Pawn, White Pawn, White Pawn, White Pawn, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Black Pawn, Black Pawn, Black Pawn, Black Pawn, Black Pawn, Black Pawn, Black Pawn, Black Pawn, Black Rook, Black Knight, Black Bishop, Black Queen, Black King, Black Bishop, Black Knight, Black Rook]

tupleToSquare :: Board -> (Int, Int) -> Square
tupleToSquare b intTuple = onSquare b (position intTuple) 


isSameColour :: Square -> Square -> Bool  
isSameColour (White _) (White _) = True
isSameColour (Black _) (Black _) = True
isSameColour sq1 sq2             = False

position :: (Int, Int) -> Int
position (x, y) = 8 * (x - 1) + y - 1


onSquare :: Board -> Int -> Square
onSquare b n = b !! n
