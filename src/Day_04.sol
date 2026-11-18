//SPDX-License-Identifier:MIT
pragma solidity ^0.8.35;
/*1. Problem statement
Build a Student Registry smart contract that allows an administrator to register, update, suspend, reactivate and remove student records.

Each student should have a unique student ID.
2. Functional requirements
Function	Expected behavior
registerStudent() -	Register a new student
updateStudent() -	Update student information
suspendStudent() -	Suspend a student
reactivateStudent() -	Reactivate a suspended student
removeStudent() -	Remove a student
getStudent() -	Retrieve student information
getTotalStudents() -	Return the number of registered students

Student information
Each student should contain:
- Student name
- Age
- Student status*/

contract StudentRegistrty{

    error NotAdmin();
    error NotRegistered();
    
    address immutable i_OWNER;
    uint256 public numberOfStudents;

    constructor(){
        i_OWNER=msg.sender;
        numberOfStudents=0;
    }

    modifier onlyAdmin(){
        if (msg.sender==i_OWNER){
            _;
        }
        else {
            revert NotAdmin();
        }
    }
    enum StudentStatus{
        ACTIVE;
        INACTIVE;
        PASSED_OUT;
        SUSPENDED;

    }

    struct StudentDetails{
        string studentName;
        uint256 studentAge;
        StudentStatus studentStatus;
    }

    mapping(String=>StudentDetails) public nameToDetails;

    function registryStudent() onlyAdmin public{}
    function updateStudent() onlyAdmin public {}
    function suspendStudent() onlyAdmin public {}
    function reactivateStudent() onlyAdmin public {}
    function removeStudent()onlyAdmin public {}
    function getStudent() public view returns(StudentDetails memory){}
    function getTotalStudent() public view returns(uint256) {}
}