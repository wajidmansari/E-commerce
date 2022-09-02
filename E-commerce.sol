// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ecommerce{

    
    enum OrderStatus{
        pending,
        shipped,
        deliverd,
        cancel
         

    }

 
    struct Products{
        string name;
        string desc;
        uint price;
        address seller;
        uint productId;
        address buyer;
        OrderStatus status;
        
    }
    address  owner;
       constructor(){
        owner = msg.sender;
    }

    modifier OnlyOwner{
        require(owner == msg.sender, "you are not seller");
        _;
    }

    mapping(uint=>Products) public ProductDetails;

    function registerProduct( uint _productId, string memory _name, string memory _desc, uint _price) public OnlyOwner {
        require(_price>0, "price should be greater than zero");
        
        ProductDetails[_productId].name = _name;
        ProductDetails[_productId].desc = _desc;
        ProductDetails[_productId].seller = msg.sender;
        ProductDetails[_productId].price = _price;
        
   
    }
   

   function buy(uint _productId) public{
       require(ProductDetails[_productId].buyer != msg.sender, "seller can't buy ");
       ProductDetails[_productId].buyer= msg.sender;

   }


   function delivery(uint _productId) public{
       require(ProductDetails[_productId].buyer == msg.sender, "only buyer can give the status");
       ProductDetails[_productId].status = OrderStatus.deliverd;

   }


}
