module System.Build.Access.Implicit where

-- | Specify whether or not to generate class files for implicitly referenced files.
class Implicit r where
  setImplicitNone ::
    r
    -> r

  setImplicitClass ::
    r
    -> r

  unsetImplicit ::
    r
    -> r

  foldImplicit ::
    x
    -> x
    -> x
    -> r
    -> x
