module System.Build.Access.Locale where

class Locale r where
  locale ::
    Maybe String
    ->  r
    ->  r

  getLocale ::
    r
    ->  Maybe String


