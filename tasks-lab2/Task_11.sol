// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Task_11 {
    address public owner;
    uint public targetAmount;
    
    // 1. Переменная для хранения суммы всех депозитов
    uint public totalUserDeposits;
   
    enum State { Active, Paused, Closed }
    State public state;


    mapping(address => uint) public balances;


    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);
    event StateChanged(State newState);

    // 2. Модификатор проверки владельца
    modifier onlyOwner() {
        require(msg.sender == owner, "Not an owner");
        _;
    }


    modifier whenActiveOrPaused() {
        require(state == State.Active || state == State.Paused, "Unavailable in closed state");
        _;
    }


    modifier whenActive() {
        require(state == State.Active, "Contract is not active");
        _;
    }

    // 3. Модификатор проверки закрытого состояния
    modifier whenClosed() {
        require(state == State.Closed, "Contract is not closed");
        _;
    }


    constructor(uint _targetAmount) {
        require(_targetAmount > 0, "Target amount should be > 0");
        owner = msg.sender;
        targetAmount = _targetAmount;
        state = State.Active;
    }

    // 4. Доработка функции deposit
    function deposit() external payable whenActive {
        require(msg.value > 0, "Deposit must be > 0");

        balances[msg.sender] += msg.value;
        totalUserDeposits += msg.value;

        emit Deposited(msg.sender, msg.value);

        // Автоматическое закрытие при достижении цели
        if (totalUserDeposits >= targetAmount) {
            state = State.Closed;
            emit StateChanged(State.Closed);
        }
    }


    function pause() external onlyOwner whenActiveOrPaused {
        require(state != State.Paused, "Contract already paused");
        state = State.Paused;
        emit StateChanged(state);
    }


    function resume() external onlyOwner {
        require(state == State.Paused, "Contract is not paused");
        state = State.Active;
        emit StateChanged(state);
    }

    // 5. Доработка функции withdraw для пользователей (в режиме Paused)
    function withdraw() external {
        require(state == State.Paused, "Withdrawal only available when paused");
        uint userBalance = balances[msg.sender];
        require(userBalance > 0, "Insufficient balance");

        // Обновление состояний перед отправкой (защита от Reentrancy)
        balances[msg.sender] = 0;
        totalUserDeposits -= userBalance;

        payable(msg.sender).transfer(userBalance);
        emit Withdrawn(msg.sender, userBalance);
    }

    // Вывод всех средств владельцем при закрытии контракта
    function ownerWithdrawAll() external onlyOwner whenClosed {
        uint contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds to withdraw");

        // Очистка данных
        totalUserDeposits = 0;

        payable(owner).transfer(contractBalance);
    }


    function getState() external view returns (string memory) {
        if (state == State.Active) return "Active";
        if (state == State.Paused) return "Paused";
        if (state == State.Closed) return "Closed";
        return "";
    }
}
