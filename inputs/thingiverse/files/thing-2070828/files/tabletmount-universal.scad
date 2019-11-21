$fn = 60;



//length(1/4th of tablet width)
x1 = 30;
//width(from edge to bezzle)
x2 = 20;
//thickness of tablet
x3 = 14;

//walls thinkness(default4)
x4 = 4;

//screw (50/50 for head and thread /x4 walls
//head
xd1 = 7.5;
//thread
xd2 = 4;

module screw(){
//screw head
union(){
translate([0,0,x4/2/2])
cylinder(h = x4/2, d1 = xd1, d2 = xd1, 
    center = true);
//screw thread
translate([0,0,-x4/2/2])
cylinder(h = x4/2, d1 = xd2, d2 = xd2, center = true);}
}
//top
rotate([0,0,0])
translate([0,-x3/2+-x4/2,0])
cube([x2+x4,x4,x1], center=true);


//back
difference(){
rotate([0,0,0])
translate([0,x3/2+x4/2,x1/2])
cube([x2+x4,x4,x1*2], center=true);
rotate([90,0,0])
//hole
translate([0,x1,-x3/2-x4/2])
#screw();}

//bottom
rotate([0,0,0])
translate([0,0,-x1/2+-x4/2])
cube([x2+x4,x3+x4*2,x4], center=true);


//side
rotate([0,0,0])
translate([-x2/2+x4+-x4,0,0])
cube([x4,x3,x1], center=true);





