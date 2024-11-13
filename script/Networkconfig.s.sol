// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "lib/forge-std/src/Script.sol";
import {MockV3Aggregator} from 'test/Mock/Mocktest_Agreegator.sol';

//This will the mock  neywrok configuration for the tes

contract Networkconfiguration is Script {


    //Here i will add 3 function one is for eth sepoliaconfig and second one is eth mainnet config and third one is  anvil local env 
    // and also we will take care about current network configuration 

    Networkconfig public current_network; //here we will save the current network configuration
    MockV3Aggregator mockPriceFeed;

    uint8 public constant  decimals=8;
    int256 public constant initialAnswer=2000e8;
    

    struct Networkconfig{
        address pricefeed;
    }

    constructor(){
        if(block.chainid==1115511){
             current_network=Sepolia_Networkconfiguration();
        }
        else if(block.chainid==1){
            current_network=Mainnet_Networkconfiguration();

        }
        else{

            current_network =anvil_Networkconfiguration();

        }
   
    }


    function  Sepolia_Networkconfiguration() public pure returns(Networkconfig memory) {
        Networkconfig memory  sepoliaConfig=Networkconfig({
            pricefeed:0x694AA1769357215DE4FAC081bf1f309aDC325306 
        });
        return sepoliaConfig;


    }
    
    function  Mainnet_Networkconfiguration() public pure returns(Networkconfig memory){
        Networkconfig memory  sepoliaConfig=Networkconfig({
            pricefeed:0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419 
        });
        return sepoliaConfig;


    }
    

    // we can't use pure if we are using vm here 
    function  anvil_Networkconfiguration() public   returns (Networkconfig memory){


        if(current_network.pricefeed!=address(0)){
            return current_network;
        }

        //set your own price feed 

        
        vm.startBroadcast();

         mockPriceFeed = new MockV3Aggregator(decimals, initialAnswer);
        vm.stopBroadcast();

     


        Networkconfig memory anvilconfig=Networkconfig({pricefeed:address(mockPriceFeed)});

        return anvilconfig;

    




    }



}