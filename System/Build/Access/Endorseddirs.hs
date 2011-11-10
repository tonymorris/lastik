module System.Build.Access.Endorseddirs where

class Endorseddirs r where
  endorseddirs ::
    [FilePath]
    -> r
    -> r

  getEndorseddirs ::
    r
    -> [FilePath]
