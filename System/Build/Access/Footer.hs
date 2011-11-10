module System.Build.Access.Footer where

class Footer r where
  footer ::
    Maybe String
    ->  r
    ->  r

  getFooter ::
    r
    ->  Maybe String


