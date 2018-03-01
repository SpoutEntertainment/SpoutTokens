pragma solidity ^0.4.17;

import './SpoutMintableToken.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol';


contract SpoutCappedCrowdsale is CappedCrowdsale, Ownable {

  address public spoutTokenAddress;

  uint256 minValue;

  function SpoutCappedCrowdsale(
    uint256 _startTime,
    uint256 _endTime,
    uint256 _rate,
    uint256 _cap,
    address _wallet,
    address _spoutTokenAddress,
    uint256 _minValue
  ) public
    Crowdsale(_startTime, _endTime, _rate, _wallet)
    CappedCrowdsale(_cap)
  {
    spoutTokenAddress = _spoutTokenAddress;
    token = createTokenContract();
    minValue = _minValue;
  }

  // creates the token to be sold.
  // override this method to have crowdsale of a specific MintableToken token.
  function createTokenContract() internal returns (MintableToken) {
    return SpoutMintableToken(spoutTokenAddress);
    // return new SpoutMintableToken();
  }

  function mintTo(address beneficiary, uint256 _amount) onlyOwner public returns (bool) {
    return token.mint(beneficiary, _amount);
  }

  function transferTokenOwnership(address newOwner) onlyOwner public {
    token.transferOwnership(newOwner);
  }

  function validPurchase() internal view returns (bool) {
       bool greaterThanMinInvestment = msg.value >= minValue;
      return super.validPurchase() && greaterThanMinInvestment ;
  }
}
