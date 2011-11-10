module System.Build.Access.Target where

import System.Build.Data.SourceRelease

class Target r where
  target ::
    Maybe SourceRelease
    -> r
    -> r

  getTarget ::
    r
    -> Maybe SourceRelease

