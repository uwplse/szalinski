// Piano Book Holder

// Customizable Parameters
frontRcubeHeight = 10; //[5,10,20,30,40]
frontLcubeHeight = 10; //[5,10,20,30,40]
backRcubeHeight = 10; //[10,20,30,40,50,60]
backLcubeHeight = 10; //[10,20,30,40,50,60]

// Joining part
cube([100,5,5]);

// Front Left Arm
//Cube that connects joining part to arm
translate([25,0,0]) 
    cube([10,15,5]); 
//Cube for the arm
translate([25,10,-20]) 
    cube([10,5,20]);

// Front Right Arm
//Cube that connects joining part to arm
translate([65,0,0]) 
    cube([10,15,5]);
//Cube for the arm
translate([65,10,-20]) 
    cube([10,5,20]);

// Back Left Arm
translate([0,0,-60]) 
    cube([10,5,60]);

// Back Right Arm
translate([90,0,-60]) 
    cube([10,5,60]);
