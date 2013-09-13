hsc3-server-utils
-----------------

This package exports a single module, `Sound.SC3.Server.Utils`.
It defines a function `quickSynth` which calls
 `Sound.SC3.Server.State.Monad.Process.withSynth` with default arguments,
 outputting all scsynth output to "scsynth.out".
It also re-exports `Sound.SC3.Server.State.Monad`
 and `Sound.SC3.Server.State.Command`.

