// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract EHRStorage {
    struct EHRMetadata {
        string ipfsHash; // Stores the IPFS hash of the encrypted EHR
        uint256 timestamp; // Time when the EHR was stored
        bool verified; // Whether the EHR has been verified by a Data Auditor
    }

    mapping(address => EHRMetadata[]) public hospitalEHRs;

    event EHRStored(address indexed hospital, string ipfsHash, uint256 timestamp);
    event EHRVerified(address indexed hospital, uint256 ehrIndex);

    // **Hospitals store an EHR's metadata**
    function storeEHR(string memory _ipfsHash) public {
        hospitalEHRs[msg.sender].push(EHRMetadata({
            ipfsHash: _ipfsHash,
            timestamp: block.timestamp,
            verified: false
        }));

        emit EHRStored(msg.sender, _ipfsHash, block.timestamp);
    }

    // **Hospitals retrieve their EHR metadata**
    function getEHR(uint256 index) public view returns (string memory, uint256, bool) {
        require(index < hospitalEHRs[msg.sender].length, "Invalid EHR index");

        EHRMetadata memory ehr = hospitalEHRs[msg.sender][index];
        return (ehr.ipfsHash, ehr.timestamp, ehr.verified);
    }

    // **Data Auditors verify an EHR**
    function verifyEHR(address hospital, uint256 index) public {
        require(index < hospitalEHRs[hospital].length, "Invalid EHR index");

        hospitalEHRs[hospital][index].verified = true;

        emit EHRVerified(hospital, index);
    }

    // **Retrieve all EHRs for a hospital**
    function getAllEHRs(address hospital) public view returns (EHRMetadata[] memory) {
        return hospitalEHRs[hospital];
    }
}