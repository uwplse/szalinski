//Fish Orginizer

//Main Body Radius
BodyRadius = 90;

//Pencil Radius
PencilRadius = 3;

//Slot Width
SlotWidth = 1;

//Height
Height = 10;

//Main Body
difference(){
    union(){
        cylinder(Height,BodyRadius,BodyRadius);
        cube([BodyRadius,BodyRadius,Height]);
        translate([-BodyRadius,-BodyRadius,0]){
            cube([BodyRadius,BodyRadius,Height]);
        }
    }
    translate([BodyRadius/2,BodyRadius/2,0]){
        cube([BodyRadius/2,BodyRadius/2,Height]);
    }
    //Pencil Holder
    for(a = [-BodyRadius*4/9:PencilRadius*2:BodyRadius*2/3]){
        translate([-a,-a,0]){
            cylinder(Height,PencilRadius,PencilRadius,$fn = 100);
        }
    }
    
    //Eye
    translate([-BodyRadius*7/9,-BodyRadius*7/9,Height/2]){
        cylinder(Height/2,BodyRadius*1/9,BodyRadius*1/9);
    }
}
translate([-BodyRadius*7/9,-BodyRadius*7/9,Height/2]){
    cylinder(Height/2,BodyRadius*1/18,BodyRadius*1/18);
}

//Tail Paper Holder
translate([BodyRadius/2,BodyRadius/2,0]){
    difference(){
        cube([BodyRadius,BodyRadius,Height]);
        rotate([0,0,45]){
            translate([-BodyRadius/5-SlotWidth/2,-BodyRadius/5-SlotWidth/2,0]){
                cube([BodyRadius*1.5,SlotWidth,Height]);
            }
        }
        rotate([0,0,45]){
            translate([-BodyRadius/15-SlotWidth/2,-BodyRadius/15-SlotWidth/2,0]){
                cube([BodyRadius*1.5,SlotWidth,Height]);
            }
        }
        rotate([0,0,45]){
            translate([BodyRadius/15-SlotWidth/2,BodyRadius/15-SlotWidth/2,0]){
                cube([BodyRadius*1.5,SlotWidth,Height]);
            }
        }
        rotate([0,0,45]){
            translate([BodyRadius/5-SlotWidth/2,BodyRadius/5-SlotWidth/2,0]){
                cube([BodyRadius*1.5,SlotWidth,Height]);
            }
        }
    }
}