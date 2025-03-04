# MTP
# Project Documentation

# **📌 System Architecture & Entities for the New System**
## **🔹 Overview of the New System**
The new system is a **blockchain-based decentralized EHR sharing and verification platform** that:
✅ **Allows hospitals to manage and store encrypted EHRs on IPFS.**  
✅ **Uses Zero-Knowledge Proofs (ZKPs) to verify medical data without revealing patient details.**  
✅ **Provides researchers access to validated, anonymized medical data for analysis.**  
✅ **Ensures trust and transparency through Ethereum smart contracts.**  

---

## **🏛️ System Architecture**
### **1️⃣ On-Chain Components (Smart Contracts on Ethereum)**
- **Role Management Contract** → Controls access roles for hospitals, data auditors, and researchers.
- **EHR Management Contract** → Manages the uploading, verification, and sharing of EHRs.
- **Storage Contracts** → Each hospital deploys its own contract to store EHR metadata.
- **ZKP Verification Contract** → Verifies EHR authenticity without revealing sensitive data.

### **2️⃣ Off-Chain Components**
- **IPFS (InterPlanetary File System)** → Stores **encrypted** EHRs to ensure privacy.
- **ZK-Proof Generator (ZoKrates)** → Generates **proofs** that an EHR is authentic without exposing patient data.
- **Data Auditors (Doctors)** → Verify EHRs before they are shared with researchers.

---

## **🛠️ System Entities & Their Roles**
### **🏥 1. Hospitals (EHR Owners)**
🔹 **Role:** The **primary entity responsible for uploading and managing EHRs.**  
🔹 **Actions:**  
✅ **Uploads encrypted EHRs** to **IPFS**.  
✅ **Manages access control** for researchers.  
✅ **Works with Data Auditors** for verification.  
🔹 **Why is it Important?**  
- Ensures **patient confidentiality**.  
- Controls who can access EHRs.

### **👨‍⚕️ 2. Data Auditors (Doctors, Trusted Entities)**
🔹 **Role:** **Verifies and certifies EHRs** before they can be used for research.  
🔹 **Actions:**  
✅ **Validates the authenticity of EHRs** before sharing.  
✅ **Uses smart contracts to mark EHRs as verified**.  
✅ **Ensures only approved records are used for research.**  
🔹 **Why is it Important?**  
- **Prevents fake EHR data** from being used in research.  
- **Adds a trust layer** between hospitals and researchers.  

### **🔬 3. Researchers/Scientists (Untrusted Party)**
🔹 **Role:** **Requests anonymized data and verifies it using Zero-Knowledge Proofs.**  
🔹 **Actions:**  
✅ **Requests specific medical data** without seeing private details.  
✅ **Uses ZKP to verify if data meets their needs**.  
✅ **Analyzes medical patterns and trends** without violating privacy.  
🔹 **Why is it Important?**  
- Enables **medical research without breaching patient confidentiality**.  
- **Uses cryptographic proofs** instead of needing direct access to EHRs.

### **🌎 4. Decentralized Hospital Network**
🔹 **Role:** **Connects multiple hospitals, allowing secure data sharing.**  
🔹 **Actions:**  
✅ **Interconnects hospitals through blockchain smart contracts.**  
✅ **Prevents tampering by decentralizing EHR data.**  
✅ **Ensures hospitals can securely exchange verified medical records.**  
🔹 **Why is it Important?**  
- Eliminates **single points of failure**.  
- Increases **trust and collaboration** between hospitals.

### **🗂️ 5. IPFS Pinning Nodes (Decentralized Storage)**
🔹 **Role:** **Stores encrypted EHRs off-chain for secure and scalable data storage.**  
🔹 **Actions:**  
✅ **Stores EHRs using content-addressable hashes**.  
✅ **Ensures data is retrievable** even if a hospital node goes offline.  
✅ **Reduces on-chain storage costs**.  
🔹 **Why is it Important?**  
- Off-chain storage **avoids blockchain bloat**.  
- **Protects patient privacy** while allowing verification.

### **⛓️ 6. Ethereum Smart Contracts (Access Control & Data Sharing)**
🔹 **Role:** **Enforces rules for accessing and verifying EHRs.**  
🔹 **Actions:**  
✅ **Manages role-based access control** for Hospitals, Auditors, and Researchers.  
✅ **Logs all transactions** for transparency.  
✅ **Facilitates ZKP-based verification** without revealing sensitive data.  
🔹 **Why is it Important?**  
- **Ensures tamper-proof auditing**.  
- **Prevents unauthorized access** to EHRs.

