$fn=50+0;
/* [Cap Type] */
type="solid"; // [coin,hole,solid]
/* [Option Dimensions] */
//dimentions of optional coin slot
slotL=25;
slotW=3;
//diameter of optional hole
holeDia=8;
/* [Hidden] */
height=12.1;
innerDia=37;
outerDia=40;

difference(){
translate([0,0,height/2]) cylinder(d=outerDia,h=height,center=true);
translate([0,0,(height/2)+1]) cylinder(d=innerDia,h=height,center=true);

if (type=="coin") cube([slotL,slotW,10],true);
if (type=="hole") cylinder(d=holeDia,h=10,center=true);
};
rotate([-3,0,0]) translate([-(innerDia/2),0,11.2]) cube([2,7,1.5],true);
rotate([-3,0,0]) translate([-(innerDia/2),0,7.2]) cube([2,7,1.5],true);

rotate([3,0,0]) translate([(innerDia/2),0,9.2]) cube([2,7,1.5],true);

rotate([0,3,0]) translate([0,(innerDia/2),10.2]) cube([7,2,1.5],true);
rotate([0,-3,0]) translate([0,-(innerDia/2),8.2]) cube([7,2,1.5],true);
