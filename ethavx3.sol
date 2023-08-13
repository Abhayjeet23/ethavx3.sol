// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    string public tokenName;
    string public tokenSymbol;
    uint256 public totalTokenSupply;
    address public ownerAddress;
    mapping(address => uint256) public balances;

    constructor(string memory _tokenName, string memory _tokenSymbol, uint256 _initialSupply) {
        tokenName = _tokenName;
        tokenSymbol = _tokenSymbol;
        totalTokenSupply = _initialSupply;
        ownerAddress = msg.sender;
        balances[msg.sender] = _initialSupply;
    }

    modifier onlyOwner() {
        require(msg.sender == ownerAddress, "Only owner");
        _;
    }

    function transferTokensTo(address to, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Not enough tokens");
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function destroyTokens(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Not enough tokens");
        balances[msg.sender] -= amount;
        totalTokenSupply -= amount;
    }

    function createTokens(address to, uint256 amount) public onlyOwner {
        balances[to] += amount;
        totalTokenSupply += amount;
    }
}
