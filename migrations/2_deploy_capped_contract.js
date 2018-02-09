const SpoutMintableToken = artifacts.require('./SpoutMintableToken')
const SpoutCappedCrowdsale = artifacts.require('./SpoutCappedCrowdsale.sol')

module.exports = function(deployer, network, accounts) {
  const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 1
  const endTime = startTime + 86400 // 1 day
  const rate = new web3.BigNumber(1000)
  const cap = new web3.BigNumber(web3.toWei(1000000, 'ether'))
  const wallet = accounts[0]

  let token

  deployer.deploy(SpoutMintableToken)
    .then(() => {
      return deployer.deploy(SpoutCappedCrowdsale, startTime, endTime, rate, cap, wallet, SpoutMintableToken.address)
    })
    .then(() => {
      return SpoutMintableToken.deployed()
    })
    .then((t) => {
      token = t
      return SpoutCappedCrowdsale.deployed()
    })
    .then((sale) => {
      return token.transferOwnership(sale.address)
    })
  // deployer.deploy(SpoutMintableToken).then(function() {
  //   return deployer.deploy(SpoutCappedCrowdsale, startTime, endTime, rate, cap, wallet, SpoutMintableToken.address)
  // })
  // return deployer.deploy(SpoutCappedCrowdsale, startTime, endTime, rate, cap, wallet);
};
