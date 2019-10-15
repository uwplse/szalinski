//Customizable Tape Dispenser

//Main Box Width
BaseWidth = 45;

//Main Box Length
BaseLength = 120;

//Main Box Height
BaseHeight = 50;

//Outside Large Box (How far it goes out)
OutsideLLength = 10;

//Outside Small Box (How far it goes out)
OutsideSLength = 5;

BottomThickness = 5;

//Main Hole Width
MHoleWidth = 35;

//Main Hole Length
MHoleLength = 110;

//Radius of Pole
RPole = 5;


difference(){
    //Base Cube
    union(){
        cube([BaseLength,BaseWidth,BaseHeight]);
        translate([-BaseLength/24,-OutsideSLength,0]){
            cube([20,20,40]);
        }
        translate([BaseLength/3,-OutsideLLength,0]){
            cube([20,20,30]);
        }
        translate([5*BaseLength/12,-OutsideSLength,0]){
            cube([30,20,40]);
        }
        translate([BaseLength/6,-OutsideSLength,BaseHeight/2]){
            cube([25,20,10]);
        }
        translate([BaseLength/6,-OutsideLLength,BaseHeight/2]){
            cube([10,20,25]);
        }
        translate([BaseLength/12,-OutsideLLength,0]){
            cube([15,20,35]);
        }
        translate([BaseLength/2,-OutsideLLength,BaseHeight/2]){
            cube([15,20,20]);
        }
        translate([-OutsideLLength,2*BaseWidth/9,0]){
            cube([15,10,25]);
        }
        rotate([0,0,180]){
            translate([-BaseLength,-BaseWidth, 0]){
                translate([-BaseLength/24,-OutsideSLength,0]){
                    cube([20,20,40]);
                }
                translate([BaseLength/3,-OutsideLLength,0]){
                    cube([20,20,30]);
                }
                translate([5*BaseLength/12,-OutsideSLength,0]){
                    cube([30,20,40]);
                }
                translate([BaseLength/6,-OutsideSLength,25]){
                    cube([25,20,10]);
                }
                translate([BaseLength/6,-OutsideLLength,25]){
                    cube([10,20,25]);
                }
                translate([BaseLength/12,-OutsideLLength,0]){
                    cube([15,20,35]);
                }
                translate([BaseLength/2,-OutsideLLength,30]){
                    cube([15,20,15]);
                }
                translate([-OutsideLLength,2*BaseWidth/9,0]){
                    cube([15,10,25]);
                }
            }
        }
    }
    //Main Hole
    translate([(BaseLength-MHoleLength)/2, (BaseWidth-MHoleWidth)/2,BottomThickness]){
        cube([MHoleLength,MHoleWidth,BaseHeight]);
    }
    //Pole
    translate([BaseLength/2.5, BaseWidth+OutsideLLength+100,BaseHeight/1.75]){
        rotate([90,0,0]){
        cylinder(BaseWidth+(OutsideLLength*2)+200,RPole,RPole);
        }
    }
    //Cutter
    translate([(BaseLength-MHoleLength)-0.5, (BaseWidth-MHoleWidth)/2,BaseHeight-5]){
        cube([MHoleLength,MHoleWidth,BaseHeight]);
    }
}
//Pole
translate([10, BaseWidth+OutsideLLength+10,0]){
    cylinder(BaseWidth+(OutsideLLength*2)+2,RPole-0.4,RPole-0.4);
}