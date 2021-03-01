pragma solidity ^0.7.6;

contract test_event {
    
    string information;
    uint balance;
    
    event LogCreate(string information, uint balance);
    event LogCreateIndex(string indexed information, uint indexed balance);
    
    constructor() public {
        information = "default";
        balance = 100;
        emit LogCreate(information, balance);
        emit LogCreateIndex(information, balance);
    }
}