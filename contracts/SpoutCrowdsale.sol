pragma solidity ^0.4.17;

import './SpoutMintableToken.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

contract SpoutCrowdsale is Ownable {
  using SafeMath for uint256;

  uint256 private constant APRIL_23_2018 = 1524441600;
  uint256 private constant MAY_01_2018 = 1525132800;
  uint256 private constant MAY_08_2018 = 1525737600;
  uint256 private constant MAY_15_2018 = 1526342400;
  uint256 private constant JUN_01_2018 = 1527811200;
  uint256 private constant JUN_15_2018 = 1529020800;
  uint256 private constant JULY_01_2018 = 1530403200;

  MintableToken public token;

  uint256 public presaleRate;

  uint256 public icoRate;

  address public wallet;

  event TokenPurchase(address indexed purchaser, address indexed beneficiary, uint256 value, uint256 amount, uint256 tokenRate, uint256 bonusRate);

  function SpoutCrowdsale(
    address _token,
    uint256 _presaleRate,
    uint256 _icoRate,
    address _wallet
  ) {
    require(_token != address(0));
    require(_wallet != address(0));

    token = SpoutMintableToken(_token);

    presaleRate = _presaleRate;
    icoRate = _icoRate;

    wallet = _wallet;
  }

  function () external payable {

    require(msg.sender != address(0));
    require(isPresalePeriod() || isICOPeriod());

    uint256 tokenRate = getCurrentTokenRate();
    uint256 tokens = msg.value.mul(tokenRate);
    uint256 bonusRate = getCurrentBonus();
    uint256 bonusTokens = bonusRate.mul(tokens.div(100));

    tokens = tokens.add(bonusTokens);

    TokenPurchase(msg.sender, msg.sender, msg.value, tokens, tokenRate, bonusRate);
    token.mint(msg.sender, tokens);

    forwardFunds();
  }

  function forwardFunds() internal {
    wallet.transfer(msg.value);
  }

  function getCurrentTokenRate() public view returns (uint256) {
    if (now >= APRIL_23_2018 && now < MAY_15_2018) {
      return presaleRate;
    } else {
      return icoRate;
    }
  }

  function isPresalePeriod() public view returns (bool) {
    if (now >= APRIL_23_2018 && now < MAY_15_2018) {
      return true;
    }
    return false;
  }

  function isICOPeriod() public view returns (bool) {
    if (now >= MAY_15_2018 && now < JULY_01_2018) {
      return true;
    }
    return false;
  }

  function getCurrentBonus() public view returns (uint256) {
    if (now >= APRIL_23_2018 && now < MAY_01_2018) {
      return 15;
    }
    if (now >= MAY_01_2018 && now < MAY_08_2018) {
      return 10;
    }
    if (now >= MAY_08_2018 && now < MAY_15_2018) {
      return 5;
    }

    if (now >= MAY_15_2018 && now < JUN_01_2018) {
      return 5;
    }
    if (now >= JUN_01_2018 && now < JUN_15_2018) {
      return 3;
    }
    if (now >= JUN_15_2018 && now < JULY_01_2018) {
      return 2;
    }

    return 0;
  }

  function mintTo(address beneficiary, uint256 _amount) onlyOwner public returns (bool) {
    return token.mint(beneficiary, _amount);
  }
}
