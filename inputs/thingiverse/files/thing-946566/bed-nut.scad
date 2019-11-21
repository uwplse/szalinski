wd=10;
offsetx=0;
offsety=0;

difference()
{
    minkowski(){
    cube([wd,5,5.],center=true);
    cylinder(d=5,h=5,center=true);
    }
    translate([offsetx,offsety,-5]) color([0.1,0.4,0.4]) cylinder(r=3,h=4,$fn=6,center=true);
    translate([offsetx,offsety,-5]) color([0.1,0.4,0.4]) cylinder(d=3.5,h=15,$fn=50,center=true);
    translate([0,0,5]) color([0.4,0.1,0.9]) cube([wd,30,10],center=true);
}