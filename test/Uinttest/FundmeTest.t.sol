// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from 'lib/forge-std/src/Test.sol';
import {FundMe} from 'src/Fundme.sol';
import {Script} from "lib/forge-std/src/Script.sol";
import {Fundmedeployscript} from 'script/Funddeploy.s.sol';
contract Mytestfile is Test, Script {
    FundMe fundme;

    function setUp() public {
        Fundmedeployscript deployfundme = new Fundmedeployscript();
        fundme = deployfundme.run();
    }
    
    function testMinimumuDollarisfive() public view {
        assertEq(fundme.MINIMUM_USD(), 5e18, "Minimum USD should be 5e18");
    }

    function testFundgetVersion() public view {
        uint256 version = fundme.getVersion();
        assertEq(version, 4);
    }

    function tesFailtonlyowner() public {
        vm.expectRevert(); 
        fundme.fund{value: 1 ether}();  // Trying to fund from a non-owner address, should fail
    }

    function testmultiplewithdraw() public  {
        // vm.prank(address(0x123));  // Set the sender to 0x123 for the next transaction
        uint256 gasstart=gasleft();
        vm.startPrank(address(0x123));
        vm.deal(address(0x123),3 ether); // Set the sender to 0x123 for the next transaction);
        fundme.fund{value: 1 ether}();  // Fund with 1 ether

        console.log(address(fundme).balance, "fund before withdraw");
        

        fundme.withdraw();  // Withdraw 1 ether

        console.log(address(fundme).balance, "fund after withdraw");
        vm.stopPrank();

        uint256 gasend=gasleft();

        uint256 used=gasend-gasstart * tx.gasprice ;
        console.log(used,"total used before withdraw");


    

    }

    function testmultiplewithdrawcheap() public {
        uint256 gasstart=gasleft();
        vm.startPrank(address(0x123));
        vm.deal(address(0x123),3 ether); // Set the sender to 0x123 for the next transaction);
        fundme.fund{value: 1 ether}();  // Fund with 1 ether

        console.log(address(fundme).balance, "fund before withdraw");
        

        fundme.withdraw();  // Withdraw 1 ether

        console.log(address(fundme).balance, "fund after withdraw");
        vm.stopPrank();

        uint256 gasend=gasleft();

        uint256 used=gasend-gasstart * tx.gasprice ;
        console.log(used,"total used before withdraw");



    }






}
