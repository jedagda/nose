pragma solidity ^0.5.7;

import "./SmellTracker.sol";

contract Raptor{
    
    address private manager;//Address of manager for high level operation clearance
    uint private totalReward = 0;
    bool private isActive = false;
    string json = "{ \"key1\": { \"key1.1\": \"value\", \"key1.2\": 3, \"key1.3\": true } }";
    
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
		@param initialSmellReport - initial JSON report
		@param rewardPerSmell - reward per smell
		@return Success flag
    **/
    function setup(string memory initialSmellReport, uint rewardPerSmell) public payable returns (bool){
        require(!isActive);
        
        //Save details
        manager = msg.sender;
        totalReward = msg.value;
        
        //Initial smell check
        uint smells = SmellTracker(smellTrackerAddress).checkSmells(initialSmellReport);
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
		status()
		Returns active flag
		@return Active flag
    **/
	function status() public returns (bool){
		return isActive;
	}
    
    /**
		checkSmells()
		Used to update smell report and reward for smell removal
		@return Smells removed
    **/
    function checkSmells(string memory smellReport, bool isInitial) public payable returns (uint){
        require(isActive);
        
        uint smells = SmellTracker(smellTrackerAddress).checkSmells(smellReport);
    }
    
    //To be called to reward for removing smells
    function reward(uint smellsRemoved) private returns (bool){
        
    }
    
}
