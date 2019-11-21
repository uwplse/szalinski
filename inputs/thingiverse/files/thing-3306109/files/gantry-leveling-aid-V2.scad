
b=5.8;
cube([5,40,115],center=false);
cube([25,40,5],center=false);
difference() {
    translate([0,7,-b/2]) cube([25,b,3], center=false);
    translate([0,7+b-1,-b-1]) rotate ([45,0,0])cube([25,b,3], center=false);
    translate([0,9.8,-b+1.5]) rotate ([135,0,0])cube([25,b,3], center=false);
    
    };
difference() {    
    translate([0,27,-b/2]) cube([25,b,3], center=false);
    translate([0,27+b-1,-b-1]) rotate ([45,0,0])cube([25,b,3], center=false);
    translate([0,29.8,-b+1.5]) rotate ([135,0,0])cube([25,b,3], center=false);
    
    };