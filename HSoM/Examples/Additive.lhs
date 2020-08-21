> {-#  LANGUAGE Arrows  #-}

> module HSoM.Examples.Additive where
> import Euterpea
> import FRP.UISF.AuxFunctions


> tab1 = tableSinesN 4096 [1]

> bell1  :: Instr (Mono AudRate)
>        -- Dur -> AbsPitch -> Volume -> AudSF () Double
> bell1 dur ap vol [] = 
>   let  f    = apToHz ap
>        v    = fromIntegral vol / 100
>        d    = fromRational dur
>        sfs  = map  (\p-> constA (f*p) >>> osc tab1 0) 
>                    [4.07, 3.76, 3, 2.74, 2, 1.71, 1.19, 0.92, 0.56]
>   in proc () -> do
>        aenv  <- envExponSeg [0,1,0.001] [0.003,d-0.003] -< ()
>        a1    <- foldSF (+) 0 sfs -< ()
>        outA -< a1*aenv*v/9


> tab1' = tableSines3N 4096 [(4.07,1,0), (3.76,1,0), (3,1,0),
>   (2.74,1,0), (2,1,0), (1.71,1,0), (1.19,1,0), (0.92,1,0), (0.56,1,0)]

> bell'1  :: Instr (Mono AudRate)
> bell'1 dur ap vol [] = 
>   let  f    = apToHz ap
>        v    = fromIntegral vol / 100
>        d    = fromRational dur
>   in proc () -> do
>        aenv  <- envExponSeg [0,1,0.001] [0.003,d-0.003] -< ()
>        a1    <- osc tab1' 0 -< f
>        outA -< a1*aenv*v

> bellTest1 = outFile "HSoM/Examples/docs/bell1.wav" 6 (bell1 6 (absPitch (C,5)) 100 []) 


> mySF f d p = proc () -> do
>                s     <- osc tab1 0 <<< constA (f*p) -< ()
>                aenv  <- envExponSeg [0,1,0.001] [0.003,d/p-0.003] -< ()
>                outA  -< s*aenv

> bell2  :: Instr (Mono AudRate)
>        -- Dur -> AbsPitch -> Volume -> AudSF () Double
> bell2 dur ap vol [] = 
>   let  f    = apToHz ap
>        v    = fromIntegral vol / 100
>        d    = fromRational dur
>        sfs  = map  (mySF f d)
>                    [4.07, 3.76, 3, 2.74, 2, 1.71, 1.19, 0.92, 0.56]
>   in proc () -> do
>        a1    <- foldSF (+) 0 sfs -< ()
>        outA  -< a1*v/9

> bellTest1' = outFile "HSoM/Examples/docs/bell'1.wav" 6 (bell'1 6 (absPitch (C,5)) 100 [])

> bellTest2 = outFile "HSoM/Examples/docs/bell2.wav" 6 (bell2 6 (absPitch (C,5)) 100 []) 


> sineTable :: Table
> sineTable = tableSinesN 4096 [1]

> env1 :: AudSF () Double
> env1 = envExpon 20 10 10000

> good = outFile "HSoM/Examples/docs/good.wav" 10 
>        (osc sineTable 0 <<< envExpon 20 10 10000 :: AudSF () Double)

> bad  = outFile "HSoM/Examples/docs/bad.wav" 10 
>        (osc sineTable 0 <<< envLine  20 10 10000 :: AudSF () Double)

> sfTest1 :: AudSF (Double,Double) Double -> Instr (Mono AudRate)
>         -- AudSF (Double,Double) Double -> 
>         -- Dur -> AbsPitch -> Volume -> [Double] -> AudSF () Double
> sfTest1 sf dur ap vol [] =
>   let f = apToHz ap
>       v = fromIntegral vol / 100
>   in proc () -> do
>        a1 <- osc sineTable 0 <<< env1 -< () 
>        a2 <- sf -< (a1,f)
>        outA -< a2*v


> tLow    =  outFile "HSoM/Examples/docs/low.wav" 10 $
>            sfTest1 filterLowPass 10 (absPitch (C,5)) 80 []

> tHi     =  outFile "HSoM/Examples/docs/hi.wav" 10 $
>            sfTest1 filterHighPass 10 (absPitch (C,5)) 80 []

> tLowBW  =  outFile "HSoM/Examples/docs/lowBW.wav" 10 $
>            sfTest1 filterLowPassBW 10 (absPitch (C,5)) 80 []

> tHiBW   =  outFile "HSoM/Examples/docs/hiBW.wav" 10 $
>            sfTest1 filterHighPassBW 10 (absPitch (C,5)) 80 []

> addBandWidth ::  AudSF (Double,Double,Double) Double ->
>                  AudSF (Double,Double) Double

> addBandWidth filter =
>   proc (a,f) -> do filter -< (a,f,200)

> tBP    =  outFile "HSoM/Examples/docs/bp.wav" 10 $
>           sfTest1 (addBandWidth (filterBandPass 1)) 10 (absPitch (C,6)) 80 []

> tBS    =  outFile "HSoM/Examples/docs/bs.wav" 10 $
>           sfTest1 (addBandWidth (filterBandStop 1)) 10 (absPitch (C,6)) 80 []

> tBPBW  =  outFile "HSoM/Examples/docs/bpBW.wav" 10 $
>           sfTest1 (addBandWidth filterBandPassBW) 10 (absPitch (C,6)) 80 []

