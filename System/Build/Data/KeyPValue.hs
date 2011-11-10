module System.Build.Data.KeyPValue where

 -- todo abstract
data KeyPValue = KeyPValue {
  keys :: [String]
, values :: Maybe String
}
