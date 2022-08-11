//SPDX-License-Identifier: MIT

/**
 * @title Token contract
 * @author Matias Arazi & Lucas Grasso Ramos
 * @notice MultiSig, Semi-Fungible, SoulBound Token standard for academic certification.
 */

pragma solidity ^0.8.4;

import "./SBTERC1155.sol";

contract Badge is SBTERC1155 {

    constructor(string memory _uri, string memory _name, string memory _symbol) SBTERC1155(_uri, _name, _symbol) {
    }

    function mint(string memory data) external {
        _mint(msg.sender, data);
    }

    function burn(uint256 id) external {
        _burn(msg.sender, id);
    }
}