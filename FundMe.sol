//SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

error Notowner();

contract FundMe {

    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 5 * 1e18;
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public funderToAmountFunded;
    address public immutable i_owner;
    constructor() {
        i_owner = msg.sender;
    }

    function fundMe() public payable {
        require(msg.value.getConversion() >= MINIMUM_USD, "Don't Get enough Ethers i.e. > 5 etheeeeeeeers");
        funders.push(msg.sender);
        funderToAmountFunded[msg.sender] = funderToAmountFunded[msg.sender] + msg.value;
    }

    function withdraw() public onlyOwners {
    for(uint256 funderindex = 0; funderindex < funders.length; funderindex++) {
        address funder = funders[funderindex];
        funderToAmountFunded[funder] = 0;
    }
    funders = new address[](0);
    // //transfer
    // payable(msg.sender).transfer(address(this).balance);                                  // If txn failed it throgh an error. Auto reverted.
    // //send
    // bool sendSuccess = payable(msg.sender).send(address(this).balance);                   // It return bool that explain txn stuatus. Noauto reverted
    // require(sendSuccess, "Send Failed");
    //call
    (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");    // 
    require(callSuccess, "Call Failed");
    }

    modifier onlyOwners() {
        // require(msg.sender == i_owner, Notowner());
        if(msg.sender == i_owner) { revert Notowner();}
        _;
    }

    receive() external payable {
        fundMe();
    }

    fallback() external payable {
        fundMe();
     }
}


