
http://www.euterpea.com/download-and-installation/

Compiling to Executable

On newer Macs, MUIs will not work from the GHCi interpreter. Failure cases range from unresponsive windows to threading errors. However, if this happens to you, you will still be able to run MUIs successfully by compiling your code to executable. Windows users can also benefit from compiling to executable with some MUIs because it can help speed up execution between frames, which is useful for interactive programs.

The easiest way to try compiling a MUI to executable the first time is to use one of the MUI example that comes included with HSoM. 


> module Main where
> import HSoM.Examples.MUIExamples2

Based on your test uncomment the below lines to reach the desired main

> main = buildChord

-- > main = bifurcate

-- > main = echo

Then, run compile this program to executable from a terminal with:

ghc MUIExamples2.lhs

and then run it with this.

./MUIExamples2

