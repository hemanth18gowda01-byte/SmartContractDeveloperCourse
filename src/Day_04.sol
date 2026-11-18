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

contract StudentRegistrty {
    error NotAdmin();
    error NotRegistered();
    error AlreadyRegistered();

    address immutable i_OWNER;
    uint256 public numberOfStudents;

    constructor() {
        i_OWNER = msg.sender;
        numberOfStudents = 0;
    }

    modifier onlyAdmin() {
        if (msg.sender == i_OWNER) {
            _;
        } else {
            revert NotAdmin();
        }
    }
    enum StudentStatus {
        ACTIVE,
        INACTIVE,
        SUSPENDED
    }

    struct StudentDetails {
        string studentName;
        string studentId;
        uint256 studentAge;
        StudentStatus studentStatus;
        bool registered = false;
    }

    mapping(bytes32 => StudentDetails) public studentIdToDetails;

    function registryStudent(string calldata _studentName,string calldata _studentId,uint256 _studentAge,StudentStatus calldata _status) public onlyAdmin {
        if(studentIdDetails[_studentId].registered==false){
            studentIdDetails[_studentId]=StudentDetails({studentName:_studentName,
            studentId:studentId,
            studentAge:_studentAge,
            studentStatus:StudentStatus.ACTIVE,
            registered:true});
            numberOfStudents+=1;
        }
        else{
            revert AlreadyRegistered();
        }

    }
    function updateStudent(string calldata _studentName,string calldata _studentId,uint256 _studentAge,StudentStatus calldata _status) public onlyAdmin {
        studentIdDetails[_studentId]=StudentDetails({studentName:_studentName,
            studentId:studentId,
            studentAge:_studentAge,
            studentStatus:StudentStatus.ACTIVE,
            registered:true});
    }
    function suspendStudent(string calldata _studentId) public onlyAdmin {
        if (bool(studentIdDetails[_studentId])){
            studentIdDetails[_studentId].studentStatus=StudentStatus.SUSPENDED;
        }
        else{
            revert NotRegistered();
        }
    }
    function reactivateStudent(string calldata _studentId) public onlyAdmin {
        if (bool(studentIdDetails[_studentId])){
            studentIdDetails[_studentId].studentStatus=StudentStatus.ACTIVE;
        }
        else{
            revert NotRegistered();
        }
    }
    function removeStudent(string calldata _studentId) public onlyAdmin {
        if (bool(studentIdDetails[_studentId])){
            studentIdDetails[_studentId].studentStatus=StudentStatus.INACTIVE;
            numberOfStudents-=1;
        }
        else{
            revert NotRegistered();
        }
    }
    function getStudent(string calldata _studentId) public view returns (StudentDetails memory) {
        if (bool(studentIdDetails[_studentId])){
            return studentIdDetails[_studentId];
        }
        else{
            revert NotRegistered();
        }
    }
    function getTotalStudent() public view returns (uint256) {
        return numberOfStudents;
    }
}
