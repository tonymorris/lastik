module System.Build.Access.Doclet where

class Doclet r where
  doclet ::
    Maybe String
    ->  r
    ->  r

  getDoclet ::
    r
    ->  Maybe String

