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
    PointP1P1* {.
        header: "ge.h",
        importc: "ge_p1p1"
    .} = object
    Point2* {.
        header: "ge.h",
        importc: "ge_p2"
    .} = object
    Point3* {.
        header: "ge.h",
        importc: "ge_p3"
    .} = object
    PointCached* {.
        header: "ge.h",
        importc: "ge_cached"
    .} = object
    PrivateKey* = array[64, cuchar]
    PublicKey* = array[32, cuchar]

#Convert a Public Key to a Point3.
proc keyToNegativePoint*(
    res: ptr Point3,
    bytes: ptr cuchar
) {.importc: "ge_frombytes_negate_vartime".}

proc p3ToCached*(
    cached: ptr PointCached,
    p3: ptr Point3
) {.importc: "ge_p3_to_cached".}

proc p1p1ToP3*(
    p3: ptr Point3,
    p1p1: ptr PointP1P1
) {.importc: "ge_p1p1_to_p3".}

#Add two points.
proc add*(
    res: ptr PointP1P1,
    p: ptr Point3,
    p2: ptr PointCached
) {.importc: "ge_add".}

#Multiply by Ed25519's base.
proc multiplyBase*(
    res: ptr Point3,
    point: ptr cuchar
) {.importc: "ge_scalarmult".}

#Multiply scalars.
proc multiplyScalar*(
    res: ptr Point2,
    scalar: ptr cuchar,
    point: ptr Point3,
    addScalar: ptr cuchar
) {.importc: "ge_double_scalarmult_vartime".}

#Serialize a Point2.
proc serialize*(
    res: ptr cuchar,
    point2: ptr Point2
) {.importc: "ge_tobytes".}

#Serialize a Point3.
proc serialize*(
    res: ptr cuchar,
    point: ptr Point3
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
