// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./RoleManagement.sol";

contract EHRManagement {
    RoleManagement roleManagement;

    struct EHR {
        string ipfsHash; // IPFS hash of the encrypted EHR file
        address uploadedBy; // Hospital that uploaded the EHR
        uint256 timestamp;
        bool verified;
    }

    mapping(address => EHR[]) private ehrRecords;
    mapping(address => mapping(address => bool)) public accessPermissions; // Hospital grants access to researchers

    event EHRUploaded(address indexed hospital, string ipfsHash);
    event EHRVerified(address indexed dataAuditor, address indexed hospital, string ipfsHash);
    event AccessGranted(address indexed hospital, address indexed researcher);
    event AccessRevoked(address indexed hospital, address indexed researcher);
    event EHRProofRequested(address indexed researcher, address indexed hospital, string ipfsHash);

    constructor(address _roleManagementAddress) {
        roleManagement = RoleManagement(_roleManagementAddress);
    }

    // **Hospitals upload EHRs to IPFS**
    function uploadEHR(string memory ipfsHash) public {
        require(roleManagement.getRole(msg.sender) == RoleManagement.Role.Hospital, "Only hospitals can upload EHRs");

        ehrRecords[msg.sender].push(EHR({
            ipfsHash: ipfsHash,
            uploadedBy: msg.sender,
            timestamp: block.timestamp,
            verified: false
        }));

        emit EHRUploaded(msg.sender, ipfsHash);
    }

    // **Data Auditors verify and approve EHRs**
    function verifyEHR(address hospital, uint256 ehrIndex) public {
        require(roleManagement.getRole(msg.sender) == RoleManagement.Role.DataAuditor, "Only data auditors can verify EHRs");
        require(ehrIndex < ehrRecords[hospital].length, "Invalid EHR index");

        ehrRecords[hospital][ehrIndex].verified = true;

        emit EHRVerified(msg.sender, hospital, ehrRecords[hospital][ehrIndex].ipfsHash);
    }

    // **Hospitals grant access to researchers for anonymized data verification**
    function grantAccess(address researcher) public {
        require(roleManagement.getRole(msg.sender) == RoleManagement.Role.Hospital, "Only hospitals can grant access");
        require(roleManagement.getRole(researcher) == RoleManagement.Role.Researcher, "Invalid researcher role");

        accessPermissions[msg.sender][researcher] = true;

        emit AccessGranted(msg.sender, researcher);
    }

    // **Hospitals revoke access from researchers**
    function revokeAccess(address researcher) public {
        require(roleManagement.getRole(msg.sender) == RoleManagement.Role.Hospital, "Only hospitals can revoke access");

        accessPermissions[msg.sender][researcher] = false;

        emit AccessRevoked(msg.sender, researcher);
    }

    // **Researchers request proof for an EHR verification**
    function requestEHRProof(address hospital, uint256 ehrIndex) public {
        require(roleManagement.getRole(msg.sender) == RoleManagement.Role.Researcher, "Only researchers can request proof");
        require(accessPermissions[hospital][msg.sender], "No access granted by hospital");
        require(ehrIndex < ehrRecords[hospital].length, "Invalid EHR index");

        emit EHRProofRequested(msg.sender, hospital, ehrRecords[hospital][ehrIndex].ipfsHash);
    }

    // **Retrieve a hospital's EHR (only accessible by authorized researchers)**
    function getEHR(address hospital, uint256 index) public view returns (string memory) {
        require(accessPermissions[hospital][msg.sender], "No access to this EHR");
        require(index < ehrRecords[hospital].length, "Invalid EHR index");

        return ehrRecords[hospital][index].ipfsHash;
    }

    // **Retrieve all EHRs uploaded by a hospital**
    function getAllEHRs(address hospital) public view returns (EHR[] memory) {
        return ehrRecords[hospital];
    }
}