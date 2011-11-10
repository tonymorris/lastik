module System.Build.Access.Exclude where

class Exclude r where
  exclude ::
    [String]
    ->  r
    ->  r

  getExclude ::
    r
    ->  [String]

