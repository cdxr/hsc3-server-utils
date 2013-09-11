quick-hsc3
----------

This package exists purely for the sake of my personal convenience.
It exports a single module, `Sound.SC3.Server.Quick`.
It defines a function `quickSynth` which calls
 `Sound.SC3.Server.State.Monad.Process.withSynth` with default arguments,
 outputting all scsynth output to "scsynth.out".
It also re-exports `Sound.SC3.Server.State.Monad`
 and `Sound.SC3.Server.State.Command`.

