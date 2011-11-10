module System.Build.Access.Source where

import System.Build.Data.SourceRelease

class Source r where
  source ::
    Maybe SourceRelease
    -> r
    -> r

  getSource ::
    r
    -> Maybe SourceRelease
