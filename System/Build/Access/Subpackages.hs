module System.Build.Access.Subpackages where

class Subpackages r where
  subpackages ::
    [String]
    ->  r
    ->  r

  getSubpackages ::
    r
    ->  [String]

