
$fn = 60;

//base width and length
x1 = 51.2;
//base thickness
x4 = 3;
//rail top & bottom height
x2 = 3.5;
//rail top & bottom thickness
x3 = 5;
//shaft hole
xd1 = 23;


module shaft(){
//shaft hole
union(){
translate([0,0,0])
cylinder(h = x4+1, d1 = xd1, d2 = xd1, 
    center = true);}}
    
difference(){
    
//base
rotate([0,0,0])
translate([0,0,0])
cube([x1,x1,x4], center=true);
    
//shaft hole
translate([0,0,0])
shaft();   
}

//rail top back
rotate([0,0,0])
translate([0,x1/2+x3/2,(x2/2)+(x4/2)+(-x4/2)])
cube([x1+x3*2,x3,x2+x4], center=true);

//rail top front
rotate([0,0,0])
translate([0,-x1/2+-x3/2,(x2/2)+(x4/2)+(-x4/2)])
cube([x1+x3*2,x3,x2+x4], center=true);

//rail bottom left
rotate([0,0,90])
translate([0,x1/2+x3/2,-(x2/2)+(x4/2)+(-x4/2)])
cube([x1+x3*2,x3,x2+x4], center=true);

//rail bottom right
rotate([0,0,90])
translate([0,-x1/2+-x3/2,-(x2/2)+(x4/2)+(-x4/2)])
cube([x1+x3*2,x3,x2+x4], center=true);

