//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

// import {Script} from "forge-std/Script.sol";
// import {FundMe} from "../src/FundMe.sol";

// contract DeployFundMe is Script {
//     function run() external {
//         vm.startBroadcast();
//         new FundMe();
//         vm.stopBroadcast();
//     }
//     //- let deploy contract like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge script script/DeployFundMe.s.sol
//     //* its generate out folder which contain compiled contract
//     //* its ask this
//     //If you wish to simulate on-chain transactions pass a RPC URL.

//     //- let test getVersion() function to see if its return version 4 inside FundMeTest.t.sol
// }

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

//refactor of DeployFundMe contract with constructor parameter like this
contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        //- any transaction before startBroadcast -> is not a real tx and no gas will be charge
        //for it, it will simulate it in a simulate or fake environment.
        //- any transaction after startBroadcast -> is real tx and it cost gas.

        HelperConfig helperConfig = new HelperConfig();
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig(); //its return either local Anvil chain priceFeed or live Sepolia chain priceFeed

        vm.startBroadcast();
        // FundMe fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        FundMe fundMe = new FundMe(ethUsdPriceFeed); //use ethUsdPriceFeed in place of sepolia chain contract address inorder to use both local Anvil chain and established Sepolia chain priceFeed
        vm.stopBroadcast();
        return fundMe;
    }
}
//- let run test command like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ source .env
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test --fork-url $SEPOLIA_RPC_URL
//its run the successful with all the test function passing
//docs.chain.link/data-feeds/price-feeds/addresses
