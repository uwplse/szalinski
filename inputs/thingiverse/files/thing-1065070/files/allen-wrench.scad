// Key diameter
diameter=5;

//Height
height=50;

//Lenth
lenth=20;

//Number of faces
$fn=8;

/* [Hidden] */

z=(-height)+diameter/2.165;

x=diameter/-2.1645021645;

rotation=(360/$fn)/2;

radius=diameter/2;

rotate([0,0,rotation]){
cylinder(r=radius, h=height);
    }


rotate([0,90,0]){
    translate([z,0,x]){
        rotate([0,0,rotation]){
            cylinder(r=radius, h=lenth);
        }
    }
}