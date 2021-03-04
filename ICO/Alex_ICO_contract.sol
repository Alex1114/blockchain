pragma solidity ^0.4.25;

import "./Alex_ICO_token.sol";

contract Alex_ICO_contract {
    
    using SafeMath for uint;

    enum ICOState {INITIAL, START, END}
    
    address private owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public mTokenAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    uint256 mCaps = 0;
    uint256 mCurrentFund = 0;
    ICOState mICOState = ICOState.INITIAL;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    modifier beforICOStart() {
        require(mICOState == ICOState.INITIAL);
        _;
    }
    modifier whenICOStart() {
        require(mICOState == ICOState.START);
        _;
    }
    modifier whenICOEnd() {
        require(mICOState == ICOState.END);
        _;
    }

    constructor() public {
        owner = msg.sender;
        string memory name = "AlexToken";
        uint8 decimals = 18;
        string memory symbol = "ANT";
        uint256 totalSupply = 1000*(10**18);
        mCaps = totalSupply;
        mTokenAddress = new Alex_ICO_token(name, decimals, symbol, totalSupply);
        mICOState = ICOState.INITIAL;
    }

    function startICO() public onlyOwner beforICOStart {
        mICOState = ICOState.START;
    }
    function endICO() public onlyOwner whenICOStart {
        mICOState = ICOState.END;
        owner.transfer(address(this).balance);
        IERC20(mTokenAddress).transfer(owner, mCaps.sub(mCurrentFund));
    }

    function() public payable whenICOStart {
        require(msg.value > 0);
        require(mCaps >= mCurrentFund + msg.value);
        mCurrentFund = mCurrentFund.add(msg.value);
        IERC20(mTokenAddress).transfer(msg.sender, msg.value);
    }
}