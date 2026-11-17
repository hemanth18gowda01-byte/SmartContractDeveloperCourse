//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

/*
Problem statement
Create a smart contract that manages student information on the blockchain.
Your contract should support the following operations:
1. Store a student's name.
2. Store their age.
3. Store their university name.
4. Store their student ID.
5. Allow the student information to be updated.
6. Retrieve the stored student information.*/

contract StudentInfo{
    string public StudentName;
    int256 public Age;
    string public UniversityName;
    string public StudentId;
    address immutable i_OWNER;

    error NotOwner();

    constructor(){
        i_OWNER = msg.sender;
    }

    modifier onlyAdmin() {
        if (msg.sender == i_OWNER){
            _;
        }
        else{
            revert NotOwner();
        }
    }

    struct StudentDetails {
        string _studentName;
        int256 _studentAge;
        string _universityName;
        string _studentId;
    }

    mapping(string=>StudentDetails) public studentPersonalDetails;

    function updateStoragedData(string memory _studentName,
    int256 _age,
    string memory _universityName,
    string memory _studentId) onlyAdmin public {
        studentPersonalDetails[_studentId]=StudentDetails({_studentName:_studentName,
        _studentAge:_age,
        _universityName:_universityName,
        _studentId:_studentId});
    }

    function revertStudentDetails(string calldata _studentId) public view virtual returns(StudentDetails memory){
        return studentPersonalDetails[_studentId];
    }
}


/* Requirements
- Use appropriate Solidity data types.
- Use a constructor to initialize the contract.
- Create separate functions for updating and retrieving information.
- Use appropriate visibility.
- Make sure the getter does not modify state.
Restrictions
- Don't use structs yet.
- Don't use mappings yet.
- Don't use inheritance.
- Don't copy code from tutorials.*/