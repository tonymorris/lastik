module System.Build.Access.Version where

class Version r where
  setVersion ::
    r
    -> r

  unsetVersion ::
    r
    -> r

