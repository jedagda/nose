const Raptor = artifacts.require('Raptor')

module.exports = function(callback) {
	
	async function asfn(){
		let accounts = await web3.eth.getAccounts()
		let contract = await Raptor.deployed()
		
		let isActive = await contract.status.call();
		
		console.log("Is Active: "+isActive)
		
		callback()
	}
	
	asfn();
	
}
