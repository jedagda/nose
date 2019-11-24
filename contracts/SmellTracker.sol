pragma solidity ^0.5.7;
pragma experimental ABIEncoderV2;

import "jsmnsol-lib/JsmnSolLib.sol";

contract SmellTracker{
	
	//mapping containing current unresolved smells
    mapping (address => uint) public smellBase;
    //Flag indicating if initial smell report was mapped
    bool hasMappedInitial = false;
    
    constructor() public{
        
    }
    
    
    
    /**
		checkSmells()
		@param smellReport - JSON code report
		@return number of smells identified in report
    **/
    function checkSmells(string memory smellReport) public returns (uint){
        
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
