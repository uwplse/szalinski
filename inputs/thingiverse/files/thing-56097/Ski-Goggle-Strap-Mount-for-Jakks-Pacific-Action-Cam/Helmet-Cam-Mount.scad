$fn=100;
brad=54/2;
trad=31.4/2;
gap=2.5;

cylinder(r=brad,h=2);
cylinder(r=trad,h=2+gap+2.5);
intersection(){
   translate([0,0,2+gap+1.25]) cube([11.5,trad*2+6,2.5], center=true);
   cylinder(r=trad+3,h=2+gap+2.5);
}
   translate([0,0,2+gap+1.25]) cube([1,trad*2+6+1,2.5], center=true);

difference() {
translate([0,0,1]) cube([47,brad*2+15,2], center=true);
translate([-20.5,brad,-1]) cube([41,5,4]);
translate([-20.5,-brad-5,-1]) cube([41,5,4]);
}