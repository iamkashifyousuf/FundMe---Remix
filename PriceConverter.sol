// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 ethPrice, , , ) = priceFeed.latestRoundData();
        return uint256(ethPrice * 1e10);
    }

    function getConversion(uint256 ethFunded) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountUSD = (ethPrice * ethFunded) / 1e18;
        return ethAmountUSD;
    }
}
