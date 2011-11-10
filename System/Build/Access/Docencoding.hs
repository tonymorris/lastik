module System.Build.Access.Docencoding where

class Docencoding r where
  docencoding ::
    Maybe String
    -> r
    -> r

  getDocencoding ::
    r
    -> Maybe String
