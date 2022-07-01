// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

/**
 * @dev Interface of the MSSBT
 */
interface ISBTDoubleSig {

    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event TokenTransfer(
        address indexed _from,
        address indexed _to,
        uint256 _id
    );

    /**
     * @dev Emitted when `_newOwner` claims or rejects pending `tokenId`.
     */
    event TokenClaimed(
        address indexed _newOwner,
        bool claimed,
        uint256 _id
    );

    /**
     * @dev Get URI 
     * @return string of the URI
     */
    function uri() external view returns (string memory);

    /**
     * @dev get ownerOf a toke, given an ID
     * @param _id uint256 of the ID to be queried
     * @return address address of the owner of the given ID.
     */
    function ownerOf(uint256 _id) external view returns(address);

    /**
     * @dev Get URI of a ID
     * @param _id uint256 of the ID to be queried
     * @return string URI of the ID
     */
    function uriOf(uint256 _id) external view  returns(string memory);

    /**
     * @dev get amount of tokens under ID(Semi-Fungible)
     * @param _id uint256 of the ID to be queried
     * @return uint256 number of tokens under ID
     */
    function amountOf(uint256 _id) external view returns(uint256);

    /**
     * @dev get tokens owned by a given address
     * @param _from addres to get owned tokens from
     * @return uint256[] IDs of all tokens owned by address.
     */
    function tokensFrom(address _from) external view returns(uint256[] memory);

    /**
     * @dev get tokens pending to be claimed by a given address
     * @param _from addres to get pending tokens from
     * @return uint256[] IDs of all tokens pending to be claimed by address.
     */
    function pendingFrom(address _from) external view returns(uint256[] memory);

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - pending[_to][_id] MUST be false
     * - `to` cannot own a token under _tokenId at call.
     * Emits a {TokenTransfer} event.
     */
    function transfer(address _from, uint256 id , address to) external returns (bool);

    function transferBatch(
        uint256 id,
        address[] memory to
    ) external returns (bool);

    

}