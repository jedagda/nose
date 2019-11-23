pragma solidity ^0.5.7;

import "./SmellTracker.sol";

contract Raptor{
    
    uint reward = 100000000000000000;
    bool wasSet = false;
    string json = "{ \"key1\": { \"key1.1\": \"value\", \"key1.2\": 3, \"key1.3\": true } }";
    
    address smellTrackerAddress;
    
    
    constructor(address _smellTrackerAddress) public{
        //Save address of smell tracker to 
        smellTrackerAddress = _smellTrackerAddress;
    }
    
    function suck() public returns (uint){
        return SmellTracker(smellTrackerAddress).checkSmells(json);
        //return 0;
    }
    
    
    //=====
    //State modification
    //=====
    
    function setup(string memory initialSmellReport, uint rewardPerSmell) public payable returns (bool){
        //require();
        //return Checker.check(json);
    }
    
    function checkSmells(string memory smellReport, bool isInitial) public payable returns (uint){
        //require();
    }
    
    function reward(uint smellaRemoved) private returns (bool){
        
    }
    
}