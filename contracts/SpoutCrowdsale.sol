pragma solidity ^0.4.17;

import './SpoutMintableToken.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

contract SpoutCrowdsale is Ownable {
  using SafeMath for uint256;

  MintableToken public token;

  address public wallet;

  uint256 public presaleRate;

  uint256 public icoRate;

  uint256 presaleOpeningTime;

  uint256 presaleClosingTime;

  uint256 icoOpeningTime;

  uint256 icoClosingTime;

  uint256 public presaleCap;

  uint256 public icoCap;

  uint256 public presaleWeiRaised;

  uint256 public icoWeiRaised;

  // Min contribution is 0.1 ether
  uint256 public constant MINIMUM_CONTRIBUTION = 10**17;

  enum Phases {
    Preparing,
    Presale,
    PresaleFinalized,
    ICO,
    ICOFinalized,
    Success,
    Failure
  }

  Phases public phase;

  function SpoutCrowdsale(
    address _token,
    uint256 _presaleRate,
    uint256 _icoRate,
    uint256 _presaleOpeningTime,
    uint256 _presaleClosingTime,
    uint256 _icoOpeningTime,
    uint256 _icoClosingTime,
    uint256 _presaleCap,
    uint256 _icoCap,
    address _wallet
  ) {
    require(_token != address(0));
    require(_wallet != address(0));
    require(_presaleRate > 0);
    require(_icoRate > 0);
    require(_presaleOpeningTime > now);
    require(_icoOpeningTime > _presaleOpeningTime);
    require(_icoOpeningTime > _presaleClosingTime);

    token = SpoutMintableToken(_token);
    wallet = _wallet;

    presaleCap = _presaleCap;
    presaleRate = _presaleRate;
    presaleOpeningTime = _presaleOpeningTime;
    presaleClosingTime = _presaleClosingTime;

    icoCap = _icoCap;
    icoRate = _icoRate;
    icoOpeningTime = _icoOpeningTime;
    icoClosingTime = _icoClosingTime;

    phase = Phases.Preparing;
  }

  function () external payable {
    if (isPresalePeriod()) {
      if (phase == Phases.Preparing) {
        phase = Phases.Presale;
      }

      buyTokens(msg.sender, msg.value);
    } else if (isICOPeriod()) {
      if (phase == Phases.PresaleFinalized) {
        phase = Phases.ICO;
      }

      buyTokens(msg.sender, msg.value);
    } else {
      revert();
    }
  }

  function buyTokens(address _beneficiary, uint256 _weiAmount) internal {
    require(_beneficiary != address(0));
    require(_weiAmount >= MINIMUM_CONTRIBUTION);

    uint256 rate;
    if (isPhasePresale()) {
      rate = presaleRate;
    } else if (isPhaseICO()) {
      rate = icoRate;
    } else {
      rate = 0;
    }

    uint256 tokens = _getTokenAmount(_weiAmount, rate);
    require(tokens != 0);

    if (isPhasePresale()) {
      require(presaleWeiRaised.add(_weiAmount) <= presaleCap);
      presaleWeiRaised = presaleWeiRaised.add(_weiAmount);
    } else if (isPhaseICO()) {
      require(icoWeiRaised.add(_weiAmount) <= icoCap);
      icoWeiRaised = icoWeiRaised.add(_weiAmount);
    }

    token.mint(_beneficiary, tokens);

    _forwardFunds();
  }

  function _forwardFunds() internal {
    wallet.transfer(msg.value);
  }

  function _getTokenAmount(uint256 _weiAmount, uint256 _rate) internal returns (uint256) {
    return _weiAmount.mul(_rate);
  }

  function isPhasePresale() constant returns (bool) {
    return phase == Phases.Presale;
  }

  function isPresalePeriod() constant returns (bool) {
    if (presaleWeiRaised > presaleCap || now >= presaleClosingTime) {
      phase = Phases.PresaleFinalized;
      return false;
    }

    return now > presaleOpeningTime;
  }

  function isPhaseICO() constant returns (bool) {
    return phase == Phases.ICO;
  }

  function isICOPeriod() constant returns (bool) {
    if (icoWeiRaised > icoCap || now >= icoClosingTime) {
      phase = Phases.ICOFinalized;
      return false;
    }

    return now > icoOpeningTime;
  }

  function mintTo(address beneficiary, uint256 _amount) onlyOwner public returns (bool) {
    return token.mint(beneficiary, _amount);
  }
}
