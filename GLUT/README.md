# GLUT

## Install the GLUT Library (optional when using the c HsGLUT linkage file)

```
$ cabal install GLFW-0.5.2.5
```

or using cabal 3.X

```
$ cabal v1-install GLFW-0.5.2.5
```

## Compile the sources

```
$ ghc HsGLUT.c GLUT2.hs
```

## Execute

```
$ ./GLUT
```

## Uninstall GLFW

```
$ ghc-pkg unregister GLFW-0.5.2.
```

# References

https://gitlab.haskell.org/ghc/ghc/-/issues/13730
