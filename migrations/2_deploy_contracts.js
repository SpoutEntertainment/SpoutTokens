const SpoutCoinCrowdsale = artifacts.require("./SpoutCoinCrowdsale.sol")

module.exports = function(deployer, network, accounts) {
  const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 120
  const endTime = startTime + 86400 // 1 day
  const rate = new web3.BigNumber(1000)
  const wallet = accounts[0]

  deployer.deploy(SpoutCoinCrowdsale, startTime, endTime, rate, wallet)
};
