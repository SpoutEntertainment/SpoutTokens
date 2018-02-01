const Web3 = require("web3");
const web3 = new Web3();

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    rinkeby: {
      host: "localhost",
      port: 8545,
      network_id: "4",
      from: "0x5f7a2e367da8588172567ff6915e648b69e09b4f",
      gas: 6712390
      // gasPrice: web3.toWei("100", "gwei")
    },
    ropsten: {
      host: "localhost",
      port: 8545,
      network_id: 3,
      // from: "0x9f6d05b40efa89b595c2318ddbee4cb1b8dd44c1",
      gas: 6712390
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
};
