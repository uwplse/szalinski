
$br = 20;  // border radius
$ir = 5;   // internal radius
$hr = 2;   // hole radius
$hsd = 13; // h singledispenser

$offset = .1;
$number_iteration = 1;
$explosion = false;

// main

if (!$explosion) {
    $ni = ($number_iteration-1);
    for (i=[0:$ni]) {
        translate([0,0,($hsd*i)]) single_dispenser_bottom();
        translate([0,0,($hsd*i)]) single_dispenser_top();
        translate([0,0,($hsd*i)]) single_cover();
    }
    translate([0,0,$hsd*$number_iteration]) close_cover();
} else {
    translate([0,0,0])          single_cover();
    translate([0,0,$hsd+5])     single_dispenser_bottom();
    translate([0,0,2*($hsd)])   single_dispenser_top();
    translate([0,0,3*($hsd+2)]) close_cover();
}

// modules

module single_dispenser_bottom() {
    difference() {
        union() {
            cylinder(r=$br,h=$offset+1,$fn=100);
            translate([0,0,$offset+1]) cylinder(r=$ir,h=$offset+($hsd-$hr-1),$fn=100);
            
            rotate([90,0,0]) translate([1,0,-3.5]) cube([$offset+5,$offset+5,($hsd/2)+1]);
        }
        union() {
            translate([0,0,-1]) cylinder(r=$offset+$hr,h=$hsd+1,$fn=100);
            rotate([90,0,0]) translate([4,3,-7]) cylinder(r=$offset+1.2,h=$hsd+1,$fn=100);
            
            translate([-2.1,-3.85,5])cube([4.2,1.1+$offset,$hsd-5.8]);
            translate([-2.1,2.75,5])cube([4.2,1.1+$offset,$hsd-5.8]);
        }
        
        translate([13,0,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        translate([9,9,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        
        translate([-13,0,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        translate([-9,9,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        
        translate([0,13,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        translate([-9,-9,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        
        translate([0,-13,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        translate([9,-9,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
            
    }
}

module single_dispenser_top() {
    difference() {
        union() {
            
            translate([0,0,2*$offset+($hsd-(2*$hr)+2)])  cylinder(r=$br,h=$offset+1,$fn=100);
            
            translate([-1.8,-(3.8+($offset/2)),5])cube([3.6,1-$offset,$hsd-5.8]);
            translate([-1.8,2.8+($offset/2),5])cube([3.6,1-$offset,$hsd-5.8]);
            
        }
        union() {
            translate([0,0,-1]) cylinder(r=$offset+$hr,h=$hsd+1,$fn=100);
            
        }
        
        translate([13,0,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        translate([9,9,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        
        translate([-13,0,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        translate([-9,9,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        
        translate([0,13,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        translate([-9,-9,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        
        translate([0,-13,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
        translate([9,-9,-1]) cylinder(r=$offset+3.4,h=$hsd+1,$fn=100);
            
        }
}

module hole_wire() {
    translate([($br-$ir),($br-$ir)/2,(($offset*3)+$hsd-5)/3]) rotate([0,90,0]) cylinder(r=$offset+1,h=10,$fn=100);
    translate([($br-$ir),($br-$ir)/2,(($offset*3)+$hsd+15)/3]) rotate([0,90,0]) cylinder(r=$offset+1,h=10,$fn=100);
    translate([($br-$ir),(($br-$ir)/2)-1.1,(($offset*3)+$hsd+15)/3]) rotate([0,90,0]) cube([7,2*($offset+1),10]);
    
    translate([($br-$ir),(($br-$ir)/2)+1.6,(($offset*3)+$hsd+15)/3]) rotate([0,90,0]) cylinder(r=$offset+.5,h=10,$fn=100);
    translate([($br-$ir),(($br-$ir)/2)+1.8,(($offset*3)+$hsd+15)/3]) rotate([0,90,0]) cylinder(r=$offset+.5,h=10,$fn=100);
    translate([($br-$ir),(($br-$ir)/2)+2,(($offset*3)+$hsd+15)/3]) rotate([0,90,0]) cylinder(r=$offset+.5,h=10,$fn=100);
    translate([($br-$ir),(($br-$ir)/2)+2.2,(($offset*3)+$hsd+15)/3]) rotate([0,90,0]) cylinder(r=$offset+.5,h=10,$fn=100);
    translate([($br-$ir),(($br-$ir)/2)+2.4,(($offset*3)+$hsd+15)/3]) rotate([0,90,0]) cylinder(r=$offset+.5,h=10,$fn=100);
    translate([($br-$ir),(($br-$ir)/2)+2.6,(($offset*3)+$hsd+15)/3]) rotate([0,90,0]) cylinder(r=$offset+.5,h=10,$fn=100);
}

module single_cover() {
        difference() {
            difference() {
                translate([-($br+2),-($br+2),-1.5]) cube([2*($br+2),2*($br+3),($offset*3)+$hsd+1]);
                hole_wire();
            }
            union() {
                translate([-($br-2.5),($br-1.5),-2]) cylinder(r=$offset+2,h=$hsd+3,$fn=100);
                translate([($br-2.5),($br-1.5),-2]) cylinder(r=$offset+2,h=$hsd+3,$fn=100);
                translate([-($br-2.5),-($br-1.5),-2]) cylinder(r=$offset+2,h=$hsd+3,$fn=100);
                translate([($br-2.5),-($br-1.5),-2]) cylinder(r=$offset+2,h=$hsd+3,$fn=100);
        
                translate([($br/2),-(($br/2)+5),-.5]) cube([($br+1.5),$br/2,($offset*3)+$hsd+1]);
                
                rotate([90,0,0]) union() {
                    translate([-($br-2.5),$ir,-($br+4.6)]) cylinder(r=$offset+2,h=3,$fn=100);
                    translate([($br-2.5),$ir,-($br+4.6)]) cylinder(r=$offset+2,h=3,$fn=100);
                }
            }
            
            translate([0,0,-.5]) cylinder(r=$br+1.5,h=($offset*3)+1+$hsd,$fn=100);
        }
        translate([0,0,-1.4]) cylinder(r=$hr-(2*$offset),h=($offset*3)+$hsd+1.4,$fn=100);
        
        rotate([90,0,0]) union() {
            translate([-($br-2.5),$ir,$br+1.4]) cylinder(r=$offset+2,r2=$offset+1.8,h=3,$fn=100);
            translate([($br-2.5),$ir,$br+1.4]) cylinder(r=$offset+2,r2=$offset+1.8,h=3,$fn=100);
        }
        
        
}


module close_cover() {
    difference() {
        translate([-($br+2),-($br+2),($offset*3)-.5]) cube([2*($br+2),2*($br+3),1]);
        union() {
            translate([-($br-2.5),($br-1.5),-2]) cylinder(r=$offset+2,h=$hsd+3,$fn=100);
            translate([($br-2.5),($br-1.5),-2]) cylinder(r=$offset+2,h=$hsd+3,$fn=100);
            
            translate([-($br-2.5),-($br-1.5),-.3]) cylinder(r=$offset+2,h=1.5,$fn=100);
            translate([($br-2.5),-($br-1.5),-.3]) cylinder(r=$offset+2,h=1.5,$fn=100);
        }
        
    }
}


