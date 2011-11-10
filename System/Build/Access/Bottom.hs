module System.Build.Access.Bottom where

class Bottom r where
  bottom ::
    Maybe String
    ->  r
    ->  r

  getBottom ::
    r
    ->  Maybe String


