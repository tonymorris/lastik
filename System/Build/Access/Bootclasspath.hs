module System.Build.Access.Bootclasspath where

class Bootclasspath a where
  bootclasspath ::
    [FilePath]
    -> a
    -> a

  getBootclasspath ::
    a
    -> [FilePath]
