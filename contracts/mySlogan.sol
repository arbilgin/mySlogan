// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

//import "@openzeppelin/contracts@4.4.0/token/ERC20/ERC20.sol";

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
    
    function publish(string calldata _slogan) public {
        // one slogan can be published only once
        require(ifSloganPublished[_slogan] == false, "This Slogan has already been published!");
        if (slogans.length == 0) {
            slogans.push(Slogans(0, _slogan, msg.sender, 0));
        } else {
            uint lindx = slogans.length;
            slogans.push(Slogans(lindx, _slogan, msg.sender, 0));
        } 
        ifSloganPublished[_slogan] = true;
    }

    function list() public view returns (Slogans[] memory) {
        return slogans;
    }

    function like(uint id) public {
        // one address can like only once
        require(ifLiked[msg.sender] == false, "You've already liked this Slogan!");
        slogans[id].likes += 1;
        ifLiked[msg.sender] = true;
    }
    
    function get_comm_fee(uint _value) internal pure returns (uint, uint) {
        uint comm_amount = 10 * (_value / 100);
        uint tip_amount = _value - comm_amount;
        return (comm_amount, tip_amount);
    }

    function tip(uint id) public payable {
        (uint comm_fee, uint tip_fee) = get_comm_fee(msg.value);
        address _to = slogans[id].publisher;
        (bool sent_to_owner, ) = owner.call{value: comm_fee}("");
        (bool sent, ) = _to.call{value: tip_fee}("");
        require(sent_to_owner, "Failed to send commission!");
        require(sent, "Failed to send tip!");
    }
}