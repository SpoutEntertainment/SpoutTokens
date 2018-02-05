pragma solidity ^0.4.17;

import './SpoutMintableToken.sol';
import 'zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';


contract SpoutCappedCrowdsale is CappedCrowdsale {

  function SpoutCappedCrowdsale(
    uint256 _startTime,
    uint256 _endTime,
    uint256 _rate,
    uint256 _cap,
    address _wallet
  ) public
    Crowdsale(_startTime, _endTime, _rate, _wallet)
    CappedCrowdsale(_cap)
  {
  }

  // creates the token to be sold.
  // override this method to have crowdsale of a specific MintableToken token.
  function createTokenContract() internal returns (MintableToken) {
    return new SpoutMintableToken();
  }

  function mintTo(address beneficiary, uint256 _amount) external returns (bool) {
    return token.mint(beneficiary, _amount);
  }
}
