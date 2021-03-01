pragma solidity ^0.7.6;

contract Fallback{
    event LogFallback(string message);
    event LogBalance(uint balance);
    
    fallback() external payable{
        emit LogFallback("Fallback");
        emit LogBalance(address(this).balance);
    }
}