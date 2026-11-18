//SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;
/*1. Problem statement
Build a decentralized voting contract where users can vote for registered candidates.

The contract should maintain candidate information and prevent users from voting more than once.
2. Functional requirements
Function	Expected behavior
addCandidate()	Register a new candidate
vote()	Allow a user to vote
getCandidate()	Retrieve candidate information
getCandidateCount()	Return number of candidates
getWinner()	Identify candidate with most votes
Candidate information
Each candidate should have:
- Candidate ID
- Candidate name
- Number of votes*/

contract VotingSystem {
    uint256 public numberOfCandidates = 0;
    address immutable i_OWNER;

    error AlreadyVoted();
    error NotAdmin();
    error NoCandidateFound();

    constructor() {
        i_OWNER = msg.sender;
    }

    modifier onlyAdmin() {
        if (msg.sender == i_OWNER) {
            _;
        } else {
            revert NotAdmin();
        }
    }

    struct Candidate {
        bytes32 candidateId;
        string candidateName;
        int256 numberOfVotes;
    }

    mapping(address => Candidate) public addressToCandidate;
    address[] public voters;
    address[] public candidateAddresses;

    function addCandidate(bytes32 _candidateId, string memory _candidateName, int256 _numberOfVotes) public {
        addressToCandidate[msg.sender] =
            Candidate({candidateId: _candidateId, candidateName: _candidateName, numberOfVotes: _numberOfVotes});
        numberOfCandidates += 1;
    }

    function vote(address _candidateAddress) public {
        require(addressToCandidate[_candidateAddress].candidateId != "", NoCandidateFound());
        for (uint256 i = 0; i < voters.length; i++) {
            if (msg.sender != voters[i]) {
                voters.push(msg.sender);
                addressToCandidate[_candidateAddress].numberOfVotes += 1;
            } else {
                revert AlreadyVoted();
            }
        }
    }

    function getCandidate(address _address) public view returns (Candidate memory) {
        if (_address != address(0)) {
            return addressToCandidate[_address];
        } else {
            revert NoCandidateFound();
        }
    }

    function getCandidateCount() public view returns (uint256) {
        return numberOfCandidates;
    }

    function getWinner() public view returns (Candidate memory) {
        if (candidateAddresses.length == 0) revert NoCandidateFound();

        Candidate memory winner = addressToCandidate[candidateAddresses[0]];

        for (uint256 j = 1; j < candidateAddresses.length; j++) {
            Candidate memory current = addressToCandidate[candidateAddresses[j]];
            if (current.numberOfVotes > winner.numberOfVotes) {
                winner = current;
            }
        }

        return winner;
    }
}

/*
Voting rules
1. Only registered candidates can receive votes.
2. Each wallet address can vote only once.
3. Votes must be recorded correctly.
4. The winner should be determined based on the highest vote count.
5. If there are no candidates, winner retrieval should revert.*/