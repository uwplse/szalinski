//Customizable Linear Extrude Sculpture

//Width Of Bottom Of Twisted Cube
WidthOfBottom = 40;

//Length Of Bottom Of Twisted Cube
LengthOfBottom = 40;

//Height Of Twisted Cube
HeightOfTwistedCube = 40;

//Twist Of Cube
Twist = 90;

//Scale From Bottom To Top Of Twisted Cube
Scale = 0;

//Slices Of 1 Twisted Cube
Slices = 90;

//Base Height
BaseHeight = 1;

translate([0,0,BaseHeight]){
    //Top Twisted Cube
    translate([0,0,HeightOfTwistedCube/2]){
        cube([WidthOfBottom,LengthOfBottom,HeightOfTwistedCube],center=true);
    }
    translate([0,0,HeightOfTwistedCube]){
        linear_extrude(height = HeightOfTwistedCube, scale = Scale, twist = Twist, slices = Slices)
            square([WidthOfBottom,LengthOfBottom],center= true);
    }

    //Four Raised Twisted Cubes
    translate([0,0,HeightOfTwistedCube/2]){
        translate([WidthOfBottom,0,0]){
            linear_extrude(height = HeightOfTwistedCube, scale = Scale, twist = Twist, slices = Slices)
                square([WidthOfBottom,LengthOfBottom],center = true);
        }
        translate([0,LengthOfBottom,0]){
            linear_extrude(height = HeightOfTwistedCube, scale = Scale, twist = Twist, slices = Slices)
                square([WidthOfBottom,LengthOfBottom],center = true);
        }
        translate([-WidthOfBottom,0,0]){
            linear_extrude(height = HeightOfTwistedCube, scale = Scale, twist = Twist, slices = Slices)
                square([WidthOfBottom,LengthOfBottom],center = true);
        }
        translate([0,-LengthOfBottom,0]){
            linear_extrude(height = HeightOfTwistedCube, scale = Scale, twist = Twist, slices = Slices)
                square([WidthOfBottom,LengthOfBottom],center = true);
        }
    }
    translate([0,0,10]){
        translate([WidthOfBottom,0,0]){
            cube([WidthOfBottom,LengthOfBottom,HeightOfTwistedCube/2],center = true);
        }
        translate([0,LengthOfBottom,0]){
            cube([WidthOfBottom,LengthOfBottom,HeightOfTwistedCube/2],center = true);
        }
        translate([-WidthOfBottom,0,0]){
            cube([WidthOfBottom,LengthOfBottom,HeightOfTwistedCube/2],center = true);
        }
        translate([0,-LengthOfBottom,0]){
            cube([WidthOfBottom,LengthOfBottom,HeightOfTwistedCube/2],center = true);
        }
    }
    
    //Four Bottom Twisted Cubes
    translate([WidthOfBottom,LengthOfBottom,0]){
        linear_extrude(height = HeightOfTwistedCube, scale = Scale, twist = Twist, slices = Slices)
            square([WidthOfBottom,LengthOfBottom],center = true);
    }
    translate([-WidthOfBottom,LengthOfBottom,0]){
        linear_extrude(height = HeightOfTwistedCube, scale = Scale, twist = Twist, slices = Slices)
            square([WidthOfBottom,LengthOfBottom],center = true);
    }
    translate([WidthOfBottom,-LengthOfBottom,0]){
        linear_extrude(height = HeightOfTwistedCube, scale = Scale, twist = Twist, slices = Slices)
            square([WidthOfBottom,LengthOfBottom],center = true);
    }
    translate([-WidthOfBottom,-LengthOfBottom,0]){
        linear_extrude(height = HeightOfTwistedCube, scale = Scale, twist = Twist, slices = Slices)
            square([WidthOfBottom,LengthOfBottom],center = true);
    }
}

//Base
translate([0,0,BaseHeight/2]){
    cube([WidthOfBottom*3,LengthOfBottom*3,BaseHeight],center = true);
}