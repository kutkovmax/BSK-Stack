module BSKStack (
  BSKStack(..), empty, push, pop, updateColors, size
) where

data Node a = Node { color :: Char, val :: a } deriving Show
newtype BSKStack a = BSKStack [Node a] deriving Show

empty :: BSKStack a
empty = BSKStack []

push :: a -> BSKStack a -> BSKStack a
push x (BSKStack xs) = BSKStack (Node 'W' x : xs)

zones :: BSKStack a -> (Int,Int)
zones (BSKStack xs) =
  let n = length xs
      w = floor (fromIntegral n * 0.3)
      b = floor (fromIntegral n * 0.7)
  in (w,b)

pop :: BSKStack a -> Maybe (a, BSKStack a)
pop s@(BSKStack xs) =
  let (w,b) = zones s
      try [] _ = Nothing
      try (Node c v:rest) i
        | i < w && (c=='W' || c=='B') = Just (v, BSKStack rest)
        | i < w = fmap (\(v', BSKStack r) -> (v', BSKStack (Node c v : r))) (try rest (i+1))
        | i < b && c=='B' = Just (v, BSKStack rest)
        | i < b = fmap (\(v', BSKStack r) -> (v', BSKStack (Node c v : r))) (try rest (i+1))
        | otherwise = Nothing
  in try xs 0

updateColors :: BSKStack a -> BSKStack a
updateColors s@(BSKStack xs) =
  let (w,b) = zones s
      upd i (Node _ v)
        | i < w = Node 'W' v
        | i < b = Node 'B' v
        | otherwise = Node 'R' v
  in BSKStack (zipWith upd [0..] xs)

size :: BSKStack a -> Int
size (BSKStack xs) = length xs