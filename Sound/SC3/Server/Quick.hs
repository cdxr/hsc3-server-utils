module Sound.SC3.Server.Quick
( withSynthOutput
, quickSynth
, module Sound.SC3.Server.State.Monad
, module Sound.SC3.Server.State.Monad.Command
) where

import Sound.SC3.Server.State.Monad
import Sound.SC3.Server.State.Monad.Command
import Sound.SC3.Server.State.Monad.Process ( withSynth )

import Sound.SC3.Server.Process
    ( OutputHandler (..)
    , defaultServerOptions
    , defaultRTOptions
    )

import System.IO


withSynthOutput :: Maybe FilePath -> Server a -> IO a
withSynthOutput outfile m = case outfile of
    Nothing -> defaultSynth noHandler m
    Just fp -> withFile fp WriteMode $ \h ->
        defaultSynth (fileHandler h) m
  where
    defaultSynth :: OutputHandler -> Server a -> IO a
    defaultSynth = withSynth defaultServerOptions defaultRTOptions

    noHandler = OutputHandler (\_ -> return ()) (\_ -> return ())

    fileHandler h = OutputHandler p p
      where
        p s = hPutStrLn h s >> hFlush h


-- | Start the default scsynth server, sending output to "scsynth.out"
quickSynth :: Server a -> IO a
quickSynth = withSynthOutput $ Just "scsynth.out"
