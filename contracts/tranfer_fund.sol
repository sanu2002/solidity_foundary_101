// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract MoneyContract {
    address[] public funders;  // List of funders' addresses
    mapping(address => uint) public fundersMap;  // Track how much each address has contributed

    // Function to add money to the contract
    function addMoney() public payable {
        require(msg.value > 0, "Must send some Ether");
        if (fundersMap[msg.sender] == 0) {
            funders.push(msg.sender);
        }
        fundersMap[msg.sender] += msg.value;
    }

    // Function for an individual user to withdraw their funds
    function withdraw() public {
        uint amount = fundersMap[msg.sender];
        require(amount > 0, "No funds to withdraw");

        // Reset the user's balance to 0 before transferring to prevent re-entrancy attacks
        fundersMap[msg.sender] = 0;

        // Transfer the amount back to the sender
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed.");
    }

    // Function to withdraw all funds (not recommended for contracts with many funders)
    function withdrawAll() public {
        for (uint i = 0; i < funders.length; i++) {
            address funder = funders[i];
            uint amount = fundersMap[funder];
            if (amount > 0) {
                // Reset the user's balance to 0 before transferring to prevent re-entrancy attacks
                fundersMap[funder] = 0;

                // Transfer the amount back to the funder
                (bool success, ) = payable(funder).call{value: amount}("");
                require(success, "Transfer failed.");
            }
        }
    }

    // Function to get the list of all funders
    function getFunders() public view returns (address[] memory) {
        return funders;
    }
}
