//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();
        fundMe = deploy.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe)); //fund using our script

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe)); //withdraw using script

        assert(address(fundMe).balance == 0);
    }
    //- let run test on Anvil like this
    //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test -vvv
    //- let run test on simulate or pretend Sepolia network like this
    // adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ source .env
    // adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test --fork-url $SEPOLIA_RPC_URL

    //- let create Makefile file in the root folder inorder to write shortcut instead of long script on the command prompt
    //* Makefile enable us to read the content of .env file without happen to type source .env file on the terminal

    //* le run make like this
    //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ make
    //its return
    // Command 'make' not found, but can be installed with:
    // sudo apt install make        # version 4.3-4.1build1, or
    // sudo apt install make-guile  # version 4.3-4.1build1
    //- after setting up Makefile we can run this command
    //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ make build

    //- inorder to do automatic verification of code we need to go to etherscan.io
    //* we need to Sign-In and Login, click on the Profil drownload, click on API keys
    //* click on Add button to create an API key
    //App Name: Foundry-Full-Course and click on Create New API Key button
    //* copied the API Key Token
    //* open .env file and create an environment variable for Etherscan API key
}
