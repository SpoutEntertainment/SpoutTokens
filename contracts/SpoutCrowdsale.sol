pragma solidity ^0.4.17;

import './SpoutToken.sol';
import 'zeppelin-solidity/contracts/crowdsale/Crowdsale.sol';


contract SpoutCrowdsale is Crowdsale {

  function SpoutCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet)
    Crowdsale(_startTime, _endTime, _rate, _wallet) {
  }

  // creates the token to be sold.
  // override this method to have crowdsale of a specific MintableToken token.
  function createTokenContract() internal returns (MintableToken) {
    return new SpoutToken();
  }
}
