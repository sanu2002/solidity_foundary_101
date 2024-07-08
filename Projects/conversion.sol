// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract MinimumUSD {
    AggregatorV3Interface internal priceFeed;


    uint minimumusd=5;

    // msg.sender   Here i will make a array which contain a list of address which contain the address of the funded 
    // account also we will map address with amount of funding 

    address[] public  funder;
    mapping (address funder => uint amount_funded ) public avail;





    function minmum_threshold() public payable{
           require(conversion(msg.value)>minimumusd,"you dont have sufficient value");
           funder.push(address(msg.sender));
           avail[msg.sender ]= avail[msg.sender] + msg.value;

    }




    constructor() {
        priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function get_price() public view returns (uint256) {
        (
            ,
            int256 answer,
            ,
            ,
        ) = priceFeed.latestRoundData();

        return uint256(answer * 1e10); // convert price to 18 decimal places
    }

    function conversion(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = get_price();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}
