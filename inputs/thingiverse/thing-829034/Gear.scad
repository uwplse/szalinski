//Gears With Holes

//Gear Radius
GearRadius = 30;

//Gear Height
GearHeight = 3;

//Handle Height
HandleHeight = 25;

//Hole Radius
HoleRadius = 5;

//Size Of Nozzle
SizeOfNozzle = 0.4;


//Gear Without Hole
module gear(){
    union(){
        rotate([0,0,0])
            cylinder(GearHeight,GearRadius,GearRadius,$fn=5);
        rotate([0,0,90]){
            cylinder(GearHeight,GearRadius,GearRadius,$fn=5);
        }
        rotate([0,0,180]){
            cylinder(GearHeight,GearRadius,GearRadius,$fn=5);
        }
        rotate([0,0,270]){
            cylinder(GearHeight,GearRadius,GearRadius,$fn=5);
        }
    }
}

//Gear With Hole
module gearh(){
    difference(){
        gear();
        cylinder(GearHeight,HoleRadius,HoleRadius,$fn=50);
    }
    difference(){
        cylinder(GearHeight*2,HoleRadius+SizeOfNozzle,HoleRadius+SizeOfNozzle,$fn = 50);
        cylinder(GearHeight*2,HoleRadius,HoleRadius,$fn = 50);
    }
}

//Gear In Middle With Handle
union(){
    gearh();
    translate([0,GearRadius/2,GearHeight]){
        cylinder(HandleHeight,GearRadius/10,GearRadius/10,$fn = 50);
    }
}
//6 Gears On Outside
rotate([0,0,0]){
    translate([GearRadius*1.5,GearRadius*1.5,0]){
        gearh();
    }
}
rotate([0,0,60]){
    translate([GearRadius*1.5,GearRadius*1.5,0]){
        gearh();
    }
}
rotate([0,0,120]){
    translate([GearRadius*1.5,GearRadius*1.5,0]){
        gearh();
    }
}
rotate([0,0,180]){
    translate([GearRadius*1.5,GearRadius*1.5,0]){
        gearh();
    }
}
rotate([0,0,240]){
    translate([GearRadius*1.5,GearRadius*1.5,0]){
        gearh();
    }
}
rotate([0,0,300]){
    translate([GearRadius*1.5,GearRadius*1.5,0]){
        gearh();
    }
}
