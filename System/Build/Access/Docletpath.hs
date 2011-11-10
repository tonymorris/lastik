module System.Build.Access.Docletpath where

class Docletpath r where
  docletpath ::
    Maybe FilePath
    ->  r
    ->  r

  getDocletpath ::
    r
    ->  Maybe FilePath

