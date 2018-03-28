# Overview of Qt Installer file structure

config.xml (global configuration, metadata about installer)
- Name
- Title
- Version
- TargetDir

packages:
- package.xml (metadata about the package)
- data

binary creator (integrates these items into one single installer)

# Setting up Qt Installer Framework

Clone the Qt Installer Framework source code from git://code.qt.io/installer-framework/installer-framework.git

Open installerfw.pro, run qmake, set your build target to Qt Static, then build release -> 'binarycreator'

Check the "Compile Output" to find where the compiled binaries are placed. They should be located in a 'bin' directory within the build-installerfw... directory.

**Important** Each of these paths must exist in System Varibles -> Paths: (Adjust the path as applicable to your environment)
D:\Qt\5.10.1\mingw53_32\bin\
D:\Qt\Tools\mingw530_32\bin\
D:\Qt\Tools\mingw530_32\bin\g++.exe

Reboot after setting variables.

# Build application and add dependencies

Paths are specific to my system as an example - change them as needed to match your system's paths.

Rebuild xcite targetting "release" with Qt non-Static.

Open CMD in D:\My Documents\GitHub\Xtrabytes\xcite\build\release and run: D:\Qt\5.10.1\mingw53_32\bin\windeployqt --compiler-runtime --release xcite.exe --qmldir ../../frontend

# Achive files

Add all the contents of "D:\My Documents\GitHub\Xtrabytes\xcite\build\release" to a new 7z archive named "xcite-0.1.4-windows.7z" and move the archive to:
"D:\My Documents\GitHub\Xtrabytes\xcite\packages\global.xtrabytes.xcite\data\xcite-0.1.4-windows.7z"

This command does the same thing but archives the "release" directory itself - I need to figure out how to make it archive just the directory contents instead:
archivegen.exe "D:\My Documents\GitHub\Xtrabytes\xcite\packages\global.xtrabytes.xcite\data\xcite-0.1.4-windows.7z" "D:\My Documents\GitHub\Xtrabytes\xcite\build\release"

# Build installer

Open cmd in D:\My Documents\GitHub\Xtrabytes\xcite

"D:\My Documents\GitHub\build-installerfw-Desktop_Qt_5_10_1_MinGW_32bit_Static-Release\bin\binarycreator.exe" -c config\config.xml -p packages XCITE-0.1.4-Windows.exe

# Reference

http://doc.qt.io/qtinstallerframework/ifw-globalconfig.html
