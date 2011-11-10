module System.Build.Access.AnnotationOptions where

import System.Build.Data.KeyPValue

class AnnotationOptions r where
  annotationOptions ::
    Maybe KeyPValue
    -> r
    -> r

  getAnnotationOptions ::
    r
    -> Maybe KeyPValue
