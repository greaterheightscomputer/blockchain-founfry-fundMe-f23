//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// import {Test} from "forge-std/Test.sol"; //library from foundry

// contract FundMeTest is Test {
//     //setUp function is the 1st function that will run in test contract
//     function setUp() external {}

//     function testDemo() public {}

//     //- let run the test like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test
// }

// //===============
// //import console object for the purpose of debugging our test code

// import {Test, console} from "forge-std/Test.sol";

// contract FundMeTest is Test {
//     uint256 number = 1;

//     function setUp() external {
//         number = 2;
//     }

//     function testDemo() public {
//         console.log(number);
//         console.log("Hello");
//         assertEq(number, 2);
//     }

//     //- let run the test like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test -vv
//     //-vv means the visibility of console
// }

//===============
//let test FundMe contract

// import {Test, console} from "forge-std/Test.sol";
// import {FundMe} from "../src/FundMe.sol";

// contract FundMeTest is Test {
//     FundMe fundMe;

//     function setUp() external {
//         fundMe = new FundMe();
//     }

//     function testMinimumDollarIsFive() public {
//         assertEq(fundMe.MINIMUM_USD(), 5e18);
//     }

//     //- let run the test like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test

//     // function testOwnerIsMsgSender() public {
//     //     assertEq(fundMe.i_owner(), msg.sender); //its throw as error
//     // }
//     //its throw an error, let find out where its throw an error by using console.log like this
//     // function testOwnerIsMsgSender() public {
//     //     console.log(fundMe.i_owner());
//     //     console.log(msg.sender);
//     //     assertEq(fundMe.i_owner(), msg.sender);
//     // }
//     //- let run the test like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test -vv
//     //* 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496 -> this is FundMeTest contract address
//     //* 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38 -> this is msg.sender address which is
//     //whoever that is calling a contract which is us.
//     //* its throws an error becos FundMeTest address is not equal to msg.sender address which is this
//     // assertEq(fundMe.i_owner(), msg.sender);

//let fix the above issue like this
//     function testOwnerIsMsgSender() public {
//         console.log(fundMe.i_owner());
//         console.log(address(this));
//         assertEq(fundMe.i_owner(), address(this));
//     }
//     //- let run the test like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test -vv
//     //* the i_owner is FundeMeTest and not FundMe contract becos FundMeTest contract is the
//     //one that is deploying FundMe contract that is why we use address(this) which is equal
//     //to FundMeTest.

//     //Advanced Deploy Scripts I
//     //- create DeployFundMe.s.sol file inside script folder
// }

//- testing getVersion() function
// import {Test, console} from "forge-std/Test.sol";
// import {FundMe} from "../src/FundMe.sol";

// contract FundMeTest is Test {
//     FundMe fundMe;

//     function setUp() external {
//         fundMe = new FundMe();
//     }

//     function testMinimumDollarIsFive() public {
//         assertEq(fundMe.MINIMUM_USD(), 5e18);
//     }

//     function testOwnerIsMsgSender() public {
//         console.log(fundMe.i_owner());
//         console.log(address(this));
//         assertEq(fundMe.i_owner(), address(this));
//     }

//     function testPriceFeedVersionIsAccurate() public {
//         uint256 version = fundMe.getVersion();
//         assertEq(version, 4);
//     }

//     //- let run test like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test
//     //its throw as error -> [FAIL. Reason: EvmError: Revert]
//     //- let see the detail while it fail like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test -vvv
//     //* its return this error becos we are call a contract address that does not exist on Anvil chain
//     //becos this contract address 0x694AA1769357215DE4FAC081bf1f309aDC325306 is on Sepolia chain
//     //     Traces:
//     //   [8019] FundMeTest::testPriceFeedVersionIsAccurate()
//     //     ├─ [2983] FundMe::getVersion() [staticcall]
//     //     │   ├─ [0] 0x694AA1769357215DE4FAC081bf1f309aDC325306::version() [staticcall]
//     //     │   │   └─ ← ()
//     //     │   └─ ← "EvmError: Revert"
//     //     └─ ← "EvmError: Revert"

//     //What can we do to work with addresses outside our system?
//     //1.    Unit -> Testing a specific part of our code
//     //2.    Integration -> Testing how our code works with other parts of our code.
//     //3.    Forked -> Testing our code on a simulated real environment.
//     //4.    Staging -> Testing our code in a real environment that is not production.

//     //- let go back to Alchemy to copy RPC Url and past it inside .env file, make sure to add
//     //.env file onto .gitignore file
//     //- let make .env variables available at the terminal like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ source .env
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ echo $SEPOLIA_RPC_URL
//     //its return https://eth-sepolia.g.alchemy.com/v2/a84ssMVWA4jLZ1B8Nkk8GnISSR9pyr4I

//     //- let use forked test like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test -vvv --fork-url $SEPOLIA_RPC_URL
//     //its return success pass becos its pretend to read from sepolia chain instead of
//     //reading from blank chain this is called simulate fork of sepolia rpc url.
//     //* the downside of this fork is that we shall be making alot of api calls to Alchemy.
//     //- let view the contract converage to view how we have test our contract like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge coverage --fork-url $SEPOLIA_RPC_URL
// }

//refactor of FundMeTest contract with constructor parameter like this
// import {Test, console} from "forge-std/Test.sol";
// import {FundMe} from "../src/FundMe.sol";
// import {DeployFundMe} from "../script/DeployFundMe.s.sol";

// contract FundMeTest is Test {
//     FundMe fundMe;

//     function setUp() external {
//         // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
//         //replace the above with the below line of code becos run() function of
//         //DeployFundMe contract will return fundMe instance or object
//         DeployFundMe deployFundMe = new DeployFundMe();
//         fundMe = deployFundMe.run();
//     }

//     function testMinimumDollarIsFive() public {
//         assertEq(fundMe.MINIMUM_USD(), 5e18);
//     }

//     // function testOwnerIsMsgSender() public {
//     //     console.log(fundMe.i_owner());
//     //     console.log(address(this));
//     //     assertEq(fundMe.i_owner(), msg.sender);
//     // }

//     function testOwnerIsMsgSender() public {
//         console.log(fundMe.i_owner());
//         console.log(msg.sender);
//         console.log(address(this));
//         assertEq(fundMe.i_owner(), msg.sender);
//     }

//     function testPriceFeedVersionIsAccurate() public {
//         uint256 version = fundMe.getVersion();
//         assertEq(version, 4);
//     }
// }
//- after adding DeployFundMe contract onto FundMeTest contract let run test command inorder to
//make sure every works find like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ source .env
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test --fork-url $SEPOLIA_RPC_URL
//its throw this error
// Failing tests:
// Encountered 1 failing test in test/FundMeTest.t.sol:FundMeTest
// [FAIL. Reason: Assertion failed.] testOwnerIsMsgSender() (gas: 24310)
//- to fix the above let change the address(this) to msg.sender
// assertEq(fundMe.i_owner(), address(this));
//- all test passed becos FundMe contract is deployed by deployFundMe.run() contract not
//FundMeTest contract

//=================
//Refactoring II
//Helper Config
//- if we try running test like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test
//* its will throw this error
// Failing tests:
// Encountered 1 failing test in test/FundMeTest.t.sol:FundMeTest
// [FAIL. Reason: EvmError: Revert] testPriceFeedVersionIsAccurate() (gas: 10135)
//* becos the PriceFeed contract address is from Sepolia chain
//- inorder to us to run priceFeed on local Anvil chain we need to create mock contract where
//we can deploy fake priceFeed for the duration of our test.
//- inorder to work with this mock contract let create HelperConfig.s.sol file inside script
//folder
//- we shall be doing two things with HelperConfig contract
//1. Deploy mocks priceFeed when we are on a local anvil chain
//2. Keep track of contract address across different chains
//Sepolia ETH/USD as different priceFeed address
//Mainnet ETH/USD as different priceFeed address

