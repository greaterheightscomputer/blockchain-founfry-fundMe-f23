//SPDX-License-Identifier:MIT

//Fund script to interact with fund() function
//Withdraw script to interact with withdraw() function

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol"; //to keep trace of the most recently deploy contract address
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address mostRecentlyDeployed) public {
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        console.log("Funded FundMe with %s ", SEND_VALUE);
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        ); //its get the most recent contract from broadcast/DeployFundMe.s.sol/31337 and pick the recent contract from run-latest.json file
        vm.startBroadcast();
        fundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );

        withdrawFundMe(mostRecentlyDeployed);
    }
}

//- let install ChainAccelOrg/foundry-devops --no-commit, this package help foundry to
//keep record of the most recently deployed contract address.
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge install ChainAccelOrg/foundry-devops --no-commit

//- let create integration folder inside test
//* create IntegrationTest.t.sol file inside test/integration folder
//- let create unit folder inside test folder and move FundMeTest.t.sol file onto unit folder
