pragma solidity ^0.7.6;

import "./AlexToken.sol";

contract Burnable is AlexToken{
    
    using SafeMath for uint256;
    
    event Burn(address account, uint256 tokens);
    
    function burn(uint256 tokens) public returns(bool){
        // enough tokens
        require(tokens <= _balance[msg.sender]);
        
        _totalSupply = _totalSupply.sub(tokens);
        _balance[msg.sender] = _balance[msg.sender].sub(tokens);
        
        emit Burn(msg.sender, tokens);
        
        emit Transfer(msg.sender, address(0), tokens);
        
        return true;
    }
}