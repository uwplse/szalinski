// Height 
Height = 60;
// Bottom Radius
Bottom_Radius = 20;
// Top Radius
Top_Radius = 20;
// phase angle 
Phase=120;
// Thickness of struts
Thickness=1.5;
//Eccentricity
Eccentricity=1.5;
// Number of increments 
Steps=18;
// sides of cylinder
Sides=10;
// base height  0 = no base
Base_Height = 3;
// base width 
Base_Width = 3;
// top height  0 = no base
Top_Height = 3;
// base width 
Top_Width = 3;
//Offset of hyperboloid into base 
Offset=1;

function norm(v) =
    pow(v.x*v.x + v.y*v.y + v.z*v.z,0.5);

module orient_to(origin, normal) {   
      translate(origin)
      rotate([0, 0, atan2(normal.y, normal.x)]) 
      rotate([0, atan2(sqrt(pow(normal.x, 2)+pow(normal.y, 2)),normal.z), 0])
      child();
}

module ruled_surface(limit,step,thickness,params) {
 for (x=[0:step:limit])
    assign(pf = f(x,params)) 
    assign(pg = g(x,params))
    assign(length = norm(pg-pf))
    orient_to(pf,pg-pf)
        cylinder(d=thickness,h=length);   
};

module ground(s=60) {
   translate([0,0,-s]) cube(s * 2, center=true);
}

function f(a,phase) = [ Bottom_Radius * cos(a), 
                        Bottom_Radius * Eccentricity * sin(a),
                        0];
function g(a,phase) =[ Top_Radius * cos(a+phase), 
                       Top_Radius * Eccentricity * sin(a + phase),
                       0]
                     + [0,0,Height];
eps=0.1;
Limit=360;
Step = Limit/Steps;
$fn= Sides;
translate([0,0,Base_Height-Offset])
 difference() {
   union(){
     ruled_surface(Limit,Step,Thickness,Phase);
     ruled_surface(Limit,Step,Thickness,-Phase);
   }
   ground();
}
scale([1,Eccentricity,1]) {
  difference() {
    cylinder(r=Bottom_Radius+Base_Width/2,h=Base_Height,$fn=100); 
    translate([0,0,-eps]) cylinder(r=Bottom_Radius-Base_Width/2,h=Base_Height+2*eps,$fn=100);
   } 
   translate([0,0,Height])
   difference() {
    cylinder(r=Top_Radius+Top_Width/2,h=Top_Height,$fn=100); 
    translate([0,0,-eps]) cylinder(r=Top_Radius-Top_Width/2,h=Top_Height+2*eps,$fn=100);
   }
}