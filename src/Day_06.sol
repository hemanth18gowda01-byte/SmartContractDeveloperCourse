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
findProduct()	Find a product by ID*/

contract Product {
    error NoProductFound();
    error ProductExists();
    error NotOwner();
    error NotManager();

    address private immutable i_OWNER;
    address private MANAGER;
    uint256 public numberOfProducts = 0;

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

    function addProduct(uint256 _productId, string calldata _productName, int256 _productPrice) public Admin Manager {
        productIdToProduct[_productId] = ProductInfo({
            productId: _productId, productName: _productName, productPrice: _productPrice, avalabilityStatus: true
        });
        allProducts.push(productIdToProduct[_productId]);
        numberOfProducts += 1;
    }

    function updateProduct(uint256 _productId, string calldata _productName, int256 _productPrice, bool _status)
        public
        Admin
        Manager
    {
        for (uint256 i = 0; i < allProducts.length; i++) {
            if (allProducts[i].productId == _productId) {
                ProductInfo memory updated = ProductInfo({
                    productId: _productId,
                    productName: _productName,
                    productPrice: _productPrice,
                    avalabilityStatus: _status
                });

                productIdToProduct[_productId] = updated;
                allProducts[i] = updated;
            }
        }

        revert NoProductFound();
    }

    function removeProduct(uint256 _productId) public Admin Manager {
        for (uint256 i = 0; i < allProducts.length; i++) {
            if (allProducts[i].productId == _productId) {
                delete productIdToProduct[_productId];

                allProducts[i] = allProducts[allProducts.length - 1];
                allProducts.pop();
                numberOfProducts -= 1;
            }
        }

        revert NoProductFound();
    }

    function getProduct(uint256 _productId) public view returns (ProductInfo memory) {
        for (uint256 i = 0; i < allProducts.length; i++) {
            if (allProducts[i].productId == _productId) {
                return allProducts[i];
            }
        }
        revert NoProductFound();
    }
    function getAllProducts() public view returns (ProductInfo[] memory) {}
    function getProductCount() public view returns (uint256) {}
    function findProduct(uint256 _productId) public pure returns (ProductInfo memory) {}
}
