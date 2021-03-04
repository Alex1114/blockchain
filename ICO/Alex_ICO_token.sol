pragma solidity ^0.4.25;

import "./SafeMath.sol";
import "./IERC20.sol";

contract Alex_ICO_token is IERC20 {

    using SafeMath for uint256;

    string mName = "AlexToken";
    uint8 mDecimals = 18;
    string mSymbol = "ANT";
    uint256 mTotalSupply = 0;
    mapping(address => uint256) mBalances;
    mapping(address => mapping(address => uint256)) mApprove;
    
    constructor(
        string memory pName,
        uint8 pDecimals,
        string  memory pSymbol,
        uint256 pTotalSupply)
        public
    {
        mName = pName;
        mDecimals = pDecimals;
        mSymbol = pSymbol;
        mTotalSupply = pTotalSupply;
        mBalances[msg.sender] = mBalances[msg.sender].add(mTotalSupply);
        emit Transfer(address(this), msg.sender, mTotalSupply);
    }

    
    function totalSupply() external view returns (uint256) {
        return mTotalSupply;
    }
    
    function balanceOf(address tokenOwner) external view returns (uint256 balance) {
        return mBalances[tokenOwner];
    }
    
    function transfer(address to, uint256 tokens) external returns (bool success) {
        return _transfer(msg.sender, to, tokens);
    }
    
    function allowance(address tokenOwner, address spender) external view returns (uint256 remaining) {
        return mApprove[tokenOwner][spender];
    }
  
    function approve(address spender, uint256 tokens) external returns (bool success) {
        mApprove[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint256 tokens) external returns (bool success) {
        mApprove[from][msg.sender] = mApprove[from][msg.sender].sub(tokens);
        
        return _transfer(from, to, tokens);
    }
    
    function _transfer(address from, address to, uint256 tokens) internal returns (bool success) {
        mBalances[from] = mBalances[from].sub(tokens);
        mBalances[to] = mBalances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }

    
    //=== ERC20 Detail information ============================================
    function name() public returns (string) {
        return mName;
    }
    
    function decimals() public returns (uint8) {
        return mDecimals;
    }
    
    function symbol() public returns (string) {
        return mSymbol;
    }
    //=========================================================================
}