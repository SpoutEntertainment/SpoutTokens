const SpoutMintableToken = artifacts.require('./SpoutMintableToken')
const SpoutCappedCrowdsale = artifacts.require('./SpoutCappedCrowdsale.sol')

module.exports = function(deployer, network, accounts) {
  const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + parseInt(process.env.START_TIME)
  const endTime = startTime + parseInt(process.env.CONTRACT_DURATION) // 1 day
  const rate = new web3.BigNumber(parseInt(process.env.CONTRACT_RATE))
  const cap = new web3.BigNumber(web3.toWei(parseInt(process.env.CONTRACT_CAP), 'ether'))
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
