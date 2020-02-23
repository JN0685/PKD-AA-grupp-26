
import Data.Char

type Board = [Square]

data Square = Empty | White Piece | Black Piece
   deriving (Eq, Show)


data Piece = Pawn | Knight | Bishop | Rook | Queen | King
   deriving (Eq, Show)

-- Helper function to validMove

validMoveQueen :: Board -> (Int, Int) -> (Int, Int) -> Bool
validMoveQueen = undefined




{- validMoveRook board startPos endPos square
   checks whether or not a rook can make a move in chess.
   PRE: 
   RETURNS: True if 'square' can make the nove from 'startPos' to 'endPos' on the Board 'board', else False
   SIDE-EFFECTS: 
   EXAMPLES:
DOES NOT WORK WHEN TRYING TO MOVE A ROOK TO A PLACE WHERE YOU CAN MOVE IT
SEEMS TO ALWAYS RETURN FALSE
 -}


validMoveRook :: Board -> (Int, Int) -> (Int, Int) -> Bool
validMoveRook board (a, b) (c, d) | isSameColour (tupleToSquare board (a, b)) (tupleToSquare board (c, d)) = False
                                  | (a,b) == (c,d) = False
                                  -- 1 and 8 to check all squares on that line
                                  | a == c = validMoveRookAux board 1 (d-b) (position (a,b)) (position (c,d)) (tupleToSquare board (a, b))
                                  -- 1 and 8 to check horizontal/vertical line
                                  | b == d = validMoveRookAux board 8 (c-a) (position (a,b)) (position (c,d)) (tupleToSquare board (a, b))
                                  ----- board 1 (a-c) instead of (a-d)
                                  | otherwise = False

{-
validMoveRook :: Board -> (Int, Int) -> (Int, Int) -> Bool
validMoveRook board (a, b) (c, d) | isSameColour (onSquare board (a, b)) (onSquare board (c, d)) = False
                                  | (a,b) == (c,d) = False
                                  -- 1 and 8 to check all squares on that line
                                  | a == c = validMoveRookAux board 8 (b-d) (a,b) (c,d) (onSquare board (a, b))
                                  -- 1 and 8 to check horizontal/vertical line
                                  | b == d = validMoveRookAux board 1 (a-c) (a,b) (c,d) (onSquare board (a, b))
                                  ----- board 1 (a-c) instead of (a-d)
                                  | otherwise = False
-}
-- 1 and 8 to check all squares on that line -- 1 and 8 to check horizontal/vertical line ----- ABOVE ^^^^^^^^


{- validMoveRookAux b indexchange n indexOfab indexOfcd square
   checks if there is anything in the way when a chess piece moves from one square to another. 
   PRE: 
   RETRUNS: -- Something about square can move to every square with the indexchange to n on b.
   SIDE-EFFECTS: 
   EXAMPLES: 
-}
-- VARIANT: n
validMoveRookAux :: Board -> Int -> Int -> Int -> Int -> Square -> Bool -- tuple might be best if changed to their index in Board.
-- checks if last square is valid to move to or not
--validMoveRookAux b ic 0 ab cd sq = if ((intToSquare ab) == Empty) || (isSameColour (intToSquare ab) sq == False) then True else False
-- OTHER WAY TO WRITE LINE ABOVE ^^^^^^ validMoveRookAux:
validMoveRookAux b ic 0 ab cd sq = ((onSquare b ab) == Empty) || (isSameColour (onSquare b ab) sq == False) ------ cd not needed
validMoveRookAux b ic n ab cd sq | abs n > 1 && ((onSquare b (ab+ic)) /= Empty) = False -- change to cd instead of ab? ---- THIS CODE ALWAYS RETURNS FALSE ON FIRST CALL
                                 | n>0       = validMoveRookAux b ic (n-1) (ab+ic) cd sq
                                 | otherwise = validMoveRookAux b ic (n+1) (ab-ic) cd sq -- n-1 changed to n+1








-- checks if the square on an index is the same colour as the square in the argument. If first Square is same Colour then True else False (False if Empty or enemy)
{-

   PRE: -
   RETURNS:
   SIDE-EFFECTS -
   EXAMPLES: isSameColour (Empty) (Empty) == False
             isSameColour (White Knight) (White King) == True
             isSameColour (Black Queen) (Black Rook) == True
             isSameColour (Empty) (Empty) == False
             -- one empty -> False
 -}
isSameColour :: Square -> Square -> Bool  
isSameColour (White _) (White _) = True
isSameColour (Black _) (Black _) = True
isSameColour sq1 sq2             = False


-- takes an index in board and converts it to its Square Form (Empty | Black _ | White _)
convertIntToSquare :: Board -> Int -> Square
convertIntToSquare = undefined

-- To get what Square is on a (Int, Int) tuple. Could make a call to intToSquare with position (Int,Int)
tupleToSquare :: Board -> (Int, Int) -> Square
tupleToSquare b intTuple = onSquare b (position intTuple) 

-- To get what Square is on a Int idex
intToSquare :: Int -> Square
intToSquare = undefined


------------ NEEDS TO BE REWRITTEN
{- position b i
   converts an input i to the postition corresponding to i on the board b. -- Converts a String of a square from a chess board to an Int.
   PRE: 'b' or 'i' cannot be empty and 'i' needs to be on the form "a1" to "h8" which corresponds to positions on a chess board
   RETURNS: The postition of i in b -- The position of 'i' on a chessboard
   EXAMPLES: position newboard "a1" = 0
-}
position :: (Int, Int) -> Int
position (x, y) = 8 * (x - 1) + y - 1




{- onSquare b i
   converts an input i to the Square that is on the position correspnding to i on the board b using the function position -- Finds which piece is on a square on a
                                                                                                                             chessboard
   PRE: 'b' or 'i' cannot be empty and 'i' needs to be on the form "a1" to "h8" which corresponds to positions on a chess board
   RETURNS: The Square of position i on b
   EXAMPLES: convert newBoard "a1" = White Rook
            convert newBoard "hej" = error
            example of when position is empty
-}
--onSquare :: Board -> String -> Square
--onSquare b i = b !! (position (convert i))

--onSquare :: Board -> (Int, Int) -> Square
--onSquare b (x, y) = b !! (position (x, y))

onSquare :: Board -> Int -> Square
onSquare b n = b !! n


{- convert i
   converts an input String into a pair of Int
   Returns: (x, y) where x is an Int from 1 to 8 intead of a Char from 'a' to 'h' and y = digitToInt y
   Examples: convert "a1" = (1, 1)
-}
convert :: String -> (Int, Int)
convert (x:y:[]) | (toUpper x) == 'A' = (1, (digitToInt y))
                 | (toUpper x) == 'B' = (2, (digitToInt y))
                 | (toUpper x) == 'C' = (3, (digitToInt y))
                 | (toUpper x) == 'D' = (4, (digitToInt y))
                 | (toUpper x) == 'E' = (5, (digitToInt y))
                 | (toUpper x) == 'F' = (6, (digitToInt y))
                 | (toUpper x) == 'G' = (7, (digitToInt y))
                 | (toUpper x) == 'H' = (8, (digitToInt y))



newBoard :: [Square]
newBoard = [White Rook, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Rook, White Knight, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Knight, White Bishop, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Bishop, White Queen, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Queen, White King, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black King, White Bishop, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Bishop, White Knight, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Knight, White Rook, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Rook]
