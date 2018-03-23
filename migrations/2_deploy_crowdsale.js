const SpoutMintableToken = artifacts.require('./SpoutMintableToken')
const SpoutCrowdsale = artifacts.require('./SpoutCrowdsale.sol')

const duration = {
  seconds: function (val) { return val; },
  minutes: function (val) { return val * this.seconds(60); },
  hours: function (val) { return val * this.minutes(60); },
  days: function (val) { return val * this.hours(24); },
  weeks: function (val) { return val * this.days(7); },
  years: function (val) { return val * this.days(365); },
};

module.exports = function(deployer, network, accounts) {
  // const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + parseInt(process.env.START_TIME)
  // const endTime = startTime + parseInt(process.env.CONTRACT_DURATION) // 1 day
  // const rate = new web3.BigNumber(parseInt(process.env.CONTRACT_RATE))
  // const cap = new web3.BigNumber(web3.toWei(parseInt(process.env.CONTRACT_CAP), 'ether'))
  // const wallet = accounts[0]
  const presaleOpeningTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 120;
  const presaleClosingTime = presaleOpeningTime + duration.days(30);
  const presaleRate = new web3.BigNumber(5);
  const presaleCap = new web3.BigNumber(web3.toWei(100, 'ether'));

  const icoOpeningTime = presaleClosingTime + duration.minutes(5);
  const icoClosingTime = icoOpeningTime + duration.days(30);
  const icoRate = new web3.BigNumber(3);
  const icoCap = new web3.BigNumber(web3.toWei(100, 'ether'));

  const wallet = accounts[0]

  deployer.deploy(SpoutMintableToken)
    .then(() => {
      return deployer.deploy(
        SpoutCrowdsale,
        SpoutMintableToken.address,
        presaleRate,
        icoRate,
        presaleOpeningTime,
        presaleClosingTime,
        icoOpeningTime,
        icoClosingTime,
        presaleCap,
        icoCap,
        wallet
      )
    })
    .then(() => {
      return SpoutMintableToken.deployed()
    })
    .then((token) => {
      return token.transferOwnership(SpoutCrowdsale.address)
    })
};
