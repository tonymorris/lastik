module System.Build.Access.Link where

class Link r where
  link ::
    [String]
    ->  r
    ->  r

  getLink ::
    r
    ->  [String]


