const Raptor = artifacts.require('Raptor')

module.exports = function(callback) {
	
	async function asfn(){
		let accounts = await web3.eth.getAccounts()
		let contract = await Raptor.deployed()
		
		let rex = await contract.checkReport({from: accounts[1]});
		
		console.log("Report checked "+rex)
		
		callback()
	}
	
	asfn();
	
}
