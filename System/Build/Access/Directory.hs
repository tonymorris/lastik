module System.Build.Access.Directory where

import System.Directory

class Directory r where
  directory ::
    Maybe FilePath
    -> r
    -> r

  getDirectory ::
    r
    -> Maybe FilePath

  directoryIs ::
    FilePath
    -> r
    -> r
  directoryIs =
    directory . Just

  getDirectoryOrCurrent ::
    r
    -> IO FilePath
  getDirectoryOrCurrent r =
    case getDirectory r of
      Nothing -> getCurrentDirectory
      Just d  -> return d

