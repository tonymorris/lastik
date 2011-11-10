{-# LANGUAGE MultiParamTypeClasses #-}

module System.Build.Compile.SourceFile where

class SourceFile m r where
  sourceFile ::
    r
    -> FilePath
    -> m [FilePath]
