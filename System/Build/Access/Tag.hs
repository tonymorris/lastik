module System.Build.Access.Tag where

class Tag r where
  tag ::
    [(String, String, String)]
    ->  r
    ->  r

  getTag ::
    r
    ->  [(String, String, String)]