//===========================
// write more test function
//- let go to https://book.getfoundry.sh/cheatcodes/expect-revert
//expect-revert is use to tell foundry that the next line should revert.
//- https://book.getfoundry.sh/cheatcodes/prank -> to know the sender of the next transaction.
//- https://book.getfoundry.sh/reference/forge-std/make-addr -> Creates an address derived from the provided name.

// import {Test, console} from "forge-std/Test.sol";
// import {FundMe} from "../src/FundMe.sol";
// import {DeployFundMe} from "../script/DeployFundMe.s.sol";

// contract FundMeTest is Test {
//     FundMe fundMe;

//     address USER = makeAddr("user"); //its return an address
//     uint256 constant SEND_VALUE = 0.1 ether; //100000000000000000
//     uint256 constant STARTING_BALANCE = 10 ether;

//     function setUp() external {
//         DeployFundMe deployFundMe = new DeployFundMe();
//         fundMe = deployFundMe.run();
//         vm.deal(USER, STARTING_BALANCE); //to create fake money
//     }

//     function testMinimumDollarIsFive() public {
//         assertEq(fundMe.MINIMUM_USD(), 5e18);
//     }

//     function testOwnerIsMsgSender() public {
//         console.log(fundMe.i_owner());
//         console.log(msg.sender);
//         console.log(address(this));
//         assertEq(fundMe.i_owner(), msg.sender);
//     }

//     function testPriceFeedVersionIsAccurate() public {
//         uint256 version = fundMe.getVersion();
//         assertEq(version, 4);
//     }

//     //Testing fund() function
//     function testFundFailsWithoutEnoughETH() public {
//         vm.expectRevert(); //which means that the next line should be revert
//         fundMe.fund(); //send 0 value
//     }

//     //- let run testFundFailsWithoutEnoughETH like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test

//     //test fund() function by sending the required amount
//     // function testFundUpdatesFundedDataStructure() public {
//     //     fundMe.fund{value: 10e18}();

//     //     uint256 amountFunded = fundMe.getAddressToAmountFunded(address(this));
//     //     assertEq(amountFunded, 10e18);
//     // }

//     //using cheatcode
//     function testFundUpdatesFundedDataStructure() public {
//         vm.prank(USER); //The next transaction will be sent by User
//         fundMe.fund{value: SEND_VALUE}();

//         uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
//         assertEq(amountFunded, SEND_VALUE);
//     }

//     //- let run test with cheatcode like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test
//     //its return this [FAIL. Reason: EvmError: Revert] testFundUpdatesFundedDataStructure() (gas: 16836)
//     //- let rerun test with cheatcode to view the detail of the error like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test -vvv
//     //- its throw the error becos the user we create don't have fund -> "EvmError: OutOfFund"
//     //- let use another cheatcode to send fake money by going to
//     //book.getfoundry.sh/cheatcodes/deal -> Sets the balance of an address who to newBalance.
//     //- after adding deal cheatcode let rerun the test like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test -vvv
//     //its run the testFundUpdatesFundedDataStructure() successfully
//     //- let see how far we have gone with testing by using coverage like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge coverage

//     function testAddsFunderToArrayOfFunders() public {
//         vm.prank(USER);
//         fundMe.fund{value: SEND_VALUE}();

//         address funder = fundMe.getFunder(0);
//         console.log(USER);
//         console.log(funder);
//         assertEq(funder, USER);
//     }

//     //- let run test like this:
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test -vvv

//     //testing function for onlyOwner modifier is working correctly
//     // function testOnlyOwnerCanWithdraw() public {
//     //     vm.prank(USER);
//     //     fundMe.fund{value: SEND_VALUE}();

//     //     vm.expectRevert();
//     //     vm.prank(USER); //means USER is not the owner of the contract and want to call withdraw() function
//     //     fundMe.withdraw();
//     // }
//     //- let run test like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test
//     //its throw this error ->
//     //[FAIL. Reason: Call did not revert as expected] testOnlyOwnerCanWithdraw()
//     //- let solve the above issue like this
//     function testOnlyOwnerCanWithdraw() public {
//         vm.prank(USER); //meaning USER is the owner of the contract
//         fundMe.fund{value: SEND_VALUE}();

//         vm.expectRevert();
//         fundMe.withdraw();
//     }
//     //- let run test like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test
//     //its run the test successfully
// }

//==========================
//Proposed Solidity best practice:
//* Organize your unit tests by using a state tree.
//* Start by defining the parent nodes as the specific state conditions that drive the
//behavior of the smart contract.
//* Then, use empty modifiers to implement the tree like this

//pragma solidity >=0.8.18;

//import {PRBTest} from "@prb/test/PRBTest.sol";

//contract MyTest is PRBTest {
//  function test_RevertWhen_CallerNotOwner() external{
//      vm.expectRevert();
//      ....
//  }
//
//  modifier callerOwner(){
//      _;
//  }
//
//  function test_RevertWhen_DepositZero() external callerOwner{
//      vm.expectRevert();
//      ...
//  }
//
//  modifier depositNotZero(){
//      _;
//  }
//
//  function test_MyFunc() external callerOwner depositNotZero{
//      ...
//  }
//}

//Let implement the above proposed test practice in our test inorder to avoid repetition of code
// import {Test, console} from "forge-std/Test.sol";
// import {FundMe} from "../src/FundMe.sol";
// import {DeployFundMe} from "../script/DeployFundMe.s.sol";

// contract FundMeTest is Test {
//     FundMe fundMe;

//     address USER = makeAddr("user");
//     uint256 constant SEND_VALUE = 0.1 ether;
//     uint256 constant STARTING_BALANCE = 10 ether;

//     function setUp() external {
//         DeployFundMe deployFundMe = new DeployFundMe();
//         fundMe = deployFundMe.run();
//         vm.deal(USER, STARTING_BALANCE);
//     }

//     function testMinimumDollarIsFive() public {
//         assertEq(fundMe.MINIMUM_USD(), 5e18);
//     }

//     function testOwnerIsMsgSender() public {
//         console.log(fundMe.getOwner());
//         console.log(msg.sender);
//         console.log(address(this));
//         assertEq(fundMe.getOwner(), msg.sender);
//     }

//     function testPriceFeedVersionIsAccurate() public {
//         uint256 version = fundMe.getVersion();
//         assertEq(version, 4);
//     }

//     function testFundFailsWithoutEnoughETH() public {
//         vm.expectRevert();
//         fundMe.fund();
//     }

//     function testFundUpdatesFundedDataStructure() public funded {
//         //using funded modifier in place of the two below codes
//         // vm.prank(USER);
//         // fundMe.fund{value: SEND_VALUE}();

//         uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
//         assertEq(amountFunded, SEND_VALUE);
//     }

//     function testAddsFunderToArrayOfFunders() public funded {
//         //using funded modifier in place of the two below codes
//         // vm.prank(USER);
//         // fundMe.fund{value: SEND_VALUE}();

//         address funder = fundMe.getFunder(0);
//         console.log(USER);
//         console.log(funder);
//         assertEq(funder, USER);
//     }

//     function testOnlyOwnerCanWithdraw() public funded {
//         //using funded modifier in place of the two below codes
//         // vm.prank(USER);
//         // fundMe.fund{value: SEND_VALUE}();
//         vm.expectRevert();
//         fundMe.withdraw();
//     }

//     function testWithDrawWithASingleFunder() public funded {
//         //testing should be in this pattern
//         //* Arrange or setup
//         uint256 startingOwnerBalance = fundMe.getOwner().balance; // owner balance
//         uint256 startingFundMeBalance = address(fundMe).balance; //contract balance which is this fundMe.fund{value: SEND_VALUE}();

//         //* Act or action
//         // vm.prank(fundMe.getOwner());
//         vm.prank(USER);
//         fundMe.withdraw();

//         //* Assert or compare
//         uint256 endingOwnerBalance = fundMe.getOwner().balance;
//         uint256 endingFundMeBalance = address(fundMe).balance;
//         // console.log("b1= ", startingFundMeBalance + startingOwnerBalance);
//         // console.log("b2= ", endingOwnerBalance);
//         assertEq(endingFundMeBalance, 0);
//         // assertEq(
//         //     startingFundMeBalance + startingOwnerBalance,
//         //     endingOwnerBalance
//         // );
//     }

