#!/bin/sh
mcs *.cs -out:VMCompiler.exe && mono VMCompiler.exe $@