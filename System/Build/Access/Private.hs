module System.Build.Access.Private where

class Private r where
  setPrivate ::
    r
    ->  r

  unsetPrivate ::
    r
    ->  r

