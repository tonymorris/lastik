module System.Build.Access.Group where

class Group r where
  group ::
    [(String, [String])]
    ->  r
    ->  r

  getGroup ::
    r
    ->  [(String, [String])]


