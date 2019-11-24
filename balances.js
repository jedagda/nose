//const Raptor = artifacts.require('Raptor')

module.exports = function(callback) {
	
	async function printBalances(){
		let accounts = await web3.eth.getAccounts()
		//let contract = await Raptor.deployed()
		var balance=0;
		
		accounts.forEach(async function (account, index){
			balance = await web3.eth.getBalance(account)
			console.log(balance)
			
			if (index+1==accounts.length){
				callback();
			}
		})
		
	}
	
	printBalances();
	
}
