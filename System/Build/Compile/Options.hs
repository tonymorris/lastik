module System.Build.Compile.Options where

class Options r where
  options ::
    r
    -> String

