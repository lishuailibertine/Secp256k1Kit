import XCTest
import Foundation
@testable import CSecp256k1

final class Secp256k1SchnorrTests: XCTestCase {
    static var magic: (UInt8, UInt8, UInt8, UInt8) { (218, 111, 179, 140) }
    static var context: OpaquePointer! = secp256k1_context_create(
        UInt32(SECP256K1_CONTEXT_SIGN|SECP256K1_CONTEXT_VERIFY)
    )
    func test_secp256k1_schnorr() throws{
//        let expectedPrivateKey = "0000000000000000000000000000000000000000000000000000000000000003"
//        let messageDigest = "0000000000000000000000000000000000000000000000000000000000000000"
//        var messageBytes = messageDigest.hexToByteArray()!
//        let auxRandPointer = UnsafeMutableRawPointer.allocate(byteCount: 32, alignment: MemoryLayout<UInt8>.alignment)
//        for i in 0..<32 {
//            auxRandPointer.storeBytes(of: 0x00, toByteOffset: i, as: UInt8.self)
//        }
//        let signture = try signature(message: &messageBytes, auxiliaryRand: auxRandPointer, privateKey: expectedPrivateKey.hexToByteArray()!)

        var pubKey = secp256k1_xonly_pubkey()
        XCTAssertTrue(secp256k1_xonly_pubkey_parse(Secp256k1SchnorrTests.context, UnsafeMutablePointer(&pubKey), []) == 1)

//        //https://github.com/bitcoin-core/secp256k1/blob/master/include/secp256k1_schnorrsig.h#L149L158)
//        XCTAssertTrue(secp256k1_schnorrsig_verify(Secp256k1SchnorrTests.context, signture, messageBytes, messageBytes.count, &pubKey) == 1)
    }

//    func signature(message: inout [UInt8], auxiliaryRand: UnsafeMutableRawPointer?, privateKey: [UInt8]) throws -> [UInt8] {
//        var keypair = secp256k1_keypair()
//        var signature = [UInt8](repeating: 0, count: 64)
//        var extraParams = secp256k1_schnorrsig_extraparams(magic: Secp256k1SchnorrTests.magic, noncefp: nil, ndata: auxiliaryRand)
//        guard secp256k1_keypair_create(Secp256k1SchnorrTests.context, UnsafeMutablePointer<secp256k1_keypair>(&keypair), privateKey) == 1,
//              secp256k1_schnorrsig_sign_custom(Secp256k1SchnorrTests.context, &signature, &message, message.count, &keypair, &extraParams) == 1
//        else {
//            return []
//        }
//
//       return signature
//    }
}
extension String {
    func hexToByteArray() -> [UInt8]? {
        let hexString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        guard hexString.count % 2 == 0 else { return nil }

        var byteArray = [UInt8]()
        var index = hexString.startIndex

        while index < hexString.endIndex {
            let byteString = hexString[index..<hexString.index(index, offsetBy: 2)]
            if let byte = UInt8(byteString, radix: 16) {
                byteArray.append(byte)
            } else {
                return nil
            }
            index = hexString.index(index, offsetBy: 2)
        }

        return byteArray
    }
}
