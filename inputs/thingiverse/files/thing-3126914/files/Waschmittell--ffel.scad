/* [Spoon] */
// Main Radius
r = 26;
// Height Vertical wall
h1 = 13.5;
// Height cone (should be larger than r)
h2 = 30;

wall = 1.2;

/* [Hidden] */

r2 = 0.4;

h3 = wall;
r3 = (r2+wall)-((r-(r2+wall))*h3)/(h2);

v1 = 3.14159*r/10*r/10*h1/10;
v2 = 3.14159*(r/10*r/10)*(h2/10)/3;
v = v1+v2;

$fn=50;


difference(){
union(){
// outer
cylinder(r=r+wall,h=h1);
translate([0,0,h1])
    cylinder(r1=r+wall,r2=r2+wall,h=h2);
translate([0,0,h1+h2])
    cylinder(r1=r2+wall,r2=r3,h=h3);
//handle
hull(){
cylinder(r=r+wall,h=wall);
translate([3*r,0,0])
cylinder(r=r/3,h=wall);
}
}

union(){
// inner
cylinder(r=r,h=h1);
translate([0,0,h1])
    cylinder(r1=r,r2=r2,h=h2);
translate([2*r,0,wall-0.4])
    linear_extrude(height = 0.4)
        text(str(round(v)),size=7,halign="center",valign="center");
}

}