### **🛡️ 7. ZoKrates ZKP System (Zero-Knowledge Proofs)**
🔹 **Role:** **Generates cryptographic proofs that EHRs are valid.**  
🔹 **Actions:**  
✅ **Allows researchers to verify EHR authenticity** without accessing private data.  
✅ **Generates proofs that confirm EHRs meet specific conditions.**  
✅ **Prevents unauthorized parties from seeing sensitive records.**  
🔹 **Why is it Important?**  
- Enables **privacy-preserving data validation**.  
- Reduces **risk of exposing patient data to researchers**.  

### **📜 8. Blockchain Ledger (Ethereum)**
🔹 **Role:** **Immutable ledger storing EHR metadata and verification records.**  
🔹 **Actions:**  
✅ **Records all transactions** (EHR uploads, access requests, verification events).  
✅ **Prevents tampering** of access control and role-based permissions.  
✅ **Increases system transparency**.  
🔹 **Why is it Important?**  
- Ensures **immutability** and **traceability**.  
- Allows **hospitals and researchers to trust** the data.  

---

## **🔄 System Workflow (How It Works)**
### **1️⃣ EHR Upload & Storage**
📌 **Step 1:** **Hospitals encrypt EHR data** and upload it to **IPFS**.  
📌 **Step 2:** The hospital stores the **IPFS hash** on Ethereum **via the smart contract**.  
📌 **Step 3:** The smart contract logs the transaction for **auditability**.

---

### **2️⃣ EHR Verification by Data Auditors**
📌 **Step 4:** **A Data Auditor reviews the EHR**.  
📌 **Step 5:** If valid, the auditor **marks the EHR as verified** using the smart contract.  
📌 **Step 6:** The verification status is **updated on-chain**.

---

### **3️⃣ Researchers Request & Verify EHR Data**
📌 **Step 7:** **A Researcher requests medical data** from a hospital.  
📌 **Step 8:** The hospital **grants access** via the smart contract.  
📌 **Step 9:** The researcher **receives a Zero-Knowledge Proof (ZKP)** that the EHR is authentic.  
📌 **Step 🔟:** The researcher **validates the proof** without needing direct access to private data.

---

## **🎯 Why is this Architecture Important?**
✅ **Decentralized & Tamper-Proof** → Ensures no single entity controls medical records.  
✅ **Privacy-Preserving Research** → Researchers verify without seeing patient data.  
✅ **Immutable Verification** → Auditors can validate EHRs transparently.  
✅ **Secure Data Sharing** → IPFS + Blockchain + ZKP prevent unauthorized access.  

---

## **🚀 Next Steps**
- **Should hospitals be able to revoke researcher access at any time?**  
- **Would you like to add time-based access control for researchers?**  

Let me know how you'd like to refine the design! 🚀🔥

# **📌 Detailed System Architecture of the New Blockchain-Based EHR System**
---

## **🔹 Overview of the System**
The new system is designed to **securely store, manage, and verify Electronic Health Records (EHRs) on a decentralized blockchain-based infrastructure**.  
It ensures **privacy, security, and selective data sharing** using **Ethereum smart contracts, IPFS for off-chain storage, and Zero-Knowledge Proofs (ZKP) for privacy-preserving verification**.

---

## **🏗️ Architecture Components**
The system consists of **three layers**:  

1️⃣ **Application Layer** (Users & Interactions)  
2️⃣ **Blockchain & Smart Contract Layer** (Core Logic & Security)  
3️⃣ **Off-Chain Storage & Verification Layer** (IPFS & ZKP)

---

## **🖥️ 1️⃣ Application Layer (User Interactions)**
### **👥 System Entities**
| **Entity**          | **Role & Responsibilities** |
|---------------------|---------------------------|
| 🏥 **Hospitals** | Upload, store, and manage encrypted EHRs. |
| 🧑‍⚕️ **Data Auditors (Doctors)** | Verify the authenticity of EHRs. |
| 🔬 **Researchers/Scientists** | Request EHR proofs for research without seeing raw data. |
| 🌍 **Decentralized Hospital Network** | Connects hospitals for secure EHR sharing. |

### **🔹 How Users Interact with the System**
- **Hospitals upload encrypted EHRs** → IPFS stores them & the smart contract records the hash.
- **Data Auditors verify EHRs** → They confirm the records' authenticity.
- **Researchers request data** → They receive **Zero-Knowledge Proofs** (ZKPs) instead of raw data.
- **Blockchain enforces access control** → Ensures only authorized entities interact.

---

## **⛓️ 2️⃣ Blockchain & Smart Contract Layer (Ethereum)**
This layer **handles security, access control, and data verification** through **smart contracts**.

