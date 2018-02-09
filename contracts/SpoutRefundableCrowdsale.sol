pragma solidity ^0.4.17;

import './SpoutMintableToken.sol';
import 'zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';
import 'zeppelin-solidity/contracts/crowdsale/RefundableCrowdsale.sol';


contract SpoutRefundableCrowdsale is CappedCrowdsale, RefundableCrowdsale {

  address public spoutTokenAddress;

  function SpoutRefundableCrowdsale(
    uint256 _startTime,
    uint256 _endTime,
    uint256 _rate,
    uint256 _goal,
    uint256 _cap,
    address _wallet,
    address _spoutTokenAddress
  ) public
    Crowdsale(_startTime, _endTime, _rate, _wallet)
    CappedCrowdsale(_cap)
    RefundableCrowdsale(_goal)
  {
    // require(_goal <= _cap);
    spoutTokenAddress = _spoutTokenAddress;
    token = createTokenContract();
  }

  // creates the token to be sold.
  // override this method to have crowdsale of a specific MintableToken token.
  function createTokenContract() internal returns (MintableToken) {
    return SpoutMintableToken(spoutTokenAddress);
  }

}

