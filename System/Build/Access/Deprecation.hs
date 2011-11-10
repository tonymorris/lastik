module System.Build.Access.Deprecation where

class Deprecation r where
  setDeprecation :: r -> r
  unsetDeprecation :: r -> r
