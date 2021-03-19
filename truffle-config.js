
const HDWalletProvider = require("@truffle/hdwallet-provider");
const fs = require('fs');
const mnemonicPhrase = "candy maple cake sugar pudding cream honey rich smooth crumble sweet treat";


module.exports = {

    networks: {
        development: {
            host: "127.0.0.1",  
            port: 8545,
            network_id: "*", 
        },
    },

    compilers: {
        solc: {
          version: "0.7.6",
          settings: {
            optimizer: {
              enabled: true,
              runs: 200
            }
          }
        }
      }
}
