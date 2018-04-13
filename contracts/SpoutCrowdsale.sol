pragma solidity ^0.4.17;

import './SpoutMintableToken.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

contract SpoutCrowdsale is Ownable {
  using SafeMath for uint256;

  uint256 private constant MAY_19_2018 = 1526688000;
  uint256 private constant MAY_21_2018 = 1526860800;
  uint256 private constant MAY_22_2018 = 1526947200;
  uint256 private constant MAY_24_2018 = 1527120000;
  uint256 private constant MAY_25_2018 = 1527206400;
  uint256 private constant MAY_28_2018 = 1527465600;
  uint256 private constant JUN_01_2018 = 1527811200;
  uint256 private constant JUN_07_2018 = 1528329600;
  uint256 private constant JUN_08_2018 = 1528416000;
  uint256 private constant JUN_14_2018 = 1528934400;
  uint256 private constant JUN_15_2018 = 1529020800;
  uint256 private constant JUN_21_2018 = 1529539200;
  uint256 private constant JUN_22_2018 = 1529625600;
  uint256 private constant JUN_30_2018 = 1530316800;

  // uint256 constant PRESALE1_OPENING_TIME = MAY_19_2018;
  // uint256 constant PRESALE1_CLOSING_TIME = MAY_21_2018;
  // uint256 constant PRESALE2_OPENING_TIME = MAY_22_2018;
  // uint256 constant PRESALE2_CLOSING_TIME = MAY_24_2018;
  // uint256 constant PRESALE3_OPENING_TIME = MAY_25_2018;
  // uint256 constant PRESALE3_CLOSING_TIME = MAY_28_2018;
  uint256 constant PRESALE1_OPENING_TIME = 1523318400; // 10/4/2018
  uint256 constant PRESALE1_CLOSING_TIME = 1523404799; // 10/4/2018 23:59:59
  uint256 constant PRESALE2_OPENING_TIME = 1523404800; // 11/4/2018
  uint256 constant PRESALE2_CLOSING_TIME = 1523491199; // 11/4/2018 23:59:59
  uint256 constant PRESALE3_OPENING_TIME = 1523491200; // 12/4/2018
  uint256 constant PRESALE3_CLOSING_TIME = 1523577599; // 12/4/2018 23:59:59

  // uint256 constant ICO1_OPENING_TIME = JUN_01_2018;
  // uint256 constant ICO1_CLOSING_TIME = JUN_07_2018;
  // uint256 constant ICO2_OPENING_TIME = JUN_08_2018;
  // uint256 constant ICO2_CLOSING_TIME = JUN_14_2018;
  // uint256 constant ICO3_OPENING_TIME = JUN_15_2018;
  // uint256 constant ICO3_CLOSING_TIME = JUN_21_2018;
  // uint256 constant ICO4_OPENING_TIME = JUN_22_2018;
  // uint256 constant ICO4_CLOSING_TIME = JUN_30_2018;
  uint256 constant ICO1_OPENING_TIME = 1523577600; // 13/4/2018
  uint256 constant ICO1_CLOSING_TIME = 1523663999; // 13/4/2018 23:59:59
  uint256 constant ICO2_OPENING_TIME = 1523836800; // 16/4/2018
  uint256 constant ICO2_CLOSING_TIME = 1523923199; // 16/4/2018 23:59:59
  uint256 constant ICO3_OPENING_TIME = 1523923200; // 17/4/2018
  uint256 constant ICO3_CLOSING_TIME = 1524009599; // 17/4/2018 23:59:59
  uint256 constant ICO4_OPENING_TIME = 1524009600; // 18/4/2018
  uint256 constant ICO4_CLOSING_TIME = 1524095999; // 18/4/2018 23:59:59

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

  function isPresale1Period() private view returns (bool) {
    if (now >= PRESALE1_OPENING_TIME && now < PRESALE1_CLOSING_TIME) {
      return true;
    }
    return false;
  }

  function isPresale2Period() private view returns (bool) {
    if (now >= PRESALE2_OPENING_TIME && now < PRESALE2_CLOSING_TIME) {
      return true;
    }
    return false;
  }

  function isPresale3Period() private view returns (bool) {
    if (now >= PRESALE3_OPENING_TIME && now < PRESALE3_CLOSING_TIME) {
      return true;
    }
    return false;
  }

  function isPresalePeriod() public view returns (bool) {
    if (isPresale1Period() || isPresale2Period() || isPresale3Period()) {
      return true;
    }
    return false;
  }

  function isICO1Period() private view returns (bool) {
    if (now >= ICO1_OPENING_TIME && now < ICO1_CLOSING_TIME) {
      return true;
    }
    return false;
  }

  function isICO2Period() private view returns (bool) {
    if (now >= ICO2_OPENING_TIME && now < ICO2_CLOSING_TIME) {
      return true;
    }
    return false;
  }

  function isICO3Period() private view returns (bool) {
    if (now >= ICO3_OPENING_TIME && now < ICO3_CLOSING_TIME) {
      return true;
    }
    return false;
  }

  function isICO4Period() private view returns (bool) {
    if (now >= ICO4_OPENING_TIME && now < ICO4_CLOSING_TIME) {
      return true;
    }
    return false;
  }

  function isICOPeriod() public view returns (bool) {
    if (isICO1Period() || isICO2Period() || isICO3Period() || isICO4Period()) {
      return true;
    }
    return false;
  }

  function getCurrentTokenRate() public view returns (uint256) {
    if (isPresalePeriod()) {
      return presaleRate;
    } else if (isICOPeriod()) {
      return icoRate;
    }
  }

  function getCurrentBonus() public view returns (uint256) {
    if (isPresale1Period()) {
      return 15;
    }
    if (isPresale2Period()) {
      return 10;
    }
    if (isPresale3Period()) {
      return 5;
    }

    if (isICO1Period()) {
      return 5;
    }
    if (isICO2Period()) {
      return 3;
    }
    if (isICO3Period()) {
      return 2;
    }
    if (isICO4Period()) {
      return 0;
    }

    return 0;
  }

  function mintTo(address beneficiary, uint256 _amount) onlyOwner public returns (bool) {
    return token.mint(beneficiary, _amount);
  }
}
