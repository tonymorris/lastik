module System.Build.Access.Package where

class Package r where
  setPackage ::
    r
    ->  r

  unsetPackage ::
    r
    ->  r
