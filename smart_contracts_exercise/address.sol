pragma solidity ^0.7.6;

contract Address{
    
    fallback() external payable{}



    function Balance() public view returns (uint256){
        return address(this).balance;
    }
    
    function Transfer(uint256 amount) public returns(bool){
        msg.sender.transfer(amount * 1 ether);
        return true;
    }
    
    function SendWithoutCheck(uint256 amount) public returns(bool){
        msg.sender.send(amount * 1 ether);
        return true;
    }

    function SendWithCheck(uint256 amount) public returns(bool){
        require(msg.sender.send(amount * 1 ether), "Send failed");
        return true;
    }   
    
    
}