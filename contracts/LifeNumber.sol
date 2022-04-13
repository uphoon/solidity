// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Life Number
 * @dev 
 */
contract LifeNumber {

   address owner;

   uint fee = 1 ether;
   //uint randNonce = 0;
   //uint[] numbers ;
   //mapping(address => uint8[]) numbers;
   

   constructor() {
      owner = msg.sender;  // Deployer
   }



   function getNumbers() external payable {

      //TODO : payable 
      require(msg.value == fee);
   } 

   function fallback() public returns(uint[] memory) {   // receive
      return _rollball();
   }


   // Run numbers
   function _rollball() private view returns (uint[] memory) {

      uint[] memory nums = new uint[](6);
      uint nonce = 0;
      uint n ;

      for(uint8 i=0; i < 6 ; i++) {
         do {
            n = _randMod(nonce);
            nonce++;
         } while(_isPutNumber(nums, n));
         nums[i] = n;
      }
      return nums;
   }


   // Check the same number in numbers[]
   function _isPutNumber(uint[] memory _nums, uint _n) private pure returns (bool) {
      bool r = false;
      for(uint i = 0; i < _nums.length; i++){
         if(_n == _nums[i] ){
            r = true;
            break;
         }
      }
      return r;
   }


   // make Random Number
   function _randMod(uint _nonce) private view returns(uint) {
      return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, _nonce))) % 46;
   }


   // Run numbers
   // function rollball() public  {

   //    require( numbers.length < 6 );

   //    uint n = _randMod(randNonce);
   //    randNonce++;

   //    if(_isPutNumber(n)){
   //       rollball();
   //    } else {
   //       numbers.push(n);
   //       if(numbers.length < 6){
   //          rollball();
   //       }
   //    }
   // }



}
