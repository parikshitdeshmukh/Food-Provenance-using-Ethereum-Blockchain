pragma solidity ^0.4.16;
import "github.com/ethereum/dapp-bin/library/stringUtils.sol";
contract Farmer{
    enum farmer_type{dairy,vegetable,grain}
    struct farmer_data {
        address farmer_address;
        uint farmer_type;
        uint weight;
        uint quantity;
        uint256 timestamp;
        string location;
       // uint lot;
    }
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
    }
   function stringToBytes32(string memory source) returns (bytes32 result) {
    bytes memory tempEmptyStringTest = bytes(source);
    if (tempEmptyStringTest.length == 0) {
        return 0x0;
    }
    assembly {
        result := mload(add(source, 32))
    }
}
   function bytes32ToString (bytes32 data) returns (string) {
    bytes memory bytesString = new bytes(32);
    for (uint j=0; j<32; j++) {
        byte char = byte(bytes32(uint(data) * 2 ** (8 * j)));
        if (char != 0) {
            bytesString[j] = char;
        }
    }
    return string(bytesString);
}
    // function getData(uint lot) returns(string)
    // {
    //     return bytes32ToString(data[lot].product);
    // }
    // function getProduct(uint lot) returns(bytes32)
    // {
    //     return data[lot].product;
    // }
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
contract Logistics is Farmer,Manufacturer{
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
    }
    mapping(uint => log_data) data;
    Farmer farmer;
    Logistics log;
    function setLogData(address add, uint lot1, uint temp1, string id) returns (uint)
    {
    if(StringUtils.equal(id,"farmer")) {
        farmer = Farmer(add);
        data[lot1].logaddress = msg.sender;
        data[lot1].provider = farmer.getAddress(lot1);
        data[lot1].weight = farmer.getWeight(lot1);
        data[lot1].quantity = farmer.getQuantity(lot1);
        data[lot1].temp = temp1;
        data[lot1].farmerType = farmer.getType(lot1);
        return lot1;
        }
    else if(StringUtils.equal(id,"3pl")) {
        log = Logistics(add);
        data[lot1].logaddress = msg.sender;
        data[lot1].provider = farmer.getAddress(lot1);
        data[lot1].weight = farmer.getWeight(lot1);
        data[lot1].quantity = farmer.getQuantity(lot1);
        data[lot1].temp = temp1;
        data[lot1].farmerType = farmer.getType(lot1);
        return lot1;
    }
    }
    function getfarmerAdderss(uint lot) returns(address)
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
}
contract Manufacturer {
    struct man_data {
        address manAdd;
        uint prodId;
        uint weight;
        uint quantity;
        uint location;
        uint Nlot;
    }
    mapping(uint => man_data) data;
    Logistics log;
    uint nLot = 1000;
    function setManData(address logadd, uint lot, uint loc) returns (uint){
        log = Logistics(logadd);
        data[lot].manAdd = msg.sender;
        data[lot].prodId = log.getProductId(lot);
        data[lot].weight = log.getWeight(lot);
        data[lot].quantity = log.getQuantity(lot);
        data[lot].location = loc;
        data[lot].Nlot = nLot;
        nLot= nLot +1;
        return data[lot].Nlot;
    }
}