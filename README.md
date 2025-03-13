# GrinningSoul

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/goodtomeetyou/GrinningSoul/blob/master/LICENSE.txt)

This is a fork of [GrinningSoul](https://github.com/daeken/grinningsoul).

GrinningSoul is a set of high-low level code that provides a translation layer between arm64 and x86-64 CPU instruction and architectures within the iOS-simulator shipped with XCode. This enables iOS App Store decrypted applications to run in the Simulator on Intel-based Macs. The project relies on the LLVM infrastructure to perform highly efficient code translation, compilation, and library support.

Not all iOS features are available, such as physical peripherals, Bluetooth, Extensions, and PlugIns. Also, some processes tend to crash the applications due to unimplemented features.

The original project was abandoned after Apple announced their CPU transition from Intel to Apple Silicon on Mac devices. The goal of this fork is to refactor the code to support modern APIs, libraries, and SDKs, convert the project to a user-friendly Mac App, bring support for iOS apps outside of the simulator, and potentially support light Apple Silicon macOS apps on Intel Macs. We will try to maintain the project until Apple stops supporting newer macOS versions on Intel Macs.

**CURRENT MILESTONES**

*   iOS 10 up to iOS 13 partial application support
    *   Known working apps: [Spotify, Airbnb, Instagram, X].
    *   Known issues: [Crashes on certain processes].
*   Partial Swift support
    *   Supported basic Swift syntax, CoreData, Foundation, UIKit, SwiftUI, etc.
*   Near native CPU performance through [libmoonage CPU emulation runtime](https://github.com/daeken/libmoonage)

## Getting Started

Follow the instructions below to build required binaries and convert an iOS app bundle.

**PREREQUISITES**

*   Intel Mac with macOS 11 (Big Sur) up to macOS 15 (Sonoma)
*   Xcode with the latest iOS SDK (install via the App Store)
*   CMake (version 3.15 or higher)
*   Make
*   Python 2 (required for some scripts)
*   Boost (version 1.70 or higher)
*   Apple Silicon Macs are **NOT** supported since this project bridges Aarch64 code to x86-64. For Apple Silicon Macs, please look for alternatives such as [Mickey Jin Alternative](https://jhftss.github.io/Run-any-iOS-Apps-in-the-Xcode-Simulator/)

**INSTALLATION**

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/goodtomeetyou/GrinningSoul/]
    cd grinningsoul
    ```

2.  **Install Dependencies:**
    *   **Homebrew**
        ```bash
        brew install boost cmake
        ```
    *   **Homebrew**
        ```bash
        brew install llvm
        ```
3.  **Create a Build Directory and Configure with CMake:**
    ```bash
    mkdir build
    cd build
    cmake ..
    ```
    *   **Important:** Check the CMake output for any errors or warnings and open a issue to address it.

4.  **Build GrinningSoul:**
    ```bash
    make
    ```

5.  **Locate the Executable files:**  After a successful build, the libarmruntime, libemuruntime, HeaderParse and Converter executable will be located in their respective `_output` subdirectory within `GrinningSoul` project folder.

**USAGE**

1.  Get a decrypted iOS application (IPA) file.
2.  Extract the application bundle (.app directory) from the decrypted IPA.
3.  Use the `convertOne` bash script to convert and prepare the application.  For example:
    ```bash
    ./convertOne.sh /path/to/MyDecryptedApp.app
    ```
4. Locate the converted app bundle on the directory `convertedapps` within `GrinningSoul` project folder.
5.  Run the converted application within the iOS Simulator.  Open a iPhone device on the Simulator and drag the app bundle to SpringBoard.

**TROUBLESHOOTING**

*   **Build Errors:** If you encounter build errors, ensure that all dependencies are installed correctly and that CMake is configured properly.  Check the CMake output for specific error messages.
*   **Application Crashes:**  As mentioned earlier, some applications may crash due to unimplemented features.  Check the GrinningSoul logs for more information.
*   **Debugging:**  Run the application through the debugger located in `Debugger` subdirectory within `GrinningSoul` project folder.

**CONTRIBUTING**

We welcome contributions to GrinningSoul!  Please open issues, fork the repository, make your changes, and submit a pull request.

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](https://github.com/goodtomeetyou/GrinningSoul/blob/master/LICENSE.txt) file for details.