> tBSBW  =  outFile "HSoM/Examples/docs/bsBW.wav" 10 $
>           sfTest1 (addBandWidth filterBandStopBW) 10 (absPitch (C,6)) 80 []


> noise1  :: Instr (Mono AudRate)
>         -- Dur -> AbsPitch -> Volume -> [Double] -> AudSF () Double
> noise1 dur ap vol [] = 
>   let  v = fromIntegral vol / 100
>   in proc () -> do
>        a1    <- noiseWhite 42 -< ()
>        outA  -< a1*v
> test1 = outFile "HSoM/Examples/docs/noise1.wav" 6 (noise1 6 (absPitch (C,5)) 100 []) 


> env2 :: AudSF () Double
> env2 = envExpon 1 10 2000

> sfTest2  :: AudSF (Double,Double,Double) Double -> Instr (Mono AudRate)
>          -- AudSF (Double,Double,Double) Double -> 
>          -- Dur -> AbsPitch -> Volume -> [Double] -> AudSF () Double
> sfTest2 sf dur ap vol [] =
>   let  f = apToHz ap
>        v = fromIntegral vol / 100
>   in proc () -> do
>        a1 <- noiseWhite 42 -< ()
>        bw <- env2 -< ()
>        a2 <- sf -< (a1,f,bw)
>        outA -< a2

> tBP'    =  outFile "HSoM/Examples/docs/bp'.wav" 10 $
>            sfTest2 (filterBandPass 1) 10 (absPitch (C,5)) 80 []

> tBS'    =  outFile "HSoM/Examples/docs/bs'.wav" 10 $
>            sfTest2 (filterBandStop 1) 10 (absPitch (C,5)) 80 []

> tBPBW'  =  outFile "HSoM/Examples/docs/bpBW'.wav" 10 $
>            sfTest2 filterBandPassBW 10 (absPitch (C,5)) 80 []

> tBSBW'  =  outFile "HSoM/Examples/docs/bsBW'.wav" 10 $
>            sfTest2 filterBandStopBW 10 (absPitch (C,5)) 80 []


> noise2  :: Instr (Mono AudRate)
> noise2 dur ap vol [] = 
>   let  f = apToHz ap
>        v = fromIntegral vol / 100
>   in proc () -> do
>        a1    <- noiseBLI 42 -< f
>        outA  -< a1*v

> test2 = outFile "HSoM/Examples/docs/noise2.wav" 6 (noise2 6 (absPitch (C,5)) 100 []) 


> ss1  :: Instr (Mono AudRate)
> ss1 dur ap vol [] = 
>   let  v    = fromIntegral vol / 100
>   in proc () -> do
>        a1    <- noiseWhite 42 -< ()
>        a2    <- filterBandPass 2 -< (a1, 1000, 200)
>        outA  -< a2*v/5

> test3 = outFile "HSoM/Examples/docs/ss1.wav" 6 (ss1 6 (absPitch (C,5)) 100 []) 


> wind :: Instr (Mono AudRate)
> wind dur ap vol [] = 
>   let  f = apToHz ap
>        v = fromIntegral vol / 100
>   in proc () -> do
>        a1    <- noiseWhite 42 -< ()
>        lfo1  <- osc sineTable 0 -< 0.9
>        lfo2  <- osc sineTable 0 -< 1.3
>        a2    <- filterBandPass 2 -< (a1, f + 100*(lfo1+lfo2), 200)
>        outA  -< a2*v/5

> test4 = outFile "HSoM/Examples/docs/wind.wav" 6 (wind 6 (absPitch (C,7)) 100 []) 


> buzzy  :: Instr (Mono AudRate)
> buzzy dur ap vol [] = 
>   let  f    = apToHz ap
>        v    = fromIntegral vol / 100
>   in proc () -> do
>        a1 <- oscPartials sineTable 0 -< (f,20)
>        outA -< a1*v

> test5 = outFile "HSoM/Examples/docs/buzzy.wav" 6 (buzzy 6 (absPitch (C,5)) 100 []) 


> buzzy2 :: Instr (Mono AudRate)
> buzzy2 dur ap vol [] = 
>   let  f    = apToHz ap
>        v    = fromIntegral vol / 100
>        d    = fromRational dur
>   in proc () -> do
>        a1   <- oscPartials sineTable 0 -< (f,20)
>        env  <- envExponSeg [0, 1, 0.001] [0.003, d - 0.003] -< ()
>        a2   <- filterLowPass -< (a1,20000*env)
>        outA -< a2*v*env

> test6 = outFile "HSoM/Examples/docs/buzzy2.wav" 6 (buzzy2 6 (absPitch (C,5)) 100 []) 

> scifi1 :: Instr (Mono AudRate)
> scifi1 dur ap vol [] = 
>   let  v    = fromIntegral vol / 100
>   in proc () -> do
>        a1 <- noiseBLH 42 -< 8
>        a2 <- osc sineTable 0 -< 600 + 200*a1
>        outA -< a2*v

> test7 = outFile "HSoM/Examples/docs/scifi1.wav" 10 (scifi1 10 (absPitch (C,5)) 100 []) 


> scifi2 :: Instr (Mono AudRate)
> scifi2 dur ap vol [] = 
>   let  v    = fromIntegral vol / 100
>   in proc () -> do
>        a1 <- noiseBLI 44 -< 8
>        a2 <- osc sineTable 0 -< 600 + 200*a1
>        outA -< a2*v

> test8 = outFile "HSoM/Examples/docs/scifi2.wav" 10 (scifi2 10 (absPitch (C,5)) 100 []) 
