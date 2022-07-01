//SPDX-License-Identifier: MIT

/**
 * @title Token contract
 * @author Matias Arazi & Lucas Grasso Ramos
 * @notice MultiSig, Semi-Fungible, SoulBound Token standard for academic certification.
 */

pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "./ISBTDoubleSig.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";


contract ERC1415 is Context, ERC165, IERC1415 {

    uint256 private nonce;
    mapping(uint256 => Token) public tokens; // id to Token
    mapping(uint256 => uint256) public amount; // the amounts of tokens for each Token
    mapping(address => mapping(uint256 => bool)) internal owners; // if owner has a specific Token
    mapping(address => mapping(uint256 => bool)) internal pending; // if owner has pending a specific Token

    struct Token {
        address owner;
        string data;
    }

    error Unauthorized(address _sender);
    error AlreadyOwned(uint256 _id);
    error AlreadyAwaitingClaim(uint256 _id);
    error NotEligableToClaim(uint256 _id);
    error NotAnEntity(address _sender);
    error CeroTokensIn(uint256 _id);

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    //Function
    function mint(string calldata _data) external virtual {
        address minter = _msgSender();
        _mint(minter, _data);
    }

    function _mint(address _account, string memory _data) internal virtual {
        unchecked{++nonce;}
        _beforeTokenClaim(_account, nonce);
        tokens[nonce] = Token(_account, _data);
        amount[nonce] = 0;
        console.log("Token minted from %s, nonce: %s",msg.sender,nonce);
        emit TokenTransfer(0,msg.sender, nonce);
        _afterTokenClaim(_account, nonce);
    }

    function transfer(uint256 _id, address calldata _to) external virtual override {
        address from = _msgSender();
        if (tokens[_id].owner != from)
            revert Unauthorized(from);
        _transferBath(from, _id, _to);
    }

    function _transfer(address _from, uint256 _id, address memory _to ) internal virtual {
        if (owners[_to][_id] != false)
            revert AlreadyOwned(_id);
        if (pending[_to][_id] != false)
            revert AlreadyAwaitingClaim(_id);
        _beforeTokenTransfer(_from, _to, nonce, 1);
        pending[_to][_id] = true;
        emit TokenTransfer(_from, dest, _id);
        _afterTokenTransfer(_from, _to, nonce, 1);
    }
    
    function transferBatch(uint256 _id, address[] calldata _to) external virtual override {
        address from = _msgSender();
        if (tokens[_id].owner != from)
            revert Unauthorized(from);
        _transferBath(from, _id, _to);
    }

    function _transferBatch(address _from, uint256 _id, address[] memory _to ) internal virtual {
        for (uint256 i = 0; i < _to.length; ) {
            address _dest = _to[i];
            if (owners[_dest][_id] != false)
                revert AlreadyOwned(_id);
            if (pending[_dest][_id] != false)
                revert AlreadyAwaitingClaim(_id);
            _transfer(_from, _id, _dest);
            unchecked {++i;}
        }
    }

    function claim(uint256 _id) external virtual {
        address claimer = _msgSender();
        _claim(claimer, _id);
    }

    function _claim(address account, uint256 _id) internal virtual {
        if (owners[account][_id] != false || pending[account][_id] != true)
            revert NotEligableToClaim(_id);
        _beforeTokenClaim(account, _id);
        owners[account][_id] = true;
        pending[account][_id] = false;
        amount[_id]++;
        emit TokenClaimed(account, true, _id);
        _afterTokenClaim(account, _id);
    }

    function reject(uint256 _id) external virtual {
        address sender = _msgSender();
        _reject(sender, _id);
    }

    function _reject(address account, uint256 _id) internal virtual {
        if (owners[account][_id] != false || pending[account][_id] != true)
            revert NotEligableToClaim(_id);
        owners[account][_id] = false;
        pending[account][_id] = false;
        emit Claim (account, false, _id);
    }

    function burn(uint256 _id) external virtual {
        if(owners[msg.sender][_id] == true)
            revert Unauthorized(msg.sender);
        if(amount[_id] <= 0)
            revert CeroTokensIn(_id);
        _burn(_id);
    }

    function _burn(uint256 _id) internal virtual {
        owners[msg.sender][_id] = false;
        amount[_id]--;
        emit TokenTransfer(msg.sender, 0, _id);
    }

    /**
     * @dev Hook that is called before any minting of tokens.
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 id,
        uint256 amount
    ) internal virtual {}
    /**
     * @dev Hook that is called after any transfer of tokens. This includes
     * minting and burning.
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 id,
        uint256 amount
    ) internal virtual {}

    /**
     * @dev Hook that is called before any token claim.
     */
    function _beforeTokenClaim(
        address newOwner,
        uint256 id
    ) internal virtual {}
    /**
     * @dev Hook that is called after any token claim.
     */
    function _afterTokenClaim(
        address newOwner,
        uint256 id
    ) internal virtual {}
}
