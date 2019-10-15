/* [Slider] */
length = 30; // [20:50]
/* [Hidden] */
margin = 5;
/* [Slider] */
desk = 28; // [10:50]
/*[ Slider ]*/
headphone = 40; // [30:60]

module rounded(t1, t2) {
    difference() {
        translate(t1) {
            cube([length, margin, margin]);
        }
        translate(t2) {
            rotate([0, 90, 0]) {
                cylinder(length, margin, margin);
            }
        }
    }  
}

module holder() {
    difference(){
        //desk holder
        translate([0, -margin, -margin])
        cube([length, length+margin, desk+margin*2]);
        
        //desk representation
        translate([-length/2, 0, 0])
        cube([length*2, length*2, desk]);
    }

    translate([0, -(headphone+margin), desk-margin]) {
        
        cube([length, headphone, margin]);
        
        translate([0, 0, margin])
        cube([length,margin, margin]);
        
        translate([0, 0, -desk/2])
        cube([length, margin, desk/2]);
        
        translate([0, 0, -desk/2-margin])
        cube([length, headphone *3/4, margin]);
        
        translate([0, headphone*2/3, -desk/2-margin])
        cube([length, margin, margin*2]);
        
        rounded([0, headphone-margin, -margin], [0, headphone-margin, -margin]);
        rounded([0, headphone-margin, margin], [0, headphone-margin, margin*2]);
        rounded([0, margin, margin], [0, margin*2, margin*2]);
        rounded([0, margin, -margin], [0, margin*2, -margin]);
        rounded([0, margin, -desk/2], [0, margin*2, margin-desk/2]);
        rounded([0, headphone*2/3-margin, -desk/2], [0, headphone*2/3-margin, margin-desk/2]);
    }
}

translate([margin+desk, length, length])
rotate([180, 90, 0])
holder();