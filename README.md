# GrinningSoul

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/goodtomeetyou/GrinningSoul/blob/master/LICENSE.txt)

This is a fork of [GrinningSoul](https://github.com/daeken/grinningsoul).

GrinningSoul is a set of high-low level code that provides a translation layer for arm64 <-> x86-64 CPU architectures within the iOS-simulator shipped with XCode. This enables iOS App Store decrypted applications to run in the Simulator (Intel-based Macs). The project relies on the LLVM infrastructure to perform highly efficient code translation, compilation, and library support.

Not all iOS features are available due Simulator limitations. Feautures that relies on physical hardware could tend to crash the applications due to unimplemented or non-existent features.

The original project was abandoned after Apple announced their CPU transition from Intel to Apple Silicon on Mac devices. The goal of this fork is to refactor the code to support modern APIs, libraries, and SDKs. I also want to refactor the code structure to be usable in other architecture bridging projects, as well as convert this project to a user-friendly Mac App so you can convert Applications easily without complications. I will try to maintain the project until Apple stops shipping newer macOS versions on Intel Macs.

**CURRENT MILESTONES**

*   Built all needed binaries/libraries
    *   Built sucessfully libemuruntime.dylib using Moonage nor Unicorn.
    *   Built libarmruntime.dylib using the latest iOS SDK.
*   Partial function database generator update.
    *   Still need to rewrite HeaderParse/generatefuncdb since is not dumping anything on the funcdb file on latest macOS/iOS-simulator versions.
*   Compilation of LLVM@9 (ios-sim target) for Moonage dynamic linking at libemuruntime.dylib [libmoonage CPU emulation library](https://github.com/daeken/libmoonage)

## Getting Started

Follow the instructions below to build required binaries/libraries and convert an iOS app bundle.

**PREREQUISITES**
*   Decrypted iOS arm64 app bundle (**MAKE SURE YOUR APPLICATION IS TARGETING AT LEAST IOS 13 SINCE NEW DYLD FORMAT IS NOT IMPLEMENTED YET, IOS 14+ APPS ARE NOT SUPPORTED**)
*   Intel Mac with macOS 11 (Big Sur) up to macOS 15 (Sequoia)
*   Xcode with the latest iOS SDK (recomended for test iOS 18.2)
*   CMake and Make via Homebrew
*   Python 2 (required for some scripts)
*   Boost (version 1.70 or higher)
*   Apple Silicon Macs are **NOT** supported since this project bridges Aarch64 <-> x86-64 instruction code and library calls. For Apple Silicon Macs, please look for alternatives such as [Mickey Jin converter](https://jhftss.github.io/Run-any-iOS-Apps-in-the-Xcode-Simulator/)

**INSTALLATION**

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/goodtomeetyou/GrinningSoul/]
    cd grinningsoul
    ```

2.  **Create a Build Directory and Configure with CMake:**
    ```bash
    mkdir build
    cd build
    cmake ..
    ```
    *   **Important:** Check the CMakeLists and adjust it if you got LLVM finding errors.

4.  **Build GrinningSoul:**
    ```bash
    make
    ```

5.  **Locate the Executable files:**  After a successful build, the libarmruntime, libemuruntime, HeaderParse and Converter executables will be located in their respective `_output` subdirectory within `GrinningSoul` project folder.

**USAGE**

1.  Get a desired iOS application (IPA) file.
2.  Extract the decrypted application bundle (.app directory) from the IPA file.
3.  Use the `convertOne` bash script to convert and prepare the application.  For example:
    ```bash
    ./convertOne.sh /path/to/MyDecryptedApp.app
    ```
4. Locate the converted app bundle on the directory `convertedApps` within `GrinningSoul` project folder.
5.  Run the converted application within the iOS Simulator.  Open a iPhone device on the Simulator and drag and drop the app bundle to SpringBoard.

**WHAT TO EXPECT AFTER AN APP CONVERTION?**

None of them will open in the simulator. The reasons? So many things changed that will need to be implemented. You can track the logs at Console Mac app.

## Current Status
As I mentioned above the project was abandonated. The developer uploaded the repo without any instruction, commit, or documentation to see the status the project was left. Debbuging the project and tracking the changes and old X posts of the original developer I could get the information provided in this README, I also I am researching the code and its high level functions in order to make some properly documentation that will be published here soon, I am gathering most information that could be useful as soon as possible.

Offline I made some fixes and updated some things, but they require more tests and time in order to commit them here.

**CONTRIBUTING**

I highly welcome contributions to this project! If you feel interested to work here or check the project you can see the issues I oppened to analyze the things needed to implement to get this work. Feel free to open new issues or make any comment.

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](https://github.com/goodtomeetyou/GrinningSoul/blob/master/LICENSE.txt) file for details.
