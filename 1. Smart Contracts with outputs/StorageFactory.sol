// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {EHRStorage} from "./SimpleStorage.sol";

contract StorageFactory {
    mapping(address => EHRStorage) public hospitalStorageContracts;

    event EHRStorageCreated(address indexed hospital, address contractAddress);

    // **Hospitals deploy their own storage contract**
    function createEHRStorageContract() public {
        require(address(hospitalStorageContracts[msg.sender]) == address(0), "Storage contract already exists");

        EHRStorage newEHRStorageContract = new EHRStorage();
        hospitalStorageContracts[msg.sender] = newEHRStorageContract;

        emit EHRStorageCreated(msg.sender, address(newEHRStorageContract));
    }

    // **Hospitals store EHR metadata in their own contract**
    function sfStoreEHR(string memory _ipfsHash) public {
        require(address(hospitalStorageContracts[msg.sender]) != address(0), "No storage contract found");

        EHRStorage myEHRStorage = hospitalStorageContracts[msg.sender];
        myEHRStorage.storeEHR(_ipfsHash);
    }

    // **Hospitals retrieve an EHR from their storage contract**
    function sfGetEHR(uint256 index) public view returns (string memory, uint256, bool) {
        require(address(hospitalStorageContracts[msg.sender]) != address(0), "No storage contract found");

        EHRStorage myEHRStorage = hospitalStorageContracts[msg.sender];
        return myEHRStorage.getEHR(index);
    }

    // **Retrieve all EHRs for a hospital**
    function sfGetAllEHRs() public view returns (EHRStorage.EHRMetadata[] memory) {
        require(address(hospitalStorageContracts[msg.sender]) != address(0), "No storage contract found");

        EHRStorage myEHRStorage = hospitalStorageContracts[msg.sender];
        return myEHRStorage.getAllEHRs(msg.sender);
    }
}