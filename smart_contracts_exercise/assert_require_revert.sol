pragma solidity ^0.7.6;

contract test_valid {
    
    bool isValid;
    
    constructor() public {
        isValid = true;
    }
    
    function f1() public returns (int){
        isValid = false;
        assert(false);
        return 0;
    }
    
    function f2() public returns (int){
        isValid = false;
        require(false, "REQUIRE");
        return 0;
    }
    
    function f3() public returns (int){
        isValid = false;
        revert("REVERT");
        return 0;
    }
    
}