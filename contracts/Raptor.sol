pragma solidity ^0.5.7;

import "./SmellTracker.sol";

contract Raptor{
    
    address private manager;//Address of manager for high level operation clearance
    address private payTo;
    uint private totalReward = 0;
    bool private isActive = false;
    string json = "{  \"total\":40,  \"p\":1,  \"ps\":100,  \"paging\":{   \"pageIndex\":1,   \"pageSize\":100,   \"total\":40  },  \"effortTotal\":241,  \"debtTotal\":241,  \"issues\":[   {    \"key\":\"AW6gHXBEthlwlpOpxQdg\",    \"status\":\"OPEN\"   },   {    \"key\":\"AW6gHXBEthlwlpOpxQdh\",    \"status\":\"OPEN\"   }  ] } ";
    
    string jsonx = "{  \"total\":40,  \"p\":1,  \"ps\":100,  \"paging\":{   \"pageIndex\":1,   \"pageSize\":100,   \"total\":40  },  \"effortTotal\":241,  \"debtTotal\":241,  \"issues\":[   {    \"key\":\"AW6gHXBEthlwlpOpxQdg\",    \"status\":\"CLOSED\"   },   {    \"key\":\"AW6gHXBEthlwlpOpxQdh\",    \"status\":\"CLOSED\"   }  ] } ";
    
    //Address of smell tracker for later use
    address private smellTrackerAddress;
    
    constructor(address _smellTrackerAddress) public{
        //Save address of smell tracker to allow use
        smellTrackerAddress = _smellTrackerAddress;
    }
    
    //=====
    //State modification
    //=====
    
    /**
		setup()
		initial contract setup
		@param smellReportAddress - initial JSON report
		@param rewardPerSmell - reward per smell
		@return Success flag
    **/
    function setup(string memory smellReportAddress, address _payTo, uint rewardPerSmell) public payable returns (bool){
        require(!isActive);
        
        //Save details
        manager = msg.sender;
        payTo = _payTo;
        totalReward = msg.value;
        
        //Initial smell check
        uint smells = SmellTracker(smellTrackerAddress).checkSmellsF(json, false);
        isActive = true;
    }
    
    /**
		cancelProgram()
		Refund reward remaining to manager and inactivate reward program
		@return Success flag
    **/
    function cancelProgram() public payable returns (bool){
		require(msg.sender==manager, "Manager required for this operation");
		require(isActive, "Reward program is inactive");
		
		msg.sender.transfer(totalReward);
		isActive = false;
		
		return true;
	}
	
	/**
		checkReport()
		Used to update smell report and reward for smell removal
		@return Smells removed
    **/
    function checkReport() public payable returns (bool){
        //require(isActive);
        
        uint oldSmells = SmellTracker(smellTrackerAddress).getSmellNumber();
        
        SmellTracker(smellTrackerAddress).reloadReport();
        
        uint smells = SmellTracker(smellTrackerAddress).checkSmellsF(jsonx, true);
        
        //if (smells<oldSmells){
		msg.sender.transfer(totalReward);
		//}
		
		return true;
    }
	
	/**
		status()
		Returns active flag
		@return Active flag
    **/
	function status() public returns (bool){
		return isActive;
	}
    
    
    
    //To be called to reward for removing smells
    function reward(uint smellsRemoved) private returns (bool){
        
    }
    
}
