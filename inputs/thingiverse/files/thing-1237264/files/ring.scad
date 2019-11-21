numberOne = 1; //This is the first digit of the combo lock.
numberTwo = 2; //This is the second digit.
numberThree = 3; //Third digit.
numberFour = 4; //Fourth digit.

rotationOne = 180-(numberOne*36);
rotationTwo = 180-(numberTwo*36);
rotationThree = 180-(numberThree*36);
rotationFour = 180-(numberFour*36);

difference(){
    rotate([0,0,rotationOne]) ring();
    translate([-3,-28,-1]) cube([6,10,20]);
}
translate([0,100,0]){
    difference(){
        rotate([0,0,rotationTwo]) ring();
        translate([-3,-28,-1]) cube([6,10,20]);
    }
}
translate([100,100,0]){
    difference(){
        rotate([0,0,rotationThree]) ring();
        translate([-3,-28,-1]) cube([6,10,20]);
    }
}
translate([100,0,0]){
    difference(){
        rotate([0,0,rotationFour]) ring();
        translate([-3,-28,-1]) cube([6,10,20]);
    }
}


module ring(){
    difference(){
        cylinder(1,28,28);
        translate([0,0,-1]) cylinder(3,21,21);
    }
    difference(){
        translate([0,0,11.7]) cylinder(1,28,28);
        translate([0,0,10.7]) cylinder(3,21,21);
    }
    difference(){
        dial();
        translate([0,0,-1]) cylinder(20,28,28);
    }
}

module dial(){
    rotate([0,0,-36]){
        rotate([0,0,-36]){
            rotate([0,0,-36]){
                rotate([0,0,-36]){
                    rotate([0,0,-36]){
                        rotate([0,0,-36]){
                            rotate([0,0,-36]){
                                rotate([0,0,-36]){
                                    rotate([0,0,-36]){
                                        rotate([0,0,-36]){
                                            linear_extrude(12.7) circle(35,$fn=10);
                                            number("0");
                                        }
                                        number("1");
                                    }
                                    number("2");
                                }
                                number("3");
                            }
                            number("4");
                        }
                        number("5");
                    }
                    number("6");
                }
                number("7");
            }
            number("8");
        }
        number("9");
    }
}

module number(digit){
    translate([-5,35,3]) scale([1,1,-1]) rotate([90,90,0]) linear_extrude(10) text(digit);
}