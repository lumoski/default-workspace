// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_06 {
    mapping(uint => string) private colors;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
        colors[0] = "Red";
        colors[1] = "Orange";
        colors[2] = "Yellow";
        colors[3] = "Green";
        colors[4] = "Blue";
        colors[5] = "Indigo";
        colors[6] = "Violet";
    }

    // Добавление цвета (только для владельца)
    function addColor(uint index, string calldata color) external onlyOwner {
        require(index <= 6, "Index must be between 0 and 6");
        colors[index] = color;
    }

    // Получение цвета по индексу
    function getColor(uint index) external view returns (string memory) {
        require(index <= 6, "Index must be between 0 and 6");
        return colors[index];
    }

    // Получение всех цветов
    function getAllColors() external view returns (string[] memory) {
        string[] memory allColors = new string[](7);
        for (uint i = 0; i < 7; i++) {
            allColors[i] = colors[i];
        }
        return allColors;
    }

    // Проверка существования цвета по индексу
    function colorExists(uint index) external view returns (bool) {
        if (index > 6) {
            return false;
        }
        return bytes(colors[index]).length > 0;
    }

    // Удаление цвета (через сброс значения)
    function removeColor(uint index) external onlyOwner {
        require(index <= 6, "Index must be between 0 and 6");
        delete colors[index];
    }
}
