> {-# LANGUAGE Arrows #-}

> module DigitalSignWaves where
> import Euterpea

> period = 1.0 -- In seconds
> pitchfrequency = 440.0  -- Concert Pitch

> sineTable     = tableSinesN 16384 [1]
> oscSine = osc sineTable 0
> sine :: AudSF () Double
> sine = 
>     proc _ -> do
>       oscSine -< pitchfrequency

> linearTable = tableLinear 10 0.0 [(0.0,10.0)]
> oscLinear = osc linearTable 0
> sineLinear :: AudSF () Double
> sineLinear =
>     proc _ -> do
>       oscLinear -< pitchfrequency


> test :: AudSF () Double -> IO ()
> test = outFile "test.wav" period
