# Ed25519

A Nim Wrapper for LibSodium's Ed25519 components.

# Installation

On a Debian based system, install `libsodium-dev` via apt. If you're on Ubuntu 16.04, the `libsodium-dev` package is very outdated, and you'll need to compile it yourself.

On Windows, download https://download.libsodium.org/libsodium/releases/libsodium-1.0.17-mingw.tar.gz. Extract the files and open the folder for your arch. Place the newly compiled DLL, located under `bin/`, in your `/build` directory. Place `lib/libsodium.a` in your compiler's static library folder.
