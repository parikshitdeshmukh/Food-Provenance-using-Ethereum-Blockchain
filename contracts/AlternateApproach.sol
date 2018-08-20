pragma solidity ^0.4.16;
contract Farmer{
    enum farmer_type{dairy,vegetable,grain}
    struct farmer_data {
        address farmer_address;
        uint farmer_type;
        uint weight;
        uint quantity;
        uint256 timestamp;
        string location;
    }
    event Order_Created(address from, uint lot);
    uint guestlot = 1000;
    mapping(uint => farmer_data) public data;
    function setData(uint farmer_type1,uint weight1,uint quantity1,string location1,uint lot1) returns (uint)
    {
        data[lot1].farmer_address=msg.sender;
        data[lot1].farmer_type=farmer_type1;
        data[lot1].weight=weight1;
        data[lot1].quantity=quantity1;
        data[lot1].timestamp=now;
        data[lot1].location=location1;
        return lot1;
        Order_Created(data[lot1].farmer_address,lot1);
    }
    function getAddress(uint lot) returns(address)
    {
        return data[lot].farmer_address;
    }
    function getType(uint lot) returns(uint)
    {
        return data[lot].farmer_type;
    }
    function getWeight(uint lot) returns(uint)
    {
        return data[lot].weight;
    }
    function getQuantity(uint lot) returns(uint)
    {
        return data[lot].quantity;
    }
}
contract Logistics{
    enum goods_type{dairy,vegetable,grain}
    //enum goods_type{};
    struct log_data {
        address logaddress;
        uint lot;
        uint temp;
        address provider;
        uint weight;
        uint quantity;
        uint farmerType;
        address senderAdd;
    }
    mapping(uint => log_data) data;
    Farmer farmer;
    Manufacturer man;
    Warehouse ware;
    function compareStrings (string a, string b) view returns (bool){
       return keccak256(a) == keccak256(b);
   }
    function setLogData(address add, uint lot1, uint temp1, string id) returns (uint)
    {
    if(compareStrings(id,"farmer")) {
        farmer = Farmer(add);
        data[lot1].senderAdd = add;
        data[lot1].logaddress = msg.sender;
        data[lot1].provider = farmer.getAddress(lot1);
        data[lot1].weight = farmer.getWeight(lot1);
        data[lot1].quantity = farmer.getQuantity(lot1);
        data[lot1].temp = temp1;
        data[lot1].farmerType = farmer.getType(lot1);
        return lot1;
        }
    else if(compareStrings(id,"man")) {
        man = Manufacturer(add);
        data[lot1].senderAdd = add;
        data[lot1].logaddress = msg.sender;
        data[lot1].provider = man.getAddress(lot1);
        data[lot1].weight = man.getWeight(lot1);
        data[lot1].quantity = man.getQuantity(lot1);
        data[lot1].temp = temp1;
        data[lot1].farmerType = man.getProductId(lot1);
        return lot1;
    }
    else if(compareStrings(id,"ware")) {
        ware = Warehouse(add);
        data[lot1].senderAdd = add;
        data[lot1].logaddress = msg.sender;
        data[lot1].provider = ware.getAddress(lot1);
        data[lot1].weight = ware.getWeight(lot1);
        data[lot1].quantity = ware.getQuantity(lot1);
        data[lot1].temp = temp1;
        data[lot1].farmerType = ware.getProductId(lot1);
        return lot1;
    }
    }
    function getProvider(uint lot) returns(address)
    {
        return data[lot].provider;
    }
    function getProductId(uint lot) returns(uint)
    {
        return data[lot].farmerType;
    }
    function getWeight(uint lot) returns(uint)
    {
        return data[lot].weight;
    }
    function getQuantity(uint lot) returns(uint)
    {
        return data[lot].quantity;
    }
    function getSendAddress(uint lot) returns(address)
    {
        return data[lot].senderAdd;
    }
    function getTemp(uint lot) returns(uint)
    {
        return data[lot].temp;
    }
}
contract Manufacturer {
    struct man_data {
        address manAdd;
        uint prodId;
        uint weight;
        uint quantity;
        uint location;
        uint oldLot;
        address senderAdd;
        uint oldProdId;
    }
    mapping(uint => man_data) data;
    Logistics log;
    uint nLot = 1000;
    uint prodIdnew = 12300;
    uint nLotRich = 10000;
    uint prodIdRich = 34500;
    function compareStrings (string a, string b) view returns (bool){
       return keccak256(a) == keccak256(b);
   }
    function setManData(address logadd, uint lot, uint loc, string id) returns (uint){
        if(compareStrings(id,"local")) {
            log = Logistics(logadd);
            data[nLot].senderAdd = logadd;
            data[nLot].manAdd = msg.sender;
            data[nLot].oldProdId = log.getProductId(lot);
            data[nLot].prodId = prodIdnew;
            data[nLot].weight = log.getWeight(lot);
            data[nLot].quantity = log.getQuantity(lot);
            data[nLot].location = loc;
            data[nLot].oldLot = lot;
            return nLot;
            nLot= nLot + 1;
            prodIdnew = prodIdnew + 1;
        }
        else if(compareStrings(id,"rich")) {
            log = Logistics(logadd);
            data[nLotRich].senderAdd = logadd;
            data[nLotRich].manAdd = msg.sender;
            data[nLotRich].oldProdId = log.getProductId(lot);
            data[nLot].prodId = prodIdRich;
            data[nLotRich].weight = log.getWeight(lot);
            data[nLotRich].quantity = log.getQuantity(lot);
            data[nLotRich].location = loc;
            data[nLotRich].oldLot = lot;
            return nLotRich;
            nLotRich= nLotRich +1;
        }
    }
    function modifyWeight(uint lot, uint weight) returns(uint){
        data[lot].weight = weight;
        return lot;
    }
    function getAddress(uint lot) returns(address)
    {
        return data[lot].manAdd;
    }
    function getProductId(uint lot) returns(uint)
    {
        return data[lot].prodId;
    }
    function getOldProductId(uint lot) returns(uint)
    {
        return data[lot].oldProdId;
    }
    function getWeight(uint lot) returns(uint)
    {
        return data[lot].weight;
    }
    function getQuantity(uint lot) returns(uint)
    {
        return data[lot].quantity;
    }
    function getSendAddress(uint lot) returns(address)
    {
        return data[lot].senderAdd;
    }
}
contract Warehouse {
    struct ware_data {
        address warehouse;
        address provider;
        uint prodId;
        uint weight;
        uint quantity;
        uint location;
        uint temp;
        uint lot;
        address senderAdd;
    }
    Logistics log;
    mapping(uint => ware_data) data;
    function setWareData(address add, uint loc, uint lot) returns(uint){
        log = Logistics(add);
        data[lot].senderAdd = add;
        data[lot].warehouse = msg.sender;
        data[lot].provider = log.getProvider(lot);
        data[lot].prodId = log.getProductId(lot);
        data[lot].weight = log.getWeight(lot);
        data[lot].quantity = log.getQuantity(lot);
        data[lot].location = loc;
        return lot;
    }
    function getAddress(uint lot) returns(address)
    {
        return data[lot].warehouse;
    }
    function getProductId(uint lot) returns(uint)
    {
        return data[lot].prodId;
    }
    function getWeight(uint lot) returns(uint)
    {
        return data[lot].weight;
    }
    function getQuantity(uint lot) returns(uint)
    {
        return data[lot].quantity;
    }
    function getSendAddress(uint lot) returns(address)
    {
        return data[lot].senderAdd;
    }
}
contract Store {
    struct store_data {
        address storename;
        uint prodId;
        uint weight;
        uint quantity;
        uint location;
        address senderAdd;
    }
    Logistics log;
    Farmer farmer;
    Manufacturer man;
    Warehouse ware;
    mapping(uint => store_data) data;
    function setStoreData(address add, uint lot, uint location) returns (uint){
        log = Logistics(add);
        data[lot].senderAdd = add;
        data[lot].storename = msg.sender;
        data[lot].prodId = log.getProductId(lot);
        data[lot].weight = log.getWeight(lot);
        data[lot].quantity = log.getQuantity(lot);
        data[lot].location = location;
        return lot;
    }
    function getSendAddress(uint lot) returns(address)
    {
        return data[lot].senderAdd;
    }
    function getAddress(uint lot) returns(address)
    {
        return data[lot].storename;
    }
    function getProductId(uint lot) returns(uint)
    {
        return data[lot].prodId;
    }
    function getWeight(uint lot) returns(uint)
    {
        return data[lot].weight;
    }
    function getQuantity(uint lot) returns(uint)
    {
        return data[lot].quantity;
    }
}
contract consumer {
    struct cons_data {
        uint prodId;
        address consumer;
    }
    mapping(uint => cons_data) data;
    Logistics log;
    Store store;
    function concat(string _base, string _value) internal returns (string) {
        bytes memory _baseBytes = bytes(_base);
        bytes memory _valueBytes = bytes(_value);
        string memory _tmpValue = new string(_baseBytes.length + _valueBytes.length);
        bytes memory _newValue = bytes(_tmpValue);
        uint i;
        uint j;
        for(i=0; i<_baseBytes.length; i++) {
            _newValue[j++] = _baseBytes[i];
        }
        for(i=0; i<_valueBytes.length; i++) {
            _newValue[j++] = _valueBytes[i++];
        }
        return string(_newValue);
    }
    function getTree(address storeAdd, uint lot) returns (uint p, uint w, uint prodId) {
        store = Store(storeAdd);
        Logistics log ;
        Warehouse ware;
        address storeAddress = store.getAddress(lot);
        // string store_details = store.getQuantity(lot)+":"+store.getWeight(lot)+":"+store.getSendAddress(lot);
        uint weight = store.getWeight(lot);
        uint quantity = store.getQuantity(lot);
        prodId = store.getProductId(lot);
        address log1 = store.getSendAddress(lot);
        log = Logistics(log1);
        address logadd1 = log.getSendAddress(lot);
        uint temp = log.getTemp(lot);
        uint weight1 = log.getWeight(lot);
        (p,w) = getRichNet(lot,logadd1);
    }
    function getRichNet(uint lot,address add) returns (uint p,uint w) {
        Warehouse ware;
        ware = Warehouse(add);
        uint weight = ware.getWeight(lot);
        uint quantity = ware.getQuantity(lot);
        address senderAdd = ware.getSendAddress(lot);
        Logistics log;
        log = Logistics(senderAdd);
        address logadd1 = log.getSendAddress(lot);
        uint temp = log.getTemp(lot);
        getRichNet(lot,logadd1);
        Manufacturer man;
        man = Manufacturer(logadd1);
        address add2 = man.getSendAddress(lot);
        uint prodId =  man.getOldProductId(lot);
        (p,w) = getSupplierNet(prodId, add2);
    }
    function getSupplierNet(uint lot, address add2) returns (uint p, uint w) {
        Logistics log;
        log = Logistics(add2);
        address logadd1 = log.getSendAddress(lot);
        uint temp = log.getTemp(lot);
        uint weight1 = log.getWeight(lot);
        Warehouse ware;
        ware = Warehouse(logadd1);
        uint weight = ware.getWeight(lot);
        uint quantity = ware.getQuantity(lot);
        address senderAdd = ware.getSendAddress(lot);
        log = Logistics(senderAdd);
        address logadd2 = log.getSendAddress(lot);
        (p,w) = getSupplierNet2(logadd2, lot);
    }
    function getSupplierNet2(address add, uint lot) returns (uint prodId, uint weight3){
        Manufacturer man;
        man = Manufacturer(add);
        address add3 = man.getSendAddress(lot);
        prodId =  man.getOldProductId(lot);
        weight3 = man.getWeight(lot);
        Logistics log;
        log = Logistics(add3);
        address logadd1 = log.getSendAddress(prodId);
        uint temp = log.getTemp(prodId);
        uint weight1 = log.getWeight(prodId);
        Farmer farm;
        string output;
        farm = Farmer(logadd1);
        address farmadd = farm.getAddress(prodId);
        uint weight2 = farm.getWeight(prodId);
        uint quantity = farm.getQuantity(prodId);
        // return prodId;
        // return weight3;
    }
}
