//SPDX-License-Identifier:MIT
// pragma solidity ^0.8.18;

// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// import {PriceConverter} from "./PriceConverter.sol";

// error FundMe__NotOwner();

// contract FundMe {
//     using PriceConverter for uint256;

//     uint256 public constant MINIMUM_USD = 5 * 1e18;
//     address[] public funders;
//     mapping(address funder => uint256 amountFunded)
//         public addressToAmountFunded;
//     address public immutable i_owner;

//     constructor() {
//         i_owner = msg.sender;
//     }

//     function fund() public payable {
//         require(
//             msg.value.getConversionRate() >= MINIMUM_USD,
//             "didn't send enough ETH"
//         );
//         funders.push(msg.sender);
//         addressToAmountFunded[msg.sender] += msg.value;
//     }

//     function getVersion() public view returns (uint256) {
//         AggregatorV3Interface priceFeed = AggregatorV3Interface(
//             0x694AA1769357215DE4FAC081bf1f309aDC325306
//         );
//         return priceFeed.version();
//     }

//     function withdraw() public onlyOwner {
//         for (
//             uint256 funderIndex = 0;
//             funderIndex < funders.length;
//             funderIndex++
//         ) {
//             address funder = funders[funderIndex];
//             addressToAmountFunded[funder] = 0;
//         }
//         funders = new address[](0);

//         (bool callSuccess, ) = payable(msg.sender).call{
//             value: address(this).balance
//         }("");
//         require(callSuccess, "Call failed");
//     }

//     modifier onlyOwner() {
//         if (msg.sender == i_owner) {
//             revert FundMe__NotOwner();
//         }
//         _;
//     }

//     receive() external payable {
//         fund();
//     }

//     fallback() external payable {
//         fund();
//     }
// }

//- after copying and pasing of FundMe contract and PriceConverter library from Remix IDE
//- let compile our code like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge compile
//* its throw an error of
//Unable to resolve imports:
//"@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"
//- let install chainlink like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit
//* expand lib folder to view the chainlink-brownie-contracts library
//- open foundry.toml file to add remappings array of string inorder to inorder to tell foundry
//to point to  lib/chainlink-brownie-contracts/contracts/ anytime it see @chainlink/contracts like this
//remappings=["@chainlink/contracts/=lib/chainlink-brownie-contracts/contracts/"]
//its means when foundry see this @chainlink/contracts/ path replace its with lib/chainlink-brownie-contracts/contracts/
//- let rebuild or recompile the contract like this
//adduser@LAPTOP-EM3P6O44:~/foundry-f23/foundry-fund-me-f23$ forge compile
//its compile successful and generate out folder which contain all the compile contracts

//- add contract name before the custom error inorder to easily know where an error came from like this
//error FundMe__NotOwner();

//Tests
//- writing test is very critical when it comes to contract development.
//* create FundMeTest.t.sol inside test folder

//=============
//Refactoring I: Testing Deploy Scripts
//- Let refactoring FundMe contract inorder to be able to deploy the AggregatorV3Interface
//contract to any chain other than Sepolia chain

// pragma solidity ^0.8.18;

// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// import {PriceConverter} from "./PriceConverter.sol";

// error FundMe__NotOwner();

// contract FundMe {
//     using PriceConverter for uint256;

//     uint256 public constant MINIMUM_USD = 5 * 1e18;
//     address[] private s_funders;
//     mapping(address funder => uint256 amountFunded)
//         private s_addressToAmountFunded;
//     address public immutable i_owner;
//     AggregatorV3Interface private s_priceFeed;

//     constructor(address priceFeed) {
//         i_owner = msg.sender;
//         s_priceFeed = AggregatorV3Interface(priceFeed);
//     }

//     function fund() public payable {
//         require(
//             msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, //s_priceFeed represent the 2nd parameter of getConversionRate()
//             "didn't send enough ETH"
//         );
//         s_funders.push(msg.sender);
//         s_addressToAmountFunded[msg.sender] += msg.value;
//     }

//     function getVersion() public view returns (uint256) {
//         // AggregatorV3Interface priceFeed = AggregatorV3Interface(
//         //     0x694AA1769357215DE4FAC081bf1f309aDC325306
//         // );
//         //replace the above AggregatorV3Interface with s_priceFeed state variable
//         return s_priceFeed.version();
//     }

//     function withdraw() public onlyOwner {
//         for (
//             uint256 funderIndex = 0;
//             funderIndex < s_funders.length;
//             funderIndex++
//         ) {
//             address funder = s_funders[funderIndex];
//             addressToAmountFunded[funder] = 0;
//         }
//         s_funders = new address[](0);

