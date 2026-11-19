//SPDX-License-Identifier:MIT
pragma solidity ^0.8.35;

/*Problem statement
Build a Task Management smart contract where users can create tasks, update them, mark them completed and retrieve task information.

Each task should have:
- Task ID
- Task title
- Completion status
Functional requirements
Function	Expected behavior
createTask() -	Create a new task
updateTask() -	Update task title
completeTask() -	Mark task completed
getTask() -	Retrieve task information
previewTask() -	Preview changes without saving them*/
contract TaskManagement{

    error AlreadyTaskExist();
    error NoTaskFound();

    struct TaskInfo{
        uint256 taskId;
        string taskTitle;
        bool completionStatus;
    }

    mapping(uint256=>TaskInfo) public taskIdToTask;

    function createTask(uint256 _taskId,string memory _taskTitle) public {
        if (_taskId!=taskIdToTask[_taskId].taskId){
            taskIdToTask[_taskId]=TaskInfo({
                taskId:_taskId,
                taskTitle:_taskTitle,
                completionStatus:false
            });
        }
        else{
            revert AlreadyTaskExist();
        }
    }
    function updateTask(uint256 _taskId,string memory _taskTitle) public{
        if (_taskId==taskIdToTask[_taskId].taskId){
            taskIdToTask[_taskId].taskTitle=_taskTitle;
        }
        else{
            revert NoTaskFound();
        }
    }
    function completeTask(uint256 _taskId) public{
        if (_taskId==taskIdToTask[_taskId].taskId){
            taskIdToTask[_taskId].completionStatus=true;
        }
        else{
            revert NoTaskFound();
        }

    }
    function getTask(uint256 _taskId) public view returns(TaskInfo memory){
        if (_taskId==taskIdToTask[_taskId].taskId){
            return taskIdToTask[_taskId];
        }
        else{
            revert NoTaskFound();
        }
    }
    function previewTask(uint256 _taskId,string calldata _taskTitle,bool _status) public pure returns(uint256,string memory,bool){
        return (_taskId,_taskTitle,_status);
        
    }
}