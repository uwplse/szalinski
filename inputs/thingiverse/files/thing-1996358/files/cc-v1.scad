$fn=128;
difference(){
union(){    
cylinder(100,70/2,90/2);
translate([0,-5,5]){cube([120/2,20/2,20/2]);    }
translate([0,-5,70]){cube([150/2,20/2,20/2]);    }
translate([130/2,0,10]){rotate([0,7,0]){cylinder(70,20/2,20/2);    }}
translate([130/2,0,14]){sphere(24/2);    }
translate([150/2,0,80]){sphere(24/2);    }
}  

translate([0,0,3]){cylinder(100,60/2,88/2);    }
    
}
