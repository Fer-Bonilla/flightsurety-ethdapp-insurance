// Contracts/FlightSuretyApp.sol
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6 <0.8.1;

/**
* @dev This contract define the Insurance Policy parameters for 
* Insurance Dapp. Policy updates require only this contract update.
*/

contract InsurancePolicy {

    // Flight status codes
    uint8 private constant STATUS_CODE_UNKNOWN = 0;
    uint8 private constant STATUS_CODE_ON_TIME = 10;
    uint8 private constant STATUS_CODE_LATE_AIRLINE = 20;
    uint8 private constant STATUS_CODE_LATE_WEATHER = 30;
    uint8 private constant STATUS_CODE_LATE_TECHNICAL = 40;
    uint8 private constant STATUS_CODE_LATE_OTHER = 50;

    // Insurance policy parameters
    uint256 private MINIMUN_AIRLINE_REGISTRATION_FEE =  10 ether;
    
    uint256 public constant REGISTRATION_FEE = 1 ether; // Fee to be paid when registering oracle
    uint256 private constant MIN_RESPONSES = 3; // Number of oracles that must respond for valid status

    uint256 private MAX_COVERAGEE =  1 ether; 
    uint256 private CONSENSUS = 4; 
    uint256 private CONSENSUS_RULE = 5; 
    uint8 private INSURANCE_MULTIPLIER = 0.5;

    
    

    
    

}
