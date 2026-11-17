//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
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
    int256 public numberOfCandidates = 0;

    error AlreadyVoted();

    struct Candidate {
        bytes32 CandidateId;
        string CandidateName;
        int256 NumberOfVotes;
    }

    mapping(address => Candidate) public addressToCandidate;

    function addCandidate(bytes32 _candidateId, string memory _candidateName, int256 _numberOfVotes) public {
        addressToCandidate[msg.sender] =
            Candidate({CandidateId: _candidateId, CandidateName: _candidateName, NumberOfVotes: _numberOfVotes});
        numberOfCandidates += 1;
    }

    function vote() public {
        if (addressToCandidate[msg.sender].NumberOfVotes == 0) {
            addressToCandidate[msg.sender].NumberOfVotes = 1;
        } else {
            revert AlreadyVoted();
        }
    }

    function getCondidate(address _address) public view returns (Candidate memory) {
        return addressToCandidate[_address];
    }

    function getCandidateCount() public view returns (int256) {
        return numberOfCandidates;
    }
    function getWinner() public {}
}

/*
Voting rules
1. Only registered candidates can receive votes.
2. Each wallet address can vote only once.
3. Votes must be recorded correctly.
4. The winner should be determined based on the highest vote count.
5. If there are no candidates, winner retrieval should revert.*/