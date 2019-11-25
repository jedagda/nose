pragma solidity ^0.5.7;
pragma experimental ABIEncoderV2;

import "jsmnsol-lib/JsmnSolLib.sol";
//import "github.com/provable-things/ethereum-api/blob/master/provableAPI_0.5.soll"
import "./provableAPI_0.5.sol";

contract SmellTracker is usingProvable{

	uint public numOfSmells;
	//mapping containing current unresolved smells
    mapping (bytes32 => bool) public smellBase;
    //Flag indicating if initial smell report was mapped

		event LogConstructorInitiated(string nextStep);
		event LogSmellBaseInitiated(string nextStep);
		event LogSmellBaseUpdated(string price);
		event LogNewProvableQuery(string description);

    constructor() public{
        emit LogConstructorInitiated("Contructor was initiated. Call 'CheckSmell()' to sebd the Query.");
    }

		function checkNumberOfSmells() public payable returns(uint){
			if(provable_getPrice("URL") > address(this).balance) {
				emit LogNewProvableQuery("Provable query was NOT sent, please add some ETH to cover for the query fee");
			} else {
				emit LogNewProvableQuery("Provable query was sent, standing by for the answer...");
				uint numOfSmells = provable_query("URL", "json(http://localhost:9000/api/issues/search).total");
				return numOfSmells;
			}
			return 0;
		}

		function checkSmells() public payable returns (string) {
			if(provable_getPrice("URL") > address(this).balance) {
				emit LogNewProvableQuery("Provable query was NOT sent, please add some ETH to cover for the query fee");
			} else {
				emit LogNewProvableQuery("Provable query was sent, standing by for the answer...");
				string query = provable_query("URL", "json(http://localhost:9000/api/issues/search).Issues.[]");
				return query;
			}
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
