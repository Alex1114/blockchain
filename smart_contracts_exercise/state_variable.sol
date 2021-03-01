pragma solidity ^0.7.6;

contract StateVariables {
    
    string name;
    address owner;
    uint rename_counter;
    
    constructor() public {
        name = "unknown";
        owner = msg.sender;
        rename_counter = 0;
    }
    
    modifier checkOwner(address _address){
        require(_address == owner, "Address is not the owner.");
        rename_counter += 1;
        _;
    }
    
    function setName(string memory _name) public checkOwner(msg.sender) returns (string memory){
        // if (msg.sender == owner){
        //     name = _name;
        // } else {
        //      ("Permission denied.");
        // }
        return name;
    }
    
    function getName() public view returns (string memory){
        return name;
    }
    
}