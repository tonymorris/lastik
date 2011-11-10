module System.Build.Access.Classpath where

class Classpath r where
  classpath ::
    [FilePath]
    -> r
    -> r

  getClasspath ::
    r
    -> [FilePath]

