//Tracks

//Width Of Base(Change This If You Change Widths Of Tracks!)
Width = 75;

//Length Of Base
Length = 140;

//Thickness Of Base
Thickness = 3;

//Thickness Of Walls
WThickness = 5;

//Width Of Square Track
STWidth = 30;

//Height Of Humps On Square Track
HeightHumps = 10;

//Extra Height For Shortest Wall
Extra = 5;

//Height Of HalfPipe
HPHeight = 30;

//Width Of Halfpipe
HPWidth = 30;

//Halp Pipe ScaleZ(The Lower, The Smaller Slope. If Over 0.42, Tracks Will Not Appear at Bottom)
ScaleZ = 0.35;

//Depth Of HalfPipe Tracks
Depth = 10;

//Height Of Square Wheel
SWHeight = 10;

//Circle Wheel Axle Radius
ARadius = 3;

//Radius Of Circle Wheel
Radius = 10;


//Base(Green)
color("GreenYellow"){
    cube([Width,Length,Thickness]);
}

//Square Track
translate([WThickness,0,0]){
    for(c=[0:HeightHumps*2:Length]){
        translate([0,0,Thickness]){
            translate([0,c,0]){
                rotate([0,90,0]){
                    difference(){
                        cylinder(STWidth,HeightHumps,HeightHumps,$fn = 100);
                        rotate([0,-90,0]){
                            translate([-1,-HeightHumps,-HeightHumps]){
                                cube([STWidth+2,HeightHumps*2,HeightHumps]);
                                translate([0,-c,HeightHumps-1]){
                                    cube([STWidth+2,HeightHumps,HeightHumps+2]);
                                    translate([0,HeightHumps+Length,0]){
                                        cube([STWidth+2,HeightHumps,HeightHumps+2]);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

//Walls(Red)
color("Red"){
    translate([0,0,Thickness]){
        cube([WThickness,Length,HeightHumps+Extra]);
        translate([STWidth+WThickness,0,0]){
            cube([WThickness,Length,HPHeight]);
            translate([HPWidth+WThickness,0,0]){
                cube([WThickness,Length,HPHeight]);
            }
        }
    }
}

//Half Pipe
translate([STWidth+2*WThickness,0,Thickness]){
    difference(){
        cube([HPWidth,Length,HPHeight]);
        translate([0,Length/2,HPHeight]){
            scale([1,1,ScaleZ]){
                rotate([0,90,0]){
                    cylinder(HPWidth,Length/2,Length/2);
                    rotate([0,-90,0]){
                        translate([WThickness,0,-Depth]){
                            rotate([0,90,0]){
                                cylinder(HPWidth*1/6,Length/2,Length/2);
                            }
                        }
                    }
                    rotate([0,-90,0]){
                        translate([HPWidth*4/6,0,-Depth]){
                            rotate([0,90,0]){
                                cylinder(HPWidth*1/6,Length/2,Length/2);
                            }
                        }
                    }
                }
            }
        }
    }
}

//Wheels

//Square Wheel
translate([Width+5,0,0]){
    cube([HeightHumps*3.14,HeightHumps*3.14,SWHeight]);
}

//Circle Wheels/Axle
translate([Width+20,HeightHumps*3.14+20,0]){
    cylinder(HPWidth*1/6,Radius,Radius,$fn = 100);
    cylinder(HPWidth*4/6,ARadius,ARadius,$fn = 100); 
}
translate([Width+20,HeightHumps*3.14+40+Radius*2,0]){
    difference(){
        cylinder(HPWidth*1/6,Radius,Radius);
        cylinder(HPWidth*1/6,ARadius,ARadius);
    } 
}