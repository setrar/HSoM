> import Euterpea

In music theory, a pitch consists of a pitch class and an octave

> concertA,a440 ::(PitchClass,Octave)
> concertA = (A, 4) -- concert A
> a440 = (A, 4) -- A440

Both can be played like:

*Main> play ( note qn a440 )
*Main> play ( note qn concertA  )

> t251 :: Music Pitch
> t251 = let dMinor = d 4 wn :=: f 4 wn :=: a 4 wn
>            gMajor = g 4 wn :=: b 4 wn :=: d 5 wn
>            cMajor = c 4 bn :=: e 4 bn :=: g 4 bn
>        in dMinor :+: gMajor :+: cMajor

> oos = ( Modify (Instrument VoiceOohs    ) (line [c 4 en, e 4 sn]))

twoFiveOne :: Pitch -> Dur -> Music Pitch 