//     function testWithdrawFromMultipleFunders() public funded {
//         //As of Solidity v0.8, you can no longer cast explicitly from address to uint256.
//         //But you can explicitly cast address to uint160 becos they has the same storage length or bytes

//         //Arrange
//         uint160 numberOfFunders = 10; //if you want to use number to generate address, the number has to be uint160
//         uint160 startingFunderIndex = 1;
//         for (uint160 i = startingFunderIndex; i < numberOfFunders; i++) {
//             //vm.prank new address
//             //vm.deal funded new address
//             //hoax -> combination of prank and deal cheatcode. hoax also means prank.
//             hoax(address(i), SEND_VALUE); //we cast uint160 to address and send money to each generated addresses
//             fundMe.fund{value: SEND_VALUE}();
//         }

//         uint256 startingOwnerBalance = fundMe.getOwner().balance;
//         uint256 startingFundMeBalance = address(fundMe).balance;

//         //Act
//         // vm.startPrank(fundMe.getOwner());
//         vm.startPrank(USER);
//         fundMe.withdraw();
//         vm.stopPrank();

//         //Assert
//         assert(address(fundMe).balance == 0);
//         // assert(
//         //     startingFundMeBalance + startingOwnerBalance ==
//         //         fundMe.getOwner().balance
//         // );
//     }

//     modifier funded() {
//         vm.prank(USER);
//         fundMe.fund{value: SEND_VALUE}();
//         _;
//     }
//     //- let run test like this
//     //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test
// }

//=========================
//Chisel -> its allow us to write solidity directly on the terminal and execute it line by line.
//- let run chisel like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ chisel
//its return -> Welcome to Chisel! Type `!help` to show available commands.
//type !help on the terminal
//➜ !help
//its return different types of commands.
//- let type solidity onto the terminal like this
// ➜ uint256 cat = 1;
// ➜ cat
//its return
// Type: uint
// ├ Hex: 0x1
// └ Decimal: 1

// ➜ uint256 catAndThree = cat + 3;
// ➜ catAndThree
// Type: uint
// ├ Hex: 0x4
// └ Decimal: 4
//- to exit from chisel press ctrl + c

//=========================
//Gas: Cheaper Withdraw
//- Anytime we will deploy transaction on chain we pay gas. The most complicated or
//computational expense our transaction is the more gas we pay.
//- to know how much gas it cost to run a test on-chain let run this command
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge snapshot
//its generate .gas-snapshot on the root folder.
//- Anvil chain gas price is default to zero. But inorder to pretend to charge gas price on
//Anvil chain we need to use txGasPrice chectcode. txGasPrice set gas price for transaction.

// import {Test, console} from "forge-std/Test.sol";
// import {FundMe} from "../src/FundMe.sol";
// import {DeployFundMe} from "../script/DeployFundMe.s.sol";

// contract FundMeTest is Test {
//     FundMe fundMe;

//     address USER = makeAddr("user");
//     uint256 constant SEND_VALUE = 0.1 ether;
//     uint256 constant STARTING_BALANCE = 10 ether;
//     uint256 constant GAS_PRICE = 1;

//     function setUp() external {
//         DeployFundMe deployFundMe = new DeployFundMe();
//         fundMe = deployFundMe.run();
//         vm.deal(USER, STARTING_BALANCE);
//     }

//     function testMinimumDollarIsFive() public {
//         assertEq(fundMe.MINIMUM_USD(), 5e18);
//     }

//     function testOwnerIsMsgSender() public {
//         console.log(fundMe.getOwner());
//         console.log(msg.sender);
//         console.log(address(this));
//         assertEq(fundMe.getOwner(), msg.sender);
//     }

//     function testPriceFeedVersionIsAccurate() public {
//         uint256 version = fundMe.getVersion();
//         assertEq(version, 4);
//     }

//     function testFundFailsWithoutEnoughETH() public {
//         vm.expectRevert();
//         fundMe.fund();
//     }

//     function testFundUpdatesFundedDataStructure() public funded {
//         uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
//         assertEq(amountFunded, SEND_VALUE);
//     }

//     function testAddsFunderToArrayOfFunders() public funded {
//         address funder = fundMe.getFunder(0);
//         console.log(USER);
//         console.log(funder);
//         assertEq(funder, USER);
//     }

//     function testOnlyOwnerCanWithdraw() public funded {
//         vm.expectRevert();
//         fundMe.withdraw();
//     }

//     function testWithDrawWithASingleFunder() public funded {
//         //* Arrange or setup
//         uint256 startingOwnerBalance = fundMe.getOwner().balance;
//         uint256 startingFundMeBalance = address(fundMe).balance;

//         //* Act or action
//         uint256 gasStart = gasleft(); //gasleft() is a build-in function in solidity. It tell us how much gas is left in the transaction call.
//         vm.txGasPrice(GAS_PRICE);
//         // vm.prank(fundMe.getOwner());
//         vm.prank(USER);
//         fundMe.withdraw();

//         uint256 gasEnd = gasleft();
//         uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice; //tx.gasprice is a build-in solidity constant that tell us the current gas price
//         console.log(gasUsed); //its return 9956 gas

//         //* Assert or compare
//         uint256 endingOwnerBalance = fundMe.getOwner().balance;
//         uint256 endingFundMeBalance = address(fundMe).balance;
//         assertEq(endingFundMeBalance, 0);
//         // assertEq(
//         //     startingFundMeBalance + startingOwnerBalance,
//         //     endingOwnerBalance
//         // );
//     }

//     function testWithdrawFromMultipleFunders() public funded {
//         //Arrange
//         uint160 numberOfFunders = 10;
//         uint160 startingFunderIndex = 1;
//         for (uint160 i = startingFunderIndex; i < numberOfFunders; i++) {
//             hoax(address(i), SEND_VALUE);
//             fundMe.fund{value: SEND_VALUE}();
//         }

//         uint256 startingOwnerBalance = fundMe.getOwner().balance;
//         uint256 startingFundMeBalance = address(fundMe).balance;

//         //Act
//         // vm.startPrank(fundMe.getOwner());
//         vm.startPrank(USER);
//         fundMe.withdraw();
//         vm.stopPrank();

//         //Assert
//         assert(address(fundMe).balance == 0);
//         // assert(
//         //     startingFundMeBalance + startingOwnerBalance ==
//         //         fundMe.getOwner().balance
//         // );
//     }

//     modifier funded() {
//         vm.prank(USER);
//         fundMe.fund{value: SEND_VALUE}();
//         _;
//     }
// }
//- let run test on testWithDrawWithASingleFunder() function inorder to veiw how much gas it
//cost to run this transaction on Anvil chain
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge test -vv

//==================
//Storage
//- all the state or global variables are also called storage variables
//- let learn about gas optimization technique
//Storage
//[0] 0x00...19 -> uint256 favoriteNumber; -> 32 bytes size
//[1] 0x00...01 -> boole someBool; -> 32 bytes size
//[2] 0x00...01 -> uint256[] myArray; its store the array length -> 32 bytes size
//[3]           -> uint256 mapping; its store mapping on a storage slot like an array but its
//                  empty storage slot that is how it differential array from mapping.
//[4]

//- [0] 0x00...19 --> storage slot: each slot is 32 bytes long and represents the bytes version of the object
//               for exampe, the uint256 25 is 0x00...0019 since that's the hex representation of 25
//- [1] 0x00...01 -> bool someBool is store in storage slot in it hex value
//- [2] 0x00...01 -> uint256[] myArray;
//myArray.push(222); is store onto this hash function [keccak256(2)] 0x00...01 to take up a
//space in storage. [keccak256(2)] storing array on hash function was delibrate becos the size
// of dynamic array can change and may be bigger than 32 bytes storage slot.
//For dynamic values like mappings and dynamic arrays, the elements are stored using a
//hashing function.
//You can see those functions in the documentation
//* for arrays, a sequential storage spot is taken up for the length of the array
//* for mappings, a sequential storage spot is taken up, but left blank.
//- Constant and immutable variables are not store in storage slot but they are considered
//part of the core of the bytecode of the contract.
//- local variable are not store in storage slot they only exist for the duration of the
//function and they get store on their own storage structure which are delete right after
//the successful execution of the function.

