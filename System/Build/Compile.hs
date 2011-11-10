module System.Build.Compile
(
  module System.Build.Compile.Options
, module System.Build.Compile.Extensions
, module System.Build.Compile.ExecCommand
, module System.Build.Compile.SourceFile
, compile
) where

import System.Build.Compile.Options
import System.Build.Compile.Extensions
import System.Build.Compile.ExecCommand
import System.Build.Compile.SourceFile

import System.FilePath.FilePather
import System.Build.Access.Directory
import Control.Monad
import Control.Monad.TM
import Data.List(intercalate)
import System.Command

compile p x s =
  do d      <- getDirectoryOrCurrent x
     target <- find always (extensionSatisfies (isTargetExtension x . drop 1)) d
     source <- find always (extensionSatisfies (isSourceExtension x . drop 1)) .>>=. s
     fs     <- filterM (\y -> anyM (p `flip` y) target) source
     c      <- command x
     system (c ++ " " ++ options x ++ " " ++ intercalate " " (map (\g -> '"' : g ++ "\"") fs))
     -- return target
