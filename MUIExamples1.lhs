
http://www.euterpea.com/download-and-installation/

Compiling to Executable

On newer Macs, MUIs will not work from the GHCi interpreter. Failure cases range from unresponsive windows to threading errors. However, if this happens to you, you will still be able to run MUIs successfully by compiling your code to executable. Windows users can also benefit from compiling to executable with some MUIs because it can help speed up execution between frames, which is useful for interactive programs.

The easiest way to try compiling a MUI to executable the first time is to use one of the MUI example that comes included with HSoM. 


> module Main where
> import HSoM.Examples.MUIExamples1

Based on your test use the desired switch on the command line

> import System.Environment
> import Data.List  

> main :: IO ()
> main = do  
>    args <- getArgs
>    case args of 
>      x:xs 
>         | x == "mui0" -> mui0
>         | x == "mui1" -> mui1
>         | x == "mui2" -> mui2
>         | x == "mui3" -> mui3
>         | x == "mui4" -> mui4
>         | x == "mui'4" -> mui'4
>         | x == "mui5" -> mui5
>         | x == "colorSwatch" -> colorSwatch
>      _ -> do
>         name <- getProgName
>         putStrLn $ "usage: " ++ name ++ " <string>" ++ " where" ++ " <string> equals mui0 or colorSwatch"

Then, run compile this program to executable from a terminal with:

ghc MUIExamples1.lhs

and then run it with this.

./MUIExamples1 mui0