//- let check the storage slot of state variables on foundry like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge inspect FundMe storageLayout
//  "storage": [
//     {
//       "astId": 43144,
//       "contract": "src/FundMe.sol:FundMe",
//       "label": "s_funders",
//       "offset": 0,
//       "slot": "0",  ---------------------------------> storage slot 0 = s_funders
//       "type": "t_array(t_address)dyn_storage"
//     },
//     {
//       "astId": 43148,
//       "contract": "src/FundMe.sol:FundMe",
//       "label": "s_addressToAmountFunded",
//       "offset": 0,
//       "slot": "1",   ---------------------------------> storage slot 1 = s_addressToAmountFunded
//       "type": "t_mapping(t_address,t_uint256)"
//     },
//     {
//       "astId": 43153,
//       "contract": "src/FundMe.sol:FundMe",
//       "label": "s_priceFeed",
//       "offset": 0,
//       "slot": "2",   ---------------------------------> storage slot 2 = s_priceFeed
//       "type": "t_contract(AggregatorV3Interface)45"
//     }
//   ],

//- Another way of viewing storage slot variables is to do the following
//* startup anvil chain like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ anvil
//* deploy DeployFundMe script onto Anvil chain like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge script script/DeployFundMe.s.sol --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast
//* copied the deployed contract address 0xe7f1725e7734ce288f8367e1bb143e90bb3f0512 add 2
//which represent the storage slot 2 which is state variable s_priceFeed like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ cast storage 0xe7f1725e7734ce288f8367e1bb143e90bb3f0512 2
//its return the hex value of 0x0000000000000000000000005fbdb2315678afecb367f032d93f642f64180aa3
//- add 0 and 1 storage slot number return empty hex value like  0x0000000000000000000000000000000000000000000000000000000000000000
//becos they are empty storage slot

