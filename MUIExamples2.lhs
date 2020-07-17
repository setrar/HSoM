
http://www.euterpea.com/download-and-installation/

Compiling to Executable

On newer Macs, MUIs will not work from the GHCi interpreter. Failure cases range from unresponsive windows to threading errors. However, if this happens to you, you will still be able to run MUIs successfully by compiling your code to executable. Windows users can also benefit from compiling to executable with some MUIs because it can help speed up execution between frames, which is useful for interactive programs.

The easiest way to try compiling a MUI to executable the first time is to use one of the MUI example that comes included with HSoM. 


> module Main where
> import HSoM.Examples.MUIExamples2

Based on your test use the desired switch on the command line

> import System.Environment
> import Data.List

> main :: IO ()
> main = do
>    args <- getArgs
>    case args of
>      x:xs
>         | x == "buildChord" -> buildChord
>         | x == "bifurcate" -> bifurcate
>         | x == "echo" -> echo
>      _ -> do
>         name <- getProgName
>         putStrLn $ "usage: " ++ name ++ " <string>" ++ " where" ++ " <string> equals bifurcate or echo"

Then, run compile this program to executable from a terminal with:

ghc MUIExamples2.lhs

and then run it with this.

./MUIExamples2 echo

