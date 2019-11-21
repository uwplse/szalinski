/******************************************************
    Battery holder for model 6-cells NiMH akupacks.
    Scaled to Orion and GENS.
    
    created by Svenny
 ******************************************************/

$fn = 200;

// default length of the holder
// (length of the pack without plastic caps)
default_len = 105;

// default cell diameter
default_d = 23;

// default flat-bed switch
default_flat=true;

module bateries(l, d) {
    hull() {
        translate([-11.5,0,0]) cylinder(d=d, h=l, center=true);
        translate([11.5,0,0]) cylinder(d=d, h=l, center=true);
    }
}

module body(l, d, flat) {
    difference() {
        hull() {
            scale([1.05,1.15,1]) bateries(l, d);
            if(flat)
                translate([0,-7,0]) cube([43,13,l], center=true);
        }
        
        // hole for akupack
        bateries(l*1.001, d);
    }
}

module holder(l=default_len, d=default_d, flat=default_flat) {
    difference() {
        body(l, d, flat);
            
        // centerlines
        translate([0,0,l/2]) cube([0.3,d+1,2], center=true);
        translate([0,0,-l/2]) cube([0.3,d+1,2], center=true);
    
        // top
        translate([0,5,0]) cube([32,20,l*1.1], center=true);
        
        // screwholes
        offset = l/2-10;
        translate([0,-9.6,-offset]) 
            rotate([90,0,0]) 
                cylinder(r2=1.5, r1=6, h=4);
        translate([0,-9.6,offset]) 
            rotate([90,0,0]) 
                cylinder(r2=1.5, r1=6, h=4);
        
        // center holes
        translate([21,-5,0]) cube([20, 28, l-2*20], center=true);
        translate([-21,-5,0]) cube([20, 28, l-2*20], center=true);
    }
}


translate([90,0,10]) 
    holder(20, default_d, true);
translate([90,80,10]) 
    holder(20, default_d, false);

translate([0,0,default_len/2])
    holder(); 
translate([0,80,default_len/2])
    holder(flat=false);