//Storage
//- writing and reading on storage is very expensive becos it cost more gas.
//- back to Remix IDE, click on Compile FundMe.sol button, click on Compilation Details button
//expand BYTECODE scroll down to "linkReferences" property like this
// "linkReferences": {},
//     "object": "60a060405234801561001057600080fd5b503373ffffffffffffffffffffffffffffffffffffffff1660808173ffffffffffffffffffffffffffffffffffffffff1681525050608051610c996100676000396000818161027301526104d70152610c996000f3fe6080604052600436106100595760003560e01c80633ccfd60b146100725780633e47d6f3146100895780636b69a592146100c6578063b60d4288146100f1578063dba6335f146100fb578063dc0d3dff1461012657610068565b3661006857610066610163565b005b610070610163565b005b34801561007e57600080fd5b50610087610271565b005b34801561009557600080fd5b506100b060048036038101906100ab9190610725565b6104b1565b6040516100bd919061076b565b60405180910390f35b3480156100d257600080fd5b506100db6104c9565b6040516100e8919061076b565b60405180910390f35b6100f9610163565b005b34801561010757600080fd5b506101106104d5565b60405161011d9190610795565b60405180910390f35b34801561013257600080fd5b5061014d600480360381019061014891906107dc565b6104f9565b60405161015a9190610795565b60405180910390f35b674563918244f4000061017534610538565b10156101b6576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016101ad90610866565b60405180910390fd5b6000339080600181540180825580915050600190039060005260206000200160009091909190916101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555034600160003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020600082825461026891906108b5565b92505081905550565b7f000000000000000000000000000000000000000000000000000000000000000073ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16036102f6576040517f30cd747100000000000000000000000000000000000000000000000000000000815260040160405180910390fd5b60005b6000805490508110156103a157600080828154811061031b5761031a6108e9565b5b9060005260206000200160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690506000600160008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000208190555050808061039990610918565b9150506102f9565b50600067ffffffffffffffff8111156103bd576103bc610960565b5b6040519080825280602002602001820160405280156103eb5781602001602082028036833780820191505090505b506000908051906020019061040192919061061b565b5060003373ffffffffffffffffffffffffffffffffffffffff1647604051610428906109c0565b60006040518083038185875af1925050503d8060008114610465576040519150601f19603f3d011682016040523d82523d6000602084013e61046a565b606091505b50509050806104ae576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016104a590610a21565b60405180910390fd5b50565b60016020528060005260406000206000915090505481565b674563918244f4000081565b7f000000000000000000000000000000000000000000000000000000000000000081565b6000818154811061050957600080fd5b906000526020600020016000915054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600080610543610572565b90506000670de0b6b3a7640000848361055c9190610a41565b6105669190610ab2565b90508092505050919050565b60008073694aa1769357215de4fac081bf1f309adc325306905060008173ffffffffffffffffffffffffffffffffffffffff1663feaf968c6040518163ffffffff1660e01b815260040160a060405180830381865afa1580156105d9573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906105fd9190610b70565b5050509150506402540be400816106149190610beb565b9250505090565b828054828255906000526020600020908101928215610694579160200282015b828111156106935782518260006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055509160200191906001019061063b565b5b5090506106a191906106a5565b5090565b5b808211156106be5760008160009055506001016106a6565b5090565b600080fd5b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b60006106f2826106c7565b9050919050565b610702816106e7565b811461070d57600080fd5b50565b60008135905061071f816106f9565b92915050565b60006020828403121561073b5761073a6106c2565b5b600061074984828501610710565b91505092915050565b6000819050919050565b61076581610752565b82525050565b6000602082019050610780600083018461075c565b92915050565b61078f816106e7565b82525050565b60006020820190506107aa6000830184610786565b92915050565b6107b981610752565b81146107c457600080fd5b50565b6000813590506107d6816107b0565b92915050565b6000602082840312156107f2576107f16106c2565b5b6000610800848285016107c7565b91505092915050565b600082825260208201905092915050565b7f6469646e27742073656e6420656e6f7567682045544800000000000000000000600082015250565b6000610850601683610809565b915061085b8261081a565b602082019050919050565b6000602082019050818103600083015261087f81610843565b9050919050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b60006108c082610752565b91506108cb83610752565b92508282019050808211156108e3576108e2610886565b5b92915050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b600061092382610752565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff820361095557610954610886565b5b600182019050919050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052604160045260246000fd5b600081905092915050565b50565b60006109aa60008361098f565b91506109b58261099a565b600082019050919050565b60006109cb8261099d565b9150819050919050565b7f43616c6c206661696c6564000000000000000000000000000000000000000000600082015250565b6000610a0b600b83610809565b9150610a16826109d5565b602082019050919050565b60006020820190508181036000830152610a3a816109fe565b9050919050565b6000610a4c82610752565b9150610a5783610752565b9250828202610a6581610752565b91508282048414831517610a7c57610a7b610886565b5b5092915050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601260045260246000fd5b6000610abd82610752565b9150610ac883610752565b925082610ad857610ad7610a83565b5b828204905092915050565b600069ffffffffffffffffffff82169050919050565b610b0281610ae3565b8114610b0d57600080fd5b50565b600081519050610b1f81610af9565b92915050565b6000819050919050565b610b3881610b25565b8114610b4357600080fd5b50565b600081519050610b5581610b2f565b92915050565b600081519050610b6a816107b0565b92915050565b600080600080600060a08688031215610b8c57610b8b6106c2565b5b6000610b9a88828901610b10565b9550506020610bab88828901610b46565b9450506040610bbc88828901610b5b565b9350506060610bcd88828901610b5b565b9250506080610bde88828901610b10565b9150509295509295909350565b6000610bf682610b25565b9150610c0183610b25565b9250828202610c0f81610b25565b91507f80000000000000000000000000000000000000000000000000000000000000008414600084121615610c4757610c46610886565b5b8282058414831517610c5c57610c5b610886565b5b509291505056fea2646970667358221220fafd03683bdaf11c4886fc991497cb69c7ac83adc1fce755cdc3e4497b339ed464736f6c63430008130033",
//     "opcodes": "PUSH1 0xA0 PUSH1 0x40 MSTORE CALLVALUE DUP1 ISZERO PUSH2 0x10 JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP CALLER PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND PUSH1 0x80 DUP2 PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND DUP2 MSTORE POP POP PUSH1 0x80 MLOAD PUSH2 0xC99 PUSH2 0x67 PUSH1 0x0 CODECOPY PUSH1 0x0 DUP2 DUP2 PUSH2 0x273 ADD MSTORE PUSH2 0x4D7 ADD MSTORE PUSH2 0xC99 PUSH1 0x0 RETURN INVALID PUSH1 0x80 PUSH1 0x40 MSTORE PUSH1 0x4 CALLDATASIZE LT PUSH2 0x59 JUMPI PUSH1 0x0 CALLDATALOAD PUSH1 0xE0 SHR DUP1 PUSH4 0x3CCFD60B EQ PUSH2 0x72 JUMPI DUP1 PUSH4 0x3E47D6F3 EQ PUSH2 0x89 JUMPI DUP1 PUSH4 0x6B69A592 EQ PUSH2 0xC6 JUMPI DUP1 PUSH4 0xB60D4288 EQ PUSH2 0xF1 JUMPI DUP1 PUSH4 0xDBA6335F EQ PUSH2 0xFB JUMPI DUP1 PUSH4 0xDC0D3DFF EQ PUSH2 0x126 JUMPI PUSH2 0x68 JUMP JUMPDEST CALLDATASIZE PUSH2 0x68 JUMPI PUSH2 0x66 PUSH2 0x163 JUMP JUMPDEST STOP JUMPDEST PUSH2 0x70 PUSH2 0x163 JUMP JUMPDEST STOP JUMPDEST CALLVALUE DUP1 ISZERO PUSH2 0x7E JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP PUSH2 0x87 PUSH2 0x271 JUMP JUMPDEST STOP JUMPDEST CALLVALUE DUP1 ISZERO PUSH2 0x95 JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP PUSH2 0xB0 PUSH1 0x4 DUP1 CALLDATASIZE SUB DUP2 ADD SWAP1 PUSH2 0xAB SWAP2 SWAP1 PUSH2 0x725 JUMP JUMPDEST PUSH2 0x4B1 JUMP JUMPDEST PUSH1 0x40 MLOAD PUSH2 0xBD SWAP2 SWAP1 PUSH2 0x76B JUMP JUMPDEST PUSH1 0x40 MLOAD DUP1 SWAP2 SUB SWAP1 RETURN JUMPDEST CALLVALUE DUP1 ISZERO PUSH2 0xD2 JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP PUSH2 0xDB PUSH2 0x4C9 JUMP JUMPDEST PUSH1 0x40 MLOAD PUSH2 0xE8 SWAP2 SWAP1 PUSH2 0x76B JUMP JUMPDEST PUSH1 0x40 MLOAD DUP1 SWAP2 SUB SWAP1 RETURN JUMPDEST PUSH2 0xF9 PUSH2 0x163 JUMP JUMPDEST STOP JUMPDEST CALLVALUE DUP1 ISZERO PUSH2 0x107 JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP PUSH2 0x110 PUSH2 0x4D5 JUMP JUMPDEST PUSH1 0x40 MLOAD PUSH2 0x11D SWAP2 SWAP1 PUSH2 0x795 JUMP JUMPDEST PUSH1 0x40 MLOAD DUP1 SWAP2 SUB SWAP1 RETURN JUMPDEST CALLVALUE DUP1 ISZERO PUSH2 0x132 JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP PUSH2 0x14D PUSH1 0x4 DUP1 CALLDATASIZE SUB DUP2 ADD SWAP1 PUSH2 0x148 SWAP2 SWAP1 PUSH2 0x7DC JUMP JUMPDEST PUSH2 0x4F9 JUMP JUMPDEST PUSH1 0x40 MLOAD PUSH2 0x15A SWAP2 SWAP1 PUSH2 0x795 JUMP JUMPDEST PUSH1 0x40 MLOAD DUP1 SWAP2 SUB SWAP1 RETURN JUMPDEST PUSH8 0x4563918244F40000 PUSH2 0x175 CALLVALUE PUSH2 0x538 JUMP JUMPDEST LT ISZERO PUSH2 0x1B6 JUMPI PUSH1 0x40 MLOAD PUSH32 0x8C379A000000000000000000000000000000000000000000000000000000000 DUP2 MSTORE PUSH1 0x4 ADD PUSH2 0x1AD SWAP1 PUSH2 0x866 JUMP JUMPDEST PUSH1 0x40 MLOAD DUP1 SWAP2 SUB SWAP1 REVERT JUMPDEST PUSH1 0x0 CALLER SWAP1 DUP1 PUSH1 0x1 DUP2 SLOAD ADD DUP1 DUP3 SSTORE DUP1 SWAP2 POP POP PUSH1 0x1 SWAP1 SUB SWAP1 PUSH1 0x0 MSTORE PUSH1 0x20 PUSH1 0x0 KECCAK256 ADD PUSH1 0x0 SWAP1 SWAP2 SWAP1 SWAP2 SWAP1 SWAP2 PUSH2 0x100 EXP DUP2 SLOAD DUP2 PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF MUL NOT AND SWAP1 DUP4 PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND MUL OR SWAP1 SSTORE POP CALLVALUE PUSH1 0x1 PUSH1 0x0 CALLER PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND DUP2 MSTORE PUSH1 0x20 ADD SWAP1 DUP2 MSTORE PUSH1 0x20 ADD PUSH1 0x0 KECCAK256 PUSH1 0x0 DUP3 DUP3 SLOAD PUSH2 0x268 SWAP2 SWAP1 PUSH2 0x8B5 JUMP JUMPDEST SWAP3 POP POP DUP2 SWAP1 SSTORE POP JUMP JUMPDEST PUSH32 0x0 PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND CALLER PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND SUB PUSH2 0x2F6 JUMPI PUSH1 0x40 MLOAD PUSH32 0x30CD747100000000000000000000000000000000000000000000000000000000 DUP2 MSTORE PUSH1 0x4 ADD PUSH1 0x40 MLOAD DUP1 SWAP2 SUB SWAP1 REVERT JUMPDEST PUSH1 0x0 JUMPDEST PUSH1 0x0 DUP1 SLOAD SWAP1 POP DUP2 LT ISZERO PUSH2 0x3A1 JUMPI PUSH1 0x0 DUP1 DUP3 DUP2 SLOAD DUP2 LT PUSH2 0x31B JUMPI PUSH2 0x31A PUSH2 0x8E9 JUMP JUMPDEST JUMPDEST SWAP1 PUSH1 0x0 MSTORE PUSH1 0x20 PUSH1 0x0 KECCAK256 ADD PUSH1 0x0 SWAP1 SLOAD SWAP1 PUSH2 0x100 EXP SWAP1 DIV PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND SWAP1 POP PUSH1 0x0 PUSH1 0x1 PUSH1 0x0 DUP4 PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND DUP2 MSTORE PUSH1 0x20 ADD SWAP1 DUP2 MSTORE PUSH1 0x20 ADD PUSH1 0x0 KECCAK256 DUP2 SWAP1 SSTORE POP POP DUP1 DUP1 PUSH2 0x399 SWAP1 PUSH2 0x918 JUMP JUMPDEST SWAP2 POP POP PUSH2 0x2F9 JUMP JUMPDEST POP PUSH1 0x0 PUSH8 0xFFFFFFFFFFFFFFFF DUP2 GT ISZERO PUSH2 0x3BD JUMPI PUSH2 0x3BC PUSH2 0x960 JUMP JUMPDEST JUMPDEST PUSH1 0x40 MLOAD SWAP1 DUP1 DUP3 MSTORE DUP1 PUSH1 0x20 MUL PUSH1 0x20 ADD DUP3 ADD PUSH1 0x40 MSTORE DUP1 ISZERO PUSH2 0x3EB JUMPI DUP2 PUSH1 0x20 ADD PUSH1 0x20 DUP3 MUL DUP1 CALLDATASIZE DUP4 CALLDATACOPY DUP1 DUP3 ADD SWAP2 POP POP SWAP1 POP JUMPDEST POP PUSH1 0x0 SWAP1 DUP1 MLOAD SWAP1 PUSH1 0x20 ADD SWAP1 PUSH2 0x401 SWAP3 SWAP2 SWAP1 PUSH2 0x61B JUMP JUMPDEST POP PUSH1 0x0 CALLER PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND SELFBALANCE PUSH1 0x40 MLOAD PUSH2 0x428 SWAP1 PUSH2 0x9C0 JUMP JUMPDEST PUSH1 0x0 PUSH1 0x40 MLOAD DUP1 DUP4 SUB DUP2 DUP6 DUP8 GAS CALL SWAP3 POP POP POP RETURNDATASIZE DUP1 PUSH1 0x0 DUP2 EQ PUSH2 0x465 JUMPI PUSH1 0x40 MLOAD SWAP2 POP PUSH1 0x1F NOT PUSH1 0x3F RETURNDATASIZE ADD AND DUP3 ADD PUSH1 0x40 MSTORE RETURNDATASIZE DUP3 MSTORE RETURNDATASIZE PUSH1 0x0 PUSH1 0x20 DUP5 ADD RETURNDATACOPY PUSH2 0x46A JUMP JUMPDEST PUSH1 0x60 SWAP2 POP JUMPDEST POP POP SWAP1 POP DUP1 PUSH2 0x4AE JUMPI PUSH1 0x40 MLOAD PUSH32 0x8C379A000000000000000000000000000000000000000000000000000000000 DUP2 MSTORE PUSH1 0x4 ADD PUSH2 0x4A5 SWAP1 PUSH2 0xA21 JUMP JUMPDEST PUSH1 0x40 MLOAD DUP1 SWAP2 SUB SWAP1 REVERT JUMPDEST POP JUMP JUMPDEST PUSH1 0x1 PUSH1 0x20 MSTORE DUP1 PUSH1 0x0 MSTORE PUSH1 0x40 PUSH1 0x0 KECCAK256 PUSH1 0x0 SWAP2 POP SWAP1 POP SLOAD DUP2 JUMP JUMPDEST PUSH8 0x4563918244F40000 DUP2 JUMP JUMPDEST PUSH32 0x0 DUP2 JUMP JUMPDEST PUSH1 0x0 DUP2 DUP2 SLOAD DUP2 LT PUSH2 0x509 JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST SWAP1 PUSH1 0x0 MSTORE PUSH1 0x20 PUSH1 0x0 KECCAK256 ADD PUSH1 0x0 SWAP2 POP SLOAD SWAP1 PUSH2 0x100 EXP SWAP1 DIV PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND DUP2 JUMP JUMPDEST PUSH1 0x0 DUP1 PUSH2 0x543 PUSH2 0x572 JUMP JUMPDEST SWAP1 POP PUSH1 0x0 PUSH8 0xDE0B6B3A7640000 DUP5 DUP4 PUSH2 0x55C SWAP2 SWAP1 PUSH2 0xA41 JUMP JUMPDEST PUSH2 0x566 SWAP2 SWAP1 PUSH2 0xAB2 JUMP JUMPDEST SWAP1 POP DUP1 SWAP3 POP POP POP SWAP2 SWAP1 POP JUMP JUMPDEST PUSH1 0x0 DUP1 PUSH20 0x694AA1769357215DE4FAC081BF1F309ADC325306 SWAP1 POP PUSH1 0x0 DUP2 PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND PUSH4 0xFEAF968C PUSH1 0x40 MLOAD DUP2 PUSH4 0xFFFFFFFF AND PUSH1 0xE0 SHL DUP2 MSTORE PUSH1 0x4 ADD PUSH1 0xA0 PUSH1 0x40 MLOAD DUP1 DUP4 SUB DUP2 DUP7 GAS STATICCALL ISZERO DUP1 ISZERO PUSH2 0x5D9 JUMPI RETURNDATASIZE PUSH1 0x0 DUP1 RETURNDATACOPY RETURNDATASIZE PUSH1 0x0 REVERT JUMPDEST POP POP POP POP PUSH1 0x40 MLOAD RETURNDATASIZE PUSH1 0x1F NOT PUSH1 0x1F DUP3 ADD AND DUP3 ADD DUP1 PUSH1 0x40 MSTORE POP DUP2 ADD SWAP1 PUSH2 0x5FD SWAP2 SWAP1 PUSH2 0xB70 JUMP JUMPDEST POP POP POP SWAP2 POP POP PUSH5 0x2540BE400 DUP2 PUSH2 0x614 SWAP2 SWAP1 PUSH2 0xBEB JUMP JUMPDEST SWAP3 POP POP POP SWAP1 JUMP JUMPDEST DUP3 DUP1 SLOAD DUP3 DUP3 SSTORE SWAP1 PUSH1 0x0 MSTORE PUSH1 0x20 PUSH1 0x0 KECCAK256 SWAP1 DUP2 ADD SWAP3 DUP3 ISZERO PUSH2 0x694 JUMPI SWAP2 PUSH1 0x20 MUL DUP3 ADD JUMPDEST DUP3 DUP2 GT ISZERO PUSH2 0x693 JUMPI DUP3 MLOAD DUP3 PUSH1 0x0 PUSH2 0x100 EXP DUP2 SLOAD DUP2 PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF MUL NOT AND SWAP1 DUP4 PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AND MUL OR SWAP1 SSTORE POP SWAP2 PUSH1 0x20 ADD SWAP2 SWAP1 PUSH1 0x1 ADD SWAP1 PUSH2 0x63B JUMP JUMPDEST JUMPDEST POP SWAP1 POP PUSH2 0x6A1 SWAP2 SWAP1 PUSH2 0x6A5 JUMP JUMPDEST POP SWAP1 JUMP JUMPDEST JUMPDEST DUP1 DUP3 GT ISZERO PUSH2 0x6BE JUMPI PUSH1 0x0 DUP2 PUSH1 0x0 SWAP1 SSTORE POP PUSH1 0x1 ADD PUSH2 0x6A6 JUMP JUMPDEST POP SWAP1 JUMP JUMPDEST PUSH1 0x0 DUP1 REVERT JUMPDEST PUSH1 0x0 PUSH20 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF DUP3 AND SWAP1 POP SWAP2 SWAP1 POP JUMP JUMPDEST PUSH1 0x0 PUSH2 0x6F2 DUP3 PUSH2 0x6C7 JUMP JUMPDEST SWAP1 POP SWAP2 SWAP1 POP JUMP JUMPDEST PUSH2 0x702 DUP2 PUSH2 0x6E7 JUMP JUMPDEST DUP2 EQ PUSH2 0x70D JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP JUMP JUMPDEST PUSH1 0x0 DUP2 CALLDATALOAD SWAP1 POP PUSH2 0x71F DUP2 PUSH2 0x6F9 JUMP JUMPDEST SWAP3 SWAP2 POP POP JUMP JUMPDEST PUSH1 0x0 PUSH1 0x20 DUP3 DUP5 SUB SLT ISZERO PUSH2 0x73B JUMPI PUSH2 0x73A PUSH2 0x6C2 JUMP JUMPDEST JUMPDEST PUSH1 0x0 PUSH2 0x749 DUP5 DUP3 DUP6 ADD PUSH2 0x710 JUMP JUMPDEST SWAP2 POP POP SWAP3 SWAP2 POP POP JUMP JUMPDEST PUSH1 0x0 DUP2 SWAP1 POP SWAP2 SWAP1 POP JUMP JUMPDEST PUSH2 0x765 DUP2 PUSH2 0x752 JUMP JUMPDEST DUP3 MSTORE POP POP JUMP JUMPDEST PUSH1 0x0 PUSH1 0x20 DUP3 ADD SWAP1 POP PUSH2 0x780 PUSH1 0x0 DUP4 ADD DUP5 PUSH2 0x75C JUMP JUMPDEST SWAP3 SWAP2 POP POP JUMP JUMPDEST PUSH2 0x78F DUP2 PUSH2 0x6E7 JUMP JUMPDEST DUP3 MSTORE POP POP JUMP JUMPDEST PUSH1 0x0 PUSH1 0x20 DUP3 ADD SWAP1 POP PUSH2 0x7AA PUSH1 0x0 DUP4 ADD DUP5 PUSH2 0x786 JUMP JUMPDEST SWAP3 SWAP2 POP POP JUMP JUMPDEST PUSH2 0x7B9 DUP2 PUSH2 0x752 JUMP JUMPDEST DUP2 EQ PUSH2 0x7C4 JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP JUMP JUMPDEST PUSH1 0x0 DUP2 CALLDATALOAD SWAP1 POP PUSH2 0x7D6 DUP2 PUSH2 0x7B0 JUMP JUMPDEST SWAP3 SWAP2 POP POP JUMP JUMPDEST PUSH1 0x0 PUSH1 0x20 DUP3 DUP5 SUB SLT ISZERO PUSH2 0x7F2 JUMPI PUSH2 0x7F1 PUSH2 0x6C2 JUMP JUMPDEST JUMPDEST PUSH1 0x0 PUSH2 0x800 DUP5 DUP3 DUP6 ADD PUSH2 0x7C7 JUMP JUMPDEST SWAP2 POP POP SWAP3 SWAP2 POP POP JUMP JUMPDEST PUSH1 0x0 DUP3 DUP3 MSTORE PUSH1 0x20 DUP3 ADD SWAP1 POP SWAP3 SWAP2 POP POP JUMP JUMPDEST PUSH32 0x6469646E27742073656E6420656E6F7567682045544800000000000000000000 PUSH1 0x0 DUP3 ADD MSTORE POP JUMP JUMPDEST PUSH1 0x0 PUSH2 0x850 PUSH1 0x16 DUP4 PUSH2 0x809 JUMP JUMPDEST SWAP2 POP PUSH2 0x85B DUP3 PUSH2 0x81A JUMP JUMPDEST PUSH1 0x20 DUP3 ADD SWAP1 POP SWAP2 SWAP1 POP JUMP JUMPDEST PUSH1 0x0 PUSH1 0x20 DUP3 ADD SWAP1 POP DUP2 DUP2 SUB PUSH1 0x0 DUP4 ADD MSTORE PUSH2 0x87F DUP2 PUSH2 0x843 JUMP JUMPDEST SWAP1 POP SWAP2 SWAP1 POP JUMP JUMPDEST PUSH32 0x4E487B7100000000000000000000000000000000000000000000000000000000 PUSH1 0x0 MSTORE PUSH1 0x11 PUSH1 0x4 MSTORE PUSH1 0x24 PUSH1 0x0 REVERT JUMPDEST PUSH1 0x0 PUSH2 0x8C0 DUP3 PUSH2 0x752 JUMP JUMPDEST SWAP2 POP PUSH2 0x8CB DUP4 PUSH2 0x752 JUMP JUMPDEST SWAP3 POP DUP3 DUP3 ADD SWAP1 POP DUP1 DUP3 GT ISZERO PUSH2 0x8E3 JUMPI PUSH2 0x8E2 PUSH2 0x886 JUMP JUMPDEST JUMPDEST SWAP3 SWAP2 POP POP JUMP JUMPDEST PUSH32 0x4E487B7100000000000000000000000000000000000000000000000000000000 PUSH1 0x0 MSTORE PUSH1 0x32 PUSH1 0x4 MSTORE PUSH1 0x24 PUSH1 0x0 REVERT JUMPDEST PUSH1 0x0 PUSH2 0x923 DUP3 PUSH2 0x752 JUMP JUMPDEST SWAP2 POP PUSH32 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF DUP3 SUB PUSH2 0x955 JUMPI PUSH2 0x954 PUSH2 0x886 JUMP JUMPDEST JUMPDEST PUSH1 0x1 DUP3 ADD SWAP1 POP SWAP2 SWAP1 POP JUMP JUMPDEST PUSH32 0x4E487B7100000000000000000000000000000000000000000000000000000000 PUSH1 0x0 MSTORE PUSH1 0x41 PUSH1 0x4 MSTORE PUSH1 0x24 PUSH1 0x0 REVERT JUMPDEST PUSH1 0x0 DUP2 SWAP1 POP SWAP3 SWAP2 POP POP JUMP JUMPDEST POP JUMP JUMPDEST PUSH1 0x0 PUSH2 0x9AA PUSH1 0x0 DUP4 PUSH2 0x98F JUMP JUMPDEST SWAP2 POP PUSH2 0x9B5 DUP3 PUSH2 0x99A JUMP JUMPDEST PUSH1 0x0 DUP3 ADD SWAP1 POP SWAP2 SWAP1 POP JUMP JUMPDEST PUSH1 0x0 PUSH2 0x9CB DUP3 PUSH2 0x99D JUMP JUMPDEST SWAP2 POP DUP2 SWAP1 POP SWAP2 SWAP1 POP JUMP JUMPDEST PUSH32 0x43616C6C206661696C6564000000000000000000000000000000000000000000 PUSH1 0x0 DUP3 ADD MSTORE POP JUMP JUMPDEST PUSH1 0x0 PUSH2 0xA0B PUSH1 0xB DUP4 PUSH2 0x809 JUMP JUMPDEST SWAP2 POP PUSH2 0xA16 DUP3 PUSH2 0x9D5 JUMP JUMPDEST PUSH1 0x20 DUP3 ADD SWAP1 POP SWAP2 SWAP1 POP JUMP JUMPDEST PUSH1 0x0 PUSH1 0x20 DUP3 ADD SWAP1 POP DUP2 DUP2 SUB PUSH1 0x0 DUP4 ADD MSTORE PUSH2 0xA3A DUP2 PUSH2 0x9FE JUMP JUMPDEST SWAP1 POP SWAP2 SWAP1 POP JUMP JUMPDEST PUSH1 0x0 PUSH2 0xA4C DUP3 PUSH2 0x752 JUMP JUMPDEST SWAP2 POP PUSH2 0xA57 DUP4 PUSH2 0x752 JUMP JUMPDEST SWAP3 POP DUP3 DUP3 MUL PUSH2 0xA65 DUP2 PUSH2 0x752 JUMP JUMPDEST SWAP2 POP DUP3 DUP3 DIV DUP5 EQ DUP4 ISZERO OR PUSH2 0xA7C JUMPI PUSH2 0xA7B PUSH2 0x886 JUMP JUMPDEST JUMPDEST POP SWAP3 SWAP2 POP POP JUMP JUMPDEST PUSH32 0x4E487B7100000000000000000000000000000000000000000000000000000000 PUSH1 0x0 MSTORE PUSH1 0x12 PUSH1 0x4 MSTORE PUSH1 0x24 PUSH1 0x0 REVERT JUMPDEST PUSH1 0x0 PUSH2 0xABD DUP3 PUSH2 0x752 JUMP JUMPDEST SWAP2 POP PUSH2 0xAC8 DUP4 PUSH2 0x752 JUMP JUMPDEST SWAP3 POP DUP3 PUSH2 0xAD8 JUMPI PUSH2 0xAD7 PUSH2 0xA83 JUMP JUMPDEST JUMPDEST DUP3 DUP3 DIV SWAP1 POP SWAP3 SWAP2 POP POP JUMP JUMPDEST PUSH1 0x0 PUSH10 0xFFFFFFFFFFFFFFFFFFFF DUP3 AND SWAP1 POP SWAP2 SWAP1 POP JUMP JUMPDEST PUSH2 0xB02 DUP2 PUSH2 0xAE3 JUMP JUMPDEST DUP2 EQ PUSH2 0xB0D JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP JUMP JUMPDEST PUSH1 0x0 DUP2 MLOAD SWAP1 POP PUSH2 0xB1F DUP2 PUSH2 0xAF9 JUMP JUMPDEST SWAP3 SWAP2 POP POP JUMP JUMPDEST PUSH1 0x0 DUP2 SWAP1 POP SWAP2 SWAP1 POP JUMP JUMPDEST PUSH2 0xB38 DUP2 PUSH2 0xB25 JUMP JUMPDEST DUP2 EQ PUSH2 0xB43 JUMPI PUSH1 0x0 DUP1 REVERT JUMPDEST POP JUMP JUMPDEST PUSH1 0x0 DUP2 MLOAD SWAP1 POP PUSH2 0xB55 DUP2 PUSH2 0xB2F JUMP JUMPDEST SWAP3 SWAP2 POP POP JUMP JUMPDEST PUSH1 0x0 DUP2 MLOAD SWAP1 POP PUSH2 0xB6A DUP2 PUSH2 0x7B0 JUMP JUMPDEST SWAP3 SWAP2 POP POP JUMP JUMPDEST PUSH1 0x0 DUP1 PUSH1 0x0 DUP1 PUSH1 0x0 PUSH1 0xA0 DUP7 DUP9 SUB SLT ISZERO PUSH2 0xB8C JUMPI PUSH2 0xB8B PUSH2 0x6C2 JUMP JUMPDEST JUMPDEST PUSH1 0x0 PUSH2 0xB9A DUP9 DUP3 DUP10 ADD PUSH2 0xB10 JUMP JUMPDEST SWAP6 POP POP PUSH1 0x20 PUSH2 0xBAB DUP9 DUP3 DUP10 ADD PUSH2 0xB46 JUMP JUMPDEST SWAP5 POP POP PUSH1 0x40 PUSH2 0xBBC DUP9 DUP3 DUP10 ADD PUSH2 0xB5B JUMP JUMPDEST SWAP4 POP POP PUSH1 0x60 PUSH2 0xBCD DUP9 DUP3 DUP10 ADD PUSH2 0xB5B JUMP JUMPDEST SWAP3 POP POP PUSH1 0x80 PUSH2 0xBDE DUP9 DUP3 DUP10 ADD PUSH2 0xB10 JUMP JUMPDEST SWAP2 POP POP SWAP3 SWAP6 POP SWAP3 SWAP6 SWAP1 SWAP4 POP JUMP JUMPDEST PUSH1 0x0 PUSH2 0xBF6 DUP3 PUSH2 0xB25 JUMP JUMPDEST SWAP2 POP PUSH2 0xC01 DUP4 PUSH2 0xB25 JUMP JUMPDEST SWAP3 POP DUP3 DUP3 MUL PUSH2 0xC0F DUP2 PUSH2 0xB25 JUMP JUMPDEST SWAP2 POP PUSH32 0x8000000000000000000000000000000000000000000000000000000000000000 DUP5 EQ PUSH1 0x0 DUP5 SLT AND ISZERO PUSH2 0xC47 JUMPI PUSH2 0xC46 PUSH2 0x886 JUMP JUMPDEST JUMPDEST DUP3 DUP3 SDIV DUP5 EQ DUP4 ISZERO OR PUSH2 0xC5C JUMPI PUSH2 0xC5B PUSH2 0x886 JUMP JUMPDEST JUMPDEST POP SWAP3 SWAP2 POP POP JUMP INVALID LOG2 PUSH5 0x6970667358 0x22 SLT KECCAK256 STATICCALL REVERT SUB PUSH9 0x3BDAF11C4886FC9914 SWAP8 0xCB PUSH10 0xC7AC83ADC1FCE755CDC3 0xE4 0x49 PUSH28 0x339ED464736F6C634300081300330000000000000000000000000000 ",
//     "sourceMap": "19262:2166:1:-:0;;;19536:52;;;;;;;;;;19570:10;19560:20;;;;;;;;;;19262:2166;;;;;;;;;;;;;;;;;"
// }
//- object property is contract in pure bytecode.
//- opcodes is bytecode converted to opcodes. opcode is the low level computer assembly level instruction that are actually executing what our smart contract should do.
//* "PUSH1 0xA0 PUSH1 0x40 MSTORE CALLVALUE DUP1" each one of this low level code has gas associated with them.
//* let go to https://www.evm.codes/?fork=shanghai to view the opcode gas
//* you will see that read and write from memory is very cheaper than read and write
//from storage like this
//MLOAD (Load word from memory)  Minimum Gas of 3
//MSTORE (Save word to memory)  Minimum Gas of 3
//MSTORE8 (Save byte to memory) Minimum Gas of 3
//SLOAD (Load word from storage) Minimum Gas of 100
//SSTORE (Save word to storage) Minimum Gas of 100
//- back to FundMe.sol contract to optimize gas

