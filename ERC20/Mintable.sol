pragma solidity ^0.7.6;

import "./AlexToken.sol";

contract Mintable is AlexToken{
    
    using SafeMath for uint256;
    
    address private owner;
    mapping(address => bool) minters;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    modifier onlyMinter(){
        require(minters[msg.sender]);
        _;
    }
    
    function addMinter(address addr) public onlyMinter returns(bool){
        minters[addr] = true;
        return true;
    }
    
    function mint(address to, uint256 tokens) public onlyMinter returns(bool){
        _totalSupply = _totalSupply.add(tokens);
        _balance[to] = _balance[to].add(tokens);
        
        emit Transfer(address(0), to, tokens);
        
        return true;
    }
}