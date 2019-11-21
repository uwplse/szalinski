$fn = 60;
bushshell = 2;
bushheight = 25;
bushdiam = 47.5 ;
ringdiam = 65;
holediam = 47.5;
ringthk = 2 ;
primwd = 13 ;
primht = 4 ;
secwd = 24 ;
secht = 6;
module mainpart(bushdiam,bushshell,bushheight,ringthk,ringdiam,holediam) {
rotate_extrude(convexity = 10) translate([bushdiam/2,0,0]) square([bushshell,bushheight],0) ;  
difference () {
    cylinder(ringthk,ringdiam/2,ringdiam/2);
    translate([0,0,-.5]) 
    cylinder(ringthk+1,holediam/2,holediam/2);} 
}
module knockout(primwd,bushheight,primht,secwd,secht) {
    translate([0,-primwd/2,bushheight-primht]) 
        cube (size = [bushdiam/2+primwd,primwd,primht],center = false);
    translate([0,-secwd+primwd/2,bushheight-primht-secht]) 
        cube (size = [bushdiam/2+secwd/2,secwd,secht], center = false);  }
difference() {
mainpart(bushdiam,bushshell,bushheight,ringthk,ringdiam,holediam);        
translate([0,secwd/2-primwd/2,0])
        knockout(primwd,bushheight,primht,secwd,secht);
rotate([0,0,120]) translate([0,secwd/2-primwd/2,0])
        knockout(primwd,bushheight,primht,secwd,secht);
rotate([0,0,-120]) translate([0,secwd/2-primwd/2,0])
        knockout(primwd,bushheight,primht,secwd,secht); }
        