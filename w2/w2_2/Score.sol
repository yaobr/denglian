// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Score {
    address private teacher;
    mapping(address => uint256) private scores;

    constructor(){
        teacher = msg.sender;
    }

    modifier onlyTeacher{
        require(
            msg.sender == teacher,
            "Only teacher can call this function");
        _;

    }
    event UpdateScore(address indexed student, uint256 indexed score);
    function updateScore(address student, uint256 score) external onlyTeacher {
        require(score <= 100, "Score should not large than 100.");
        if (scores[student] != score){
            scores[student] = score;
        }

        emit UpdateScore(student, score);
    }
}

interface IScore {
    function updateScore(address student, uint256 score) external;
}

contract Teacher {
    Score public scoreContract;

    constructor(){
         scoreContract = new Score();
    }

    function updateStudentScore(address student, uint256 score) public {
        IScore(address(scoreContract)).updateScore(student, score);
    }
}
