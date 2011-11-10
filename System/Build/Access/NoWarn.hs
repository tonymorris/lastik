module System.Build.Access.NoWarn where

class NoWarn r where
  setNoWarn :: r -> r
  unsetNoWarn :: r -> r
