> {-# LANGUAGE Arrows #-}

> import Euterpea

> sineTable :: Table
> sineTable = tableSinesN 4096 [1]

> sine440 :: AudSF () Double
> sine440 =
>    proc _ -> do
>       y <- osc sineTable 0 -< 440
>       returnA -< y

> main = outFile "HSoM/Examples/docs/sine440.wav" 2.0 sine440
