// KWB KWB497609 Mortier Mixeur 90 x 400mm
// Modeling as in ebay | all in mm 
$fn=200;
// AXE
translate([0.45,0,0])
hull() {
    translate([-2,-2,0])
    cylinder(r=0.5,h=400, center=true, $fn=200);
    translate([2,2,0])
    cylinder(r=0.5,h=400, center=true, $fn=200);
    translate([2,-2,0])
    cylinder(r=0.5,h=400, center=true, $fn=200);
     translate([-2,2,0])
    cylinder(r=0.5,h=400, center=true, $fn=200);
}

// HEAD MIX

// First Bar
 rotate(-4){
            translate([-3,-45,-96])
            cube([7,90,5], centre=true);
        }

// Second Bar
 rotate(15){
            translate([-3,-45,-200])
            cube([7,90,5], centre=true);
        }

// First Spring
translate([0,0,-200])
for ( z = [1:170]){ rotate(z*2) translate([-15,45,z*.6]) 
    rotate([90,0,0]) cube(size = [9,7,3], center = false);}

       
// Second Spring
rotate(182){
translate([0,0,-200])
for ( z = [1:170]){ rotate(z*2) translate([-15,45,z*.6]) rotate([90,0,0]) cube(size = [9,7,3], center = false);}

}


    