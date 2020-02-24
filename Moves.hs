module Moves
  where

import Data.Char


type Board = [Square]

data Square = Empty | White Piece | Black Piece

   deriving (Eq, Show)

--data Colour = White | Black
  -- deriving (Show)

data Piece = Pawn | Knight | Bishop | Rook | Queen | King
   deriving (Eq, Show)

--main = undefined


{- move b i o
   moves a piece from the Square corresponding to i to the square corresponding to o on the board.. -- Moves a chess piece from one square to another.
   PRE: move need to be valid
   RETURNS: a board where the piece on 'i' has been moved to 'o'.
   EXAMPLES: move newBoard "b1" "c1" = [White Rook, White Knight, White Bishop, White Queen, White King, White Bishop, White Knight, White Rook, Empty, White Pawn, White Pawn, White Pawn, White Pawn, White Pawn, White Pawn, White Pawn, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Empty, Black Pawn, Black Pawn, Black Pawn, Black Pawn, Black Pawn, Black Pawn, Black Pawn, Black Pawn, Black Rook, Black Knight, Black Bishop, Black Queen, Black King, Black Bishop, Black Knight, Black Rook]
-}
move :: Board -> String -> String -> Board
move b i o = let
              removed
                = (take (position (convert i)) b) ++ [Empty] ++ (drop ((position (convert i)) + 1) b)
             in (take (position (convert o)) removed) ++ ((onSquare b (position (convert i))) : (drop ((position (convert o)) + 1) b))

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

onSquare :: Board -> Int -> Square
onSquare b n = b !! n


{- isSameColour sq1 sq2
   Checks if two Squares are of the same colour
   RETURNS: True if sq1 and sq2 are the same colour. Otherwise False
   EXAMPLES: isSameColour (Empty) (Empty) == False
             isSameColour (White Knight) (White King) == True
             isSameColour (Black Queen) (Black Rook) == True
             isSameColour (Empty) (Empty) == False
-}
isSameColour :: Square -> Square -> Bool  
isSameColour (White _) (White _) = True
isSameColour (Black _) (Black _) = True
isSameColour sq1 sq2             = False


{- newBoard -- This is a function, should be treated as one.
   Creates a new chessboard
   Returns A list of Square where the first element in the list corresponds to A1 on a chess board, the 9th element corresponds to B1 on a chess board and thr 64th element corresponds to H8 on a chess board
-}
newBoard = [White Rook, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Rook, White Knight, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Knight, White Bishop, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Bishop, White Queen, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Queen, White King, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black King, White Bishop, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Bishop, White Knight, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Knight, White Rook, White Pawn, Empty, Empty, Empty, Empty, Black Pawn, Black Rook]
