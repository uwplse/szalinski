
baseRadius = 10; //[2:1:30]
roudness = 5; //[1:1:10]
sides = 5; //[3:1:30]
Height = 20; //[2:1:200]
shellThickness = 1; //[1:1:10]
Twist = 40; //[1:1:100]
Res = 100; //[0:1:300]
draft = 2; //[1:1:20]
insideRotation = 0; //[0:5:360]
//[10:Small,20:Medium,30:Large]


Base(solid = "yes");
Extrude();


module Base() {
offset(r = roudness, $fn = 50)
    circle(r = baseRadius, $fn = sides);
       
    if(solid == "no") {
            difference() { 
        linear_extrude(height = Height, twist = Twist, slices = Res, scale = draft)
            offset(r = roudness, $fn = 20)
                circle(r = baseRadius, $fn = sides);
            
            
              //  rotate(insideRotation)
                translate([0,0,shellThickness])
                    linear_extrude(height = Height, twist = Twist, slices = Res, scale = draft) 
                            offset(r = roudness, $fn = 30)
                                circle(r = baseRadius-shellThickness, $fn = sides)
                                    ;
            }
        }
}

module Extrude() {
        Base(solid = "no");
}