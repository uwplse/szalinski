x=100;
y=30;
z=30;
cut=2;
module miter(){
difference(){
cube([x,y+10,z+10],true);
union(){
translate([0,0,5])cube([x+12,y+1.5,z+10],true);
translate([0,0,5])cube([cut,y*2,z+10],true); //90
rotate([0,0,45])translate([0,0,5])cube([cut,y*3,z+10],true); //45
rotate([0,0,-45])translate([0,0,5])cube([cut,y*3,z+10],true); //-45
rotate([0,0,60])translate([0,0,5])cube([cut,y*3,z+10],true); //60
rotate([0,0,-60])translate([0,0,5])cube([cut,y*3,z+10],true); //-60
}
}
}


miter();