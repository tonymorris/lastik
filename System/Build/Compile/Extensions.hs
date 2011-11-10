module System.Build.Compile.Extensions where

type Extension =
  String

class Extensions r where
  isSourceExtension ::
    r
    -> Extension
    -> Bool
  isTargetExtension ::
    r
    -> Extension
    -> Bool

