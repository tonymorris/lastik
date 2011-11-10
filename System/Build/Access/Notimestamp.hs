module System.Build.Access.Notimestamp where

class Notimestamp r where
  setNotimestamp ::
    r
    ->  r

  unsetNotimestamp ::
    r
    ->  r

