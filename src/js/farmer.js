App = {
  web3Provider: null,
  contracts: {},

  init: function() {
    // Load pets.
    // $.getJSON('../pets.json', function(data) {
    //   var petsRow = $('#petsRow');
    //   var petTemplate = $('#petTemplate');

    //   for (i = 0; i < data.length; i ++) {
    //     petTemplate.find('.panel-title').text(data[i].name);
    //     petTemplate.find('img').attr('src', data[i].picture);
    //     petTemplate.find('.pet-breed').text(data[i].breed);
    //     petTemplate.find('.pet-age').text(data[i].age);
    //     petTemplate.find('.pet-location').text(data[i].location);
    //     petTemplate.find('.btn-adopt').attr('data-id', data[i].id);

    //     petsRow.append(petTemplate.html());
    //   }
    // });

    return App.initWeb3();
  },

  initWeb3: function() {
    /*
     * Replace me...
     */
     // Is there an injected web3 instance?
     if (typeof web3 !== 'undefined') {
       App.web3Provider = web3.currentProvider;
     } else {
       // If no injected web3 instance is detected, fall back to Ganache
       App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
     }
     web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  initContract: function() {

      $.getJSON('Main.json', function(data) {
       // Get the necessary contract artifact file and instantiate it with truffle-contract
       var MainArtifact = data;
       App.contracts.Main = TruffleContract(MainArtifact);

       // Set the provider for our contract
       App.contracts.Main.setProvider(App.web3Provider);

       // Use our contract to retrieve and mark the adopted pets
       // return App.markAdopted();
     });

    return App.bindEvents()
  },

  bindEvents: function() {

        $(document).on('click', 'GetFarmerData', App.getFarmerData),


     event.preventDefault();

    // var petId = parseInt($(event.target).data('id'));

    /*
     * Replace me...
     */
     var mainInstance;

     web3.eth.getAccounts(function(error, accounts) {
       if (error) {
         console.log(error);
       }

       var account = accounts[0];
       var MainArtifact = data;
       App.contracts.Main = TruffleContract(MainArtifact);

       // Set the provider for our contract
       App.contracts.Main.setProvider(App.web3Provider);

       App.contracts.Main.deployed().then(function(instance) {
         mainInstance = instance;

         // Execute adopt as a transaction by sending account
         return mainInstance.setRichData("0xca35b7d915458ef540ade6068dfe2f44e8fa733c","0x14723a09acff6d2a60dcdf7aa4aff308fddc160c","0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db","0x583031d1113ad414f02576bd6afabfb302140225","0xdd870fa1b7c4700f2bd7f44238821c26f7392148", {from: account});
       }).then(function(result) {
       }).catch(function(err) {
         console.log(err.message);
       });
     });

  },


  getFarmerData: function(){

     event.preventDefault();

    // var petId = parseInt($(event.target).data('id'));

    /*
     * Replace me...
     */
     var mainInstance;

     // web3.eth.getAccounts(function(error, accounts) {
     //   if (error) {
     //     console.log(error);
     //   }

     //   var account = accounts[0];

       App.contracts.Main.deployed().then(function(instance) {
         mainInstance = instance;

         // Execute adopt as a transaction by sending account
         return mainInstance.getFarmerData(qty, name, weight, location, {from: account});
       }).then(function(result) {

            $("ol").append("<li>Lot number of stored item:"+ result+"</li>");


       }).catch(function(err) {
         console.log(err.message);
       });
     },


  getPLData: function(ls, account) {
    /*
     * Replace me...
     */

     var mainInstance;

     App.contracts.Main.deployed().then(function(instance) {
       farmerInstance = instance;

      
       return farmerInstance.getFarmerData(lot,"0xca35b7d915458ef540ade6068dfe2f44e8fa733c","0x14723a09acff6d2a60dcdf7aa4aff308fddc160c",temp, {from: account});
       }).then(function(result) {
       }).catch(function(err) {
         console.log(err.message);
       });
     }



};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
