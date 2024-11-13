// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from 'lib/forge-std/src/Test.sol';
import {FundMe} from '../src/Fundme.sol';

import {Fundmedeployscript} from 'script/Funddeploy.s.sol';

contract Mytestfile is Test {
    FundMe fundme;

    function setUp() public {
        // fundme = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        Fundmedeployscript deployfundme=new Fundmedeployscript();
        fundme=deployfundme.run();


    }
    
    function testMinimumuDollarisfive() public view {
        // This function should not be marked `view` since it calls assertEq
        assertEq(fundme.MINIMUM_USD(), 5e18, "Minimum USD should be 5e18");
    }




    //we will check wheather msg.sender==fundme.i_owner

    // function testIsowner() public view {
 
    //     console.log(address(this));
    //     console.log(fundme.i_owner());
    //     // assertEq(msg.sender,fundme.i_owner(),"both is not same ");
    //     assertEq(fundme.i_owner(),address(this));




    // }


    function testFundgetVersion() public view {
        uint256 version= fundme.getVersion();
        assertEq(version,4);


    }



}



//there are 4 different types of test 

// 1:- uint test -> testing a specific part  of your code 
// 2:- intergration test -> Testing how our code works testing another part of the code 
// 3:- fork test :- Testing  our code on simulated real env 
// 4:-stagging test : - Testing  our code on real env which is not prod 