thickness = 3;
height = 45;
length = 60;
width = 15;



difference(){
        union(){cube([length,width,thickness]);
translate([0,0,height+thickness]) cube([length,width,thickness]);
cube([thickness,width,height+2*thickness]);
translate([length,width/2,height+thickness]) cylinder(r1=width/2, r2=width/2, h=thickness);
$fn=50;
translate([length,width/2,0]) cylinder(r1=width/2, r2=width/2, h=thickness);
}
        translate([0,0,height+thickness+1]) rotate(a=-45, v=[0,1,0]) cube([50,width,thickness]);
        translate([-7.5,0,1]) rotate(a=45, v=[0,1,0]) cube([50,width,thickness]);
}