

# References

GUI https://gitlab.haskell.org/ghc/ghc/-/issues/13730


Virtual MIDI Keyboard 

```
$ brew cask install vmpk
```

```
$  cabal v1-install Euterpea UISF pure-fft
```

In `ghci` load `MusicToSignal` program file and run main. The program will generate a file `song.wav`.

```
Prelude> :l HSoM/Examples/MusicToSignal.lhs
*HSoM.Examples.MusicToSignal> main
```


Page `xvi`: Tom Makucevich, ... Watching him toil endlessly with low-level [`csound`](https://csound.com/) programs ... Additionally, Matt Zamec helped me greatly in the creation of [HasSound](https://www.cs.yale.edu/homes/hudak-paul/CS431F06/HasSoundManual.html)
