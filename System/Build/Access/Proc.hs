-- | Control whether annotation processing and/or compilation is done.
module System.Build.Access.Proc where

class Proc r where
  setProcNone ::
    r
    -> r

  setProcOnly ::
    r
    -> r

  unsetProc ::
    r
    -> r

  foldProc ::
    x
    -> x
    -> x
    -> r
    -> x

