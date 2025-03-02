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

    // **Get the status of a request (only accessible by the requester)**
    function getRequestStatus() public view returns (string memory, string memory) {
        RoleRequest memory request = roleRequests[msg.sender];
        string memory statusString;

        if (request.status == RequestStatus.None) {
            statusString = "None";
        } else if (request.status == RequestStatus.Requested) {
            statusString = "Pending";
        } else if (request.status == RequestStatus.Approved) {
            statusString = "Approved";
        } else if (request.status == RequestStatus.Rejected) {
            statusString = "Rejected";
        }

        return (statusString, request.registrationId);
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
