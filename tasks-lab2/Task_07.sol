// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Task_07 {
    mapping(uint => string) public athletes;
    uint public athletesCount;
    address public owner;


    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    constructor() {
        owner = msg.sender;
        addAthlete(0, "John Doe");
        addAthlete(1, "Jane Smith");
        addAthlete(2, "Mike Johnson");
    }

    // Публичная функция для добавления спортсмена
    function addAthlete(uint index, string memory athlete) public onlyOwner {
        require(index >= 0 && index <= 2, "Index must be between 0 and 2");
        athletes[index] = athlete;
        if (index >= athletesCount) {
            athletesCount = index + 1;
        }
    }

    // Получение спортсмена по индексу
    function getAthlete(uint index) public view returns (string memory) {
        require(index >= 0 && index < athletesCount, "Invalid index");
        return athletes[index];
    }

    // Проверка существования спортсмена
    function athleteExists(uint index) public view returns (bool) {
        require(index >= 0 && index < athletesCount, "Invalid index");
        return bytes(athletes[index]).length > 0;
    }

    // Удаление спортсмена по индексу
    function removeAthlete(uint index) public onlyOwner {
        require(index >= 0 && index < athletesCount, "Invalid index");
        delete athletes[index];
        // Можно уменьшить athletesCount, если удаляется последний элемент
        if (index == athletesCount - 1) {
            athletesCount--;
        }
    }

    // Получение всех спортсменов
    function getAllAthletes() public view returns (string[] memory) {
        string[] memory allAthletes = new string[](athletesCount);
        for (uint i = 0; i < athletesCount; i++) {
            allAthletes[i] = athletes[i];
        }
        return allAthletes;
    }

    // Обновление спортсмена
    function updateAthlete(uint index, string calldata newAthlete) public onlyOwner {
        require(index >= 0 && index < athletesCount, "Invalid index");
        athletes[index] = newAthlete;
    }

    // Замена всех спортсменов
    function replaceAllAthletes(string[] memory newAthletes) public onlyOwner {
        require(newAthletes.length == 3, "Must provide exactly 3 athletes");
        
        for (uint i = 0; i < 3; i++) {
            athletes[i] = newAthletes[i];
        }

        athletesCount = 3;
    }
}