const Raptor = artifacts.require("Raptor");
const SmellTracker = artifacts.require("SmellTracker");

module.exports = function(deployer) {
    deployer.deploy(SmellTracker).then(function() {
        return deployer.deploy(Raptor, SmellTracker.address);
    }).then(function() { })
};