//         (bool callSuccess, ) = payable(msg.sender).call{
//             value: address(this).balance
//         }("");
//         require(callSuccess, "Call failed");
//     }

//     modifier onlyOwner() {
//         if (msg.sender == i_owner) {
//             revert FundMe__NotOwner();
//         }
//         _;
//     }

//     receive() external payable {
//         fund();
//     }

//     fallback() external payable {
//         fund();
//     }
// }
//-  add constructor parameter onto FundMe contract inside DeployFundMe.s.sol and
//FundMeTest.t.sol contract

//========================
//Refactor FundMe
//- let change these public visibility to private becos its gas efficient
//- let add getter function

// pragma solidity ^0.8.18;

// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// import {PriceConverter} from "./PriceConverter.sol";

// error FundMe__NotOwner();

// contract FundMe {
//     using PriceConverter for uint256;

//     uint256 public constant MINIMUM_USD = 5 * 1e18;
//     address[] private s_funders;
//     mapping(address funder => uint256 amountFunded)
//         private s_addressToAmountFunded;
//     address private immutable i_owner;
//     AggregatorV3Interface private s_priceFeed;

//     constructor(address priceFeed) {
//         i_owner = msg.sender;
//         s_priceFeed = AggregatorV3Interface(priceFeed);
//     }

//     function fund() public payable {
//         require(
//             msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, //s_priceFeed represent the 2nd parameter of getConversionRate()
//             "didn't send enough ETH"
//         );
//         s_funders.push(msg.sender);
//         s_addressToAmountFunded[msg.sender] += msg.value;
//     }

//     function getVersion() public view returns (uint256) {
//         return s_priceFeed.version();
//     }

//     function withdraw() public onlyOwner {
//         for (
//             uint256 funderIndex = 0;
//             funderIndex < s_funders.length;
//             funderIndex++
//         ) {
//             address funder = s_funders[funderIndex];
//             s_addressToAmountFunded[funder] = 0;
//         }
//         s_funders = new address[](0);

//         (bool callSuccess, ) = payable(msg.sender).call{
//             value: address(this).balance
//         }("");
//         require(callSuccess, "Call failed");
//     }

//     modifier onlyOwner() {
//         if (msg.sender == i_owner) {
//             revert FundMe__NotOwner();
//         }
//         _;
//     }

//     receive() external payable {
//         fund();
//     }

//     fallback() external payable {
//         fund();
//     }

//     // View / Pure functions (Getters)

//     function getAddressToAmountFunded(
//         address fundingAddress
//     ) external view returns (uint256) {
//         return s_addressToAmountFunded[fundingAddress];
//     }

//     function getFunder(uint256 index) external view returns (address) {
//         return s_funders[index];
//     }

//     function getOwner() external view returns (address) {
//         return i_owner;
//     }
// }

//==========================
//Optimization of Gas

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error FundMe__NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5 * 1e18;
    address[] private s_funders;
    mapping(address funder => uint256 amountFunded)
        private s_addressToAmountFunded;
    address private immutable i_owner;
    AggregatorV3Interface private s_priceFeed;

    constructor(address priceFeed) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, //s_priceFeed represent the 2nd parameter of getConversionRate()
            "didn't send enough ETH"
        );
        s_funders.push(msg.sender);
        s_addressToAmountFunded[msg.sender] += msg.value;
    }

    function getVersion() public view returns (uint256) {
        return s_priceFeed.version();
    }

    function cheaperWithdraw() public onlyOwner {
        uint256 fundersLength = s_funders.length; //here we read s_funders.length once from storage
        for (
            uint256 funderIndex = 0;
            funderIndex < fundersLength;
            funderIndex++
        ) {
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }
        s_funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed");
    }

    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < s_funders.length; //anytime we read the s_funders.length is reading from storage which is 100 gas and that is very expensive
            funderIndex++
        ) {
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }
        s_funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner() {
        if (msg.sender == i_owner) {
            revert FundMe__NotOwner();
        }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

    // View / Pure functions (Getters)

    function getAddressToAmountFunded(
        address fundingAddress
    ) external view returns (uint256) {
        return s_addressToAmountFunded[fundingAddress];
    }

    function getFunder(uint256 index) external view returns (address) {
        return s_funders[index];
    }

    function getOwner() external view returns (address) {
        return i_owner;
    }
}
