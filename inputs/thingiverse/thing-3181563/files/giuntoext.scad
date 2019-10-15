difference(){
cube([16,16,25],center=true);
translate([0,0,25/2]) cylinder(r=5.3/2,h=25,center=true,$fn=100);
translate([0,0,-25/2]) cylinder(r=5.9/2,h=35,center=true,$fn=100);
translate([0,-8,0]) cube([0.5,16,30],center=true);    
rotate([0,90,0]) translate([0,-8,0]) cube([0.5,16,30],center=true);       
translate([0,-5,8]) rotate([0,90,0]) cylinder(r=3.2/2,h=35,center=true,$fn=100);
translate([0,-5,-8]) rotate([0,90,0]) cylinder(r=3.2/2,h=35,center=true,$fn=100);    
}

