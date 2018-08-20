var Adoption = artifacts.require("Adoption");

module.exports = function(deployer){
	deployer.deploy(Adoption);
}

var RichDapp = artifacts.require("RichDapp");

module.exports = function(deployer){
	deployer.deploy(RichDapp);
}



