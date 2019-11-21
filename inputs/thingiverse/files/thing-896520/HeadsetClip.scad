
//Monitor Depth
monD=25;

//Monitor frame
monF=19;

//Headset Depth
heaD=10;

//Headset Diameter
heaDiameter = 50;

//Headset lip;
heaL=6;

//Total width
width=25;

//thickness
thick=1.4;

//face number
$fn=100;

//security
heaDia= max(width+thick*2,heaDiameter);

function pyth(a,h) = sqrt(h*h - a*a);

difference() {
    cube([monD+thick*2,monF+thick,width]);
    translate([thick,-0.1,-0.1]) cube([monD,monF+0.1,width+0.2]);
   // translate([thick*2+monD,thick,0]) cube([heaD,monF,width]);
    translate([thick+monD,-pyth(width/2,(heaDia-thick*2)/2),width/2])rotate([0,90,0])
    cylinder(d=heaDia-thick*2,h=thick);
}
intersection(){
translate([thick*2+monD,-pyth(width/2,(heaDia-thick*2)/2),width/2])
rotate([0,90,0])
difference(){
    union(){
        cylinder(d=heaDia,h=heaD);
        translate([0,heaL,heaD])cylinder(d=heaDia,h=thick);
    }
    cylinder(d=heaDia-thick*2,h=heaD+thick);
}
cube([monD+thick*3+heaD,monF+thick,width]);
}