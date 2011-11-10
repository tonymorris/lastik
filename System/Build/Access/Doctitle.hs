module System.Build.Access.Doctitle where

class Doctitle r where
  doctitle ::
    Maybe String
    ->  r
    ->  r

  getDoctitle ::
    r
    ->  Maybe String


