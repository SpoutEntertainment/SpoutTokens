pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/token/ERC20/MintableToken.sol';

contract SpoutMintableToken is MintableToken {
  string public constant name = "SpoutToken";
  string public constant symbol = "SPC";
  uint8 public constant decimals = 18;
}
