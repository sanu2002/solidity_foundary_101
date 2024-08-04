// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract Thebank{
    mapping (address => uint) public funders;

    function deposit() payable public {
          require(msg.value >= 1 ether, "cannot deposit below 100 wei");
          funders[msg.sender] += msg.value;

    }



    function witdraw() public payable  {

         uint balance=funders[msg.sender];
         require(balance >= 1 ether, "cannot deposit below 100 wei");
         funders[msg.sender]=0; //reasom for reentarcy attack 



         (bool success,)=msg.sender.call{value:balance}("");
         require(success, "transaction failed");


         //update the balance ;


             
    }

     function totalBalance() public view returns (uint) {
        return address(this).balance;
    }


       

}
