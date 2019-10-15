inner_diameter = 45.0; //[24:0.1:70]
bearing_style = 1; //[1:Inside, 2:Outside]
bearing_fit = 11.2; //[11.2:Normal, 11:Tight]

inner_rad = inner_diameter/2;
outer_diameter = inner_diameter + 5;
outer_rad = outer_diameter/2;

difference() {
    
    union() {
        cylinder(3,outer_rad,outer_rad,false,$fn=360);
        translate ([0,0,3]) {
            cylinder(7,inner_rad,inner_rad,false,$fn=360);
        }
    };
    
    union() {
        if (bearing_style == 2) {
            cylinder(7,bearing_fit,bearing_fit,false,$fn=360);
            translate ([0,0,7]) {
                cylinder(3,4,4,false,$fn=360);
            }
        } else {
            cylinder(3,4,4,false,$fn=360);
            translate ([0,0,3]) {
                cylinder(7,bearing_fit,bearing_fit,false,$fn=360);
            }
        };
    };
}