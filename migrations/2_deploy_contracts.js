const SpoutCappedCrowdsale = artifacts.require("./SpoutCappedCrowdsale.sol")

module.exports = function(deployer, network, accounts) {
  const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 120
  const endTime = startTime + 86400 // 1 day
  const rate = new web3.BigNumber(1000)
  const cap = new web3.BigNumber(web3.toWei(1000000, 'ether'))
  const wallet = accounts[0]

  deployer.deploy(SpoutCappedCrowdsale, startTime, endTime, rate, cap, wallet)
};
