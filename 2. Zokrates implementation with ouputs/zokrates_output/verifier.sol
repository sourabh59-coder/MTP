// This file is MIT Licensed.
//
// Copyright 2017 Christian Reitwiessner
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
pragma solidity ^0.8.0;
library Pairing {
    struct G1Point {
        uint X;
        uint Y;
    }
    // Encoding of field elements is: X[0] * z + X[1]
    struct G2Point {
        uint[2] X;
        uint[2] Y;
    }
    /// @return the generator of G1
    function P1() pure internal returns (G1Point memory) {
        return G1Point(1, 2);
    }
    /// @return the generator of G2
    function P2() pure internal returns (G2Point memory) {
        return G2Point(
            [10857046999023057135944570762232829481370756359578518086990519993285655852781,
             11559732032986387107991004021392285783925812861821192530917403151452391805634],
            [8495653923123431417604973247489272438418190587263600148770280649306958101930,
             4082367875863433681332203403145435568316851327593401208105741076214120093531]
        );
    }
    /// @return the negation of p, i.e. p.addition(p.negate()) should be zero.
    function negate(G1Point memory p) pure internal returns (G1Point memory) {
        // The prime q in the base field F_q for G1
        uint q = 21888242871839275222246405745257275088696311157297823662689037894645226208583;
        if (p.X == 0 && p.Y == 0)
            return G1Point(0, 0);
        return G1Point(p.X, q - (p.Y % q));
    }
    /// @return r the sum of two points of G1
    function addition(G1Point memory p1, G1Point memory p2) internal view returns (G1Point memory r) {
        uint[4] memory input;
        input[0] = p1.X;
        input[1] = p1.Y;
        input[2] = p2.X;
        input[3] = p2.Y;
        bool success;
        assembly {
            success := staticcall(sub(gas(), 2000), 6, input, 0xc0, r, 0x60)
            // Use "invalid" to make gas estimation work
            switch success case 0 { invalid() }
        }
        require(success);
    }


    /// @return r the product of a point on G1 and a scalar, i.e.
    /// p == p.scalar_mul(1) and p.addition(p) == p.scalar_mul(2) for all points p.
    function scalar_mul(G1Point memory p, uint s) internal view returns (G1Point memory r) {
        uint[3] memory input;
        input[0] = p.X;
        input[1] = p.Y;
        input[2] = s;
        bool success;
        assembly {
            success := staticcall(sub(gas(), 2000), 7, input, 0x80, r, 0x60)
            // Use "invalid" to make gas estimation work
            switch success case 0 { invalid() }
        }
        require (success);
    }
    /// @return the result of computing the pairing check
    /// e(p1[0], p2[0]) *  .... * e(p1[n], p2[n]) == 1
    /// For example pairing([P1(), P1().negate()], [P2(), P2()]) should
    /// return true.
    function pairing(G1Point[] memory p1, G2Point[] memory p2) internal view returns (bool) {
        require(p1.length == p2.length);
        uint elements = p1.length;
        uint inputSize = elements * 6;
        uint[] memory input = new uint[](inputSize);
        for (uint i = 0; i < elements; i++)
        {
            input[i * 6 + 0] = p1[i].X;
            input[i * 6 + 1] = p1[i].Y;
            input[i * 6 + 2] = p2[i].X[1];
            input[i * 6 + 3] = p2[i].X[0];
            input[i * 6 + 4] = p2[i].Y[1];
            input[i * 6 + 5] = p2[i].Y[0];
        }
        uint[1] memory out;
        bool success;
        assembly {
            success := staticcall(sub(gas(), 2000), 8, add(input, 0x20), mul(inputSize, 0x20), out, 0x20)
            // Use "invalid" to make gas estimation work
            switch success case 0 { invalid() }
        }
        require(success);
        return out[0] != 0;
    }
    /// Convenience method for a pairing check for two pairs.
    function pairingProd2(G1Point memory a1, G2Point memory a2, G1Point memory b1, G2Point memory b2) internal view returns (bool) {
        G1Point[] memory p1 = new G1Point[](2);
        G2Point[] memory p2 = new G2Point[](2);
        p1[0] = a1;
        p1[1] = b1;
        p2[0] = a2;
        p2[1] = b2;
        return pairing(p1, p2);
    }
    /// Convenience method for a pairing check for three pairs.
    function pairingProd3(
            G1Point memory a1, G2Point memory a2,
            G1Point memory b1, G2Point memory b2,
            G1Point memory c1, G2Point memory c2
    ) internal view returns (bool) {
        G1Point[] memory p1 = new G1Point[](3);
        G2Point[] memory p2 = new G2Point[](3);
        p1[0] = a1;
        p1[1] = b1;
        p1[2] = c1;
        p2[0] = a2;
        p2[1] = b2;
        p2[2] = c2;
        return pairing(p1, p2);
    }
    /// Convenience method for a pairing check for four pairs.
    function pairingProd4(
            G1Point memory a1, G2Point memory a2,
            G1Point memory b1, G2Point memory b2,
            G1Point memory c1, G2Point memory c2,
            G1Point memory d1, G2Point memory d2
    ) internal view returns (bool) {
        G1Point[] memory p1 = new G1Point[](4);
        G2Point[] memory p2 = new G2Point[](4);
        p1[0] = a1;
        p1[1] = b1;
        p1[2] = c1;
        p1[3] = d1;
        p2[0] = a2;
        p2[1] = b2;
        p2[2] = c2;
        p2[3] = d2;
        return pairing(p1, p2);
    }
}

