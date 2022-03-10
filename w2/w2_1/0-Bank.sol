// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Bank{
    address public owner;
    mapping(address => uint256) public balances;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(
            msg.sender == owner,
            "Only owner can call this function");
        _;

    }

    event Received(address, uint);
    receive() external payable {
        balances[msg.sender] += msg.value;
        emit Received(msg.sender, msg.value);
    }

    function withdraw() public payable onlyOwner {
        if (address(this).balance > 0) {
            payable(owner).transfer(address(this).balance);
        }
    }

    function getContractBalance() public view returns(uint256){
        return address(this).balance;
    }
}
