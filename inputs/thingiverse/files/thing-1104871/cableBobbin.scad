// Ver1. Too big
//rMbobbin=25;
//rmbobbin=8;
//zBobbin=20;
//rCable=1;    

/* [Global] */
// Ver3. Headphones
// External radius
rMbobbin=18;
// Internal radius
rmbobbin=8;
// Heigth of the bobbin
zBobbin=15;
// Cable radius
rCable=1; 

part = "bottom"; // [bottom:Bottom Only,top:Top Only]


/* [Hidden] */
precission=80;
depth=1.5;
rMink=2;


module easyBobbinBottom(){
difference(){
union(){   
minkowski(){
cylinder(r=rMbobbin-depth/2, h=0.01, center=true, $fn = precission); 
sphere(r=depth/2, $fn = precission);
}
minkowski(){
cylinder(r=rmbobbin-depth/2-0.4, h=zBobbin+20, $fn = precission); 
sphere(r=depth/2, $fn = precission);
}}

// DIFF
// Hole for cables
hull(){
translate([0,0,-2]) rotate([90,0,0]) cylinder(r=rCable, h=100, center=true, $fn = precission); 
translate([0,0,8]) rotate([90,0,0]) cylinder(r=rCable+1.1, h=100, center=true, $fn = precission);
}

//hull(){
//translate([0,0,12]) rotate([90,0,0]) cylinder(r=rCable, h=40, center=true, $fn = precission);
//translate([10,0,12]) rotate([90,0,0]) cylinder(r=rCable+1, h=40, center=true, $fn = precission); 
//}

// Holes for teeth
hull(){
translate([7,0,zBobbin+11]) rotate([90,0,0]) cylinder(r=3, h=40, center=true, $fn = precission); 
translate([8,0,zBobbin+45]) rotate([90,0,0]) cylinder(r=3, h=40, center=true, $fn = precission);}
hull(){
translate([-7,0,zBobbin+11]) rotate([90,0,0]) cylinder(r=3, h=40, center=true, $fn = precission); 
translate([-8,0,zBobbin+45]) rotate([90,0,0]) cylinder(r=3, h=40, center=true, $fn = precission);}

// Fingers holes
translate([0,rMbobbin/2+rmbobbin/2,0]) cylinder(r=7.5, h=20, center=true, $fn = precission); 

translate([0,-(rMbobbin/2+rmbobbin/2),0]) cylinder(r=7.5, h=20, center=true, $fn = precission); 

// Torus
translate([0,0,1.3*zBobbin])
rotate_extrude(convexity = 10)
translate([rmbobbin+0.4, 0, 0])
circle(r = 2, $fn = precission); 

// Keychain holes
translate([0, 0, 1.31*zBobbin]) rotate([90,0,0]) cylinder(r=2, h=20, center=true, $fn = precission); 
translate([0, 0, 2.1*zBobbin]) rotate([90,0,90]) cylinder(r=2, h=20, center=true, $fn = precission); 


//translate([11,0,1.3*zBobbin])
//rotate_extrude(convexity = 10)
//translate([11, 0, 0])
//circle(r = 2, $fn = precission); 
}}





module easyBobbinTop(){
difference(){
union(){
difference(){
translate([0,0,-depth+3])
minkowski(){
cylinder(r=rMbobbin, h=zBobbin, $fn = precission); 
sphere(r=rMink, $fn = precission);
}
// dif
translate([0,0,-6-depth])
cylinder(r=rMbobbin, h=zBobbin+10, $fn = precission); 
}
translate([0,0,zBobbin-1])
cylinder(r=rmbobbin+depth, h=4, $fn = precission); 
}

// DIFF
// Holes for tubes
hull(){
rotate([90,0,0]) cylinder(r=3, h=80, center=true, $fn = precission); 
translate([0,0,10]) rotate([90,0,0]) cylinder(r=3, h=80, center=true, $fn = precission); 
}
// Central hole
cylinder(r=rmbobbin, h=zBobbin+10, $fn = precission);

// Bite for bottom part
translate([0,0,1])
minkowski(){
cylinder(r=rMbobbin-depth/2+1, h=0.01, center=true, $fn = precission); 
sphere(r=depth/2, $fn = precission);
}}
}


//translate([0,0,0.5]) color("blue",1) easyBobbinBottom();
//color("yellow",1) easyBobbinTop();

print_part();

module print_part() {
	if (part == "bottom") {
		translate([0,0,0.5]) color("blue",1) easyBobbinBottom();
	} else if (part == "top") {
        rotate([180,0,0]) color("yellow",1) easyBobbinTop();
	} 
}

