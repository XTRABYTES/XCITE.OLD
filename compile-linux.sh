#!/bin/bash

qmake "RELEASE=1" xcite.pro

make -j4 -f Makefile