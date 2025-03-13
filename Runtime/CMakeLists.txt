cmake_minimum_required(VERSION 3.15)
project(Runtime)

set(CMAKE_CXX_STANDARD 20)

# Set LLVM paths explicitly
set(LLVM_INSTALL_DIR "/path/to/llvm-ios-sim/install")
set(LLVM_DIR "${LLVM_INSTALL_DIR}/lib/cmake/llvm")

# Find LLVM package with explicit path
find_package(LLVM 21.0.0 REQUIRED CONFIG
    PATHS ${LLVM_INSTALL_DIR}/lib/cmake/llvm
    NO_DEFAULT_PATH
)

# Add LLVM definitions and includes
include_directories(SYSTEM ${LLVM_INSTALL_DIR}/include)
include_directories(SYSTEM ${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

# Set Boost configuration
set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED ON)
find_package(Boost 1.72.0)
include_directories(${Boost_INCLUDE_DIRS})

set(USE_UNICORN ON)

# CPU core libraries includes
include_directories("/path/to/unicorn/include")
include_directories("/path/to/libmoonage")
include_directories("/path/to/libmoonage/xbyak")

set(CMAKE_OSX_SYSROOT "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated-declarations -O2")
set(CMAKE_OSX_DEPLOYMENT_TARGET "" CACHE STRING "Empty for iOS" FORCE)

if(USE_UNICORN)
    add_definitions(-DUSE_UNICORN)
    include_directories(/path/to/unicorn/include)
    link_directories(../)
    link_libraries(unicorn)
else()
    link_directories(/path/to/libmoonage/build)
    link_libraries(moonage)
endif()

link_libraries(objc "-framework CoreFoundation" "-framework Foundation" "-framework Security")

get_target_property(ARMRUNTIME_SOURCES armruntime SOURCES)
list(TRANSFORM ARMRUNTIME_SOURCES PREPEND "../ArmRuntime/")

add_custom_command(
    OUTPUT ../Runtime/replacements.generated.h
    COMMAND python generateReplacements.py
    WORKING_DIRECTORY ../ArmRuntime
    DEPENDS ../ArmRuntime/generateReplacements.py ${ARMRUNTIME_SOURCES}
)

add_custom_target(replacementGeneration ALL DEPENDS ../ArmRuntime/generateReplacements.py ${ARMRUNTIME_SOURCES})
add_dependencies(armruntime replacementGeneration)

add_library(emuruntime SHARED
    kickoff.cpp 
    cpu.cpp 
    trampoliner.cpp 
    trampoliner.h 
    ../init.h 
    objcWrappers.mm 
    objcWrappers.h 
    wrappers.h 
    wrappers.cpp 
    ../Runtime/replacements.generated.h 
    swiftDemangler.cpp 
    swiftDemangler.h 
    swiftDemangler.cpp 
    swiftDemangler.h
    repr.h 
    record.h 
    keychainTester.mm 
    objcppWrappers.mm 
    objcppWrappers.h 
    logging.mm 
    logging.h
    format.cc 
    os.cc 
    fmt/chrono.h 
    fmt/color.h 
    fmt/compile.h 
    fmt/core.h 
    fmt/format-inl.h 
    fmt/format.h 
    fmt/locale.h 
    fmt/os.h 
    fmt/ostream.h 
    fmt/posix.h 
    fmt/printf.h 
    fmt/ranges.h
    exceptionHandlers.mm 
    exceptionHandlers.h 
    jmpWrappers.cpp 
    jmpWrappers.h
)

target_include_directories(emuruntime PRIVATE
    ${LLVM_INSTALL_DIR}/include
    ${LLVM_INCLUDE_DIRS}
)
add_dependencies(emuruntime armruntime replacementGeneration)

llvm_config(emuruntime core)

add_custom_command(TARGET emuruntime POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:emuruntime> ../
)
