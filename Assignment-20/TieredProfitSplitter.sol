pragma solidity ^0.5.0;

// lvl 2: Tiered Split

contract TieredProfitSplitter {
    address payable employee_one; // ceo
    address payable employee_two; // cto
    address payable employee_three; // bob

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    // Should always return 0! Use this to test your `deposit` function's logic
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        uint points = msg.value / 100; // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;

        // Calculate and transfer the distribution percentage for the CEO (60%)
        
        // Step 1: Set amount to equal `points` * the number of percentage points for this employee
        amount = points * 60;
        // Step 2: Add the `amount` to `total` to keep a running total
        total += amount;
        // Step 3: Transfer the `amount` to the employee
        employee_one.transfer(amount);

        // Calculate and transfer the distribution percentage for the CTO (25%)
        amount = points * 25;
        total += amount;
        employee_two.transfer(amount);
        
        // Calculate and transfer the distribution percentage for Bob (15%)
        amount = points * 15;
        total += amount;
        employee_three.transfer(amount);
        
        employee_one.transfer(msg.value - total); // ceo gets the remaining wei
    }

    function() external payable {
        deposit();
    }
}

