//Switching from glass bed to stock bed requires adjusting the Z stop limit switch.  Adding this U-spacer can compensate for the glass thickness, and the Z switch does not have to move.
tk=2;  //glass thickness 2-4
increment=0.2; //making 3 U-spacers, thickness tk, tk+increment, and tk-increment. Pick the best fit.

module zstop(tk=2){
difference(){
translate([0,0,0])  cube([9,10,10]);
translate([2,-0,tk]) cube([4.56,20,50]);
translate([2,10,tk]) rotate([90,0,0]) cylinder(r=1,h=20,$fn=100);
translate([6.5,10,tk]) rotate([90,0,0]) cylinder(r=1,h=20,$fn=100);

}}




zstop(tk);

translate([12,0,0])zstop(tk-increment);
translate([24,0,0])zstop(tk+increment);
