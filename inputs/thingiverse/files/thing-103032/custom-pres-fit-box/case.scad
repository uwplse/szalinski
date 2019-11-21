//CUSTOMIZER VARIABLES

// Internal X measurement in mm.
x = 14;
// Internal Y measurement in mm.
y = 40;
// Internal Z measurement in mm.
z = 14;
//CUSTOMIZER VARIABLES END


difference(){
cube([x+8,y+8,(z/2)+2]);
translate([4,4,2])cube([x,y,(z/2)+1]);
translate([2,2,z/2])cube([x+4,y+4,3]);
}
translate([x+20,0,0])
difference(){
cube([x+8,y+8,(z/2)+4]);
translate([4,4,2])cube([x,y,(z/2)+3]);

difference(){
translate([-1,-1,(z/2)+2])cube([x+12,y+12,3]);
translate([2,2,(z/2)+2])cube([x+4,y+4,6]);
}
}