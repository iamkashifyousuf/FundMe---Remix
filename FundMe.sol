// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
// library {}
// import {PriceConverter} from "./PriceConverter.sol"

contract Fund {

    // using PriceConverter for uint256;
    address public immutable i_owner;
    uint256 public constant MINIMUMS_ETH = 1e18;
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public funderToAmountFunded;


    constructor() {
        i_owner = msg.sender;
    }

    function fundMe() public payable {
        require(msg.value >= MINIMUMS_ETH, "Not get enought Eth");
        funders.push(msg.sender);
        funderToAmountFunded[msg.sender] += msg.value;
    }

    // function getPrice() public view returns(uint256){
    //     AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    //     (,int256 answer,,,) = priceFeed.latestRoundData();
    //     return uint256(answer*1e10);
    // }

    // function getConversion(uint256 ethFunded) public view returns(uint256) {
    //     uint256 ethPrice = getPrice();
    //     uint256 ethAmount = (ethPrice * ethFunded) / 1e18;
    //     return ethAmount;
    // }

    function withdraw() public {
        require(msg.sender == i_owner, "Only Owner do witdrawal");
        (bool callSuccees,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccees,"Call failed");
        for(uint256 index = 0; index < funders.length; index++) {
            address funder = funders[index];
            funderToAmountFunded[funder] = 0; 
        }
        funders = new address[](0);
    }
}