### **🔹 Key Smart Contracts**
| **Smart Contract** | **Functionality** |
|--------------------|------------------|
| 🔑 **Role Management Contract** | Manages roles (Hospital, Data Auditor, Researcher). |
| 📜 **EHR Management Contract** | Controls EHR upload, access, and verification. |
| 📂 **Storage Factory Contract** | Deploys individual EHR storage contracts per hospital. |
| 🔍 **ZKP Verifier Contract** | Uses ZoKrates to verify EHR integrity without exposing data. |

---

### **📜 Smart Contract Interactions**
1️⃣ **Hospitals upload EHRs**  
   - The **EHR Management Contract** records the **IPFS hash** on the blockchain.
   - **Storage Factory Contract** ensures each hospital gets its own storage.

2️⃣ **Data Auditors verify EHRs**  
   - Auditors **validate** EHRs and **update their verification status** on-chain.

3️⃣ **Researchers request EHR verification**  
   - The **ZKP Verifier Contract** generates a **Zero-Knowledge Proof** to verify data without revealing raw details.

---

## **🗂️ 3️⃣ Off-Chain Storage & Verification Layer (IPFS & ZKP)**
This layer ensures **efficient storage and privacy-preserving verification**.

### **🔹 Components**
| **Component** | **Functionality** |
|--------------|------------------|
| 🌐 **IPFS (InterPlanetary File System)** | Stores **encrypted** EHRs **off-chain** to prevent blockchain congestion. |
| 🔑 **IPFS Pinning Nodes** | Ensures EHR data remains accessible and retrievable. |
| 🔢 **ZoKrates ZKP System** | Generates cryptographic proofs for EHR verification. |

### **📜 Off-Chain Process**
1️⃣ **Hospitals encrypt EHRs and upload to IPFS.**  
   - They receive a **content-addressed hash** that uniquely identifies the record.

2️⃣ **Smart contracts store the hash and metadata.**  
   - Prevents tampering and ensures immutability.

3️⃣ **ZoKrates generates ZKPs when researchers request data.**  
   - **Researchers only see proofs, NOT raw EHR data**.

---

## **🔄 End-to-End Workflow**
### **1️⃣ EHR Upload & Storage (Hospitals)**
📌 **Step 1**: **Hospital encrypts EHR** and uploads it to **IPFS**.  
📌 **Step 2**: Hospital stores **IPFS hash** in the **EHR Management Smart Contract**.  
📌 **Step 3**: The contract **logs the transaction** for traceability.

---

### **2️⃣ EHR Verification (Data Auditors)**
📌 **Step 4**: **A Data Auditor reviews the EHR** for authenticity.  
📌 **Step 5**: If valid, the auditor **marks the EHR as verified** in the **EHR Management Contract**.  
📌 **Step 6**: The **verification status is updated** on-chain.

---

### **3️⃣ Researchers Request & Verify Data (Zero-Knowledge Proofs)**
📌 **Step 7**: **A Researcher requests medical data** from a hospital.  
📌 **Step 8**: The hospital **grants access** via the **smart contract**.  
📌 **Step 9**: The **ZoKrates ZKP System** generates a **cryptographic proof** that the data is valid.  
📌 **Step 🔟**: The researcher **verifies the proof** using the **ZKP Verifier Contract**, **without seeing private data**.

---

## **🔍 Security & Privacy Features**
### **✅ 1. Data Encryption**
- **EHRs are encrypted** before being stored on IPFS.
- **Only authorized parties can decrypt** the records.

### **✅ 2. Immutable Blockchain Records**
- **All transactions (uploads, verifications, access grants) are stored permanently**.
- **Prevents fraud and ensures accountability**.

### **✅ 3. Zero-Knowledge Proofs (ZKPs)**
- **Allows verification without exposing raw patient data**.
- **Researchers get proof that a record meets their criteria** without accessing sensitive information.

### **✅ 4. Role-Based Access Control (RBAC)**
- **Hospitals control who can access records**.
- **Only verified researchers can request proofs**.
- **Data Auditors ensure record authenticity**.

---

## **📌 System Architecture Diagram**
Here’s a simplified **visual representation** of how the system components interact:

```
                           +---------------------------+
                           |    👥 USERS (Entities)     |
                           +---------------------------+
                                    |
                                    v
                        +------------------------+
                        |    📜 Ethereum Layer   |
                        | (Smart Contracts & ZKP) |
                        +------------------------+
                           |     |     |      |
               +-----------+     |     |      +-------------+
               |                 |     |                    |
        +------------+   +------------+   +----------------+
        | Role Mgmt  |   |  EHR Mgmt   |   | ZKP Verifier   |
        |  Contract  |   |  Contract   |   |  Contract      |
        +------------+   +------------+   +----------------+
               |                 |                     |
               v                 v                     v
        +------------+    +------------------+  +----------------------+
        |   🔗 IPFS  |    | 🏥 Hospital Nodes |  | 🔬 Researcher Queries |
        |  Storage   |    | (EHR Uploads)    |  | (Verifies EHR w/ ZKP) |
        +------------+    +------------------+  +----------------------+
```

