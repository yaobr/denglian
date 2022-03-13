//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "hardhat/console.sol";

contract Vault {
    mapping(address => uint) public deposited;
    address public immutable token;

    constructor(address _token) {
        token = _token;
    }

    function deposit(uint256 amount) public {
        console.log("[deposit]from: %s, to: %s, amount: %s", msg.sender, address(this), amount);
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "Transfer from error");
        deposited[msg.sender] += amount;
    }

    function withdraw() public {
        console.log("[withdraw]from: %s, to: %s, amount: %s", msg.sender, address(this), deposited[msg.sender]);
        require(IERC20(token).approve(msg.sender, deposited[msg.sender]), "Approve error");
        require(IERC20(token).transferFrom(address(this), msg.sender, deposited[msg.sender]), "Transfer from error");
        deposited[msg.sender] = 0;
    }

    function getDeposit(address account) public view returns (uint256){
        console.log("[getDeposit]account: %s, deposited: %s", account, deposited[account]);

        return deposited[account];
    }
}

