version     = "1.0.0"
author      = "Luke Parker"
description = "A Nim Wrapper for LibSodium's Ed25519 components."
license     = "MIT"

installFiles = @[
    "mc_ed25519.nim"
]

installDirs = @[
    "libsodium"
]

requires "nim > 0.18.0"
