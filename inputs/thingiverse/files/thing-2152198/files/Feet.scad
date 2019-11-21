// The height (in millimeters) of the leveling foot's base
base_height = 1.0; // [0.5:0.1:50]

/* [Hidden] */
faces = 100;

difference(){
    union(){ 
        translate([0,0,base_height]){
            // cone
            difference(){
                cylinder(h=3.2, r1=14, r2=14.72, $fn=faces);
                // extra height as the "cutter" must extend beyond
                // what it cuts through. It also solves rendering
                // issues on Thingispace.
                translate([0,0,-1]){
                    cylinder(h=3.2+2, r1=11.6, r2=12.32, $fn=faces);
                }
            }
            
            // bottom circle
            rotate([0,180,0]){
                cylinder(h=base_height, r=14, $fn=faces);
            };
        }
    }

    // center hole - must extend beyond what it cuts through
    translate([0,0,-1]){
        cylinder(h=base_height+2, r=1, $fn=faces);
    }
}