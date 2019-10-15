
// Size of base
base = 16; //[10:200]

// Size of gap for cable to pass through (Must be less than the base!)
gap = 6; //[195]

// Thickness of all parts, higher values are stronger but take longer
thickness = 2; //[1:6]

// Length of straight part of the cable holder
armLength = 8; //[2:40]

// Angle of arngled portion of the cable holder
armAngle = 45; //[45]

// Length of cable holder after the bend
armBent = 6; //[20]

difference(){
union(){
cube([base,base,thickness]);

/*
difference(){
union(){
union(){
cube([(base/2)-(gap/2),2,10]);
translate([(base/2)+(gap/2),0,0])
cube([(base/2)-(gap/2),2,10]);
}
translate([0,0,10])
rotate([-45,0,0])
union(){
cube([(base/2)-(gap/2),2,8]);
translate([(base/2)+(gap/2),0,0])
cube([(base/2)-(gap/2),2,8]);
}
}
translate([-base*2,-10,0])
cube([(base*4),10,80]);
}*/

difference(){
union(){
cube([base,thickness,armLength+thickness]);
    
translate([0,0,armLength+thickness])
rotate([-armAngle,0,0])
cube([base,thickness,armBent]);
}

translate([-base*2,-10,0])
cube([(base*4),10,80]);

translate([base/2-gap/2,-1,thickness])
cube([gap,base*(armBent+armLength)*2,armLength+armBent+1]);
}

}
translate([-1,-1,-1])
cube([base*2,base*2,1]);
}