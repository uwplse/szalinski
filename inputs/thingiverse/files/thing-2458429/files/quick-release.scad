//--------------------
//parameters
//--------------------

D1 = 20; //large diameter
D2 = 10; //small diameter
S = 2;   //shift of the center of small diameter

A = 20; //height of the part
C = 5;  //thickness of the handle
L = 40; //length of the handle
G = 45; // angle in degrees between handle and x axis

A2 = 3;
D3 = 4; 
N = 8;  


tol = 0.3; //tolerance
rendering_quality = 300;

//--------------------
//modules for parts
//--------------------

//part#1
module create_part1() {
difference(){
    union(){
    cylinder(h = A, d = D1, $fn=rendering_quality);
    rotate([0,0,-G]) translate([D1/2-C,-L,0]) cube([C,L,A]); 
    }
    translate([S,0,-tol])cylinder(h = A+2*tol, d = D2, $fn=rendering_quality);
   rotate([0,0,-G]) translate([-D1,-L,(A-N-tol)/2]) cube([D1/2-C+D1,2*L,N+tol]);
    translate([-D1/2,-D2/2,(A-N-tol)/2])cube([D1,D1,N+tol]);
    
}
}
//part#2
module create_part2() {
translate([S,0,0])rotate([0,0,180])difference(){
 cylinder(  h=A, d=D2-2*tol,$fn=rendering_quality);  
    translate([0,0,A/2])rotate([90,0,0])cylinder(  h=A, d=D3+tol*2,center=true ,$fn=rendering_quality);
    translate([0,0,A/2])rotate([90,30,0]) linear_extrude(height = 12,  convexity = 10, $fn=rendering_quality) {
    polygon(points = [ [N/2*cos(0), N/2*sin(0)], [N/2*cos(60), N/2*sin(60)], [N/2*cos(120), N/2*sin(120)], [N/2*cos(180), N/2*sin(180)], [N/2*cos(240), N/2*sin(240)], [N/2*cos(300), N/2*sin(300)] ]);
    }
    
}
}
//part#3 
module create_part3() {
    difference(){
translate([-D1/2-A2,-D1/2,0])cube([D1/2,D1,A]); 
   translate([D2/2,0,(A/2+N/2)]) cylinder(h = A, d = D1+D2+2*tol, $fn=rendering_quality);
    translate([D2/2,0,-(A/2+N/2)]) cylinder(h = A, d = D1+D2+2*tol, $fn=rendering_quality);
    translate([D2/2,0,0]) cylinder(h = A, d = D1+D2-1, $fn=rendering_quality);
    translate([0,0,A/2]) rotate([90,0,90]) cylinder(h = D1+D2, d = D3+2*tol, $fn=rendering_quality,center = true);
}
}

//--------------------
//Start of the code
//create parts
//--------------------

create_part1();

translate([-D1,A/2,D2/2-tol])rotate([90,0,0]) 
create_part2();

translate([-D1*1.5,0,D1/2+A2]) rotate([0,-90,0])
create_part3();