---

## **🎯 Key Advantages of the System**
✅ **Decentralized & Tamper-Proof** → Prevents unauthorized data alterations.  
✅ **Privacy-Preserving Research** → Researchers verify without seeing patient data.  
✅ **Immutable Verification** → Auditors validate EHRs transparently.  
✅ **Efficient & Scalable** → IPFS & ZKP reduce storage and computation overhead.  

---


### **📌 `RoleManagement.sol` for the New System**
This **updated Role Management smart contract** is designed for the **new system**, which includes **Hospitals, Data Auditors, Researchers, and IPFS Nodes**.

### **🔹 Key Changes from the Old System**
✅ **Replaces Patients, Doctors, and Pharmacies** with **Hospitals, Data Auditors (Doctors), and Researchers**.  
✅ **Allows role requests and verification by an admin**.  
✅ **Enables hospitals to register and control EHR access**.  
✅ **Includes functions for role assignment, approval, and revocation.**  

---

## **📜 New `RoleManagement.sol`**
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RoleManagement {
    enum Role { None, Hospital, DataAuditor, Researcher, IPFSNode }
    enum RequestStatus { None, Requested, Approved, Rejected }

    struct RoleRequest {
        string registrationId;
        RequestStatus status;
    }

    struct VerifiedRole {
        address userAddress;
        Role role;
        string registrationId;
    }

    mapping(address => Role) public roles;
    mapping(address => RoleRequest) public roleRequests;
    address public admin;
    address[] public pendingRequests; // List of addresses with pending requests

    VerifiedRole[] public verifiedHospitals;
    VerifiedRole[] public verifiedAuditors;
    VerifiedRole[] public verifiedResearchers;
    VerifiedRole[] public verifiedIPFSNodes;

    event RoleRequested(address indexed requestor, string registrationId, Role role);
    event RoleApproved(address indexed requestor, Role role);
    event RoleRejected(address indexed requestor);
    event RoleRevoked(address indexed user, Role role);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyRequester() {
        require(roleRequests[msg.sender].status == RequestStatus.Requested, "No request found");
        _;
    }

    constructor() {
        admin = msg.sender; // Set the deployer as the initial admin
    }

    // **Request to become a Hospital**
    function requestHospitalRole(string memory _registrationId) public {
        require(roles[msg.sender] == Role.None, "Role already assigned");
        require(roleRequests[msg.sender].status == RequestStatus.None, "Role request already pending");

        roleRequests[msg.sender] = RoleRequest({
            registrationId: _registrationId,
            status: RequestStatus.Requested
        });

        pendingRequests.push(msg.sender);
        emit RoleRequested(msg.sender, _registrationId, Role.Hospital);
    }

    // **Request to become a Data Auditor (Doctor)**
    function requestDataAuditorRole(string memory _registrationId) public {
        require(roles[msg.sender] == Role.None, "Role already assigned");
        require(roleRequests[msg.sender].status == RequestStatus.None, "Role request already pending");

        roleRequests[msg.sender] = RoleRequest({
            registrationId: _registrationId,
            status: RequestStatus.Requested
        });

        pendingRequests.push(msg.sender);
        emit RoleRequested(msg.sender, _registrationId, Role.DataAuditor);
    }

    // **Request to become a Researcher**
    function requestResearcherRole(string memory _registrationId) public {
        require(roles[msg.sender] == Role.None, "Role already assigned");
        require(roleRequests[msg.sender].status == RequestStatus.None, "Role request already pending");

        roleRequests[msg.sender] = RoleRequest({
            registrationId: _registrationId,
            status: RequestStatus.Requested
        });

        pendingRequests.push(msg.sender);
        emit RoleRequested(msg.sender, _registrationId, Role.Researcher);
    }

    // **Request to become an IPFS Node**
    function requestIPFSNodeRole(string memory _registrationId) public {
        require(roles[msg.sender] == Role.None, "Role already assigned");
        require(roleRequests[msg.sender].status == RequestStatus.None, "Role request already pending");

        roleRequests[msg.sender] = RoleRequest({
            registrationId: _registrationId,
            status: RequestStatus.Requested
        });

        pendingRequests.push(msg.sender);
        emit RoleRequested(msg.sender, _registrationId, Role.IPFSNode);
    }

    // **Admin verifies a Hospital role request**
    function verifyHospitalRole(address _requestor) public onlyAdmin {
        require(roleRequests[_requestor].status == RequestStatus.Requested, "No request to verify");
        require(roles[_requestor] == Role.None, "Role already assigned");

        roles[_requestor] = Role.Hospital;
        roleRequests[_requestor].status = RequestStatus.Approved;

        verifiedHospitals.push(VerifiedRole(_requestor, Role.Hospital, roleRequests[_requestor].registrationId));
        _removePendingRequest(_requestor);

        emit RoleApproved(_requestor, Role.Hospital);
    }

    // **Admin verifies a Data Auditor role request**
    function verifyDataAuditorRole(address _requestor) public onlyAdmin {
        require(roleRequests[_requestor].status == RequestStatus.Requested, "No request to verify");
        require(roles[_requestor] == Role.None, "Role already assigned");

        roles[_requestor] = Role.DataAuditor;
        roleRequests[_requestor].status = RequestStatus.Approved;

        verifiedAuditors.push(VerifiedRole(_requestor, Role.DataAuditor, roleRequests[_requestor].registrationId));
        _removePendingRequest(_requestor);

        emit RoleApproved(_requestor, Role.DataAuditor);
    }

    // **Admin verifies a Researcher role request**
    function verifyResearcherRole(address _requestor) public onlyAdmin {
        require(roleRequests[_requestor].status == RequestStatus.Requested, "No request to verify");
        require(roles[_requestor] == Role.None, "Role already assigned");

        roles[_requestor] = Role.Researcher;
        roleRequests[_requestor].status = RequestStatus.Approved;

        verifiedResearchers.push(VerifiedRole(_requestor, Role.Researcher, roleRequests[_requestor].registrationId));
        _removePendingRequest(_requestor);

        emit RoleApproved(_requestor, Role.Researcher);
    }

    // **Admin verifies an IPFS Node role request**
    function verifyIPFSNodeRole(address _requestor) public onlyAdmin {
        require(roleRequests[_requestor].status == RequestStatus.Requested, "No request to verify");
        require(roles[_requestor] == Role.None, "Role already assigned");

        roles[_requestor] = Role.IPFSNode;
        roleRequests[_requestor].status = RequestStatus.Approved;

        verifiedIPFSNodes.push(VerifiedRole(_requestor, Role.IPFSNode, roleRequests[_requestor].registrationId));
        _removePendingRequest(_requestor);

        emit RoleApproved(_requestor, Role.IPFSNode);
    }

    // **Admin rejects a role request**
    function rejectRole(address _requestor) public onlyAdmin {
        require(roleRequests[_requestor].status == RequestStatus.Requested, "No request to reject");

        roleRequests[_requestor].status = RequestStatus.Rejected;
        _removePendingRequest(_requestor);

        emit RoleRejected(_requestor);
    }

    // **Admin revokes a role**
    function revokeRole(address _user) public onlyAdmin {
        require(roles[_user] != Role.None, "User has no assigned role");

        Role revokedRole = roles[_user];
        roles[_user] = Role.None;

        emit RoleRevoked(_user, revokedRole);
    }

    // **Get all pending requests**
    function getPendingRequests() public view onlyAdmin returns (address[] memory) {
        return pendingRequests;
    }

    // **Get assigned role of an address**
    function getRole(address user) public view returns (Role) {
        return roles[user];
    }

    // **Internal function to remove an address from the pending requests array**
    function _removePendingRequest(address _requestor) internal {
        for (uint i = 0; i < pendingRequests.length; i++) {
            if (pendingRequests[i] == _requestor) {
                pendingRequests[i] = pendingRequests[pendingRequests.length - 1];
                pendingRequests.pop();
                break;
            }
        }
    }
}
```

---

## **🔍 Key Features in the New System**
✅ **Hospitals register to manage EHRs.**  
✅ **Data Auditors (Doctors) verify & modify medical records.**  
✅ **Researchers request access to EHRs using ZKP verification.**  
✅ **IPFS Nodes handle off-chain encrypted storage.**  
✅ **Admin assigns, verifies, revokes roles as needed.**  



### **📌 `EHRManagement.sol` for the New System**
This smart contract **manages EHRs (Electronic Health Records)** in the **new system**, where:
- **Hospitals own & manage EHRs**.
- **Data Auditors (Doctors) verify and modify EHRs**.
- **Researchers request Zero-Knowledge Proofs (ZKPs) for verification**.
- **EHRs are stored on IPFS** for decentralized storage.

---

## **🔹 Key Changes from Old System**
✅ **Replaces "Patients" with "Hospitals" as EHR owners.**  
✅ **Replaces "Doctors issuing prescriptions" with "Data Auditors managing EHRs."**  
✅ **Removes pharmacy interactions (focuses on full EHRs).**  
✅ **Allows Researchers to request proof-based verification of anonymized data.**  
✅ **Uses IPFS for storing medical records off-chain.**  

---

## **📜 New `EHRManagement.sol`**
```solidity
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
```

---

## **🔍 Key Features in the New System**
✅ **Hospitals upload EHRs to IPFS (off-chain storage).**  
✅ **Data Auditors (Doctors) verify EHRs to ensure correctness.**  
✅ **Researchers can request ZKP-based proof verification of EHRs.**  
✅ **Hospitals control researcher access to anonymized EHRs.**  

---

### **📌 `SimpleStorage.sol` for the New System**
This contract will store **EHR metadata** instead of simple numbers.  
It will allow **hospitals** to **store** and **retrieve** patient records with associated metadata.

---

## **🔹 Key Changes from the Old System**
✅ **Replaces "Favorite Number" with "EHR Metadata" (IPFS hash, timestamp, verified status).**  
✅ **Uses a mapping to associate hospitals with EHR records.**  
✅ **Allows hospitals to store and retrieve their own EHR metadata.**  

---

## **📜 New `SimpleStorage.sol`**
```solidity
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

        EHRMetadata memory ehr = hospitalEHRs[msg.sender];
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
```

---

## **🔍 Key Features in the New System**
✅ **Hospitals store and manage EHR metadata.**  
✅ **Uses IPFS for off-chain encrypted storage.**  
✅ **Data Auditors can verify stored EHRs.**  
✅ **Hospitals can retrieve their stored EHRs at any time.**  

---


### **📌 `StorageFactory.sol` for the New System**
This contract **manages multiple EHR storage contracts** and allows hospitals to **deploy** and **interact with** their own storage contracts.

---

## **🔹 Key Changes from Old System**
✅ **Replaces `SimpleStorage` with `EHRStorage` to manage EHR metadata.**  
✅ **Hospitals can deploy their own `EHRStorage` contracts.**  
✅ **Hospitals can store and retrieve their EHRs from their respective contracts.**  

---

## **📜 New `StorageFactory.sol`**
```solidity
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
```

---

## **🔍 Key Features in the New System**
✅ **Hospitals deploy their own EHR storage contract.**  
✅ **Each hospital manages its own records securely.**  
✅ **EHRs are stored using IPFS hashes.**  
✅ **Hospitals can retrieve their own EHRs at any time.**  

---


### **📌 `AddFiveStorage.sol` for the New System**
This contract extends `EHRStorage.sol` and **modifies the way EHRs are stored**. Instead of simply storing an EHR, this contract **automatically flags all new EHRs as unverified** and requires a **Data Auditor to verify it**.

---

## **🔹 Key Changes from the Old System**
✅ **Extends `EHRStorage` instead of `SimpleStorage`**.  
✅ **Overrides `storeEHR()` to automatically mark EHRs as unverified**.  
✅ **Ensures Data Auditors must verify newly stored EHRs.**  

---

## **📜 New `AddVerificationStorage.sol`**
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {EHRStorage} from "./SimpleStorage.sol";

contract AddVerificationStorage is EHRStorage {

    // **Override function to ensure all EHRs start as unverified**
    function storeEHR(string memory _ipfsHash) public override {
        hospitalEHRs[msg.sender].push(EHRMetadata({
            ipfsHash: _ipfsHash,
            timestamp: block.timestamp,
            verified: false // Always starts as unverified
        }));

        emit EHRStored(msg.sender, _ipfsHash, block.timestamp);
    }
}
```

