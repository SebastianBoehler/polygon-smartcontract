// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Lock {
    uint public unlockTime;
    address payable public owner;
    address[] public deposits;

    event Withdrawal(uint amount, uint when);
    event Deposit(uint amount, uint when, address from, string message);

    constructor(uint _unlockTime) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        unlockTime = _unlockTime;
        owner = payable(msg.sender);
        deposits.push(msg.sender);
    }

    function withdraw() public {
        // Uncomment this line, and the import of "hardhat/console.sol", to print a log in your terminal
        // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner");

        emit Withdrawal(address(this).balance, block.timestamp);

        owner.transfer(address(this).balance);
    }

    function deposit(string calldata message) public payable {
        require(msg.sender == owner, "You aren't the owner");
        require(msg.value > 0, "You need to send some tokens");
        require(msg.value < 50000000000000000, "You can't send more than 0.005 token");

        emit Deposit(msg.value, block.timestamp, msg.sender, message);
        deposits.push(msg.sender);
    }

    function getDeposits() public view returns (address[] memory) {
        return deposits;
    }
}
