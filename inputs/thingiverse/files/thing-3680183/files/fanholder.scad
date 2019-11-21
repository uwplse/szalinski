$fn = 100;

wall = 3.4;

sizex = 25;
sizey = 14;

fanholeoutd = 7;
fanholeind = 5;
mountholed = 5;
centerdiff = 5;

module base(){
    translate([0,0,wall/2]) cube([sizex, sizey, wall], center=true);
    translate([sizex/2+wall/2,0,sizey/2+wall])cube([wall, sizey, sizey+wall*2], center=true);
}

module holes(){
    translate([sizex/2,0,sizey/2+wall*2]) rotate([0,90,0]) cylinder(d1=fanholeind, d2=fanholeoutd, h=wall);
    translate([centerdiff,0,0]) cylinder(d=mountholed, h=100);
    translate([-centerdiff,0,0]) cylinder(d=mountholed, h=100);
}

difference(){
    base();
    holes();
}