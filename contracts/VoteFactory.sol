//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./EIP1167.sol";

/**
 * @notice interface to interact with cloned Vote contracts.
 * @dev Used to call the initialize() function given that cloned contracts can't have constructors.
 */
interface VoteInit {
    function initialize(
        uint256 _votingCost,
        uint256 _minVotes,
        uint256 _timeToVote,
        address _sender
    ) external;
}

contract VoteFactory is MinimalProxy {
    address internal immutable admin;
    address internal voteImpl; //Adress of the vote contract to be cloned

    /**
     * @dev custom errors
     */
    error InvalidVote();
    error unauthorized();

    /**
     * @dev events
     */
    event EthReceived(address _sender, uint256 _amount);

    constructor() {
        admin = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != admin) revert unauthorized();
        _;
    }

    /**
     * @dev change implementation adress, only callable by admin
     * @param _newVoteImpl adress of the new implemention/contract to be cloned
     */
    function changeImpl(address _newVoteImpl) public onlyOwner {
        voteImpl = _newVoteImpl;
    }

    /**
     * @notice function to create an instance of Vote.sol
     * @dev clone and init Vote function
     * @param _votingCost should be N usd, info gathered in the front-end
     * @param _minVotes minimal votes to win, determines entrerprise level
     * @param _timeToVote days to vote, should be at least N days.
     */
    function createVote(
        uint256 _votingCost,
        uint256 _minVotes,
        uint256 _timeToVote
    ) public payable {
        if (_votingCost > 0 || _minVotes > 50 || _timeToVote > 5)
            revert InvalidVote();
        _createVote (_votingCost, _minVotes, _timeToVote, msg.sender);
    }

    function _createVote (
        uint256 _votingCost,
        uint256 _minVotes,
        uint256 _timeToVote,
        address _sender
    ) internal {
        address voteproxy = this.deployMinimal(voteImpl);
        VoteInit(voteproxy).initialize(
            _votingCost,
            _minVotes,
            _timeToVote,
            _sender
        );
    }

    /**
     * @dev  Fallbacks functions
     */
    fallback() external payable {}

    receive() external payable {
        emit EthReceived(msg.sender, msg.value);
    }

    /**
     * @dev get vote impl address
     * @return address addr of the implementation
     */
    function getImplAddr() external view returns (address) {
        return voteImpl;
    }

    /**
     * @dev get adm addr
     * @return address addr of contract admin
     */
    function getAdmin() external view returns (address) {
        return admin;
    }
}
