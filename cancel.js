const Raptor = artifacts.require('Raptor')

module.exports = function(callback) {
	
	async function asfn(){
		let accounts = await web3.eth.getAccounts()
		let contract = await Raptor.deployed()
		
		let didCancel = await contract.cancelProgram({from: accounts[2]});
		
		console.log(didCancel)
		
		callback()
		
	}
	
	asfn();
	
}
