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

      $.getJSON('Farmer.json', function(data) {
       // Get the necessary contract artifact file and instantiate it with truffle-contract
       var FarmerArtifact = data;
       App.contracts.Farmer = TruffleContract(FarmerArtifact);

       // Set the provider for our contract
       App.contracts.Farmer.setProvider(App.web3Provider);

       // Use our contract to retrieve and mark the adopted pets
       // return App.markAdopted();
     });

    return App.bindEvents();
  },

  // bindEvents: function() {
  //   $(document).on('click', '.btn-adopt', App.handleAdopt);
  // },

  $(document).on('click', 'LogIN', App.setData)
    $(document).on('click', 'SearchByLot', App.getAll)





  setData: function(){

     event.preventDefault();

    // var petId = parseInt($(event.target).data('id'));

    /*
     * Replace me...
     */
     var farmerInstance;

     web3.eth.getAccounts(function(error, accounts) {
       if (error) {
         console.log(error);
       }

       var account = accounts[0];

       App.contracts.Farmer.deployed().then(function(instance) {
         farmerInstance = instance;

         // Execute adopt as a transaction by sending account
         return farmerInstance.setData(xxxxxxxxxxxxxxxxxxxc, {from: account});
       }).then(function(result) {
         return App.getAll(result);
       }).catch(function(err) {
         console.log(err.message);
       });
     });


  }

  getAll: function(ls, account) {
    /*
     * Replace me...
     */

     var farmerInstance;

     App.contracts.Farmer.deployed().then(function(instance) {
       farmerInstance = instance;

       return farmerInstance.getAll.call();
     }).then(function(ls) {
       for (i = 0; i < ls.length; i++) {
         
           $('.panel-pet').eq(i).find('button').text(ls[i]).attr('disabled', true);
         
       }
     }).catch(function(err) {
       console.log(err.message);
     });
  },


};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
