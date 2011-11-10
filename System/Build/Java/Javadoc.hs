{-# LANGUAGE MultiParamTypeClasses #-}

-- | A module for documenting Java source files using @javadoc@.
module System.Build.Java.Javadoc
(
  Javadoc
  -- * @Javadoc@ values
, javadoc
) where

import System.Build.Access.Overview
import System.Build.Access.Public
import System.Build.Access.Protected
import System.Build.Access.Package
import System.Build.Access.Private
import System.Build.Access.Help
import System.Build.Access.Doclet
import System.Build.Access.Docletpath
import System.Build.Access.Sourcepath
import System.Build.Access.Classpath
import System.Build.Access.Exclude
import System.Build.Access.Subpackages
import System.Build.Access.Breakiterator
import System.Build.Access.Bootclasspath
import System.Build.Access.Source
import System.Build.Access.Extdirs
import System.Build.Access.Verbose
import System.Build.Access.Locale
import System.Build.Access.Encoding
import System.Build.Access.Quiet
import System.Build.Access.Flags
import System.Build.Access.Directory
import System.Build.Access.Use
import System.Build.Access.Version
import System.Build.Access.Author
import System.Build.Access.Docfilessubdirs
import System.Build.Access.Splitindex
import System.Build.Access.Windowtitle
import System.Build.Access.Doctitle
import System.Build.Access.Header
import System.Build.Access.Footer
import System.Build.Access.Top
import System.Build.Access.Bottom
import System.Build.Access.Link
import System.Build.Access.Linkoffline
import System.Build.Access.Excludedocfilessubdir
import System.Build.Access.Group
import System.Build.Access.Nocomment
import System.Build.Access.Nodeprecated
import System.Build.Access.Noqualifier
import System.Build.Access.Nosince
import System.Build.Access.Notimestamp
import System.Build.Access.Nodeprecatedlist
import System.Build.Access.Notree
import System.Build.Access.Noindex
import System.Build.Access.Nohelp
import System.Build.Access.Nonavbar
import System.Build.Access.Serialwarn
import System.Build.Access.Tag
import System.Build.Access.Taglet
import System.Build.Access.Tagletpath
import System.Build.Access.Charset
import System.Build.Access.Helpfile
import System.Build.Access.Linksource
import System.Build.Access.Sourcetab
import System.Build.Access.Keywords
import System.Build.Access.Stylesheetfile
import System.Build.Access.Docencoding
import System.Build.Data.SourceRelease
import System.Build.Compile.Options
import System.Build.Compile.Extensions
import System.Build.Compile.ExecCommand
import Control.Monad
import Data.Maybe
import Data.List hiding (group)
import System.FilePath
import System.Environment

-- | Javadoc is the compiler for Java API documentation.
data Javadoc = Javadoc {
  overview' :: Maybe FilePath,        -- ^ @-overview@
  public :: Bool,                     -- ^ @-public@
  protected :: Bool,                  -- ^ @-protected@
  package :: Bool,                    -- ^ @-package@
  private :: Bool,                    -- ^ @-private@
  help :: Bool,                       -- ^ @-help@
  doclet' :: Maybe String,            -- ^ @-doclet@
  docletpath' :: Maybe FilePath,      -- ^ @-docletpath@
  sourcepath' :: [FilePath],          -- ^ @-sourcepath@
  classpath' :: [FilePath],           -- ^ @-classpath@
  exclude' :: [String],               -- ^ @-exclude@
  subpackages' :: [String],           -- ^ @-subpackages@
  breakiterator :: Bool,              -- ^ @-breakiterator@
  bootclasspath' :: [FilePath],       -- ^ @-bootclasspath@
  source' :: Maybe SourceRelease,     -- ^ @-source@
  extdirs' :: [FilePath],             -- ^ @-extdirs@
  verbose :: Bool,                    -- ^ @-verbose@
  locale' :: Maybe String,            -- ^ @-locale@
  encoding' :: Maybe String,          -- ^ @-encoding@
  quiet :: Bool,                      -- ^ @-quiet@
  flags' :: [String],                 -- ^ @-flags@
  directory' :: Maybe FilePath,       -- ^ @-d@
  use :: Bool,                        -- ^ @-use@
  version :: Bool,                    -- ^ @-version@
  author :: Bool,                     -- ^ @-author@
  docfilessubdirs :: Bool,            -- ^ @-docfilessubdirs@
  splitindex :: Bool,                 -- ^ @-splitindex@
  windowtitle' :: Maybe String,       -- ^ @-windowtitle@
  doctitle' :: Maybe String,          -- ^ @-doctitle@
  header' :: Maybe String,            -- ^ @-header@
  footer' :: Maybe String,            -- ^ @-footer@
  top' :: Maybe String,               -- ^ @-top@
  bottom' :: Maybe String,            -- ^ @-bottom@
  link' :: [String],                  -- ^ @-link@
  linkoffline' :: [(String, String)], -- ^ @-linkoffline@
  excludedocfilessubdir' :: [String], -- ^ @-excludedocfilessubdir@
  group' :: [(String, [String])],     -- ^ @-group@
  nocomment :: Bool,                  -- ^ @-nocomment@
  nodeprecated :: Bool,               -- ^ @-nodeprecated@
  noqualifier' :: [String],           -- ^ @-noqualifier@
  nosince :: Bool,                    -- ^ @-nosince@
  notimestamp :: Bool,                -- ^ @-notimestamp@
  nodeprecatedlist :: Bool,           -- ^ @-nodeprecatedlist@
  notree :: Bool,                     -- ^ @-notree@
  noindex :: Bool,                    -- ^ @-noindex@
  nohelp :: Bool,                     -- ^ @-nohelp@
  nonavbar :: Bool,                   -- ^ @-nonavbar@
  serialwarn :: Bool,                 -- ^ @-serialwarn@
  tag' :: [(String, String, String)], -- ^ @-tag@
  taglet :: Bool,                     -- ^ @-taglet@
  tagletpath :: Bool,                 -- ^ @-tagletpath@
  charset' :: Maybe String,           -- ^ @-charset@
  helpfile' :: Maybe FilePath,        -- ^ @-helpfile@
  linksource :: Bool,                 -- ^ @-linksource@
  sourcetab' :: Maybe Int,            -- ^ @-sourcetab@
  keywords :: Bool,                   -- ^ @-keywords@
  stylesheetfile' :: Maybe FilePath,  -- ^ @-stylesheetfile@
  docencoding' :: Maybe String        -- ^ @-docencoding@
}

-- | A @Javadoc@ with nothing set.
javadoc ::
  Javadoc
javadoc =
  Javadoc Nothing False False False False False Nothing Nothing [] [] [] [] False [] Nothing [] False Nothing Nothing False [] Nothing False False False False False Nothing Nothing Nothing Nothing Nothing Nothing [] [] [] [] False False [] False False False False False False False False [] False False Nothing Nothing False Nothing False Nothing Nothing

instance Overview Javadoc where
  overview x j =
    j { overview' = x }

  getOverview =
    overview'

instance Public Javadoc where
  setPublic j =
    j { public = True }

  unsetPublic j =
    j { public = False }

instance Protected Javadoc where
  setProtected j =
    j { protected = True }

  unsetProtected j =
    j { protected = False }

instance Package Javadoc where
  setPackage j =
    j { package = True }

  unsetPackage j =
    j { package = False }

instance Private Javadoc where
  setPrivate j =
    j { private = True }

  unsetPrivate j =
    j { private = False }

instance Help Javadoc where
  setHelp j =
    j { help = True }

  unsetHelp j =
    j { help = False }

instance Doclet Javadoc where
  doclet x j =
    j { doclet' = x }

  getDoclet =
    doclet'

instance Docletpath Javadoc where
  docletpath x j =
    j { docletpath' = x }

  getDocletpath =
    docletpath'

instance Sourcepath Javadoc where
  sourcepath x j =
    j { sourcepath' = x }

  getSourcepath =
    sourcepath'

instance Classpath Javadoc where
  classpath x j =
    j { classpath' = x }

  getClasspath =
    classpath'

instance Exclude Javadoc where
  exclude x j =
    j { exclude' = x }

  getExclude =
    exclude'

instance Subpackages Javadoc where
  subpackages x j =
    j { subpackages' = x }

  getSubpackages =
    subpackages'

instance Breakiterator Javadoc where
  setBreakiterator j =
    j { breakiterator = True }

  unsetBreakiterator j =
    j { breakiterator = False }

instance Bootclasspath Javadoc where
  bootclasspath x j =
    j { bootclasspath' = x }

  getBootclasspath =
    bootclasspath'

instance Source Javadoc where
  source x j =
    j { source' = x }

  getSource =
    source'

instance Extdirs Javadoc where
  extdirs x j =
    j { extdirs' = x }

  getExtdirs =
    extdirs'

instance Verbose Javadoc where
  setVerbose j =
    j { verbose = True }

  unsetVerbose j =
    j { verbose = False }

instance Locale Javadoc where
  locale x j =
    j { locale' = x }

  getLocale =
    locale'

instance Encoding Javadoc where
  encoding x j =
    j { encoding' = x }

  getEncoding =
    encoding'

instance Quiet Javadoc where
  setQuiet j =
    j { quiet = True }

  unsetQuiet j =
    j { quiet = False }

instance Flags Javadoc where
  flags x j =
    j { flags' = x }

  getFlags =
    flags'

instance Directory Javadoc where
  directory x j =
    j { directory' = x }

  getDirectory =
    directory'

instance Use Javadoc where
  setUse j =
    j { use = True }

  unsetUse j =
    j { use = False }

instance Version Javadoc where
  setVersion j =
    j { version = True }

  unsetVersion j =
    j { version = False }

instance Author Javadoc where
  setAuthor j =
    j { author = True }

  unsetAuthor j =
    j { author = False }

instance Docfilessubdirs Javadoc where
  setDocfilessubdirs j =
    j { docfilessubdirs = True }

  unsetDocfilessubdirs j =
    j { docfilessubdirs = False }

instance Splitindex Javadoc where
  setSplitindex j =
    j { splitindex = True }

  unsetSplitindex j =
    j { splitindex = False }

instance Windowtitle Javadoc where
  windowtitle x j =
    j { windowtitle' = x }

  getWindowtitle =
    windowtitle'

instance Doctitle Javadoc where
  doctitle x j =
    j { doctitle' = x }

  getDoctitle =
    doctitle'

instance Header Javadoc where
  header x j =
    j { header' = x }

  getHeader =
    header'

instance Footer Javadoc where
  footer x j =
    j { footer' = x }

  getFooter =
    footer'

instance Top Javadoc where
  top x j =
    j { top' = x }

  getTop =
    top'

instance Bottom Javadoc where
  bottom x j =
    j { bottom' = x }

  getBottom =
    bottom'

instance Link Javadoc where
  link x j =
    j { link' = x }

  getLink =
    link'

instance Linkoffline Javadoc where
  linkoffline x j =
    j { linkoffline' = x }

  getLinkoffline =
    linkoffline'

instance Excludedocfilessubdir Javadoc where
  excludedocfilessubdir x j =
    j { excludedocfilessubdir' = x }

  getExcludedocfilessubdir =
    excludedocfilessubdir'

instance Group Javadoc where
  group x j =
    j { group' = x }

  getGroup =
    group'

instance Nocomment Javadoc where
  setNocomment j =
    j { nocomment = True }

  unsetNocomment j =
    j { nocomment = False }

instance Nodeprecated Javadoc where
  setNodeprecated j =
    j { nodeprecated = True }

  unsetNodeprecated j =
    j { nodeprecated = False }

instance Noqualifier Javadoc where
  noqualifier x j =
    j { noqualifier' = x }

  getNoqualifier =
    noqualifier'

instance Nosince Javadoc where
  setNosince j =
    j { nosince = True }

  unsetNosince j =
    j { nosince = False }

instance Notimestamp Javadoc where
  setNotimestamp j =
    j { notimestamp = True }

  unsetNotimestamp j =
    j { notimestamp = False }

instance Nodeprecatedlist Javadoc where
  setNodeprecatedlist j =
    j { nodeprecatedlist = True }

  unsetNodeprecatedlist j =
    j { nodeprecatedlist = False }

instance Notree Javadoc where
  setNotree j =
    j { notree = True }

  unsetNotree j =
    j { notree = False }

instance Noindex Javadoc where
  setNoindex j =
    j { noindex = True }

  unsetNoindex j =
    j { noindex = False }

instance Nohelp Javadoc where
  setNohelp j =
    j { nohelp = True }

  unsetNohelp j =
    j { nohelp = False }

instance Nonavbar Javadoc where
  setNonavbar j =
    j { nonavbar = True }

  unsetNonavbar j =
    j { nonavbar = False }

instance Serialwarn Javadoc where
  setSerialwarn j =
    j { serialwarn = True }

  unsetSerialwarn j =
    j { serialwarn = False }

instance Tag Javadoc where
  tag x j =
    j { tag' = x }

  getTag =
    tag'

instance Taglet Javadoc where
  setTaglet j =
    j { taglet = True }

  unsetTaglet j =
    j { taglet = False }

instance Tagletpath Javadoc where
  setTagletpath j =
    j { tagletpath = True }

  unsetTagletpath j =
    j { tagletpath = False }

instance Charset Javadoc where
  charset x j =
    j { charset' = x }

  getCharset =
    charset'

instance Helpfile Javadoc where
  helpfile x j =
    j { helpfile' = x }

  getHelpfile =
    helpfile'

instance Linksource Javadoc where
  setLinksource j =
    j { linksource = True }

  unsetLinksource j =
    j { linksource = False }

instance Sourcetab Javadoc where
  sourcetab x j =
    j { sourcetab' = x }

  getSourcetab =
    sourcetab'

instance Keywords Javadoc where
  setKeywords j =
    j { keywords = True }

  unsetKeywords j =
    j { keywords = False }

instance Stylesheetfile Javadoc where
  stylesheetfile x j =
    j { stylesheetfile' = x }

  getStylesheetfile =
    stylesheetfile'

instance Docencoding Javadoc where
  docencoding x j =
    j { docencoding' = x }

  getDocencoding =
    docencoding'

instance Options Javadoc where
  options (Javadoc overview'
                   public'
                   protected'
                   package'
                   private'
                   help'
                   doclet'
                   docletpath'
                   sourcepath'
                   classpath'
                   exclude'
                   subpackages'
                   breakiterator'
                   bootclasspath'
                   source'
                   extdirs'
                   verbose'
                   locale'
                   encoding'
                   quiet'
                   flags'
                   directory'
                   use'
                   version'
                   author'
                   docfilessubdirs'
                   splitindex'
                   windowtitle'
                   doctitle'
                   header'
                   footer'
                   top'
                   bottom'
                   link'
                   linkoffline'
                   excludedocfilessubdir'
                   group'
                   nocomment'
                   nodeprecated'
                   noqualifier'
                   nosince'
                   notimestamp'
                   nodeprecatedlist'
                   notree'
                   noindex'
                   nohelp'
                   nonavbar'
                   serialwarn'
                   tag'
                   taglet'
                   tagletpath'
                   charset'
                   helpfile'
                   linksource'
                   sourcetab'
                   keywords'
                   stylesheetfile'
                   docencoding') =
    let g ^^^ t      = intercalate t (filter (not . null) g)
        param k c s  = (~?) (\z -> '-' : k ++ c : quote (s z))
        g ~~ k       = if k then '-' : g else []
        (~?)         = maybe []
        s ~: z       = if null z then [] else '-' : s ++ ' ' : [searchPathSeparator] >===< z
        s >===< k    = intercalate s (fmap quote k)
        quote s      = '"' : (s >>= \x -> if x == '"' then "\\\"" else [x]) ++ "\""
        (~~>) k      = param k ' ' show
        (~~~>) = (. Just) . (~~>)
        many k v = intercalate " " $ map (k ~~~>) v
        manys f k = many k . map f
        c = intercalate ":"
    in [ "overview" ~~> overview'
       , "public" ~~ public'
       , "protected" ~~ protected'
       , "package" ~~ package'
       , "private" ~~ private'
       , "help" ~~ help'
       , "doclet" ~~> doclet'
       , "docletpath" ~~> docletpath'
       , "sourcepath" ~: sourcepath'
       , "classpath" ~: classpath'
       , "exclude" ~: exclude'
       , "subpackages" ~: subpackages'
       , "breakiterator" ~~ breakiterator'
       , "bootclasspath" ~: bootclasspath'
       , "source" ~~> source'
       , "extdirs" ~: extdirs'
       , "verbose" ~~ verbose'
       , "locale" ~~> locale'
       , "encoding" ~~> encoding'
       , "quiet" ~~ quiet'
       , intercalate " " $ map ("-J" ++) flags'
       , "d" ~~> directory'
       , "use" ~~ use'
       , "version" ~~ version'
       , "author" ~~ author'
       , "docfilessubdirs" ~~ docfilessubdirs'
       , "splitindex" ~~ splitindex'
       , "windowtitle" ~~> windowtitle'
       , "doctitle" ~~> doctitle'
       , "header" ~~> header'
       , "footer" ~~> footer'
       , "top" ~~> top'
       , "bottom" ~~> bottom'
       , "link" `many` link'
       , manys (\(x, y) -> x ++ "\" \"" ++ y) "linkoffline" linkoffline'
       , intercalate ":" excludedocfilessubdir'
       , manys (\(x, y) -> x ++ "\" \"" ++ c y) "group" group'
       , "nocomment" ~~ nocomment'
       , "nodeprecated" ~~ nodeprecated'
       , intercalate ":" noqualifier'
       , "nosince" ~~ nosince'
       , "notimestamp" ~~ notimestamp'
       , "nodeprecatedlist" ~~ nodeprecatedlist'
       , "notree" ~~ notree'
       , "noindex" ~~ noindex'
       , "nohelp" ~~ nohelp'
       , "nonavbar" ~~ nonavbar'
       , "serialwarn" ~~ serialwarn'
       , manys (\(x, y, z) -> c [x, y, z]) "tag" tag'
       , "taglet" ~~ taglet'
       , "tagletpath" ~~ tagletpath'
       , "charset" ~~> charset'
       , "helpfile" ~~> helpfile'
       , "linksource" ~~ linksource'
       , "sourcetab" ~~> sourcetab'
       , "keywords" ~~ keywords'
       , "stylesheetfile" ~~> stylesheetfile'
       , "docencoding" ~~> docencoding'
       ] ^^^ " "

instance Extensions Javadoc where
  isSourceExtension _ =
    (== "java")

  isTargetExtension _ _ =
    True

instance ExecCommand IO Javadoc where
  command _ =
    let envs = [
                 ("JAVADOC_HOME", (</> "bin" </> "javadoc"))
               , ("JDK_HOME", (</> "bin" </> "javadoc"))
               , ("JAVADOC", id)
               ]
        tryEnvs es =
          do e <- getEnvironment
             let k [] = Nothing
                 k ((a, b):t) = fmap b (a `lookup` e) `mplus` k t
             return (k es)
    in fromMaybe "javadoc" `fmap` tryEnvs envs
