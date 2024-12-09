// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import {FundFundMe, WithdrawFundMe} from "script/Integrationtest.s.sol";
import {Fundmedeployscript} from "script/Funddeploy.s.sol";
import {FundMe} from "src/Fundme.sol";
import {Test, console} from "lib/forge-std/src/Test.sol";

contract InteractionTest is Test {
    FundMe public fundme;
    Fundmedeployscript deployFundMe;

    uint256 public constant SEND_VALUE = 0.1 ether; // Adjusted for practical testing
    uint256 public constant STARTING_USER_BALANCE = 10 ether; // Lowered for practicality

    address alice = makeAddr("alice");

    function setUp() public {
        deployFundMe = new Fundmedeployscript();
        fundme = deployFundMe.run();
        vm.deal(alice, STARTING_USER_BALANCE); // Sets up Alice with a starting balance
    }

    function testUserCanDeployAndWithdraw() public {
        uint256 preUserBalance = alice.balance;
        console.log("Pre user balance:", preUserBalance);
        uint256 preContractBalance = address(fundme).balance;
        console.log("Pre contract balance:", preContractBalance);

        // Simulate funding by Alice
        vm.prank(alice);
        fundme.fund{value: SEND_VALUE}();

        console.log("Contract balance after funding:", address(fundme).balance);

        // Simulate withdrawal
        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundme)); // Corrected to pass FundMe contract address

        uint256 afterUserBalance = alice.balance;
        uint256 afterContractBalance = address(fundme).balance;

        console.log("Post user balance:", afterUserBalance);
        console.log("Post contract balance:", afterContractBalance);

        // Assertions
        assertEq(afterContractBalance, 0, "Contract balance should be zero after withdrawal");
        assertEq(afterUserBalance + SEND_VALUE, preUserBalance, "Alice's balance should be refunded");
    }
}
