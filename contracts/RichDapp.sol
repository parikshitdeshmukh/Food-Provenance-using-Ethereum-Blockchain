pragma solidity ^0.4.16;
contract RichDapp{
    address farmer_address;
    address PL_address;
    address man_address;
    address warehouse_address;
    address store_address;
    uint _3count=100;
    uint _4count=1000;
    
    struct farmer_data {
        address farmer_address;
        uint farmer_type;
        string product;
        uint weight;
        uint quantity;
        uint256 timestamp;
        string location;
    }
    struct PL_data{
        address PL_address;
        string product;
        uint weight;
        uint quantity;
        uint256 timestamp;
        address inbound;
        address outbound;
        uint temperature;
        uint lot;
    }
    struct manufacture_data{
        address man_address;
         string product;
        uint weight;
        uint quantity;
        uint256 timestamp;
        string location;
        uint old_lot;
    }
    struct warehouse_data{
        address ware_address;
        string product;
         uint weight;
        uint quantity;
        uint256 timestamp;
        string location;
        uint temperature;
        uint lot;
    }
    struct store_data{
        address store_address;
        string product;
        uint weight;
        uint quantity;
        string location;
        uint lot;
    }
    mapping(uint => farmer_data) public fdata;
    mapping(uint => PL_data) public PLdata;
    mapping(uint => manufacture_data) public mdata;
    mapping(uint => warehouse_data) public wdata;
    mapping(uint => store_data) public sdata;
    function RichDapp(address fa,address pa,address ma,address wa,address sa)
    {
     farmer_address=fa;
     PL_address=pa;
     man_address=ma;
     warehouse_address=wa;
     store_address=sa;
    }
    function generate3Lot() returns(uint)
    {
        _3count = _3count+1;
        return _3count;
    }
    function generate4Lot() returns(uint)
    {
        _4count = _4count+1;
        return _4count;
    }
    function getFarmerData(uint farmer_type,string product,uint weight,uint quantity,string location) returns (uint)
    {
       // require(msg.sender==farmer_address);
       uint lot = generate3Lot();
       fdata[lot].farmer_address=msg.sender;
       fdata[lot].farmer_type=farmer_type;
       fdata[lot].product=product;
       fdata[lot].weight=weight;
       fdata[lot].quantity=quantity;
       fdata[lot].timestamp=now;
       fdata[lot].location=location;
      // return fdata[lot].product;
      return lot;
    }
    function getPLData(uint lot,address inbound,address outbound,uint temperature) returns(uint,string)
    {
        // require(msg.sender==PL_address);
       require(provider=farmer_address);
        PLdata[lot].PL_address=msg.sender;
        PLdata[lot].timestamp=now;
        PLdata[lot].inbound=inbound;
        PLdata[lot].outbound=outbound;
        PLdata[lot].temperature=temperature;
        PLdata[lot].lot=lot;
        if ((lot/1000)<=0 )
        {
        PLdata[lot].product= fdata[lot].product;
        PLdata[lot].weight=fdata[lot].weight;
        PLdata[lot].quantity=fdata[lot].quantity;
        return (lot,PLdata[lot].product);
        }
        else
        {
        PLdata[lot].product= mdata[lot].product;
        PLdata[lot].weight=mdata[lot].weight;
        PLdata[lot].quantity=mdata[lot].quantity;
        return (lot,PLdata[lot].product);
        }
        
    }
    function getManufacturerData(uint lot,string location,string product,uint quantity,uint weight) returns (uint)
    {
        // require(msg.sender==man_address);
        uint new_lot=generate4Lot();
        mdata[new_lot].man_address=msg.sender;
        mdata[new_lot].product=product;
        mdata[new_lot].quantity=quantity;
        mdata[new_lot].timestamp=now;
        mdata[new_lot].location=location;
        mdata[new_lot].weight=weight;
        mdata[new_lot].old_lot=lot;
        return new_lot;
    }
    function getWareHouseData(uint lot,string location) returns (string)
    {
        // require(msg.sender==warehouse_address);
        wdata[lot].ware_address=msg.sender;
        wdata[lot].product=PLdata[lot].product;
        wdata[lot].weight=PLdata[lot].weight;
        wdata[lot].quantity=PLdata[lot].quantity;
        wdata[lot].location=location;
        wdata[lot].temperature=PLdata[lot].temperature;
        wdata[lot].lot=lot;
        return wdata[lot].product;
    }
    function getStoreData(uint lot,string location) returns(string)
    {
        // require(msg.sender==store_address);
        sdata[lot].store_address=msg.sender;
        sdata[lot].product= PLdata[lot].product;
        sdata[lot].quantity=PLdata[lot].quantity;
        sdata[lot].weight=PLdata[lot].weight;
        sdata[lot].location=location;
        sdata[lot].lot=lot;
        return sdata[lot].product;
    }
    function queryStoreData(uint lot) returns (address,string,string,uint,uint)
    {
        uint query_lot=lot;
        return (sdata[lot].store_address,sdata[lot].product,sdata[lot].location,sdata[lot].quantity,sdata[lot].weight);
        
    }
    function queryWareHouseData(uint lot) returns (address,string,string,uint,uint)
    {
        uint query_lot=lot;
        return (wdata[lot].ware_address,wdata[lot].product,wdata[lot].location,wdata[lot].quantity,wdata[lot].weight); 
    }
    function queryManufacturerData(uint lot) returns (address,string,string,uint,uint)
    {
        uint query_lot=lot;
       return (mdata[lot].man_address,mdata[lot].product,mdata[lot].location,mdata[lot].quantity,mdata[lot].weight); 
    }
    function queryGetPLData(uint lot) returns (address,string,uint,uint,uint)
    {
       uint query_lot=lot;
    return (PLdata[lot].PL_address,PLdata[lot].product,PLdata[lot].temperature,PLdata[lot].quantity,PLdata[lot].weight);  
    }
    function queryGetFarmerData(uint lot) returns (address,string,string,uint,uint)
    {
         uint query_lot=lot;
        return (fdata[lot].farmer_address,fdata[lot].product,fdata[lot].location,fdata[lot].quantity,fdata[lot].weight); 
    }
}