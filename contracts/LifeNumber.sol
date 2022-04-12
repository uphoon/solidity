// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract LifeNumber {

   uint[] numbers ;

   address owner;

   constructor() {
      owner = msg.sender;
   }

   function getNumbers() public view returns(uint[] memory) {

      return numbers;
   } 

   function rollball() public  {

      require( numbers.length < 6 );

      uint n = _randMod();

      if(_isPutNumber(n)){
         rollball();
      } else {
         numbers.push(n);
      }
   }

   function _isPutNumber(uint _n) private view returns (bool) {
      bool r = false;
      for(uint i = 0; i < numbers.length; i++){
         if(_n == numbers[i] ){
            r = true;
            break;
         }
      }
      return r;
   }


   function _randMod() private view returns(uint) {
      uint randNonce = 0;
      return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % 46;
   }

}
