module System.Build.Access.Src where

class Src r where
  src ::
    Maybe FilePath
    -> r
    -> r

  getSrc ::
    r
    -> Maybe FilePath
