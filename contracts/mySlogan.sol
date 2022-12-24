// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

//import "hardhat/console.sol";
 
/**
 * @author  arda@mentholprotocol.com
 * @title   A contract for a slogan publishing DApp
 * @dev     .
 * @notice  .
 */

contract MySlogan { 

    address public owner;

    constructor ()  {
       owner = msg.sender;
   }
    
    struct Slogans {
        uint id;
        string text;
        address publisher;
        uint likes;
    }

    Slogans[] public slogans;
    
    mapping (string => bool) ifSloganPublished; 
    mapping (address => bool) ifLiked;
   
    /**
     * @notice  Will publish a slogan
     * @dev     .
     * @param   _slogan  The slogan to be published
     */
    function publish(string calldata _slogan) public {
        // one slogan can be published only once
        require(ifSloganPublished[_slogan] == false, "This Slogan has already been published!");
        
            uint lindx = slogans.length;
            slogans.push(Slogans(lindx, _slogan, msg.sender, 0));
        
        ifSloganPublished[_slogan] = true;
    }

    function  updateSlogan(uint id) public {
        require();
    }
    

    /**
     * @notice  .
     * @dev     .
     * @return  Slogans[]  List of the published slogans
     */
    function list() public view returns (Slogans[] memory) {
        return slogans;
    }

    /**
     * @notice  Lets you like a published slogan
     * @dev     .
     * @param   id  Id of the published slogan
     */
    function like(uint id) public {
        // one address can like only once
        require(ifLiked[msg.sender] == false, "You've already liked this Slogan!");
        slogans[id].likes += 1;
        ifLiked[msg.sender] = true;
    }
    
     function getLikeNumber(uint id) public view returns (uint) {
        uint likeNumber = slogans[id].likes;
        return likeNumber;
    }

    /**
     * @notice  .
     * @dev     Lets the contract owner get commission fee
     * @param   _value  The amount of token to be sent
     * @return  uint  The amount of commision fee
     * @return  uint  The amount token sent to the publisher
     */
    function get_comm_fee(uint _value) internal pure returns (uint, uint) {
        uint comm_amount = 10 * (_value / 100);
        uint tip_amount = _value - comm_amount;
        return (comm_amount, tip_amount);
    }

    /**
     * @notice  Lets you send tips to the publisher of the slogan
     * @dev     .
     * @param   id  Id of the published slogan
     */
    function tip(uint id) public payable {
        (uint comm_fee, uint tip_fee) = get_comm_fee(msg.value);
        address _to = slogans[id].publisher;
        (bool sent_to_owner, ) = owner.call{value: comm_fee}("");
        (bool sent, ) = _to.call{value: tip_fee}("");
        require(sent_to_owner, "Failed to send commission!");
        require(sent, "Failed to send tip!");
    }
}