---

## **🔍 Key Features in the New System**
✅ **Automatically flags new EHRs as unverified.**  
✅ **Data Auditors must verify EHRs manually.**  
✅ **Ensures that all EHRs require validation before use.**  

---


### **📌 `ehr.zok` for the New System**
This Zero-Knowledge Proof (ZKP) circuit is designed for the **new system** where:
- **Hospitals** upload **EHRs** (Electronic Health Records).
- **Researchers** can verify EHR authenticity **without revealing patient data**.
- **Data Auditors** validate EHRs to ensure accuracy before sharing.
- **IPFS hashes are used to store records off-chain**.

---

## **🔹 Key Changes from the Old System**
✅ **Replaces `patientID` and `doctorID` with `hospitalID` and `dataAuditorID`.**  
✅ **Replaces `drugID` with a more general `EHRTypeID` to cover multiple records (X-rays, Blood Tests, etc.).**  
✅ **Ensures that verification is based on full EHR data rather than just prescriptions.**  
✅ **Hashes the EHR for ZKP validation without revealing sensitive details.**  

---

## **📜 New `ehr.zok`**
```zokrates
import "hashes/sha256/sha256Padded";

def main(
    u8[5] hospitalID,
    u8[5] dataAuditorID,
    u8[32] ehrData,      // Encrypted EHR data (e.g., X-ray, blood test reports)
    u8[5] ehrTypeID,     // Identifier for the type of EHR (X-ray, MRI, etc.)
    u32[8] expected_hash // Expected hash for verification
) -> u8 {
    u8[47] ehr = [
        hospitalID[0], hospitalID[1], hospitalID[2], hospitalID[3], hospitalID[4],
        dataAuditorID[0], dataAuditorID[1], dataAuditorID[2], dataAuditorID[3], dataAuditorID[4],
        ehrData[0], ehrData[1], ehrData[2], ehrData[3],
        ehrData[4], ehrData[5], ehrData[6], ehrData[7],
        ehrData[8], ehrData[9], ehrData[10], ehrData[11],
        ehrData[12], ehrData[13], ehrData[14], ehrData[15],
        ehrData[16], ehrData[17], ehrData[18], ehrData[19],
        ehrData[20], ehrData[21], ehrData[22], ehrData[23],
        ehrData[24], ehrData[25], ehrData[26], ehrData[27],
        ehrData[28], ehrData[29], ehrData[30], ehrData[31],
        ehrTypeID[0], ehrTypeID[1], ehrTypeID[2], ehrTypeID[3], ehrTypeID[4]
    ];

    // Compute the SHA-256 hash of the input EHR
    u32[8] hash = sha256Padded(ehr);

    // Verify that the computed hash matches the expected hash
    assert(hash == expected_hash);

    // Return 1 if the hash matches (valid proof)
    return 1;
}
```

