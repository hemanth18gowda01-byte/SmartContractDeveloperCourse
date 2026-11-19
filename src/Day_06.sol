//SPDX-License-Identifier:MIT
pragma solidity ^0.8.35;
/*1. Problem statement
Build a smart contract that manages a collection of products.

Each product has:
- Product ID
- Product name
- Price
- Availability status
The contract should allow users to add, update, remove and retrieve products.
2. Functional requirements
Function	Expected behavior
addProduct()	Add a product
updateProduct()	Update product details
removeProduct()	Remove a product
getProduct()	Retrieve a product by index
getAllProducts()	Return all products
getProductCount()	Return total products
findProduct()	Find a product by ID
*/

contract Product {
    error NoProductFound();
    error ProductExists();
    error NotOwner();
    error NotManager();

    address private immutable i_OWNER;
    address private MANAGER;
    uint256 public numberOfProducts;

    constructor(address _manager) {
        i_OWNER = msg.sender;
        MANAGER = _manager;
    }

    modifier Admin() {
        if (msg.sender == i_OWNER) {
            _;
        } else {
            revert NotOwner();
        }
    }

    modifier Manager() {
        if (msg.sender == MANAGER) {
            _;
        } else {
            revert NotOwner();
        }
    }

    struct ProductInfo {
        uint256 productId;
        string productName;
        int256 productPrice;
        bool avalabilityStatus;
    }

    mapping(uint256 => ProductInfo) public productIdToProduct;
    ProductInfo[] public allProducts;

    function addProduct() public Admin Manager {}
    function updateProduct() public Admin Manager {}
    function removeProduct() public Admin Manager {}
    function getProduct() public view returns (ProductInfo) {}
    function getAllProducts() public view returns (ProductInfo[] memory) {}
    function getProductCount() public view returns (uint256) {}
    function findProduct() public pure returns (ProductInfo memory) {}
}
