module System.Build.Access.Etc where

class Etc r where
  etc ::
    Maybe String
    -> r
    -> r

  getEtc ::
    r
    -> Maybe String
