# flightsurety-ethdapp-insurance

Dapp to manage smart contracts for delay insurance for passengers. 


## Description

This Project explores the development a Ethereum blockchain based Dapp to manage smart contracts for delay insurance for passengers. This app uses solidity oracles to check flights state.

## Dapp Requirements

- Passengers can buy an insurance prior to flight
- If flights are delayed due to airline fault, passengers are paid with 1.5 times the price paid
- Register first airline when contract is deployed
- Only existing airline may register a new airline until there are at least four airlines registered
- Registration of fifth and subsequent airlines requires multi-party consensus of 50% of registered airlines
- Airline can be registered but does not participate in contract until it submits funding of 10 ether
- Passengers may pay up to 1 ether for purchasing flight insurance
- Flight numbers and timestamps are fixed for the purpose of the project and can be defined in the Dapp client
- Contracts must have operations status control
- Functions must fail fast - use require() at the start of functions
- Scaffolding code is provided ut you are free to replace it with your own code
