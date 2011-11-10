module System.Build.Access.Linkoffline where

class Linkoffline r where
  linkoffline ::
    [(String, String)]
    ->  r
    ->  r

  getLinkoffline ::
    r
    ->  [(String, String)]


