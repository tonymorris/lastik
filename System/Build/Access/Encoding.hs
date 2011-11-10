module System.Build.Access.Encoding where

class Encoding r where
  encoding ::
    Maybe String
    -> r
    -> r

  getEncoding ::
    r
    -> Maybe String
