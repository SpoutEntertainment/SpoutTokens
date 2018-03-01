// const SpoutMintableToken = artifacts.require("./SpoutMintableToken.sol")
// const SpoutCappedCrowdsale = artifacts.require("./SpoutCappedCrowdsale")
// const SpoutRefundableCrowdsale = artifacts.require("./SpoutRefundableCrowdsale.sol")
//
// module.exports = function(deployer, network, accounts) {
//   const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 1
//   const endTime = startTime + 86400 // 1 day
//   const rate = new web3.BigNumber(1000)
//   const goal = new web3.BigNumber(web3.toWei(1000000, 'ether'))
//   const cap = new web3.BigNumber(web3.toWei(1000000, 'ether'))
//   const wallet = accounts[0]
//
//   let refund, capped
//   return deployer.deploy(SpoutRefundableCrowdsale, startTime, endTime, rate, goal, cap, wallet, SpoutMintableToken.address)
//     .then(() => {
//       return SpoutRefundableCrowdsale.deployed()
//     })
//     .then((r) => {
//       refund = r
//       return SpoutCappedCrowdsale.deployed()
//     })
//     .then((c) => {
//       capped = c
//       return capped.transferTokenOwnership(refund.address)
//     })
//     .then(r => console.log(r))
// };
//
