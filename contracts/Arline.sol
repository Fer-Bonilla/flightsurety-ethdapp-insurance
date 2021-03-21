// Contracts/Airline.sol
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6 <0.8.1;

import "./FlightSuretyData.sol";
import "./InsurancePolicy.sol";

contract Airline {

    /********************************************************************************************/
    /*                                       DATA VARIABLES                                     */
    /********************************************************************************************/    

    FlightSuretyData SuretyData;

    struct AirlineData {
        address airlineAddress // Airline address
        bytes32 airlineName; // Airline name
        AirlineState state; // Arline state
        address[] votedBy; // for multi-party consensus
        uint deposit; // Eth deposit
    }

    enum AirlineState {
        Requested, // 0 Arline requesting register
        Approved, // 1 Arline approved 
        Active // 2 Airline active to operate
    }

    /********************************************************************************************/
    /*                                       FUNCTION MODIFIERS                                 */
    /********************************************************************************************/

    /**
     * @dev This Modifier validates that Airline's Address is not registered yet in the Smart Contract
     */

    modifier onlyNotRegistered(address airlineAccount) {
        require(isNotRegistered(airlineAccount), "Airline is registered, can't be registered again");
        _;
    }

    /**
     * @dev This Modifier validates that Airline´s state is Requested
     */

    modifier onlyRequested(address airlineAccount) {
        require(isRequested(airlineAccount), "Airline must be have a request register state first");
        _;
    }

    /**
     * @dev This Modifier validates that Airline´s state is Approved
     */

    modifier onlyApproved(address airlineAccount) {
        require(isApproved(airlineAccount), "Airline must be be approved first");
        _;
    }

    /**
     * @dev This Modifier validates that Airline´s state is Active
     */

    modifier onlyActive(address airlineAccount) {
        require(isActive(airlineAccount), "Airline must be Approved first");
        _;
    }

    function isNotRegistered(address airlineAccount)
        internal
        view
        returns(bool)
    {
        return airlines[airlineAccount] != NULL;
    }

    function isRequested(address airlineAccount)
        internal
        view
        returns(bool)
    {
        return airlines[airlineAccount].state == AirlineState.Requested;
    }

    function isApproved(address airlineAccount)
        internal
        view
        returns(bool)
    {
        return airlines[airlineAccount].state == AirlineState.Approved;
    }

    function isActive(address airlineAccount)
        internal
        view
        returns(bool)
    {
        return airlines[airlineAccount].state == AirlineState.Active;
    }

    /********************************************************************************************/
    /*                                     SMART CONTRACT FUNCTIONS                             */
    /********************************************************************************************/

    /**
     * @dev This Function register the Airline Addres in the contract and set state to Requested
     */
    function requestRegistration(address airlineAccount, bytes32 airlineName)
        internal
        onlyNotRegistered(airlineAccount)
    {
        AirlineData memory newAirline = AirlineData(AirlineStatus.Entried, new address[](0), 0);
        SuretyData.addArline(newAirline);
    }

    /**
     * @dev This Function register the Airline Addres in the contract and set state to Requested
     */
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