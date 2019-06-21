#Include and link the Ed25519 library.
const currentFolder = currentSourcePath().substr(0, currentSourcePath().len - 15)

{.passC: "-I" & currentFolder & "ed25519/src/".}
{.emit: """
extern "C" {
#include "ed25519.h"
#include "ge.h"
}
""".}

{.compile: currentFolder & "ed25519/src/ge.c".}
{.compile: currentFolder & "ed25519/src/sign.c".}
{.compile: currentFolder & "ed25519/src/verify.c".}
{.compile: currentFolder & "ed25519/src/add_scalar.c".}
{.compile: currentFolder & "ed25519/src/fe.c".}
{.compile: currentFolder & "ed25519/src/key_exchange.c".}
{.compile: currentFolder & "ed25519/src/keypair.c".}
{.compile: currentFolder & "ed25519/src/sc.c".}
{.compile: currentFolder & "ed25519/src/seed.c".}
{.compile: currentFolder & "ed25519/src/sha512.c".}

#Define the Ed25519 objects.
type
    FE* {.
        header: "fe.h",
        importc: "fe"
    .} = array[10, int32]
    Point* {.
        header: "ge.h",
        importc: "ge_p3"
    .} = object
        x: FE
        y: FE
        Z: FE
        T: FE
    PrivateKey* = array[64, cuchar]
    PublicKey* = array[32, cuchar]

#Multiply by Ed25519's base.
proc multiplyBase*(
    res: ptr Point,
    point: ptr cuchar
) {.importc: "ge_scalarmult_base".}

#Serialize a point.
proc serialize*(
    res: ptr cuchar,
    point: ptr Point
) {.importc: "ge_p3_tobytes".}

#Sign a message.
proc sign*(
    sig: ptr cuchar,
    msg: ptr cuchar,
    msgLen: csize,
    pubKey: ptr cuchar,
    privKey: ptr cuchar
) {.importc: "ed25519_sign", header: "ed25519.h".}

#Verify a message.
proc verify*(
    sig: ptr cuchar,
    msg: ptr cuchar,
    msgLen: csize,
    pubKey: ptr cuchar
): int {.importc: "ed25519_verify", header: "ed25519.h".}
