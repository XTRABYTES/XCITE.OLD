![xcite_update_github](https://user-images.githubusercontent.com/17502298/40376087-78bb39f8-5dbb-11e8-9467-23edb26cd637.png)

<div align="center">
  <h3>
    <a href="https://xtrabytes.global">
      Website
    </a>
    <span> | </span>
    <a href="https://xtrabytes.global/whitepaper.pdf">
      Whitepaper
    </a>
    <span> | </span>
    <a href="https://discord.xtrabytes.global">
      Discord
    </a>
    <span> | </span>
    <a href="https://support.xtrabytes.global">
      Help Center
    </a>
  </h3>
</div>

<div align="center"><a href="https://twitter.com/xtrabytes" target="_blank"> <img src="https://img.shields.io/twitter/follow/XTRABYTES.svg?style=social"></a> <span>  </span>
<a href="https://github.com/XTRABYTES/XCITE/releases" target="_blank"> <img src="https://img.shields.io/github/downloads/XTRABYTES/XCITE/total.svg?label=XCITE%20Downloads&logoColor=blue&style=social"></a></div>


#                X C I T E
####  XTRABYTES Consolidated Interactive TErminal

XCITE is the core application utilizing the XTRABYTES Proof-of-Signature blockchain protocol. Built to support modules like a decentralized exchange and a fully-integrated chat protocol. The code-fluid architecture will let any developer use the XTRABYTES API and create their dream project. XCITE is poised to be a top contender in all-in-one decentralized applications.


# Our Mission

We aim to deliver a blockchain platform that provides users with superior speed, security, and scalability over present blockchain offerings. We have crafted a unique Proof of Signature consensus algorithm that obtains these benefits in an economical and eco-friendly manner. Our platform’s modular nature will allow users to assume an infinite capacity for growth. And with modularity driving our development pipeline, we will be able to institute enhanced usabilities for programmers and end-users alike. This includes code-agnostic APIs, superior technical support, and best-in-class user interfaces. All to achieve our vision of having users and developers view XTRABYTES as the premier blockchain platform within the cryptocurrency world.


## Table of Content

- [Features](#features)
- [Statistics](#statistics)
- [Getting Started](#getting-started)
  - [Prerequisites (Windows)](#prerequisites-windows)
  - [Prerequisites (macOS)](#prerequisites-macos)
- [Dependencies](#dependencies)
  - [Desktop Platform](#required-dependencies-for-the-desktop-platform-windows-macos-linux)
  - [Mobile Platform](#required-dependencies-for-the-mobile-platform-android-ios)
  - [MinGW (Windows)](#mingw-windows-only)
  - [Compiling (Desktop Platform)](#compiling-desktop-platforms-only)
- [Installing QT](#install-qt)
  - [Project Configuration (Android)](#project-configuration-android)
  - [Project Configuration (iOS)](#project-configuration-ios)
  - [Qt Troubleshooting Advice](#qt-troubleshooting-advice)
- [XCITE Desktop Screenshots](#xcite-desktop-screenshots)
- [XCITE Mobile Screenshots](#xcite-mobile-screenshots)
- [Contributing](#contributing)
- [Frequently Asked Questions](#frequently-asked-questions)
- [External Links](https://xtrabytes.global/)


## Features 
[![xcite_android_github](https://forthebadge.com/images/badges/built-for-android.svg)](#features)
[![forthebadge](https://forthebadge.com/images/badges/uses-html.svg)](#features)
[![forthebadge](https://forthebadge.com/images/badges/made-with-python.svg)](#features)

A few of the things you can do with XCITE:

- Ability to register several user accounts
- Wallet keys can be saved on your local device or on our servers
- Retrieve registered user accounts on different devices and platforms
- Import and export addresses
- Import private keys onto any supported devices
- Track and monitor the balance of wallets without the need of private keys
- Open device applications directly from the XCITE mobile app, such as the phone (call) app, sms/message app and email app
- Choose from 2 different wallet modes
  - View only mode (no transactions allowed)
  - Active view mode (transactions are allowed)
- Create and store contact entries such as phone numbers and emails
- Pinlock code authentication available for added security
- Receive notification alerts when wallet balance changes 
- Real time market prices
- 24 hour XBY, XFUEL, BTC and ETH price monitor
- Mobile platform available for Android and iOS
- Desktop platform available for Windows, macOS and Linux


## Statistics 

Some information regarding XCITE and its development:

[![GitHub contributors](https://img.shields.io/github/contributors-anon/XTRABYTES/XCITE.svg?logo=github)
![GitHub last commit](https://img.shields.io/github/last-commit/xtrabytes/xcite.svg?logo=github)
![GitHub issues](https://img.shields.io/github/issues/xtrabytes/xcite.svg?logo=github)
![GitHub closed issues](https://img.shields.io/github/issues-closed/xtrabytes/xcite.svg?logo=github)
![GitHub pull requests](https://img.shields.io/github/issues-pr/xtrabytes/xcite.svg?logo=github)
![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/xtrabytes/xcite.svg?logo=github)
![GitHub repo size](https://img.shields.io/github/repo-size/xtrabytes/xcite.svg?label=repository%20size&logo=github)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/xtrabytes/xcite.svg?label=code%20size%20in%20bytes&logo=github)
![GitHub language count](https://img.shields.io/github/languages/count/xtrabytes/xcite.svg?label=total%20programming%20languages&logo=github&logoColor=white)
![GitHub top language](https://img.shields.io/github/languages/top/xtrabytes/xcite.svg?logo=c%2B%2B&logoColor=white)
](#statistics)

Status: 

[![Website](https://img.shields.io/website/https/xtrabytes.global.svg?down_message=Offline&label=XTRABYTES%20website&up_message=Online)](https://xtrabytes.global)
[![Website](https://img.shields.io/website/https/discord.xtrabytes.global.svg?down_message=Offline&label=Discord&logo=discord&logoColor=white&up_message=Online)](https://discord.xtrabytes.global)

## Getting Started

### Prerequisites (Windows)

Prerequisites for Windows deployment:

- [Python 3.7.2](https://www.python.org/downloads/release/python-372/)
- [ActivePerl 5.26.3](https://www.activestate.com/products/activeperl/downloads/) 


### Prerequisites (macOS)

Prerequisites for macOS deployment:

- [Python 2.7.16](https://www.python.org/downloads/release/python-2716/)
- [Xcode](https://developer.apple.com/xcode/)
- [Apple Developer Account](https://developer.apple.com/) (Apple ID)

--------
### Dependencies
Dependencies are a set of resource files (modules, libraries) used in the creation of the application. Pre-compiled dependencies can be used or they can be compiled, from source, with the correct compiler.<br>
Libraries or modules can include configuration data, documentation, message templates, subroutines, classes, values or type specifications.

#### Required dependencies for the desktop platform (Windows, macOS, Linux):
- [Boost 1.60](https://www.boost.org/users/history/version_1_60_0.html) -> C++ libraries
- [Berkeley DB 4.8.30 NC](http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz) -> Database libraries
- [Openssl 1.0.2q](https://www.openssl.org/source/old/1.0.2/) -> Cryptography libraries
- [Mininupnpc](http://miniupnp.free.fr/files/download.php?file=miniupnpc-1.9.tar.gz) -> UPnP protocol libraries

#### Required dependencies for the mobile platform (Android, iOS):
- The required dependencies are already included and can be found inside the XCITE /dependencies folder. There is no need to compile them.

#### MinGW (Windows only)
__MinGW__ is recommended when compiling libraries in Windows. You can download the MinGW compiler for Windows [here](https://sourceforge.net/projects/mingw/files/Installer/mingw-get-setup.exe/download). 

- __MinGW__ provides a complete open source programming toolset for developers working on the Windows platform. It includes a port of the GNU Compiler Collection (GCC), including C, C++ and other compilers.<br>
- __MSYS__ is an alternative to Microsoft's cmd.exe. It provides a general purpose command line environment, suited for use with MinGW.
- [![Complete instructions guide](https://img.shields.io/badge/click_HERE_for_the-mingw_guide-green.svg?style=flat&logo=github&logoColor=white&labelColor=blue)](https://github.com/xtrabytes/xcite/blob/master/documentation/guide/mingwsetup.pdf)

### Compiling (Desktop platforms only)
Compiling converts source code (in our case, the dependency files) to binary or object code (the files needed for the XCITE app build).
A compiler is a program (or set of programs) that transforms source code written in a programming language (the source language) into another computer language (the target language, often having a binary form known as object code).

*Note that the compiling procedures in the macOS and Linux systems are similar to Windows. Use the Windows example as a reference.*

Create a folder where you are going to copy the required dependencies, for example, C:\deps.

Boost (Windows example)

- Open a __Windows__ command prompt line and inside the boost folder type:
  - bootstrap.bat mingw
  - b2 --build-type=complete --with-chrono --with-filesystem --with-program_options --
with-system --with-thread toolset=gcc variant=release link=static threading=multi
runtime-link=static stage

Berkeley DB 4.8.30 NC (Windows example)

- Using the __MinGW__ command prompt window type:
  - cd db-4.8.30.NC/build_unix
  - Still inside the build_unix folder type:
    - ../dist/configure --enable-mingw --enable-cxx --disable-shared --disablereplication
  - Once it finishes aggregating all the necessary files, type:
    - Make

Openssl 1.0.2q

Follow the instructions on how to compile openssl libraries (Windows example).
- [![Complete instructions guide](https://img.shields.io/badge/click_HERE_for_the-openssl_guide-green.svg?style=flat&logo=github&logoColor=white&labelColor=blue)](https://github.com/XTRABYTES/XCITE/blob/master/documentation/build-openssl-windows.txt)

__Editing the .pro file__

Edit the xcitedesk.pro file to include the correct paths of the compiled dependencies. See the example below:

[![xcite-pro-file](https://github.com/XTRABYTES/XCITE/blob/master/documentation/guide8.png)](#instructions-desktop-platform-only)

---------

### Install Qt

XCITE development requires the Qt cross-platform framework. If you don't have Qt installed you can download it from [here](https://www.qt.io/download-qt-installer) for free.<br> 
QT includes Qt Creator, an integrated development environment (IDE). Qt Creator comes with a wide range of integrated tools for both developers and designers. 

__macOS NOTE:__ Before installing Qt, you first need to install __Xcode__.

Our development is currently targeting Qt 5.11.3 and up. When the Qt installer asks which Qt components to install, select the following components and a compiler suitable to your development environment:

- Qt 5.11.3 -> Qt Charts (Required --> All platforms)
- Qt 5.11.3 -> MinGW 5.3.0 32 bit  (Windows compiler)
- Developer and Designer Tools -> MinGW 5.3.0 32 bit (Windows compiler)
- Qt 5.11.3 -> macOS (Mac components --> Desktop)
- Qt 5.11.3 -> iOS (Mac components --> Mobile)
- Qt 5.11.3 -> Android ARMv7 (Android physical device components)
- Qt 5.11.3 -> Android x86 (Android virtual device components)


**Windows installer options**
[![qt-windows-installation](https://github.com/xtrabytes/XCITE/blob/master/documentation/guide5.png)](#install-qt)

Once the Qt installation is complete, clone or download the XCITE repository. <br>
Edit the __.pro__ file accordingly and open the xcitedesk.pro (for the desktop platform) or the xcite.pro (for the mobile platform) using Qt Creator.


### Project Configuration (Android)

Configuring Java, Android SDK and Android NDK in Qt Creator. And the versions best suited for development.

Java is a widely used programming language, designed to be used in a distributed environment, as is often the case with the Android platform.
The Android SDK (software development kit) is a set of development tools used to develop applications for the Android platform.
The Android NDK (Native Development Kit) is a companion tool to the Android SDK that lets developers build performance-critical portions of the apps in native code. It provides headers and libraries that allow developers to build activities, handle user input, use hardware sensors, access application resources, and more, when programming in C or C++.

Prerequisites for Android deployment:

- [Java SE Development Kit 8u211 (JDK)](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) (Version 8)
- [Android Software Development Kit (SDK)](https://developer.android.com/studio/#command-tools) (SDK Command Tools)
- [Android Native Development Kit (NDK)](https://developer.android.com/ndk) 
  - [Recommended Android NDK r17c for Qt 5.11.x](https://developer.android.com/ndk/downloads/older_releases.html)
  - [Recommended Android NDK r19c for Qt 5.12.x](https://developer.android.com/ndk/downloads)

*There is no need to download and install Android Studio (SDK). The Android SDK command tools contain all the necessary files.*

In the Qt project, choose the Android kit that corresponds to your target device: 

- Android for ARM if using physical device
- Android for x86 if using an emulator

In Qt Options --> Devices --> Android, confirm that the prerequisite paths are correct. Once finished, your project configuration should have the following appearance and you should be able to select the necessary kit:

[![QT options](https://i.imgur.com/zs1UU3G.png)](#project-configuration-android)

- [![Complete instructions guide](https://img.shields.io/badge/click_HERE_for_the-android_guide-green.svg?style=flat&logo=github&logoColor=white&labelColor=blue)](https://github.com/xtrabytes/xcite/blob/master/documentation/guide/Android%20setup.pdf)

### Project Configuration (iOS)

Again, if you have not installed the necessary files, please do so.

Prerequisites for iOS deployment:

- [Xcode](https://developer.apple.com/xcode/)
- [Apple Developer Account](https://developer.apple.com/) (Apple ID)

You need to select the correct kit for the mobile version in Qt Creator: 

- Qt (xx version) for iOS --> the mobile version

Xcode, developed by Apple, provides a suite of software development tools, similar to the Qt platform, for coding, testing and creating application.  While Qt can be used to create macOS and iOS applications, we recommend using Xcode for iOS project builds. <br>
To use Xcode, it is necessary to create a .xcodeproj file to be able to build the iOS XCITE application. Qt will generate the file. Once it is generated, Xcode can use it to make the iOS build.

An Apple ID can be used to obtain the Apple Developer account. The basic privileges of an Apple Developer account are available for free. It will grant access to developer forums, beta updates and the ability to use Xcode to build, deploy and test apps on our own devices.

To generate the .xcodeproj file:

- Open the xcite.pro in QT
- Go to Build --> Run qmake

[![QT qmake](https://github.com/xtrabytes/XCITE/blob/master/documentation/guide1.png)](#project-configuration-ios)

- Go to your XCITE folder and search for the newly created .xcodeproj file

[![mac folder](https://github.com/xtrabytes/XCITE/blob/master/documentation/guide2.png)](#project-configuration-ios)

- Open the .xcodeproj file in Xcode and choose Product --> Build

[![iOS build](https://github.com/xtrabytes/XCITE/blob/master/documentation/guide3.png)](#project-configuration-ios)


### Qt Troubleshooting Advice

QMake is a fundamental part of Qt that serves the function of creating a make file. QMake not installing properly is usually attributed to user error and can be simply solved. If you run into a QMake issue during your Qt installation process follow these troubleshooting tips.

If this issue arises you should first try the following steps before performing a reinstallation of Qt:

1. Ensure antivirus did not keep QMake from installing during the installation process.

2. Ensure proper Kit is selected/detected by going to Tools --> Options --> Build & Run --> Kits.

- If no kit is selected or all kits are errored out, you will need to either manually install a kit or perform  a
        reinstallation

3. Ensure a compiler is installed by checking Tools --> Options --> Build & Run --> Compilers.

- If no compiler is installed you will need to either reinstall or manually install MinGW version 5.3.0

Other Qt errors:

1. Edit the xcitedesk.pro file to include the correct paths of the compiled dependencies.

- If the paths do not exist or are incorrect, you will get several Qt errors leading to compiling failure

2. Ensure you have an Apple Developer Account ([create one](https://developer.apple.com/)) when compiling the iOS version.

  ```Code Sign error: No code signing identities found: No valid signing identities (i.e. certificate and private key pair) were found.```

- To avoid the above error message, make sure you have a valid Apple Developer account. In XCODE go to Preferences --> Accounts and enter your account details.

<!--  ## Interacting with the XBY Testnet

**Please note that the Testnet is currently offline until we're ready for Testnet 4.**

1. Download the normal testnet wallet [here](https://testnet.xtrabytes.global/)
2. Run the testnet wallet and allow it to completely synchronize.
3. Close the wallet and browse to your application data folder.
     - **Windows:** %APPDATA%\xcite\
     - **Mac:** Home/Library/Application Support/xcite/
4. Within this folder, create a new file and name it "xcite.conf". **Make sure the file is not called "xcite.config.txt". The file must be saved with a ".conf" extension.**
     - **Windows:** In Notepad, go to File -> Save As ->  Set the "File name:" to xcite.conf, change the "Save as type:" dropdown to "All Files", then click Save.
     - **Mac:** In TextEdit, click Format in the file bar -> Make Plain Text -> File ->Save -> Change "Save As:" to xcite.conf, then click Save.
4. Edit the xcite.conf file, paste the following content into the file, then save and close it:

     ```
     rpcuser=xcite
     rpcpassword=xtrabytes
     server=1
     ```

5. Re-open the wallet and allow it to synchronize.
6. Open XCITE (allow the XCITE wallet to continue running in the background)
7. In XCITE, click the online indicator in the bottom-left to connect via RPC. If it works correctly the balance should be updated in XCITE and the Send Coins & History views should be functional. -->

## XCITE Desktop Screenshots

[![xcite-testnet-2-21-18](https://github.com/xtrabytes/XCITE/blob/master/documentation/laptop.png)](https://github.com/xtrabytesteam/xcite/blob/master/README.md#xcite-desktop-screenshots)

**Testnet Interaction**
[![xcite-testnet-2-21-18](https://user-images.githubusercontent.com/17502298/36481552-2c7ba1a0-16de-11e8-8848-102cfa4653e7.gif)](https://github.com/xtrabytesteam/xcite/blob/master/README.md#xcite-desktop-screenshots)

**XCITE -> Home**
[![image](https://user-images.githubusercontent.com/17502298/37713999-d1f137f0-2cee-11e8-8f1f-bf0e3cb5aad8.png)](https://github.com/xtrabytesteam/xcite/blob/master/README.md#xcite-desktop-screenshots)

**XCITE -> Testnet Interaction (Debug Console)**

[![xcite-console2](https://user-images.githubusercontent.com/17502298/37714402-d33c441e-2cef-11e8-9bdd-e9d3715598a2.gif)](https://github.com/xtrabytesteam/xcite/blob/master/README.md#xcite-desktop-screenshots)

**XCITE -> Send Coins**
[![image](https://user-images.githubusercontent.com/17502298/37714509-1361b272-2cf0-11e8-9619-ae1ec3d6d63b.png)](https://github.com/xtrabytesteam/xcite/blob/master/README.md#xcite-desktop-screenshots)

**XCITE -> Receive Coins**
[![image](https://user-images.githubusercontent.com/17502298/37714529-1fa6bb22-2cf0-11e8-83e8-f20cfb97b0dc.png)](https://github.com/xtrabytesteam/xcite/blob/master/README.md#xcite-desktop-screenshots)

**XCITE -> Settings**
[![image](https://user-images.githubusercontent.com/17502298/37714557-31b12db6-2cf0-11e8-8b71-8b799a4e7696.png)](https://github.com/xtrabytesteam/xcite/blob/master/README.md#xcite-desktop-screenshots)

**X-CHANGE -> Home**
[![image](https://user-images.githubusercontent.com/17502298/37714617-5d365e34-2cf0-11e8-8e6a-ee18e4ccba8a.png)](https://github.com/xtrabytesteam/xcite/blob/master/README.md#xcite-desktop-screenshots)

**X-CHAT -> Home**
[![image](https://user-images.githubusercontent.com/17502298/37714647-717e8e5c-2cf0-11e8-972b-51825bdccde1.png)](https://github.com/xtrabytesteam/xcite/blob/master/README.md#xcite-desktop-screenshots)


## XCITE Mobile Screenshots

<img src="https://github.com/xtrabytes/XCITE/blob/master/documentation/guide4.png">

**XCITE Mobile -> Start**

<img src="https://github.com/xtrabytes/XCITE/blob/master/documentation/xciteg1.jpg" width="375" height="716">

**XCITE Mobile -> Home**

<img src="https://github.com/xtrabytes/XCITE/blob/master/documentation/xciteg2.jpg" width="375" height="716">

**XCITE Mobile -> Transfer**

<img src="https://github.com/xtrabytes/XCITE/blob/master/documentation/xciteg3.jpg" width="375" height="716">


## Contributing

If you would like to contribute to XCITE development, please [contact us](mailto:development@xtrabytes.global). We would love to hear from you.

Submit any __bugs__ through the project's tracker: <br>

[![Issues](https://img.shields.io/github/issues/xtrabytes/xcite.svg?logo=github)]( https://github.com/XTRABYTES/XCITE/issues )

## Frequently Asked Questions

**1. Where is the rest of the source code?**

   Since the Proof of Signature consensus algorithm is still closed-source, this repository does not yet include the complete source code. We understand that the public needs to be able to review the source code and will publish the remaining source code as soon as it's ready.

**2. What platforms does XCITE plan to support?**

   - Linux Desktop
   - Android devices
   - Apple Desktop (macOS)
   - iPhone/iPad (iOS)
   - Windows desktop

**3. Where can I learn more about XTRABYTES?**

   - [Website](https://xtrabytes.global/)
   - [Discord](https://discord.xtrabytes.global)
   - [Whitepaper](https://xtrabytes.global/whitepaper.pdf)
   - [Forum](https://community.xtrabytes.global)
   - [Help Center](http://support.xtrabytes.global)

---
<div align="center">
  <h3>
    <a href="https://xtrabytes.global">
      Website
    </a>
    <span> | </span>
    <a href="https://xtrabytes.global/whitepaper.pdf">
      Whitepaper
    </a>
    <span> | </span>
    <a href="https://discord.xtrabytes.global">
      Discord
    </a>
    <span> | </span>
    <a href="https://github.com/XTRABYTES/XCITE/">
      Github
    </a>
    <span> | </span>
    <a href="https://blog.xtrabytes.global/">
      Blog
    </a>
    <span> | </span>
    <a href="https://twitter.com/xtrabytes">
      Twitter
    </a>
    <span> | </span>
    <a href="https://support.xtrabytes.global">
      Help Center
    </a>
  </h3>
   <h5>
    © 2019 XTRABYTES Ltd.
  </h5>
</div>
