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

import qualified System.IO as IO


withSynthOutput :: Maybe FilePath -> Server a -> IO a
withSynthOutput outfile = case outfile of
    Nothing -> defaultSynth noHandler
    Just fp -> \m -> IO.withFile fp IO.WriteMode $ \h -> do
        IO.hSetBuffering h IO.LineBuffering
        defaultSynth (fileHandler h) m
  where
    defaultSynth :: OutputHandler -> Server a -> IO a
    defaultSynth = withSynth defaultServerOptions defaultRTOptions

    noHandler = OutputHandler (\_ -> return ()) (\_ -> return ())

    fileHandler h = let p = IO.hPutStrLn h in OutputHandler p p


-- | Start the default scsynth server, sending output to "scsynth.out"
quickSynth :: Server a -> IO a
quickSynth = withSynthOutput $ Just "scsynth.out"
