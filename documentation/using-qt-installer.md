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

1. Clone the Qt Installer Framework source code from git://code.qt.io/installer-framework/installer-framework.git
2. Open installerfw.pro, run qmake, set your build target to Qt Static, then build release -> 'binarycreator'
3. Check the "Compile Output" to find where the compiled binaries are placed. They should be located in a 'bin' directory within the build-installerfw... directory.

4. **Important** Each of these paths must exist in System Varibles -> Paths: (Adjust the path as applicable to your environment)

    ```
    D:\Qt\5.10.1\mingw53_32\bin\
    D:\Qt\Tools\mingw530_32\bin\
    D:\Qt\Tools\mingw530_32\bin\g++.exe
    ```

5. Reboot after setting variables.

# Building the installer (Scripted - recommended)

1. Build the latest **release** xcite.exe 
2. Run MSYS2/MINGW32/Git Terminal
3. Ensure the following executables are in your shell path: windeployqt.exe gcc.exe archivegen.exe binarycreator.exe
    
    ```
    export PATH="/d/My Documents/GitHub/build-installerfw-Desktop_Qt_5_10_1_MinGW_32bit_Static-Release/bin:/d/Qt/Tools/mingw530_32/bin:/d/Qt/5.10.1/mingw53_32/bin:$PATH"
    ```

4. Change into xcite directory and run ./build-windows.installer.sh

This will:

- Determine version from the package.xml file 
- Clear out all previous dynamic build files and any existing installer/7z files for the same version
- Collect the dynamic assets in build/release
- Copy in the OpenSSL DLLs from support/ (save us getting everyone to build them)
- Create a versioned 7z file in packages/
- Create a versioned installer in the xcite directory

# Building the installer (Manual - not recommended)

## Build application and add dependencies

1. Paths are specific to my system as an example - change them as needed to match your system's paths.
2. Rebuild xcite targetting "release" with Qt non-Static.
3. Open CMD in `D:\My Documents\GitHub\Xtrabytes\xcite\build\release` and run:

    `D:\Qt\5.10.1\mingw53_32\bin\windeployqt --compiler-runtime --release xcite.exe --qmldir ../../frontend`

## Achive files

(Manual) Add all the contents of "D:\My Documents\GitHub\Xtrabytes\xcite\build\release" to a new 7z archive named "xcite-0.1.4-windows.7z" and move the archive to:
```
D:\My Documents\GitHub\Xtrabytes\xcite\packages\global.xtrabytes.xcite\data\xcite-0.1.4-windows.7z
```

(Using Archivegen)
```
archivegen.exe "D:\My Documents\GitHub\Xtrabytes\xcite\packages\global.xtrabytes.xcite\data\xcite-0.1.4-windows.7z" "D:\My Documents\GitHub\Xtrabytes\xcite\build\release\"
```

## Build installer

Open cmd in `D:\My Documents\GitHub\Xtrabytes\xcite` and run the following command:
```
"D:\My Documents\GitHub\build-installerfw-Desktop_Qt_5_10_1_MinGW_32bit_Static-Release\bin\binarycreator.exe" -c config\config.xml -p packages XCITE-0.1.4-Windows.exe
```

# Reference

http://doc.qt.io/qtinstallerframework/ifw-globalconfig.html
