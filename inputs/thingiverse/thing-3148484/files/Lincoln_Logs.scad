//Lincoln Logs

//All measurements below in mm
//You only need to change length and radius of log

//Length of Log
    L=40;
//Radius of Log
    R=5;
    
//Cutout Cube Size for Endcap Difference
    w=R*2;
    d=R*2;
    h=R;
//Length of Endcap
    E=w+1.5*R;
//Angle Log is Oriented At
    X=90;
    Y=0;
    Z=0;
//Translate Endcaps
    a=0;
    b=(L/2)+(E/2);
    c=0;
//Translate Cutouts
    x=0;
    y=0;
    z=R;
    
module log(){
//Positive Y Endcap of Log
translate ([a,b,c])difference() {
    rotate([X,Y,Z])cylinder(E,R,R,center=true);
    union(){
        translate([x,y,z])cube([w,d,h],center=true);
        translate([-x,y,-z])cube([w,d,h],center=true);
            }
        }
//Negative Y Endcap of Log
translate ([a,-b,c])difference() {
    rotate([X,Y,Z])cylinder(E,R,R,center=true);
    union(){
        translate([x,y,z])cube([w,d,h],center=true);
        translate([-x,y,-z])cube([w,d,h],center=true);
            }
        }
//Middle Cylinder
 rotate([X,Y,Z])cylinder(L,R,R,center=true);
}
log();