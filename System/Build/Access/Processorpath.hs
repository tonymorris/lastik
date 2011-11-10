module System.Build.Access.Processorpath where

class Processorpath r where
  processorpath ::
    Maybe FilePath
    -> r
    -> r

  getProcessorpath ::
    r
    -> Maybe FilePath

