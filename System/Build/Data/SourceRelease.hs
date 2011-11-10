module System.Build.Data.SourceRelease where

-- | Provide source compatibility with specified release
data SourceRelease =
  S15   -- ^ @1.5@
  | S14 -- ^ @1.4@
  | S13 -- ^ @1.3@
  deriving Eq

instance Show SourceRelease where
  show S15 =
    "1.5"
  show S14 =
    "1.4"
  show S13 =
    "1.3"
