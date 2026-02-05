// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Task_11 {
    address public owner;
    uint public targetAmount;
   
    enum State { Active, Paused, Closed }
    State public state;


    mapping(address => uint) public balances;


    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);
    event StateChanged(State newState);


    modifier onlyOwner() {
       
    }


    modifier whenActiveOrPaused() {
        require(state == State.Active || state == State.Paused, "Unavailable in closed state");
        _;
    }


    modifier whenActive() {
        require(state == State.Active, "Contract is not active");
        _;
    }


    modifier whenClosed() {
       
    }


    constructor(uint _targetAmount) {
        require(_targetAmount > 0, "Target amount should be > 0");
        owner = msg.sender;
        targetAmount = _targetAmount;
        state = State.Active;
    }


    function deposit() external payable whenActive {
       
    }


    function pause() external onlyOwner whenActiveOrPaused {
        require(state != State.Paused, "Contract paused");
        state = State.Paused;
        emit StateChanged(state);
    }


    function resume() external onlyOwner {
        require(state == State.Paused, "Contract is not paused");
        state = State.Active;
        emit StateChanged(state);
    }


    function withdraw() external ... {
        require(state == State.Paused, "Fund withdraw available only if paused");
        uint userBalance = balances[msg.sender];


    }


    function ownerWithdrawAll() external onlyOwner whenClosed {
        uint contractBalance = address(this).balance;
        require(contractBalance > 0, "No fund to withdraw");


        balances[owner] = 0;


        totalUserDeposits = 0;
    }


    function getState() external view returns (string memory) {
        if (state == State.Active) return "Active";
        if (state == State.Paused) return "Paused";
        if (state == State.Closed) return "Closed";
        return "";
    }
}
