pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/token/ERC20/MintableToken.sol';

contract SpoutMintableToken is MintableToken {
  string public constant name = "SpoutToken";
  string public constant symbol = "SPT";
  uint8 public constant decimals = 18;
  address originalOwner;

  bool public transferEnabled = false;

  function SpoutMintableToken() public {
    originalOwner = msg.sender;
  }

  function setTransferStatus(bool _enable)  public {
    require(originalOwner == msg.sender);
    transferEnabled = _enable;
  }

  function getTransferStatus() public view returns (bool){
      return transferEnabled;
  }

  function getOriginalOwner() public view returns(address) {
      return originalOwner;
  }

  function transfer(address _to, uint256 _value) public returns (bool) {
    require(transferEnabled);

    return super.transfer(_to, _value);
  }
}