---

#**Outputs**

## **🔍 Explanation of Changes**
### ✅ **New Inputs**
1. **`hospitalID` (5 bytes)** → Identifies the **hospital** that uploaded the EHR.
2. **`dataAuditorID` (5 bytes)** → Identifies the **data auditor** who verified the record.
3. **`ehrData` (32 bytes)** → Stores the **encrypted** health record (X-ray, MRI, etc.).
4. **`ehrTypeID` (5 bytes)** → Identifies the **type of EHR** (e.g., `00101` for X-ray, `00202` for MRI).
5. **`expected_hash` (8 x 32-bit integers)** → The **expected hash** value for verification.

### ✅ **Processing**
- The circuit **concatenates** all inputs into a **single data array (ehr)**.
- The **SHA-256 hash** of the data is computed.
- The computed **hash is compared with the expected hash**.
- If the **hash matches**, the proof is **valid**, and `1` is returned.

---

## **🔍 Key Features in the New System**
✅ **Allows verification of full EHRs instead of just prescriptions.**  
✅ **Supports different types of medical records (X-rays, Blood Tests, etc.).**  
✅ **Ensures patient privacy by using encrypted off-chain storage (IPFS).**  
✅ **Zero-Knowledge Proofs allow Researchers to verify authenticity without seeing private data.**  

