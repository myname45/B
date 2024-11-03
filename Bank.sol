// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Bank {
    // Mapping to track balances of each address
    mapping(address => uint) public balances;

    // Constructor, marked as payable to accept ETH during deployment if needed
    constructor() payable {}

    // Deposit function to add ETH to the sender's balance
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
    }
    
    // Withdraw function to allow users to withdraw specified amount
    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Update balance before sending to prevent reentrancy attacks
        balances[msg.sender] -= _amount;

        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent, "Failed to send ETH");
    }

    // Function to get the contract's total ETH balance
    function getBal() public view returns (uint) {
        return address(this).balance;
    }
}
