const SpoutMintableToken = artifacts.require('./SpoutMintableToken')
const SpoutCrowdsale = artifacts.require('./SpoutCrowdsale.sol')

module.exports = function(deployer, network, accounts) {
  const presaleRate = new web3.BigNumber(1000);
  const icoRate = new web3.BigNumber(800);
  const wallet = accounts[0];

  deployer.deploy(SpoutMintableToken)
    .then(() => {
      return deployer.deploy(
        SpoutCrowdsale,
        SpoutMintableToken.address,
        presaleRate,
        icoRate,
        wallet
      )
    })
    .then(() => {
      return SpoutMintableToken.deployed()
    })
    .then((token) => {
      return token.transferOwnership(SpoutCrowdsale.address)
    });
};
