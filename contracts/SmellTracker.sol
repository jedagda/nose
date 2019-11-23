pragma solidity ^0.5.7;
pragma experimental ABIEncoderV2;

import "jsmnsol-lib/JsmnSolLib.sol";

contract SmellTracker{

    mapping (address => uint) public smellBase;
    bool hasMappedInitial = false;//Flag indicating if initial smell JSON was mapped
    
    constructor() public{
        
    }
    
    
    /**
		checkSmells()
    
    **/
    function checkSmells(string memory smellReport) internal returns (uint){
        
        //Fields to store return values of parsing call
        uint returnCode;
        JsmnSolLib.Token[] memory tokens;
        uint actualNumber;
        
        //Parse smell report. Pass string containing JSON, & maximum number of tokens
        (returnCode, tokens, actualNumber) = JsmnSolLib.parse(smellReport, 10);
        
        //TOOD - create smell mapping and update smellBase
        
        //TODO - Return actual number of smells found
        return 41;
    }

}
