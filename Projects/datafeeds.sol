// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;
// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
// solhint-disable-next-line interface-starts-with-i
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}



contract price{


        function get_version() public view returns(uint) {

                return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();

        }

        function get_description() public  view returns(string memory){
              return  AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).description();
        }


        function get_price() public  view returns(uint){
               (
                ,
                int256 answer,
                ,
                ,

               )=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).latestRoundData();

               return uint(answer)*1e18;
        }


        // function  get_price_getRoundData() public  view returns(uint){
        //      (
        //         ,
        //         int256 answer,
        //         ,
        //         ,

        //        )=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).getRoundData();

        //        return uint(answer);

        // }

        // so in oracles round_id is used wen we require historical data by specifying the id of that updated round 




}



// we are getting 3055,43867557(8 decimal point so according  to the latest price of eth)

