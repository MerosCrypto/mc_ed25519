#Include and link Sodium.
const currentFolder = currentSourcePath().substr(0, currentSourcePath().len - 15)
{.passC: "-I" & currentFolder & "libsodium/".}
{.passL: "-lsodium".}

#Define the Ed25519 objects.
type
    Seed* = array[32, cuchar]
    PrivateKey* = array[64, cuchar]
    PublicKey* = array[32, cuchar]
    State* {.
        header: "sodium.h",
        importc: "crypto_sign_ed25519ph_state"
    .} = object

#Multiply a point in a char array against the base point and store it in the provided point.
proc multiplyBase*(
    output: ptr cuchar,
    input: ptr cuchar
) {.
    header: "sodium.h",
    importc: "crypto_scalarmult_ed25519_base"
.}

#Init a state.
proc init*(
    state: ptr State
): int {.
    header: "sodium.h",
    importc: "crypto_sign_ed25519ph_init"
.}

#Update a state.
proc update*(
    state: ptr State,
    msg: ptr char,
    len: culong
): int {.
    header: "sodium.h",
    importc: "crypto_sign_ed25519ph_update"
.}

#Sign a message.
proc sign*(
    state: ptr State,
    sig: ptr char,
    len: ptr culong,
    priv: PrivateKey
): int {.
    header: "sodium.h",
    importc: "crypto_sign_ed25519ph_final_create"
.}

#Verify a message.
proc verify*(
    state: ptr State,
    sig: ptr char,
    pub: PublicKey
): int {.
    header: "sodium.h",
    importc: "crypto_sign_ed25519ph_final_verify"
.}
