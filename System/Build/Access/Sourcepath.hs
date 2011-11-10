module System.Build.Access.Sourcepath where

class Sourcepath r where
  sourcepath ::
    [FilePath]
    -> r
    -> r

  getSourcepath ::
    r
    -> [FilePath]
