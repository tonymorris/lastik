module System.Build.Access.Windowtitle where

class Windowtitle r where
  windowtitle ::
    Maybe String
    ->  r
    ->  r

  getWindowtitle ::
    r
    ->  Maybe String


