module System.Build.Access.Stylesheetfile where

class Stylesheetfile r where
  stylesheetfile ::
    Maybe FilePath
    ->  r
    ->  r

  getStylesheetfile ::
    r
    ->  Maybe FilePath


