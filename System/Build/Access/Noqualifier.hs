module System.Build.Access.Noqualifier where

class Noqualifier r where
  noqualifier ::
    [String]
    ->  r
    ->  r

  getNoqualifier ::
    r
    ->  [String]