contract Verifier {
    using Pairing for *;
    struct VerifyingKey {
        Pairing.G1Point alpha;
        Pairing.G2Point beta;
        Pairing.G2Point gamma;
        Pairing.G2Point delta;
        Pairing.G1Point[] gamma_abc;
    }
    struct Proof {
        Pairing.G1Point a;
        Pairing.G2Point b;
        Pairing.G1Point c;
    }
    function verifyingKey() pure internal returns (VerifyingKey memory vk) {
        vk.alpha = Pairing.G1Point(uint256(0x0ed1b5c0c0acc2197eda6218e52a8994bb1350252f2078773b06a44836df334d), uint256(0x08fe9e4320a62807b89890c93999e1b31dc2f4fb0731c24d9c80846e559b59e2));
        vk.beta = Pairing.G2Point([uint256(0x1fa224e97823d342d5d90fef40fa05d47b7dee5f0170a742ad96a7af065e8ea3), uint256(0x0b84d7b1238b68fe787a666ef110b8ed4dfc5b50bbbcd4e094cb11c838da1cf5)], [uint256(0x29513c9b7a455c79b0f0fe4999c6899fa0787c8200380fa95eb52fc4fb82dc2a), uint256(0x24d563bf756c9bafed5209c2b705de0cd8dd4a3c3b103fe1a7a53cfa9f10eb30)]);
        vk.gamma = Pairing.G2Point([uint256(0x0276dd0ecfd5a5ba5e782f4ee1dcdfc831efcd167a81c1ee2c0596abfa104d13), uint256(0x1cae7a82a0ea36d39512b4b99acfb7fb607e19c26ef20b53b1693982672da37c)], [uint256(0x13f32104f4cf40848f73dbf4090d9af8488b58b415d25d09c680e9c0034b7a06), uint256(0x18a01eb88d48da1881eec60737c5986b665a928f968fb6ebdfe5e871685ccddc)]);
        vk.delta = Pairing.G2Point([uint256(0x1463cc20f453432077ac8b6008c2c02a7418c0ca706b3a7945f1bd4a705f4a71), uint256(0x0af9cdf8ba6e610cd5c1807e0e563edf3b453001ea97a7c63363672193b3f899)], [uint256(0x22804debdc05039912ca922417b89036d58698b0d5e09b0bedeeef0333ab1971), uint256(0x06ea0844864ec587e4ddbc9e12564acdb14dc07e8bf8af4f068c587af098fffd)]);
        vk.gamma_abc = new Pairing.G1Point[](57);
        vk.gamma_abc[0] = Pairing.G1Point(uint256(0x135fa7e2ffb9e1a440f7c3604ebc2dee69932d564edb3a11cd02c8c882e2a72d), uint256(0x1126a5b28bda445f7b333ed620582c428456dfc9c152a411c2091d72439927b1));
        vk.gamma_abc[1] = Pairing.G1Point(uint256(0x0d2b7a8b0d2503bfef90810afd3d49ef8de3388f5cdbe80c8e24f97fbe90467d), uint256(0x07823b6a0efe905830da3fcc870d4ed9f9b5d02b0d7302dc13c7cb8d4d54dd5c));
        vk.gamma_abc[2] = Pairing.G1Point(uint256(0x16483b04cf87b102a9039b89191db87a7f31fda59d58271275c85fcf795ca142), uint256(0x002c9863f30d333799569d9d11c0c46cf02378fb4f0bbe4102808e79641f4e2d));
        vk.gamma_abc[3] = Pairing.G1Point(uint256(0x07e868358174051a58ab4e396709ccd93f0dc7617a942ebe4939492f2413582b), uint256(0x2c9fc89f8a46e656c966775a55a0f36625e1078693ccf3dde7deb1ec0c91e93e));
        vk.gamma_abc[4] = Pairing.G1Point(uint256(0x20943ce121ca276be1612b0f69119099c2130e6488ed5af0a509495915ac6590), uint256(0x1a95c0a13063dc7b7906b6313cc6cdab9ae30b0afb56b4bb4d3508d8c33eaba7));
        vk.gamma_abc[5] = Pairing.G1Point(uint256(0x0987615332217b007ec06dcf0239395f70278e595b6bca79d27753aad363a2cd), uint256(0x1a26f2f6dcf921e45413826172c92d67d1b11e3ff069962b65a458409c83b11d));
        vk.gamma_abc[6] = Pairing.G1Point(uint256(0x26c187b35c82b0131a96ad8e49b99261cdfdbaa4e87a8f8b9b85e783bbb08e89), uint256(0x2cb50e9bf76ff400594e01b992440159efc8b9ae7cf95a55e8f3857b58432931));
        vk.gamma_abc[7] = Pairing.G1Point(uint256(0x2a622d7b2f7420c0efac679b7440c52fa53f87d2397bad276991e4933284e511), uint256(0x25ca0ee36bee5614c304ed37beb81fe52557f9f875aba03b784dc40139320578));
        vk.gamma_abc[8] = Pairing.G1Point(uint256(0x1838982d1e9856a852edcdf416e4c95dc249d7fd9c0cf01a3f7b7556c068c781), uint256(0x00bc7700456e5be91bc33b4e98b56e5926fb8a10b3c82ec2fcf634398e05af46));
        vk.gamma_abc[9] = Pairing.G1Point(uint256(0x2930daee7dc6acec7159ec35a96b9c4ff5dbf74b5bf7442efef3c25c5bf99a05), uint256(0x0541a6b0043681afb6d9ffadb2d7c6301d82b1ed882c36cf0b20b96aead6a9fe));
        vk.gamma_abc[10] = Pairing.G1Point(uint256(0x21178d628fdb74f82c01fbd99ea4b9384756c1f16f01d71acc2b557d035b6f13), uint256(0x0a82f4c9fa6493e3c28ed0ca6ea5650ddb27758f81fdd9774782661f69017741));
        vk.gamma_abc[11] = Pairing.G1Point(uint256(0x2861ee69ebe931f203c5571fa6453d9128bfc5fad274d18ccfa0da7b14970379), uint256(0x109b995dbca3446dfa7d5d5e1fd472ff6f068ac87df77dd346d4f500e92ab30d));
        vk.gamma_abc[12] = Pairing.G1Point(uint256(0x2667dbd996351c3b53fe77b83ec8ddcf54a823d3227f9c6e4a75d3ff8bed52db), uint256(0x073c9f606ce9bc65dc4aa084a909f6d27e4d0605400e1b3aecbd8327cd79f258));
        vk.gamma_abc[13] = Pairing.G1Point(uint256(0x043e6b9bca652eed4cb76a25e3600638e0b1572ef7ae6c3bc7a42cef6e2bab29), uint256(0x1f8688c0977ac0e8872a6c68798035789aa04f4b3928f44dfa72758e299985c5));
        vk.gamma_abc[14] = Pairing.G1Point(uint256(0x0909abc466bc551e9bfc2098cccfe7ef15874924184330e3c8816185442bd490), uint256(0x1ede0754d590d3fcdab53a8c54e1cd42c00ff95da596baf954dc7b0fdff67c5b));
        vk.gamma_abc[15] = Pairing.G1Point(uint256(0x15810973933554c8bb2a1101a282e6e6dd142b8c6ce164a72758a2f7d781d990), uint256(0x1e2acd09fb167990758887c560c888881a23965906597bed7cac5d59708c9f56));
        vk.gamma_abc[16] = Pairing.G1Point(uint256(0x0f526903ed6eb711beb59515114f3e05668b4f353302d09b8cfea516273c6452), uint256(0x2f8e149012a44952dbe10d90fde61d93a59a9bfcd99ad7962597bbfa92dc9e8e));
        vk.gamma_abc[17] = Pairing.G1Point(uint256(0x07d3d790ea1359dd1e70637e029faded73667a77d329b449fabd65080142674d), uint256(0x26cce3073ab030d1229bd432b75b0bc3f812a87918cb78863f4bfabf04851e8b));
        vk.gamma_abc[18] = Pairing.G1Point(uint256(0x293a641a1ea55874c532deb126af08c6a833d25cbe5591c837f7cc27d1c98801), uint256(0x2290bb786ad270113d2b4076325954088e769f2e30bd6fa3ad7e4a0813a55f4f));
        vk.gamma_abc[19] = Pairing.G1Point(uint256(0x301651fd9ca4de3316e82ad96a419bf4fae9a37196e941c93b4c8bd617f3b897), uint256(0x0324c3b0d394b51a6476f5646e675f12a3000bc9dd6cca2ca05f9c0447d8955f));
        vk.gamma_abc[20] = Pairing.G1Point(uint256(0x094e2626c18aaf20f235a087107b3c84ed0b135e740f070981906d956fefa425), uint256(0x1bd22cd52552bfbbe3f0d96ec3a8109440687fc8e3d6d2457018d694546fdd68));
        vk.gamma_abc[21] = Pairing.G1Point(uint256(0x2df5be5e5c055b7f6b6bf3d2b1bf06229af67629ad0f27db2db3de05743fd1b8), uint256(0x11c798c76fa7ba107b6d0e45456b6a18158bc451d493879cf1aff791975aecb3));
        vk.gamma_abc[22] = Pairing.G1Point(uint256(0x18f4b064daffb72b07217c2b0e283ffe6894808f8af93b0ece9d810c69436279), uint256(0x097f345c109bdad62cf912007c2622540e83c1acc209f198ad5419abfb3cfda9));
        vk.gamma_abc[23] = Pairing.G1Point(uint256(0x2c5ff1e1f25a080e822ed5ac32ce174a1a376a6a695a346249d88aeeb5a03069), uint256(0x059c46669f3475866c94748657a502893e6e9ce496ff4c3919a2f59910547913));
        vk.gamma_abc[24] = Pairing.G1Point(uint256(0x16b7f1e17d044131d937ff7ae50d78a6b09cb69b8f1efb38fb1bec2ef2b26ebc), uint256(0x01179dc1af52002fa5e71a60d99a6f184af767e3895074b344d9f92f0e4887e4));
        vk.gamma_abc[25] = Pairing.G1Point(uint256(0x152d42f5e7c8266157fb8d6e521e39854c8b4e4a47bf95746248ad64edeb0e70), uint256(0x049662623004ac4e1f2175e9140b4d715501d57d2b65ad99f996f3a3a8ce84f4));
        vk.gamma_abc[26] = Pairing.G1Point(uint256(0x01890277f6e578f62487fc6edcea010d46fc01b322425f98a5e16902fa614abc), uint256(0x0089c46e35d3760b5f6afafae946d22e3157253119e52fa52eb2412316b7f040));
        vk.gamma_abc[27] = Pairing.G1Point(uint256(0x12528a86d2f883034b19acc9d58eaa92e8b20c7116a0dd987b0ac8c083d02499), uint256(0x279d9d643ce70606347eae14a44c8b7685f0bff3e9a5d9df4e0c9071f12dc3d9));
        vk.gamma_abc[28] = Pairing.G1Point(uint256(0x0d81e180ec890805fbe6d11b2d9ae003096938c35fd441dfa4384eade7d5aedd), uint256(0x2a85f7265b69e0c7a8368baae22916ce2046941882fb5687cc13af4aef8ee17d));
        vk.gamma_abc[29] = Pairing.G1Point(uint256(0x292348e7e83301c08920ac5882c5e52f2255c8b64a675cd43a6f0ed536cfe18b), uint256(0x0e5448f695c4119bafafb3fbec833544a74f2804751e8dd92f5149ee975526b4));
        vk.gamma_abc[30] = Pairing.G1Point(uint256(0x15de104b3ffb6072146c0ea4e4ce30c3aa615494af17407e51a42f8f69d6d4ca), uint256(0x1ce703ec53f870f7a4bb09ec567059b975739c574d3eb106b9e0a0242876f69d));
        vk.gamma_abc[31] = Pairing.G1Point(uint256(0x243bf3909fc4bb97811d31a1eb8bedb9af166bb90d6560e9c3f24006b8493818), uint256(0x0e7820db81771ce6359c77ea8604efd79a92ff56abe3c33389bd9c836c501c20));
        vk.gamma_abc[32] = Pairing.G1Point(uint256(0x284a6d47d47f7c7c6039191e88baf46f4724e413d5cddde187406728660e67c4), uint256(0x1bac73608097d459e1c94aaea0fc4f4795fdd6ce2a141a747172e53bd960d95c));
        vk.gamma_abc[33] = Pairing.G1Point(uint256(0x18f45782d7c3e3ad9de0db6a08cb8cde44e57ab0c552c739181db84896dbbd5f), uint256(0x0f974990da1ca84448e6d599a1cb7ddb9b94acdeaf0031e661214d1279954c8b));
        vk.gamma_abc[34] = Pairing.G1Point(uint256(0x011d586346268b51a11b201868714a614a503aca64f6429d4a3ebacbfb5cbc99), uint256(0x2c29b0d4828d3d1bb05aa7ae69c9fb3a5cd889754805c8c66214805282068eb0));
        vk.gamma_abc[35] = Pairing.G1Point(uint256(0x249552d01e19f1e8a75dfda7b075e1ddd2418c1999aac31d19daa9f52c3a029f), uint256(0x04c877dd2b2048014cabca8431cc79b6e8b16624320e0b9163f6bda37c5db6ca));
        vk.gamma_abc[36] = Pairing.G1Point(uint256(0x1ca4e1d5f878f9f8dba1a7997696aa575a53b4f78bb4b34d9e5872af28d62836), uint256(0x2e5e72b09c0b086691c0d62ff01b93223f701ca1a5aa8961a771a79a126e0df7));
        vk.gamma_abc[37] = Pairing.G1Point(uint256(0x07bfc10908fdf76dac375c27daab15e90a76b4e2c44cfa3983ec201dfcd8930a), uint256(0x087afbe375c991cf8f94822b5ecce7ec78901d35d5c496a806f32da3c6392f0c));
        vk.gamma_abc[38] = Pairing.G1Point(uint256(0x2aeb5f4e29e9f7ebde69e7fcbbb8c0c4c9634b7fcfe56cc3c12c2dbaa45ac054), uint256(0x0a306ebdde5fe0940eaebb93dacc2e6f23672cf6667278ef77d7eed27fc74e46));
        vk.gamma_abc[39] = Pairing.G1Point(uint256(0x0e71a12800456a88d5e22657cb1cb4431019dc735082cc8417ff033e1291fb30), uint256(0x18b4faef8f98f73344750fa60617dac1f4924dabc023a4ca646d0e00227745f6));
        vk.gamma_abc[40] = Pairing.G1Point(uint256(0x0d45f14027310bff1ac6acd8d76af7b54965503ea390295cd60961c2f1889a98), uint256(0x1c50944fd42daebf4d1ae70ee6b078ef08f3405903f303ee894bc30f39fdbb0c));
        vk.gamma_abc[41] = Pairing.G1Point(uint256(0x026ec327e16b3167b28f31767bdcd5cbb916c64279a0c5eb95eb7444b7f99e43), uint256(0x2b11e457a30c6b471c20cd26cd941e6d3abd942d10d654f42b793e47be371c13));
        vk.gamma_abc[42] = Pairing.G1Point(uint256(0x00b750345a92fb381bd3bc2518cc5510652b41c3ec375f25dabf6b0d3c7cef6d), uint256(0x1b586105703f570a5d6306f758535348194e3728da240ae5666b22de00337898));
        vk.gamma_abc[43] = Pairing.G1Point(uint256(0x2544db4aada587ab580b67cb07c71893b401e2670b0e38257429138a4d4cd070), uint256(0x14e4f78021561cd1d96d6349024251d3eccf9937f9f73ae1b9ad95a65a376451));
        vk.gamma_abc[44] = Pairing.G1Point(uint256(0x075b0e1c2195833e58c8b2348cc14f16f1c692757dd578b1e6fafdf177771e82), uint256(0x2d3e7a811ed03302cf467a09abcea77789546fbacfe55353a612a4549c4506de));
        vk.gamma_abc[45] = Pairing.G1Point(uint256(0x2d2ad74cd24c2aec31308c171dfe1e890599a587870c4954b53685ed930816f4), uint256(0x0059dba5a00f9fa05a7a68fb5b4e259b6e1ce7d816e32ec090f3c3688bca31f1));
        vk.gamma_abc[46] = Pairing.G1Point(uint256(0x0e5829c4bc5bd961016d5c28e3c43854ee59e85186f687b698ca708d3a5a2850), uint256(0x30510780b57b68ede53b667321e9d20ae1252175537f86e90d3713e21007dd0d));
        vk.gamma_abc[47] = Pairing.G1Point(uint256(0x28ec97a700ad4412f3756e7ee634a8736b96166bcb66b64dafb378d402a14334), uint256(0x18bfa3fb913e8ab904dae13b25b3dce95338d35b23e67a39506f13a6d28bb09a));
        vk.gamma_abc[48] = Pairing.G1Point(uint256(0x07f391a1adaa053d2bef76fdcf0829afaf69c065566621a641e8d692d8e5b097), uint256(0x0b49a6ac57c1266f07a560fe3d456904e76853b6f3ae0b0e15be2ea5fa487a50));
        vk.gamma_abc[49] = Pairing.G1Point(uint256(0x099a183b3b409faae6b8801e2d3e2222c26695247ac342fc72726241fddb2ec6), uint256(0x00e8413edf3c264d7edc0a1c1ba9dac078cd021a3419126fedcb3e5a1d519e94));
        vk.gamma_abc[50] = Pairing.G1Point(uint256(0x13c074cc37fd2e5d5c45eb67e0b9dcd09016d7f0dde0081605faa083a3ade293), uint256(0x1d8abc06bba211723a6b88951b7bb1930da443d7d45502527d5895166690661d));
        vk.gamma_abc[51] = Pairing.G1Point(uint256(0x156eec6fe8edf229aad568fd9ad12404b1c99f7126c6c944c13139de3b349d22), uint256(0x10458b0f61177216a044294ac6bb30961085f9d9b8f500360bfadf58295317c9));
        vk.gamma_abc[52] = Pairing.G1Point(uint256(0x0eec18831c32099de3705ef21d518902de116023dcfac9ef1075326c9a6ae918), uint256(0x1b09e8182dc5f200d3017a4511de90a0c108e01e6dff8cec60a879952b4e2bc0));
        vk.gamma_abc[53] = Pairing.G1Point(uint256(0x199b43090712de09662fdd2477711e7b8a5b9f9346d4a442904df2d2eec4008a), uint256(0x264e590fcd962254b6f96d91ea455a278755e894e9ca3c31f205beaaa7c38a2b));
        vk.gamma_abc[54] = Pairing.G1Point(uint256(0x20f48b92ecacf73cfdca126e87ea1108d761281d99832dfd12b711b2ba0194f0), uint256(0x249ce90b237bcb5652663195f4de55c6144c10cbb3dbe14543acd8c7bb4c9f0c));
        vk.gamma_abc[55] = Pairing.G1Point(uint256(0x2da590ecc4bca14ca5e9accfb96797c0a64ad34bd19769015a4ca6c81e41aa5b), uint256(0x2cfe674f778fcd4227d624557cf06f64783e50ca9307d206a94bf160b30c7047));
        vk.gamma_abc[56] = Pairing.G1Point(uint256(0x22fd96481fa5973fccaed8bbbf2c9bae11a0badfa9c9b9a2622c0b78bd9d4f68), uint256(0x160b04dbd622446021a3222deb193f8065dbdbb9e6a0c20732cf26cb8d33c030));
    }
    function verify(uint[] memory input, Proof memory proof) internal view returns (uint) {
        uint256 snark_scalar_field = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
        VerifyingKey memory vk = verifyingKey();
        require(input.length + 1 == vk.gamma_abc.length);
        // Compute the linear combination vk_x
        Pairing.G1Point memory vk_x = Pairing.G1Point(0, 0);
        for (uint i = 0; i < input.length; i++) {
            require(input[i] < snark_scalar_field);
            vk_x = Pairing.addition(vk_x, Pairing.scalar_mul(vk.gamma_abc[i + 1], input[i]));
        }
        vk_x = Pairing.addition(vk_x, vk.gamma_abc[0]);
        if(!Pairing.pairingProd4(
             proof.a, proof.b,
             Pairing.negate(vk_x), vk.gamma,
             Pairing.negate(proof.c), vk.delta,
             Pairing.negate(vk.alpha), vk.beta)) return 1;
        return 0;
    }
    function verifyTx(
            Proof memory proof, uint[56] memory input
        ) public view returns (bool r) {
        uint[] memory inputValues = new uint[](56);
        
        for(uint i = 0; i < input.length; i++){
            inputValues[i] = input[i];
        }
        if (verify(inputValues, proof) == 0) {
            return true;
        } else {
            return false;
        }
    }
}
