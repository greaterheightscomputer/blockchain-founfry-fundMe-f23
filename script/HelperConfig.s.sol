//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// import {Script} from "forge-std/Script.sol";

// contract HelperConfig is Script {
//     //if we are on a local Anvil chain, deploy mocks
//     //Otherwise, grab the existing address from the live or established network
//     NetworkConfig public activeNetworkConfig; //activeNetworkConfig state variable of NetworkConfig data type

//     struct NetworkConfig {
//         address priceFeed; //ETH/USD price feed address
//     }

//     constructor() {
//         if (block.chainid == 11155111) {
//             activeNetworkConfig = getSepoliaEthConfig();
//         } else if (block.chainid == 1) {
//             activeNetworkConfig = getMainnetEthConfig();
//         } else {
//             activeNetworkConfig = getAnvilEthConfig();
//         }
//     }

//     function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
//         //return price feed address from sepolia chain
//         NetworkConfig memory sepoliaConfig = NetworkConfig({
//             priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
//         });
//         return sepoliaConfig;
//     }

//     function getAnvilEthConfig() public pure returns (NetworkConfig memory) {
//         //return price feed address from Anvil chain
//     }
// }

//=========================
//Add Mainnet PriceFeed contract address
//- go to https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum, scroll down
//you will see different chains, click on Ethereum, scroll down to copy ETH/USD priceFeed
//contract address
//- use the Mainnet priceFeed contract address inside getMainnetEthConfig() function
//- back to Alchemy node provider to copy Mainnet RPC Url for deploying contract onto Mainnet chain
//* while in Alchemy create App, Forking Chain and click on VIEW KWY tab to copy HTTPS,
//create environment variable called MAINNET_RPC_URL to store the rpc_url copy from Alchemy node provider

// contract HelperConfig is Script {
//     NetworkConfig public activeNetworkConfig;

//     struct NetworkConfig {
//         address priceFeed;
//     }

//     constructor() {
//         if (block.chainid == 11155111) {
//             activeNetworkConfig = getSepoliaEthConfig();
//         } else if (block.chainid == 1) {
//             activeNetworkConfig = getMainnetEthConfig();
//         } else {
//             activeNetworkConfig = getAnvilEthConfig();
//         }
//     }

//     function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
//         //return price feed address from sepolia chain
//         NetworkConfig memory sepoliaConfig = NetworkConfig({
//             priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
//         });
//         return sepoliaConfig;
//     }

//     function getMainnetEthConfig() public pure returns (NetworkConfig memory) {
//         //return price feed address from mainnet chain
//         NetworkConfig memory ethConfig = NetworkConfig({
//             priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
//         });
//         return ethConfig;
//     }

//     function getAnvilEthConfig() public pure returns (NetworkConfig memory) {
//         //return price feed address from Anvil chain
//     }
// }
//- let make .env environment variables available on the terminal like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ source .env
//- adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ echo $MAINNET_RPC_URL
//its return -> https://eth-mainnet.g.alchemy.com/v2/EtADcPh3V8CsYQ2YbqwsafKPQztFhWWf
//- let run test on forked mainnet like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test --fork-url $MAINNET_RPC_URL
//its run test successfully

//====================
import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

//Refactoring III: Mocks PriceFeed for Anvil chain
//1. Deploy the mocks or fake contract address
//2. Return the mock address
contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    //Magic Numbers
    uint8 public constant DECIMALS = 8; //decimal of ETH/USD is 8
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        address priceFeed;
    }

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 1) {
            activeNetworkConfig = getMainnetEthConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        //return price feed address from sepolia chain
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaConfig;
    }

    function getMainnetEthConfig() public pure returns (NetworkConfig memory) {
        //return price feed address from mainnet chain
        NetworkConfig memory ethConfig = NetworkConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
        return ethConfig;
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        //if MockV3Aggregator contract address as already created, don't create new address use the existing address
        if (activeNetworkConfig.priceFeed != address(0)) {
            return activeNetworkConfig;
        }
        vm.startBroadcast(); //since we use vm we can't have pure keyword as part of function declaration
        //let deploy our own priceFeed, inorder to deploy priceFeed we need a priceFeed contract
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(
            DECIMALS,
            INITIAL_PRICE
        );
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });
        return anvilConfig;
    }

    //- let create mocks folder inside test folder
    //- create MockV3Aggregator.sol file inside test/mocks folder
    //- go to https://github.com/Cyfrin/foundry-fund-me-f23/blob/main/test/mock/MockV3Aggregator.sol
    //to copy and past MockV3Aggregator onto test/mocks/MockV3Aggregator.sol file
    //- the MockV3Aggregator contract contain all the priceFeed information.
    //- let import MockV3Aggregator contract onto HelperConfig contract.
}

//- let run test on different chains like this
//Forked Sepolia chain
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ source .env
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test --fork-url $SEPOLIA_RPC_URL
//its run test successfully on forked Sepolia chain
//- go to Alchemy node provider to view the request made to Sepolia chain

//Forked Mainnet chain
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test --fork-url $MAINNET_RPC_URL
//its run test successfully on forked Mainnet chain
//- go to Alchemy node provider to view the request made to Mainnet chain

//Anvil chain
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test
//* deploy test onto Anvil chain passed becos of the Mock PriceFeed created.

//- let view our coverage on terminal like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge coverage
//its show that we have not test much, so let start write more test function
//- back to FundMeTest.t.sol to write more test function
