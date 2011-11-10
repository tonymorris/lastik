{-# LANGUAGE MultiParamTypeClasses #-}

-- | A module for compiling Java source files using @javac@.
module System.Build.Java.Javac
(
  Javac
, javac
) where

import System.Build.Access.Debug
import System.Build.Access.NoWarn
import System.Build.Access.Verbose
import System.Build.Access.Deprecation
import System.Build.Access.Proc
import System.Build.Access.Implicit
import System.Build.Access.Classpath
import System.Build.Access.Sourcepath
import System.Build.Access.Bootclasspath
import System.Build.Access.Extdirs
import System.Build.Access.Endorseddirs
import System.Build.Access.Processor
import System.Build.Access.Processorpath
import System.Build.Access.Directory
import System.Build.Access.Src
import System.Build.Access.Encoding
import System.Build.Access.Source
import System.Build.Access.Target
import System.Build.Access.Version
import System.Build.Access.Help
import System.Build.Access.AnnotationOptions
import System.Build.Access.Flags
import System.Build.Access.Etc
import System.Build.Data.SourceRelease
import System.Build.Data.KeyPValue
import System.Build.Compile.Options
import System.Build.Compile.Extensions
import System.Build.Compile.ExecCommand
import System.Build.Compile.SourceFile
import Control.Arrow
import Control.Monad
import Data.List
import Data.Maybe
import Data.Binary.Get
import qualified Data.ByteString.Lazy as B
import System.FilePath
import System.Environment
import Language.Java.ClassFile
import Language.Java.Syntax

data Debug' =
  Lines
  | Vars
  | Source
  | None
  | All
  deriving Eq

instance Show Debug' where
  show Lines =
    "lines"
  show Vars =
    "vars"
  show Source =
    "source"
  show None =
    "none"
  show All =
    "all"

newtype Proc' = Proc' Bool
  deriving Eq

instance Show Proc' where
  show (Proc' False) =
    "none"
  show (Proc' True) =
    "only"

newtype Implicit' = Implicit' Bool
  deriving Eq

instance Show Implicit' where
  show (Implicit' False) =
    "none"
  show (Implicit' True) =
    "class"

-- | Javac is the compiler for Java source files.
data Javac = Javac {
  debug :: Maybe Debug',                  -- ^ @-g@
  nowarn :: Bool,                         -- ^ @-nowarn@
  verbose :: Bool,                        -- ^ @-verbose@
  deprecation :: Bool,                    -- ^ @-deprecation@
  classpath' :: [FilePath],               -- ^ @-classpath@
  sourcepath' :: [FilePath],              -- ^ @-sourcepath@
  bootclasspath' :: [FilePath],           -- ^ @-bootclasspath@
  extdirs' :: [FilePath],                 -- ^ @-extdirs@
  endorseddirs' :: [FilePath],            -- ^ @-endorseddirs@
  proc :: Maybe Proc',                    -- ^ @-proc@
  processor' :: [String],                 -- ^ @-processor@
  processorpath' :: Maybe FilePath,       -- ^ @-processorpath@
  directory' :: Maybe FilePath,           -- ^ @-d@
  src' :: Maybe FilePath,                 -- ^ @-s@
  implicit :: Maybe Implicit',            -- ^ @-implicit@
  encoding' :: Maybe String,              -- ^ @-encoding@
  source' :: Maybe SourceRelease,         -- ^ @-source@
  target' :: Maybe SourceRelease,         -- ^ @-target@
  version :: Bool,                        -- ^ @-version@
  help :: Bool,                           -- ^ @-help@
  annotationOptions' :: Maybe KeyPValue,  -- ^ @-Akey[=value]@
  flags' :: [String],                     -- ^ @-J@
  etc' :: Maybe String                    -- ^ /extras/
}

-- | A @Javac@ with nothing set.
javac ::
  Javac
javac =
  Javac Nothing False False False [] [] [] [] [] Nothing [] Nothing Nothing Nothing Nothing Nothing Nothing Nothing False False Nothing [] Nothing

instance Debug Javac where
  setDebugLines j =
    j { debug = Just Lines }
  setDebugVars j =
    j { debug = Just Vars }
  setDebugSource j =
    j { debug = Just Source }
  setDebugNone j =
    j { debug = Just None }
  setDebugAll j =
    j { debug = Just All }
  unsetDebug j =
    j { debug = Nothing }
  foldDebug lines vars source none all unset j =
    case debug j of
      Just Lines  -> lines
      Just Vars   -> vars
      Just Source -> source
      Just None   -> none
      Just All    -> all
      Nothing     -> unset

instance NoWarn Javac where
  setNoWarn j =
    j { nowarn = True }

  unsetNoWarn j =
    j { nowarn = False }

instance Verbose Javac where
  setVerbose j =
    j { verbose = True }

  unsetVerbose j =
    j { verbose = False }

instance Deprecation Javac where
  setDeprecation j =
    j { deprecation = True }

  unsetDeprecation j =
    j { deprecation = False }

instance Proc Javac where
  setProcNone j =
    j { proc = Just (Proc' True) }

  setProcOnly j =
    j { proc = Just (Proc' False) }

  unsetProc j =
    j { proc = Nothing }

  foldProc none only unset j =
    case proc j of
      Just (Proc' True)  -> none
      Just (Proc' False) -> only
      Nothing            -> unset

instance Implicit Javac where
  setImplicitNone j =
    j { implicit = Just (Implicit' True) }

  setImplicitClass j =
    j { implicit = Just (Implicit' False) }

  unsetImplicit j =
    j { implicit = Nothing }

  foldImplicit none class' unset j =
    case implicit j of
      Just (Implicit' True)  -> none
      Just (Implicit' False) -> class'
      Nothing                -> unset

instance Classpath Javac where
  classpath x j =
    j { classpath' = x }

  getClasspath =
    classpath'

instance Sourcepath Javac where
  sourcepath x j =
    j { sourcepath' = x }

  getSourcepath =
    sourcepath'

instance Bootclasspath Javac where
  bootclasspath x j =
    j { bootclasspath' = x }

  getBootclasspath =
    bootclasspath'

instance Extdirs Javac where
  extdirs x j =
    j { extdirs' = x }

  getExtdirs =
    extdirs'

instance Endorseddirs Javac where
  endorseddirs x j =
    j { endorseddirs' = x }

  getEndorseddirs =
    endorseddirs'

instance Processor Javac where
  processor x j =
    j { processor' = x }

  getProcessor =
    processor'

instance Processorpath Javac where
  processorpath x j =
    j { processorpath' = x }

  getProcessorpath =
    processorpath'

instance Directory Javac where
  directory x j =
    j { directory' = x }

  getDirectory =
    directory'

instance Src Javac where
  src x j =
    j { src' = x }

  getSrc =
    src'

instance Encoding Javac where
  encoding x j =
    j { encoding' = x }

  getEncoding =
    encoding'

instance Source Javac where
  source x j =
    j { source' = x }

  getSource =
    source'

instance Target Javac where
  target x j =
    j { target' = x }

  getTarget =
    target'

instance Version Javac where
  setVersion j =
    j { version = True }

  unsetVersion j =
    j { version = False }

instance Help Javac where
  setHelp j =
    j { help = True }

  unsetHelp j =
    j { help = False }

instance AnnotationOptions Javac where
  annotationOptions x j =
    j { annotationOptions' = x }

  getAnnotationOptions =
    annotationOptions'

instance Flags Javac where
  flags x j =
    j { flags' = x }

  getFlags =
    flags'

instance Etc Javac where
  etc x j =
    j { etc' = x }

  getEtc =
    etc'

instance Options Javac where
  options (Javac debug'
                 nowarn'
                 verbose'
                 deprecation'
                 classpath'
                 sourcepath'
                 bootclasspath'
                 extdirs'
                 endorseddirs'
                 proc''
                 processor'
                 processorpath'
                 directory'
                 src'
                 implicit''
                 encoding'
                 source'
                 target'
                 version'
                 help'
                 annotationOptions'
                 flags'
                 etc') =
    let g ^^^ t      = intercalate t (filter (not . null) g)
        param k c s  = (~?) (\z -> '-' : k ++ c : quote (s z))
        g ~~ k       = if k then '-' : g else []
        (~?)         = maybe []
        s ~: z       = if null z then [] else '-' : s ++ ' ' : [searchPathSeparator] >===< z
        s >===< k    = intercalate s (fmap quote k)
        quote s      = '"' : (s >>= \x -> if x == '"' then "\\\"" else [x]) ++ "\""
        (~~>) k      = param k ' ' show
        (-~>) k      = param k ':' show
        (~~~>) k     = param k ' ' id
        d (Just All) = "g" ~~ True
        d k          = "g" -~> k
    in [ d debug'
       , "nowarn" ~~ nowarn'
       , "verbose" ~~ verbose'
       , "deprecation" ~~ deprecation'
       , "classpath" ~: classpath'
       , "sourcepath" ~: sourcepath'
       , "bootclasspath" ~: bootclasspath'
       , "extdirs" ~: extdirs'
       , "endorseddirs" ~: endorseddirs'
       , "proc" ~~> proc''
       , case processor' of [] -> []
                            _ -> intercalate "," processor'
       , "processorpath" ~~~> processorpath'
       , "d" ~~~> directory'
       , "s" ~~~> src'
       , "implicit" ~~> implicit''
       , "encoding" ~~~> encoding'
       , "source" ~~> source'
       , "target" ~~> target'
       , "version" ~~ version'
       , "help" ~~ help'
       , (\z -> "-A" ++ case first (intercalate ".") z of (k, Just v) -> k ++ '=' : v
                                                          (k, Nothing) -> k) ~? fmap (keys &&& values) annotationOptions'
       , unwords $ map ("-J" ++) flags'
       , fromMaybe [] etc'] ^^^ " "

instance Extensions Javac where
  isSourceExtension _ =
    (== "java")

  isTargetExtension _ =
    (== "class")

instance ExecCommand IO Javac where
  command _ =
    let envs = [
                 ("JAVA_HOME", (</> "bin" </> "javac"))
               , ("JDK_HOME", (</> "bin" </> "javac"))
               , ("JAVAC", id)
               ]
        tryEnvs es =
          do e <- getEnvironment
             let k [] = Nothing
                 k ((a, b):t) = fmap b (a `lookup` e) `mplus` k t
             return (k es)
    in fromMaybe "javac" `fmap` tryEnvs envs

instance SourceFile IO Javac where
  sourceFile j p =
    do k <- B.readFile p
       let (ClassType ct, cir) = runGet getClass k
           sp                  = sourcePath cir
       case ct of
         [] -> return []
         t' -> let (h:t) = map (\(Ident i, _) -> i) . reverse $ t'
                   h'    = h `fromMaybe` sp
                   j'    = [] `fromMaybe` getSrc j
               in return [(j' </>) . joinPath . reverse . (h':) $ t]

