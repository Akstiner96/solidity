pragma solidity ^0.5.0;

// Level 2: Tiered Split
contract TieredProfitSplitter {
    //Create three payable addresses representing 'employee_one', 'employee_two', and 'employee_three'.
    address payable employee_one; // ceo
    address payable employee_two; // cto
    address payable employee_three; // bob
    
    //Make a constructor to set addresses for the 3 employees
    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }
    
    //Should always return 0! Use this to test your 'deposit' function's logic
    function balance() public view returns(uint) {
        return address(this).balance;
    }
    
    function deposit() public payable {
        uint points = msg.value / 100; // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;
        
        //@TODO: Calculate and transfer the distribution percentage
        // Step 1: Set amount to equal `points` * the number of percentage points for this employee
        amount = points*60; // the CEO gets 60%
        
        // Step 2: Add the `amount` to `total` to keep a running total
        total+=amount;
        
        // Step 3: Transfer the `amount` to the employee
        employee_one.transfer(amount);
        
        // @TODO: Repeat the previous steps for `employee_two` and `employee_three`
        
        //Employee 2, the CTO, gets 25%
        amount = points*25;
        total+=amount;
        employee_two.transfer(amount);
        
        //Employee 3, aka Bob, gets 15%
        amount = points*15;
        total+=amount;
        employee_three.transfer(amount);
        
        //Send the remaining amount to the CEO
        employee_one.transfer(msg.value - total);
    }
    function() external payable{
        //@TODO: Enforce that the 'deposit' function is called in the fallback function!
        deposit();
    }    
}