![xcite-github_banner-final](https://user-images.githubusercontent.com/17502298/35755546-b0b13276-0835-11e8-85bd-4f46b34afee3.png)

#                X C I T E
####  XTRABYTES Consolidated Interactive TErminal

XCITE is the core application utilizing the XTRABYTES Proof-of-Signature blockchain protocol. Built to support modules like a decentralized exchange and a fully-integrated chat protocol, the SHA512 encrypted network is quantum resistant and lightning fast. The code-fluid architecture means any developer looking to make a third-party DApp can use the XTRABYTES API to build out their dream project. XCITE is poised to be a top contender in all-in-one decentralized applications.
## Getting Started

#### Install Qt

XCITE development requires the Qt cross-platform framework. If you don't have Qt installed you can download it from [here](https://www.qt.io/download-qt-installer) for free. 

#### Install Additional Features

During installation, be sure to pick the "Qt 5.9.3" component since that is the version our development is currently targeting. If you plan to compile Windows binaries, also include the Tools -> MinGW 5.3.0 component.

#### Project Configuration

After installing Qt, clone this repository and open xcite.pro using Qt Creator.

#### Qt Troubleshooting Advice

QMake is a fundamental part of Qt that serves the function of creating a make file. QMake not installing properly is usually attributed to user error and can be simply solved. If you run into a QMake issue during your Qt installation process follow these troubleshooting tips. 

If this issue arises you should first try the following steps before performing a reinstallation of Qt:

1.) Ensure antivirus did not keep QMake from installing during the installation process

2.) Ensure a proper Kit is selected/detected by going to Tools --> Options --> Build & Run --> Kits
      2a.) If no kit is selected or all kits are errored out, you will need to either manually install a kit or perform  a 
        reinstallation. 
          
3.) Ensure a compiler is installed by checking Tools --> Options --> Build & Run --> Compilers 
   3a.) If no compiler is installed you will need to either reinstall or manually install MinGW version 5.3.0


      
## Screenshots

##### X-Board -> Home
![image](https://user-images.githubusercontent.com/17502298/35881872-43b765d2-0b50-11e8-814d-ab8d21c6b341.png)

##### X-Board -> X-Chat Popup
![image](https://user-images.githubusercontent.com/17502298/35882148-34667f04-0b51-11e8-9a93-a0bc395d81bd.png)

##### X-Board -> Nodes
![image](https://user-images.githubusercontent.com/17502298/35881909-6768340c-0b50-11e8-8a65-2307d5053db3.png)

## Contributing

If you would like to contribute to XCITE development, please [contact us](mailto:development@xtrabytes.global). We would love to hear from you.

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
   - [Whitepaper](https://xtrabytes.global/whitepaper.pdf)
   - [Forum](https://community.xtrabytes.global)
   - [Help Center](http://support.xtrabytes.global)
