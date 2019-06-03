version     = "1.1.0"
author      = "Luke Parker"
description = "A Nim Wrapper for orlp's Ed25519 library."
license     = "MIT"

installFiles = @[
    "mc_ed25519.nim"
]

installDirs = @[
    "ed25519"
]

requires "nim > 0.18.0"
