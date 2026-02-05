pragma solidity ^0.8.0;


contract Task_05 {
    // Хранит температуру в градусах Цельсия
    uint256 public celsiusTemperature; // storage


    // Функция для установки температуры в градусах Цельсия
    function setCelsiusTemperature(uint256 temperature) public {
        celsiusTemperature = temperature; // изменяем значение в storage
    }


    // Функция для конвертации градусов Цельсия в Фаренгейт
    function convertToFahrenheit(uint256 temperature) public pure returns (uint256) {
        // Используем memory для временной переменной
        uint256 fahrenheitTemperature = (temperature * 9 / 5) + 32; // конвертация
        return fahrenheitTemperature; // возвращаем результат
    }


    // Функция для получения температуры в Фаренгейтах, используя текущее значение в storage
    function getFahrenheitTemperature() public view returns (uint256) {
        return convertToFahrenheit(celsiusTemperature); // возвращаем конвертированное значение
    }
}