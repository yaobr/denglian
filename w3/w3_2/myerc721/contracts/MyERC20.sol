//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyERC20 is ERC20 {
    constructor() ERC20("MyERC20", "MyERC20") {
    }

    function mintToken(uint256 amount) public {
         _mint(msg.sender, amount);
    }
}