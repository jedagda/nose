pragma solidity ^0.5.7;

import "./SmellTracker.sol";

contract Raptor{
    
    uint rewardPreSmell = 100000000000000000;
    bool wasSet = false;
    string json = "{ \"key1\": { \"key1.1\": \"value\", \"key1.2\": 3, \"key1.3\": true } }";
    
    //Address of smell tracker for later use
    address smellTrackerAddress;
    
    constructor(address _smellTrackerAddress) public{
        //Save address of smell tracker to allow use
        smellTrackerAddress = _smellTrackerAddress;
    }
    
    //=====
    //State modification
    //=====
    
    //initial setup for contract
    function setup(string memory initialSmellReport, uint rewardPerSmell) public payable returns (bool){
        //require();
        //return Checker.check(json);
    }
    
    //Used to update smell report
    function checkSmells(string memory smellReport, bool isInitial) public payable returns (uint){
        //require();
    }
    
    //To be called to reward for removing smells
    function reward(uint smellsRemoved) private returns (bool){
        
    }
    
}
