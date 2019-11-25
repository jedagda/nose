const Raptor = artifacts.require('Raptor')

module.exports = function(callback) {
	
	async function asfn(){
		let accounts = await web3.eth.getAccounts()
		let contract = await Raptor.deployed()
		
		let didSet = await contract.setup("report", 400, {from: accounts[0], value: 29879897619999997000});
		
		console.log(didSet)
		
		callback()
		
	}
	
	asfn();
	
}
