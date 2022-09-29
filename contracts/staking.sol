// SPDX-License-Identifier:MIT
pragma solidity ^0.8.4;

import "../contracts/IERC721.sol";
import "../contracts/IERC20.sol";



contract Staking {

    IERC721 boredape = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);
    IERC20 myToken;

    struct StakeData {
        uint256 stakedAmount;
        uint256 theTimeStaked;
    }

    constructor(address _tokenaadr) {
        myToken = IERC20(_tokenaadr);
    }

    mapping (address => StakeData) stakes;


    function stake(uint256 amountToStake) public payable {
        StakeData storage s = stakes[msg.sender];
        address contractAddr = address(this);
        require(amountToStake > 0, "You can't stake 0 amount");
        require(boredape.balanceOf(msg.sender) > 1, "You are not eligible to stake");
        require(myToken.allowance(msg.sender, contractAddr) >= amountToStake, "You need to approve for the staked amount");
        s.theTimeStaked = block.timestamp;
        myToken.transferFrom(msg.sender, contractAddr, amountToStake);
        s.stakedAmount = amountToStake;
    }

    function withdraw(uint256 _amount) public {
        StakeData storage s = stakes[msg.sender];
        require(s.stakedAmount > _amount, "Insufficient Balance");
        s.stakedAmount -= _amount;
        uint256 total = block.timestamp - s.theTimeStaked;
        uint256 amountToWithdrawn = (_amount / 25920000) * total;
        myToken.transfer(msg.sender, amountToWithdrawn);
    }
}