---


# **📌 Outputs **
## *ZoKrates (zk-SNARK) Compilation and Execution Outputs*
1. *ZoKrates Code for zk-SNARK*  
    ![ZoKrates Code for zk-SNARK](https://github.com/user-attachments/assets/d0eb1cab-dd59-4f34-a1a6-cfa4e9880131)  

2. **Compilation of .zor File**  
    ![Compilation of .zor File](https://github.com/user-attachments/assets/8120cd2e-a2d7-4889-9126-aa729d4bdea0)  

3. **Compute Input of .zor**  
    ![Compute Input of .zor](https://github.com/user-attachments/assets/b9efdce2-806f-47a9-813d-4cee9e917cc8)  

4.  **Computed Successfully .zor File**  
    ![Computed Successfully .zor File](https://github.com/user-attachments/assets/acd26af4-d7ba-454b-994c-54b328c2d11e)  

5. **Run Setup Successfully for .zor File**  
    ![Run Setup Successfully for .zor File](https://github.com/user-attachments/assets/7a0f91ca-9f8f-4c02-85e2-c19d049aa2ff)  

6. **Generated Proof for .zor File**  
    ![Generated Proof for .zor File](https://github.com/user-attachments/assets/9aafa2a4-8667-4765-ad56-6e5e61dcfe8c)  

7. **Exported Verifier Key for .zor File**  
    ![Exported Verifier Key for .zor File](https://github.com/user-attachments/assets/233d68c2-3b6c-45e2-bab5-17c7e2178fb9)  

---

## *Smart Contract Functions and Deployment Costs*
1. *Smart Contracts Files and Outputs*  
   ![Smart Contracts Files and Output](https://github.com/user-attachments/assets/002efd3e-7964-4306-9ad1-98d5ae5667ea)  

2. *Role Management Smart Contract Functions - I*  
   ![RoleManagement Smart Contract Functions - I](https://github.com/user-attachments/assets/a1ce533d-41b4-416e-8b51-60e1c921b107)

3. *Role Management Smart Contract Functions - II*  
   ![Role Management Smart Contract Functions - II](https://github.com/user-attachments/assets/ebb14378-6c17-4000-ab5b-6cbaa86678d4)  

4. *Cost of Deploying RoleManagement.sol*  
    ![Cost of Deploying RoleManagement.sol](https://github.com/user-attachments/assets/26c22f38-b78f-4064-8bfe-fea9d1111a23)  

5. *Copying Deployment of RoleManagement.sol Contract*  
    ![Copying Deployment of RoleManagement.sol Contract](https://github.com/user-attachments/assets/f005d42f-4b46-4d4f-ba8d-d5f914d1383d)  

6. *Deploying EHRManagement.sol Smart Contract*  
    ![Deploying EHRManagement.sol Smart Contract](https://github.com/user-attachments/assets/61d2a422-929f-4ebc-b8ba-f430809d907f) 

7. *Functions of EHRManagement.sol*  
   ![Functions of EHRManagement.sol](https://github.com/user-attachments/assets/6d685e47-dcdc-481e-9d78-987a5bf90f52)       

8. *EHRManagement.sol Functions*  
   ![EHRManagement.sol Functions](https://github.com/user-attachments/assets/2b24546f-ea5a-4233-8033-4bcbfd2af492)  

9. *EHRStorage.sol Functions*  
   ![EHRStorage.sol Functions](https://github.com/user-attachments/assets/fece0e85-93c9-4cb2-a318-d07132cac85f)  

10. *EHRStorage.sol Deployment Cost*  
   ![EHRStorage.sol Deployment Cost](https://github.com/user-attachments/assets/56310dd5-aa1f-44a3-b838-754c7fe93310)  

11. *StorageFactory.sol Functions*  
   ![StorageFactory.sol Functions](https://github.com/user-attachments/assets/57a3b5b5-7492-4537-bdc1-432bac379df8)  

12. *StorageFactory.sol Deployment Costs*  
   ![StorageFactory.sol Deployment Costs](https://github.com/user-attachments/assets/683ed895-0091-4d23-abcf-35c3651982c7) 

---

## *zk-SNARK vs zk-STARK Analysis Graphs*
1. *Transaction Cost Comparison*  
    ![Transaction Cost Comparison](https://github.com/user-attachments/assets/ead49151-e961-4576-9ae6-391edfc6809f)  

2. *Execution Cost Comparison*  
    ![Execution Cost Comparison](https://github.com/user-attachments/assets/aefa5cad-0fa9-43a2-9ce4-9e4bcdc7789e)  

3. *CPU Usage vs zk-SNARK Proof Generation*  
    ![CPU Usage vs zk-SNARK Proof Generation](https://github.com/user-attachments/assets/81f66301-c4d6-40d2-be07-5026289d8979)  

4.  *Gas Cost Comparison in ETH*  
    ![Gas Cost Comparison in ETH](https://github.com/user-attachments/assets/26c4a478-f229-4a3c-838c-90d1e51bc1c9)  

5. *Proof size log wrt transactions*
![Proof size logs](https://github.com/user-attachments/assets/4378908d-f06a-40be-bafe-21e16499ba17)

6. *Verification Time Comparison: zk-SNARK vs zk-STARK*  
    ![Verification Time Comparison: zk-SNARK vs zk-STARK](https://github.com/user-attachments/assets/c6c26e56-d4e5-4f7b-a943-232f2a0d0dbc) 

7.    *EVM Verification Gas Cost Comparison: zk-SNARK vs zk-STARK*  
    ![EVM Verification Gas Cost Comparison: zk-SNARK vs zk-STARK](https://github.com/user-attachments/assets/d0d072b2-a4db-41db-ba00-361ea2a33f3a)  

8. *zk-SNARK vs zk-STARK Network Latency*  
    ![zk-SNARK vs zk-STARK Network Latency](https://github.com/user-attachments/assets/d8a4db74-bc4a-43b8-8683-8dda846345ce)  

9. *zk-SNARK vs zk-STARK Multi-Party Computation*  
    ![zk-SNARK vs zk-STARK Multi-Party Computation](https://github.com/user-attachments/assets/64042bf4-af91-49e1-88dc-9329ed67016f)  

---

## *Tabular Output*
1. *Tabular Output Representation*  
    ![Tabular Output Representation](https://github.com/user-attachments/assets/ea88b433-cccb-4035-8efc-3eca788d34db)
---

