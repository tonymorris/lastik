module System.Build.Access.Flags where

class Flags r where
  flags ::
    [String]
    -> r
    -> r

  getFlags ::
    r
    -> [String]
