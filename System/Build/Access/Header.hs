module System.Build.Access.Header where

class Header r where
  header ::
    Maybe String
    ->  r
    ->  r

  getHeader ::
    r
    ->  Maybe String


