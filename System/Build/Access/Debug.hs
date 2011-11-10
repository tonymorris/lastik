module System.Build.Access.Debug where

-- | The debug options that can be passed to @javac@.
class Debug r where
  -- | Generate only some debugging info (@lines@).
  setDebugLines  ::
    r
    -> r

  -- | Generate only some debugging info (@vars@).
  setDebugVars   ::
    r
    -> r

  -- | Generate only some debugging info (@source@).
  setDebugSource ::
    r
    -> r

  -- | Generate no debugging info.
  setDebugNone   ::
    r
    -> r

  -- | Generate all debugging info.
  setDebugAll    ::
    r
    -> r

  -- | Use the default.
  unsetDebug     ::
    r
    -> r

  foldDebug ::
    x
    -> x
    -> x
    -> x
    -> x
    -> x
    -> r
    -> x

  -- todo combinators
