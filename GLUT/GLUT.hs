-- GLUT.hs
module Main where

import Graphics.UI.GLUT (($=), getArgsAndInitialize, createWindow, displayCallback, mainLoop)

main :: IO ()
main = do
  (_progName, _args) <- getArgsAndInitialize
  _window <- createWindow "Hello World"
  displayCallback $= return ()
  mainLoop

