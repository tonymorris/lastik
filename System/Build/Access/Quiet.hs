module System.Build.Access.Quiet where

class Quiet r where
  setQuiet ::
    r
    ->  r

  unsetQuiet ::
    r
    ->  r


