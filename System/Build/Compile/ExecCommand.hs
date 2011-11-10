{-# LANGUAGE MultiParamTypeClasses #-}

module System.Build.Compile.ExecCommand where

class ExecCommand m r where
  command ::
    r
    -> m String
