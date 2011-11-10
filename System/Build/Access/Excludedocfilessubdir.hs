module System.Build.Access.Excludedocfilessubdir where

class Excludedocfilessubdir r where
  excludedocfilessubdir ::
    [String]
    ->  r
    ->  r

  getExcludedocfilessubdir ::
    r
    ->  [String]


