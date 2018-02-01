pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/token/ERC20/MintableToken.sol';

contract SpoutCoin is MintableToken {
  string public name = "SPOUT COIN";
  string public symbol = "SPC";
  uint8 public decimals = 18;
}
