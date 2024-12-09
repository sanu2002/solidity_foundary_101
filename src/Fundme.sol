// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Note: The AggregatorV3Interface might be at a different location than what was in the video!
import {AggregatorV3Interface} from '@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol';
import {PriceConverter} from "src/Priceconverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;


    // use private  as much as possible avoid to use public because private is more gas efficient 
    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;

    // Could we make this constant?  /* hint: no! We should make it immutable! */
    address public /* immutable */ i_owner;
    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;
    AggregatorV3Interface private s_pricefeed;

    constructor(address  pricefeed) {
        i_owner = msg.sender;
        s_pricefeed=AggregatorV3Interface(pricefeed);

    }

    function fund() public payable {
        require(msg.value.getConversionRate(s_pricefeed) >= MINIMUM_USD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
        //  AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        // return priceFeed.version();
        return s_pricefeed.version();
            
       
    }

    modifier onlyOwner() {
        // require(msg.sender == owner);
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }

    function withdraw_cheap() public {
        uint256  length=funders.length;

         for(uint256 funderIndex=0; funderIndex<length;funderIndex++){ //but here each time funders.index  fetcjhing value from contract instead of iterating over agaun and again better to store in a variabble and used it
             address funder=funders[funderIndex];
             addressToAmountFunded[funder] = 0;
                
         }
         funders =new  address[](0);
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");


    }

    function withdraw() public  {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];  
            addressToAmountFunded[funder] = 0;//state update otherwise we will face the reentarcy-attack 
        }
        funders = new address[](0);
        // // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
    // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \
    //         yes  no
    //         /     \
    //    receive()?  fallback()    
    //     /   \
    //   yes   no
    //  /        \
    //receive()  fallback()

    // So basically fallback and receive are very useful :- Because receive will allow the the function to be receive ether as well as 
    // the data inside it  and fall back is used wen a used request for a uknow function request to be received 

    function get_owner() public view returns(address) {
         return address(i_owner);

    }
    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }



    // wenever i will receive some eth then the funders should be updated 



    




}

// Concepts we didn't cover yet (will cover in later sections)
// 1. Enum
// 2. Events
// 3. Try / Catch
// 4. Function Selector
// 5. abi.encode / decode
// 6. Hash with keccak256
// 7. Yul / Assembly





// Note:- The thing that we should notice / 
// If your intebd is to make track of the owner funds then you can write single withdraw function but why we use loop here 
// -> Just because wenever you are trying to a conytract for public purposes there is no single address that contribute to the network 

// there may be a lot of funders available so to keep track of all the address we are using for loop instead of using the notmal one 

// And this for loop ensure that at each iteration every address fund should be updated to 0 