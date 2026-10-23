// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/// @title Vault
/// @notice Tiny deposit vault used as a scan target.
contract Vault {
    mapping(address => uint256) public balanceOf;
    address public owner;

    constructor() { owner = msg.sender; }

    function deposit() external payable { balanceOf[msg.sender] += msg.value; }

    function withdraw(uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "insufficient");
        balanceOf[msg.sender] -= amount;
        (bool ok, ) = msg.sender.call{value: amount}("");
        require(ok, "transfer failed");
    }
}
