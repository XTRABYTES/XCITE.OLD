![xcite-github_banner-final](https://user-images.githubusercontent.com/17502298/35755546-b0b13276-0835-11e8-85bd-4f46b34afee3.png)

#                X C I T E
####  XTRABYTES Consolidated Interactive TErminal

XCITE is the core application utilizing the XTRABYTES Proof-of-Signature blockchain protocol. Built to support modules like a decentralized exchange and a fully-integrated chat protocol, the SHA512 encrypted network is quantum resistant and lightning fast. The code-fluid architecture means any developer looking to make a third-party DApp can use the XTRABYTES API to build out their dream project. XCITE is poised to be a top contender in all-in-one decentralized applications.
## Getting Started

#### Install Qt

XCITE development requires the Qt cross-platform framework. If you don't have Qt installed you can download it from [here](https://www.qt.io/download-qt-installer) for free.

Our development is currently targeting Qt 5.10.1. When the Qt installer asks which Qt components to install, select the following components and a compiler suitable to your development environment:

- Qt 5.10.1 -> Qt Charts (Required)
- Qt 5.10.1 -> MinGW 5.3.0 32 bit  (Windows compiler)
- Tools -> MinGW 5.3.0 (Windows compiler)
- Qt 5.10.1 -> macOS (Mac compiler)
- Qt 5.10.1 -> iOS (iOS compiler)
- Qt 5.10.1 -> Android ARMv7 (Android compiler)

#### Project Configuration

After installing Qt, clone this repository and open xcite.pro using Qt Creator.

#### Qt Troubleshooting Advice

QMake is a fundamental part of Qt that serves the function of creating a make file. QMake not installing properly is usually attributed to user error and can be simply solved. If you run into a QMake issue during your Qt installation process follow these troubleshooting tips.

If this issue arises you should first try the following steps before performing a reinstallation of Qt:

1. Ensure antivirus did not keep QMake from installing during the installation process

2. Ensure proper Kit is selected/detected by going to Tools --> Options --> Build & Run --> Kits

- If no kit is selected or all kits are errored out, you will need to either manually install a kit or perform  a
        reinstallation.

3. Ensure a compiler is installed by checking Tools --> Options --> Build & Run --> Compilers

- If no compiler is installed you will need to either reinstall or manually install MinGW version 5.3.0

## Interacting with the XBY Testnet

1. Download the normal testnet wallet [here](https://testnet.xtrabytes.global/)
2. Run the testnet wallet and allow it to completely synchronize.
3. Close the wallet and browse to your application data folder.
    - **Windows:** %APPDATA%\xcite\
    - **Mac:** Home/Library/Application Support/xcite/
4. Within this folder, create a new file and name it "xcite.conf". **Make sure the file is not called "xcite.config.txt". The file must be saved with a ".conf" extension.**
    - **Windows:** In Notepad, go to File -> Save As ->  Set the "File name:" to xcite.conf, change the "Save as type:" dropdown to "All Files", then click Save.
    - **Mac:** In TextEdit, click Format in the file bar -> Make Plain Text -> File -> Save -> Change "Save As:" to xcite.conf, then click Save.
4. Edit the xcite.conf file, paste the following content into the file, then save and close it:

    ```
    rpcuser=xcite
    rpcpassword=xtrabytes
    server=1
    ```

5. Re-open the wallet and allow it to synchronize.
6. Open XCITE (allow the XCITE wallet to continue running in the background)
7. In XCITE, click the online indicator in the bottom-left to connect via RPC. If it works correctly the balance should be updated in XCITE and the Send Coins & History views should be functional.

## Screenshots

**Testnet Interaction**
![xcite-testnet-2-21-18](https://user-images.githubusercontent.com/17502298/36481552-2c7ba1a0-16de-11e8-8848-102cfa4653e7.gif)

**XCITE-> Home**
![image](https://user-images.githubusercontent.com/17502298/36481260-4a1cbc7c-16dd-11e8-841c-fbfdb077290c.png)

**XCITE-> Send Coins**
![image](https://user-images.githubusercontent.com/17502298/36481289-640b4fcc-16dd-11e8-8706-d2c3b761072e.png)

**XCITE-> Send Coins -> Send Confirmation**
![image](https://user-images.githubusercontent.com/17502298/36481304-77d2afa0-16dd-11e8-983c-f1033efd5dc3.png)

**XCITE-> Receive Coins**
![image](https://user-images.githubusercontent.com/17502298/36481323-82b32742-16dd-11e8-8804-8440774b4d57.png)

**XCITE-> History**
![image](https://user-images.githubusercontent.com/17502298/36481337-8e668638-16dd-11e8-93e6-f3ab10588076.png)

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
