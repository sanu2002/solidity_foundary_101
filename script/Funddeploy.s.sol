// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "lib/forge-std/src/Script.sol";

import {FundMe} from "../src/Fundme.sol";

import {Networkconfiguration} from "script/Networkconfig.s.sol"; //This is the contarct where i cab  have the all functionalty about the network configuration


contract Fundmedeployscript is Script {


    function run() external returns (FundMe) {

        //we will make  it gas efficient  so we will set the  contract before the actual script execution 
        Networkconfiguration helperconfig = new Networkconfiguration();
        address ethUsdpricefeed=helperconfig.current_network();

        vm.startBroadcast();
        FundMe fundme  =new FundMe(ethUsdpricefeed);
        vm.stopBroadcast();
        return fundme;




    }





}