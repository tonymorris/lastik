module System.Build.Access.Verbose where

class Verbose r where
  setVerbose :: r -> r
  unsetVerbose :: r -> r
