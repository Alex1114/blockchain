pragma solidity ^0.7.6;

import "./IERC20.sol";
import "./SafeMath.sol";

contract AlexToken is IERC20 {

    using SafeMath for uint256;
    
    string public constant name = "Alex Token";
    uint8 public constant decimals = 18;
    string public constant symbol = "ANT";
    
    
    uint256 public _totalSupply;
    mapping(address => uint256) _balance;
    mapping(address => mapping(address => uint256)) _approve;
    
    function totalSupply() external view override returns (uint256){
        return _totalSupply;
    }
    
    // address => uint256
    function balanceOf(address tokenOwner) external view override returns (uint256){
        return _balance[tokenOwner];
    }
    
    // msg.sender --- tokens ---> to
    function transfer(address to, uint256 tokens) external override returns (bool){
        return _transfer(msg.sender, to, tokens);
    }


    function allowance(address tokenOwner, address spender) external view override returns (uint256){
        return _approve[tokenOwner][spender];
    }
    
    // tokenOwner -> spender -> tokens
    // address => address => uint256
    function approve(address spender, uint256 tokens) external override returns (bool){
        _approve[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        
        return true;
    }

    function transferFrom(address from, address to, uint256 tokens) external override returns (bool){
        _approve[from][msg.sender] = _approve[from][msg.sender].sub(tokens);
         
         return _transfer(from, to, tokens);
    }
    
    function _transfer(address from, address to, uint256 tokens) internal returns (bool){
        _balance[from] = _balance[from].sub(tokens);
        _balance[to] = _balance[to].add(tokens);
        emit Transfer(from, to, tokens); 
        
        return true;
    }
}
