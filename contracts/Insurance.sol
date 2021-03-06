// Contracts/Airline.sol
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6 <0.8.1;

import "./InsurancePolicy.sol";

contract Airline {
    
    /********************************************************************************************/
    /*                                       DATA VARIABLES                                     */
    /********************************************************************************************/
    
    mapping (address => Airline) internal airlines; // Mapping with airlines list

    struct AirlineData {
        bytes32 airlineName; // Airline name
        AirlineState state; // Arline state
        address[] votedBy; // for multi-party consensus
        uint deposit; // Eth deposit
    }

    enum AirlineState {
        Requested, // 0 Arline register requesting 
        Approved, // 1 Arline approved 
        Active // 2 Airline active to operate
    }

    /********************************************************************************************/
    /*                                       FUNCTION MODIFIERS                                 */
    /********************************************************************************************/

    modifier onlyRegistrationRequested(address account) {
        require(isRegistrationRequested(account), "Airline must be BeforeEntry state");
        _;
    }

    modifier onlyApproved(address account) {
        require(isEntried(account), "Airline must be Entried state");
        _;
    }

    modifier onlyActive(address account) {
        require(isRegistered(account), "Airline must be Registered state");
        _;
    }

    function isRegistrationRequested(address account)
        internal
        view
        returns(bool)
    {
        return airlines[account].state == AirlineState.RegistrationRequested;
    }

    function isEntried(address account)
        internal
        view
        returns(bool)
    {
        return airlines[account].status == AirlineStatus.Entried;
    }

    function isRegistered(address account)
        internal
        view
        returns(bool)
    {
        return airlines[account].status == AirlineStatus.Registered;
    }

    function entry(address account)
        internal
        onlyBeforeEntry(account)
    {
        Airline memory airline = Airline(AirlineStatus.Entried, new address[](0), 0);
        airlines[account] = airline;
    }

    function voted(address account, address from)
        internal
        onlyEntried(account)
        onlyRegistered(from)
    {
        bool isDuplicate = false;
        for(uint i = 0; i < airlines[account].votedBy.length; i++) {
            if (airlines[account].votedBy[i] == from) {
                isDuplicate = true;
                break;
            }
        }
        require(!isDuplicate, "Already voted from this airline");

        airlines[account].votedBy.push(from);
    }

    function register(address account)
        internal
        onlyEntried(account)
    {
        airlines[account].status = AirlineStatus.Registered;
        registeredAirlineCount++;
    }

    function fund(address account, uint amount)
        internal
        onlyRegistered(account)
    {
        airlines[account].deposit += amount;
    }
}