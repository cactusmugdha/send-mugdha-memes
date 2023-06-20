// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// deployed to goerli at 0x20f740E1CF7b03D89DEAEB1F2884278D70E69B5E 

import "hardhat/console.sol";

contract BuyMeACoffee{

    event NewMemo(
        address indexed from,
        uint256 timestap,
        string name,
        string message
    );
    
    struct Memo {
        address from;
        uint256 timestap;
        string name;
        string message;
    }

    // list of all memos recieved
    Memo[] memos;

    // address of the contract deployer
    address payable owner;

    constructor(){
        owner = payable(msg.sender);
    }

    // buying a coffee for the contract. param name- name of coffee buyer
    // param message- a msg from the buyer 

    function buyCoffee (string memory _name, string memory _message)public  payable{
      require(msg.value > 0, "can't buy coffee with zero Eth");

      memos.push(Memo(
        msg.sender,
        block.timestamp,
        _name,
        _message
      ));

      emit NewMemo(
        msg.sender,
        block.timestamp,
        _name,
        _message
      );
    }
    
    // all the money is strored in the contract itslef. 
    //allows to send the stores eth to the owner
    function withdrawTips()public{
        
        require(owner.send(address(this).balance)); // sends the money to the owner.

    }

    // retrieves all the memos stored on the blockchain and displays on screen
    function getMemos() public view returns (Memo[]memory){
       return memos;
    }
} 
