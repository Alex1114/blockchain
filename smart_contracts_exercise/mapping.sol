pragma solidity ^0.7.6;

contract Donation{
    mapping(address => uint) public ledger;
    mapping(address => bool) public donors;
    address[] public donors_list;
    
    function is_donor(address addr) internal view returns(bool){
        return donors[addr];
    }
    
    function donate() public payable{
        if(msg.value >= 1 ether){
            if(!is_donor(msg.sender)){
                donors[msg.sender] = true;
                donors_list.push(msg.sender);
            }
            
            ledger[msg.sender] += msg.value;
        } 
        else{
            revert(" < 1 ether");
        }
    }
    
}