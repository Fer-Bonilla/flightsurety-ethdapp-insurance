// Contracts/Ticket.sol
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6 <0.8.1;

import "./InsurancePolicy.sol";

contract Ticket {
    mapping (address => Airline) internal airlines;

    
    address airline; // Airline address
    address flight; // Airline address
    address passenger; // Passenger address
    uint price; // Ticket price

        bytes32 airlineName; // Airline name
        AirlineState state; // Arline state
        address[] votedBy; // for multi-party consensus
        uint deposit; // Eth deposit
    }



    enum AirlineState {
        RegistrationRequested, // 0 Arline requesting register
        Approved, // 1 Arline approved 
        Active // 2 Airline active to operate
    }

    uint internal registeredAirlineCount = 0;

    modifier onlyRegistrationRequested(address account) {
        require(isBeforeEntry(account), "Airline must be BeforeEntry state");
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

    function isBeforeEntry(address account)
        internal
        view
        returns(bool)
    {
        return airlines[account].status == AirlineStatus.BeforeEntry;
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