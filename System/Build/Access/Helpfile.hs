module System.Build.Access.Helpfile where

class Helpfile r where
  helpfile ::
    Maybe FilePath
    ->  r
    ->  r

  getHelpfile ::
    r
    ->  Maybe FilePath


