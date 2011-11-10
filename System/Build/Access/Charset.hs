module System.Build.Access.Charset where

class Charset r where
  charset ::
    Maybe String
    ->  r
    ->  r

  getCharset ::
    r
    ->  Maybe String


