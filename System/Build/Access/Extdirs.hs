module System.Build.Access.Extdirs where

class Extdirs r where
  extdirs ::
    [FilePath]
    -> r
    -> r

  getExtdirs ::
    r
    -> [FilePath]

