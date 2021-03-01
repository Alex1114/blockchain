pragma solidity ^0.7.6;

contract Ownable{
    address private owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(isOwner());
        _;
    }
    
    function isOwner() public view returns(bool){
        return owner == msg.sender;
    }
    
    
}

contract Main is Ownable{
    string public name = "";
    function modifyName(string memory _name) public onlyOwner{
        name = _name;
    }
}