pragma solidity ^0.5.7;
pragma experimental ABIEncoderV2;

import "jsmnsol-lib/JsmnSolLib.sol";

contract SmellTracker{
	
	//mapping containing current unresolved smells
    mapping (string => uint) public smellBase;
    uint issueCount;
    //Flag indicating if initial smell report was mapped
    
    
    constructor() public{
        issueCount = 0;
        //hasMappedInitial = false;
    }
    
    
    
    /**
		checkSmellsF()
		@param smellReport - JSON code report
		@return number of smells identified in report
    **/
    
    bool hasReloaded = false;
    
    function reloadReport() public{
		hasReloaded = true;
	}
    
    function getReport() public returns (string memory){
		if (hasReloaded){
			return "{  \"total\":40,  \"p\":1,  \"ps\":100,  \"paging\":{   \"pageIndex\":1,   \"pageSize\":100,   \"total\":40  },  \"effortTotal\":241,  \"debtTotal\":241,  \"issues\":[   {    \"key\":\"AW6gHXBEthlwlpOpxQdg\",    \"status\":\"CLOSED\"   },   {    \"key\":\"AW6gHXBEthlwlpOpxQdh\",    \"status\":\"OPEN\"   }  ] } ";
		}
		return "{  \"total\":40,  \"p\":1,  \"ps\":100,  \"paging\":{   \"pageIndex\":1,   \"pageSize\":100,   \"total\":40  },  \"effortTotal\":241,  \"debtTotal\":241,  \"issues\":[   {    \"key\":\"AW6gHXBEthlwlpOpxQdg\",    \"status\":\"OPEN\"   },   {    \"key\":\"AW6gHXBEthlwlpOpxQdh\",    \"status\":\"OPEN\"   }  ] } ";
	}
    
    
    
    function checkSmellsF(string memory json, bool hasMappedInitial) public returns (uint){
    
    
		//Fields to store return values of parsing call
		uint returnCode;
		JsmnSolLib.Token[] memory tokens;
		uint actualNumber;
		
		//Parse smell report. Pass string containing JSON, & maximum number of tokens
		(returnCode, tokens, actualNumber) = JsmnSolLib.parse(json, 150);
		
		//Check that parsing went smoothly
		require(returnCode==0, "Invalid report");
		
		
		//Deconstruct
		bool insideIssue = false;
		uint issueIndex = 0;
		uint issueChildren = 0;
		string memory issueKey;
		string memory issueStatus;
		for (uint tokenIndex = 0; tokenIndex<actualNumber; tokenIndex++){
			
			if (insideIssue){
				
				//Guard to break if outside issue zone
				/*
				if (tokenIndex-issueIndex>issueChildren){
					tokenIndex--;
					insideIssue=false;
					break;
				}
				*/
				
				//Find key
				if (isToken(json, tokens[tokenIndex], "key")){
					
					//Get key
					issueKey = JsmnSolLib.getBytes(json, tokens[tokenIndex+1].start, tokens[tokenIndex+1].end);
					tokenIndex++;//Skip key value
					
				//Find status
				}else if (isToken(json, tokens[tokenIndex], "status")){
					
					issueStatus = JsmnSolLib.getBytes(json, tokens[tokenIndex+1].start, tokens[tokenIndex+1].end);
					tokenIndex++;//Skip status value
					
					//return issueStatus;
					
					//Check status for open
					if (JsmnSolLib.strCompare(issueStatus, "OPEN")==0){
						
						if (!hasMappedInitial){//goes into map
							smellBase[issueKey] = 1;
							issueCount++;
						}
						
					}else if (JsmnSolLib.strCompare(issueStatus, "CLOSED")==0){
						
						if (hasMappedInitial && smellBase[issueKey]==1){//goes into map
							smellBase[issueKey] = 0;
							issueCount--;
						}
						
					}
					
					//tokenIndex = issueIndex+issueChildren;
					//insideIssue = false;
				}
			
			}else if (tokens[tokenIndex].jsmnType==JsmnSolLib.JsmnType.STRING){
				string memory value = JsmnSolLib.getBytes(json, tokens[tokenIndex].start, tokens[tokenIndex].end);
				
				if (JsmnSolLib.strCompare(value, "issues")==0 && tokens[tokenIndex+1].jsmnType==JsmnSolLib.JsmnType.ARRAY && tokens[tokenIndex+2].jsmnType==JsmnSolLib.JsmnType.OBJECT){
					
					//Position at issue object
					tokenIndex += 2;
					
					//Bookmark
					issueIndex = tokenIndex;
					issueChildren = tokens[tokenIndex].size;
					
					//set flag
					insideIssue = true;
				}
				
			}
			
		}
		
		hasMappedInitial = true;
		
		return issueCount;
	}

	

	function getSmellNumber() public returns (uint){
		return issueCount;
	}
	

	function isToken(string memory json, JsmnSolLib.Token memory token, string memory str) private returns (bool){
		
		return JsmnSolLib.strCompare(JsmnSolLib.getBytes(json, token.start, token.end), str)==0;
	}

}
