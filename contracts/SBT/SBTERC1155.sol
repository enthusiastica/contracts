//SPDX-License-Identifier: MIT

/**
 * @title Token contract
 * @author Matias Arazi & Lucas Grasso Ramos
 * @notice MultiSig, Semi-Fungible, SoulBound Token standard for academic certification.
 */

pragma solidity ^0.8.4;


import "./ISBTDS.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SBTDS is Context, ERC165, IERC1155 {

    uint256 private nonce;

    // Used as the URI for all token types by relying on ID substitution, e.g. https://token-cdn-domain/{id}.json
    string private _uri;

    // Mapping to token id to Token struct[creator, data(IPF-Hash)]
    mapping(uint256 => Token) internal tokens; // id to Token

    // Mapping from token ID to account balances
    mapping(address => mapping(uint256 => bool)) internal _balances; 

    // Mapping from address to mapping id bool that states if address has tokens(under id) awaiting to be claimed
    mapping(address => mapping(uint256 => bool)) internal pending;

    /**
     * @dev Main token struct.
     * @param creator Minter/Creator of the token
     * @param data IPFS Hash of the token
     */
    struct Token {
        address creator;
        string data;
    }

    /**
     * @dev Sets base uri for tokens. Preferably "https://ipfs.io/ipfs/"
     */
    constructor(string memory uri_) {
        _uri = uri_;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return
            interfaceId == type(IERC1155).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC1155-balanceOf}.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function balanceOf(address account, uint256 id) public view virtual override returns (uint256) {
        require(account != address(0), "SBTERC1155: address zero is not a valid owner");
        if(_balances[account][id]) {
            return 1;  
        }
        else {
            return 0;
        }
        
    }

    /**
     * @dev See {IERC1155-balanceOfBatch}.
     *
     * Requirements:
     *
     * - `accounts` and `ids` must have the same length.
     */
    function balanceOfBatch(address[] memory accounts, uint256[] memory ids)
        public
        view
        virtual
        override
        returns (uint256[] memory)
    {
        require(accounts.length == ids.length, "SBTERC1155: accounts and ids length mismatch");

        uint256[] memory batchBalances = new uint256[](accounts.length);

        for (uint256 i = 0; i < accounts.length; ++i) {
            batchBalances[i] = balanceOf(accounts[i], ids[i]);
        }

        return batchBalances;
    }

    /**
     * @dev See {ISBTDoubleSig-ownerOf}.
     */
    function creatorOf(uint256 _id)
        external
        view
        virtual
        returns (address)
    {
        return (tokens[_id].creator);
    }

    /**
     * @dev See {ISBTDoubleSig-uriOf}.
     */
    function uriOf(uint256 _id)
        external
        view
        virtual
        returns (string memory)
    {
        return string(abi.encodePacked(_uri, tokens[_id].data));
    }

    /**
     * @dev See {ISBTDoubleSig-tokensFrom}.
     */
    function tokensFrom(address _from)
        public
        view
        virtual
        returns (uint256[] memory)
    {
        uint256 _tokenCount = 0;
        for (uint256 i = 1; i <= nonce; ) {
            if (_balances[_from][i]) {
                unchecked {
                    ++_tokenCount;
                }
            }
            unchecked {
                ++i;
            }
        }
        uint256[] memory _ownedTokens = new uint256[](_tokenCount);
        for (uint256 i = 1; i <= nonce; ) {
            if (_balances[_from][i]) {
                _ownedTokens[--_tokenCount] = i;
            }
            unchecked {
                ++i;
            }
        }
        return _ownedTokens;
    }

    function tokensURIFrom(address _from)
        external
        view
        virtual
        returns (string[] memory)
    {
        (uint256[] memory ownedTokens) = tokensFrom(_from);
        uint256 _nTokens = ownedTokens.length;
        string[] memory tokenURIS = new string[](_nTokens);
        
        for (uint256 i = 0; i < _nTokens; ) {
            tokenURIS[i] = string(
                abi.encodePacked(_uri, tokens[ownedTokens[i]].data)
            );

            unchecked {
                ++i;
            }
        } 
        return tokenURIS;
    }

    /**
     *@dev mints(creates) a token
     *@param _account address who will mint the token
     *@param _data the uri of the token
     */
    function _mint(address _account, string memory _data) internal virtual {

        unchecked {
            ++nonce;
        }

        address operator = _msgSender();
        uint256[] memory ids = _asSingletonArray(nonce);
        uint256[] memory amounts = _asSingletonArray(1);
        bytes memory _bData = bytes(_data);

        _beforeTokenTransfer(operator, address(0), operator, ids, amounts, _bData);
        tokens[nonce] = Token(_account, _data);
        emit TransferSingle(operator, address(0), operator, nonce, 1);
        _afterTokenTransfer(operator, address(0), operator, ids, amounts, _bData);
    }

    /**
     * @dev See {IERC1155-safeTransferFrom}.
     * Requirements:
     * - from must be id creator(minter)
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        require(from == tokens[id].creator, "SBTERC1155: caller is not creator");
        _safeTransferFrom(from, to, id, amount, data);
    }

    /**
     * @dev See {SBTERC1155-safeBatchTransfer}.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) external override {
        require(to != address(0), "SBTERC1155: transfer to the zero address");
        _safeBatchTransferFrom(from, to, ids, amounts, data);
    }

    function safeMultiTransfer (
        address from,
        address[] memory to,
        uint256 id
    ) public virtual {
        require(from == tokens[id].creator, "SBTERC1155: caller is not creator");
        _safeMultiTransfer(from, to, id);
    }

    /**
     * @dev Transfers `amount` tokens of token type `id` from `from` to `to`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - `from` must have a balance of tokens of type `id` of at least `amount`.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155Received} and return the
     * acceptance magic value.
     */
    function _safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(from == tokens[id].creator, "SBTERC1155: caller is not creator");
        require(to != address(0), "SBTERC1155: transfer to the zero address");
        require(amount == 1, "SBTERC1155: can only transfer one token");
        require(_balances[to][id] == false, "SBTERC1155: Already owned");
        require(pending[to][id] == false, "SBTERC1155: Already owned");

        address operator = _msgSender();
        uint256[] memory ids = _asSingletonArray(id);
        uint256[] memory amounts = _asSingletonArray(amount);

        _beforeTokenTransfer(operator, from, to, ids, amounts,data);

        pending[to][id] = true;

        emit TransferSingle(operator, operator, to, nonce, amount);
        _afterTokenTransfer(operator, from, to, ids, amounts,data);

    }

    function _safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) external override {

        address operator = _msgSender();

        _beforeTokenTransfer(operator, from, to, ids, amounts, data);

        uint256 totalIds = ids.length;
        
        for(uint256 i = 0; i < totalIds;){
            require(_balances[to][ids[i]] == false, "SBTERC1155: Already owned");
            require(pending[to][ids[i]] == false, "SBTERC1155: Already owned");
            pending[to][ids[i]] = true;
            unchecked {
                ++i;
            }
        }

        emit TransferBatch(operator, from, to, ids, amounts);

        _afterTokenTransfer(operator, from, to, ids, amounts,data);
    }

    /**
     * @dev 
     * @dev requirements See {SBTERC1155-safeTransfer}.
     */
    function _safeMultiTransfer(
        address from,
        address[] memory to,
        uint256 id
    ) internal virtual {
        require(from == tokens[id].creator, "SBTERC1155: caller is not creator");

        uint256 TotalDestinataries = to.length;

        for (uint256 i = 0; i < TotalDestinataries; ) {
            address _dest = to[i];
            require(_dest != address(0), "SBTERC1155: transfer to the zero address");
        }

        for (uint256 i = 0; i < to.length; ) {
            address _dest = to[i];

            require(_balances[_dest][id] == false, "SBTERC1155: Already owned");
            require(pending[_dest][id] == false, "SBTERC1155: Already owned");

            pending[_dest][id] = true;

            unchecked {
                ++i;
            }
        }
    }

    
     /**
     * @dev Hook that is called before any token transfer. This includes minting
     * and burning, as well as batched variants.
     *
     * The same hook is called on both single and batched variants. For single
     * transfers, the length of the `ids` and `amounts` arrays will be 1.
     *
     * Calling conditions (for each `id` and `amount` pair):
     *
     * - When `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * of token type `id` will be  transferred to `to`.
     * - When `from` is zero, `amount` tokens of token type `id` will be minted
     * for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens of token type `id`
     * will be burned.
     * - `from` and `to` are never both zero.
     * - `ids` and `amounts` have the same, non-zero length.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {}

    /**
     * @dev Hook that is called after any token transfer. This includes minting
     * and burning, as well as batched variants.
     *
     * The same hook is called on both single and batched variants. For single
     * transfers, the length of the `id` and `amount` arrays will be 1.
     *
     * Calling conditions (for each `id` and `amount` pair):
     *
     * - When `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * of token type `id` will be  transferred to `to`.
     * - When `from` is zero, `amount` tokens of token type `id` will be minted
     * for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens of token type `id`
     * will be burned.
     * - `from` and `to` are never both zero.
     * - `ids` and `amounts` have the same, non-zero length.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {}

    function _asSingletonArray(uint256 element) private pure returns (uint256[] memory) {
        uint256[] memory array = new uint256[](1);
        array[0] = element;

        return array;
    }

    /**
     * @dev Disabled function
     * @dev See {IERC1155-setApprovalForAll}.
     */
    function setApprovalForAll(address operator, bool approved) public virtual override {}

    /**
     * @dev Disabled function
     * @dev See {IERC1155-isApprovedForAll}.
     */
    function isApprovedForAll(address account, address operator) public view virtual override returns (bool) {}
}
