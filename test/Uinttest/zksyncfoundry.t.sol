// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ZkSyncChainChecker} from "lib/foundry-devops/src/ZkSyncChainChecker.sol";
import {Test, console} from 'lib/forge-std/src/Test.sol';
import {FundMe} from 'src/Fundme.sol';
import {Script} from "lib/forge-std/src/Script.sol";
import {Fundmedeployscript} from 'script/Funddeploy.s.sol';

contract Zksyncfoundry is ZkSyncChainChecker {
    FundMe public fundme;

    function setUp() public {
        Fundmedeployscript deployfundme = new Fundmedeployscript();
        fundme = deployfundme.run();
        console.log("FundMe contract deployed at:", address(fundme));
    }

    // This function will skip if you are on zkSync chain
    modifier skipZkSync1() {
        if (block.chainid == 280) {  // zkSync chain ID
            return;
        }
        _;
    }

    // This function will only execute on zkSync
    modifier onlyZkSync2() {
        require(block.chainid == 280, "This function can only be run on zkSync");
        _;
    }

    // Modifier for vanilla Foundry
    modifier onlyVanilla() {
        require(
            block.chainid != 300 && block.chainid != 324 && block.chainid != 260,
            "This function is not allowed on ZkSync chains"
        );
        _;
    }

    function testdotStuff() public skipZkSync1 {}

    // This function will only execute on ZkSync
    function testdotStuff1() public onlyZkSync2 {}

    // Function restricted to vanilla Foundry
    function testonlyVanillaTest() public onlyVanilla {
        // Logic for pure Foundry
    }
}



// you can bring all function from import {ZkSyncChainChecker} from "lib/foundry-devops/src/ZkSyncChainChecker.sol";
// no need to write modifiers 