//=====================
//Gas Optimization
//- let test cheaperWithdraw() function

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        console.log(fundMe.getOwner());
        console.log(msg.sender);
        console.log(address(this));
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughETH() public {
        vm.expectRevert();
        fundMe.fund();
    }

    function testFundUpdatesFundedDataStructure() public funded {
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

    function testAddsFunderToArrayOfFunders() public funded {
        address funder = fundMe.getFunder(0);
        // console.log(USER);
        // console.log(funder);
        assertEq(funder, USER);
    }

    function testOnlyOwnerCanWithdraw() public funded {
        vm.expectRevert();
        fundMe.withdraw();
    }

    function testWithDrawWithASingleFunder() public funded {
        //* Arrange or setup
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        //* Act or action
        uint256 gasStart = gasleft(); //gasleft() is a build-in function in solidity. It tell us how much gas is left in the transaction call.
        vm.txGasPrice(GAS_PRICE);
        // vm.prank(fundMe.getOwner());
        vm.prank(USER);
        fundMe.withdraw();

        uint256 gasEnd = gasleft();
        uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice; //tx.gasprice is a build-in solidity constant that tell us the current gas price
        console.log(gasUsed); //its return 9956 gas

        //* Assert or compare
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingFundMeBalance = address(fundMe).balance;
        assertEq(endingFundMeBalance, 0);
        // assertEq(
        //     startingFundMeBalance + startingOwnerBalance,
        //     endingOwnerBalance
        // );
    }

    function testWithdrawFromMultipleFunders() public funded {
        //Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;
        for (uint160 i = startingFunderIndex; i < numberOfFunders; i++) {
            hoax(address(i), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }

        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingFundMeBalance = address(fundMe).balance;

        //Act
        // vm.startPrank(fundMe.getOwner());
        vm.startPrank(USER);
        fundMe.withdraw();
        vm.stopPrank();

        //Assert
        assert(address(fundMe).balance == 0);
        // assert(
        //     startingFundMeBalance + startingOwnerBalance ==
        //         fundMe.getOwner().balance
        // );
    }

    function testWithdrawFromMultipleFundersCheaper() public funded {
        //Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;
        for (uint160 i = startingFunderIndex; i < numberOfFunders; i++) {
            hoax(address(i), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }

        // uint256 startingOwnerBalance = fundMe.getOwner().balance;
        // uint256 startingFundMeBalance = address(fundMe).balance;

        //Act
        // vm.startPrank(fundMe.getOwner());
        vm.startPrank(USER);
        fundMe.cheaperWithdraw();
        vm.stopPrank();

        //Assert
        assert(address(fundMe).balance == 0);
        // assert(
        //     startingFundMeBalance + startingOwnerBalance ==
        //         fundMe.getOwner().balance
        // );
    }

    //- let view how much gas it cost each function
    //adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge snapshot
    //- click on .gas-snapshot file to view the updated gas price different

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }
}

//- Integration tests
//- using forge script inorder to have a reproducible way of funding and withdraw
//- let create Interactions.s.sol file inside script folder inorder to interact with the
//FundMe contract
