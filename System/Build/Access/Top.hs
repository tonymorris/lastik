module System.Build.Access.Top where

class Top r where
  top ::
    Maybe String
    ->  r
    ->  r

  getTop ::
    r
    ->  Maybe String


