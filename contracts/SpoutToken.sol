pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/token/ERC20/MintableToken.sol';

contract SpoutToken is MintableToken {
  string public constant name = "SpoutToken";
  string public constant symbol = "SPC";
  uint8 public constant decimals = 18;

  uint256 public constant INITIAL_SUPPLY = 1000000;

  function SpoutToken() public {
    balances[msg.sender] = INITIAL_SUPPLY;
    Transfer(0x0, msg.sender, INITIAL_SUPPLY);
  }
}
