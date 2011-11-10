module System.Build.Access.Sourcetab where

class Sourcetab r where
  sourcetab ::
    Maybe Int
    ->  r
    ->  r

  getSourcetab ::
    r
    ->  Maybe Int


