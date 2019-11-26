pragma solidity ^0.5.3;

import "./Seriality.sol";

contract Zeta is Seriality {
    
    constructor () public {
        owner = msg.sender;
    }
    
    
    address public owner;
    
    mapping (address => string[]) public score;
    

    function Upload(address _address, string memory _score) public {
        require(msg.sender==owner);
        
        score[_address].push(_score);    
    }
    
    function retrieve(address _address) public view returns(bytes memory x) {
        
        
        uint startindex = 0;
        uint endindex = score[_address].length-1;

        require(endindex >= startindex);
        
        uint offset = 64*((endindex - startindex) + 1);
        
        bytes memory buffer = new  bytes(offset);
        string memory out1  = new string(32);
        
        
        for(uint i = startindex; i <= endindex; i++){
            out1 = score[_address][i];
            
            stringToBytes(offset, bytes(out1), buffer);
            offset -= sizeOfString(out1);
        }
        
        return (buffer);
        
    }
    
}