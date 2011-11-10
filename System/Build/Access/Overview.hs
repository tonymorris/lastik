module System.Build.Access.Overview where

class Overview r where
  overview ::
    Maybe FilePath
    ->  r
    ->  r

  getOverview ::
    r
    ->  Maybe FilePath

