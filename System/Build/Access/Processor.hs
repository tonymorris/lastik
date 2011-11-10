module System.Build.Access.Processor where

class Processor r where
  processor ::
    [String]
    -> r
    -> r

  getProcessor ::
    r
    -> [String]
