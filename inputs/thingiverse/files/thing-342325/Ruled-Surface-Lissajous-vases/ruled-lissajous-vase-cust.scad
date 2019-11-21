// Height of vase
Height=60;
//Thickness of wall and base
Thickness=0.5;
// Base Radius 
Radius_base=20;
//Base eccentricity 1 = circular
Eccentricity_base=1.4;
//Top Radius 
Radius_top=20;
//Top eccentricity
Eccentricity_top=1/1.4;

// Include Base
Make_base=1;  // [0,1]

// Resolution of surface
Steps=150;

// Resolution of cylinder
Sides=10;

//  Lissajous parameters
A=1;
B=1;
Theta=90;


function norm(v) =
    pow(v.x*v.x + v.y*v.y + v.z*v.z,0.5);

module orient_to(origin, normal) {   
      translate(origin)
      rotate([0, 0, atan2(normal.y, normal.x)]) 
      rotate([0, atan2(sqrt(pow(normal.x, 2)+pow(normal.y, 2)),normal.z), 0])
      child();
}

module slice(x,thickness,params) {
    assign(pa = f(x,params)) 
    assign(pb = g(x,params))
    assign(length = norm(pb-pa))
    orient_to(pa,pb-pa)
        cylinder(r=thickness,h=length);   
};

module ruled_surface(limit,step,thickness=1,params) {
 for (x=[0:step:limit])
  hull() {
      slice(x,thickness,params);
      slice(x+step,thickness,params);
  }
};

module ground(size=50) {
   translate([0,0,-size]) cube(2*size,center=true);
}

module ruler(n) {
   for (i=[0:n-1]) 
       translate([(i-n/2 +0.5)* 10,0,0]) cube([9.8,5,2], center=true);
}

function f(x,p) = [Eccentricity_base*Radius_base * (cos(x*360 ) ), 
                   Radius_base * (sin(x*360) ),
                   0];
function g(x,p) = [Eccentricity_top*Radius_top * (cos(A*x*360+Theta) ) , 
                   Radius_top * (sin(B*x*360+Theta) ),
                   Height];

Step=1/Steps;

$fn= Sides;

scale(1.5) {

  difference() {
   ruled_surface(1,Step,Thickness);
   ground();
 //  cube(50);
 }
 if (Make_base==1) 
     linear_extrude(height=Thickness) scale([Eccentricity_base,1,1]) circle(Radius_base,$fn=100);
}

* ruler(10);