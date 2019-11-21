/* [Top Plate] */

// Diameter of the top plate, in mm.
diam = 116;

// Thickness of the top plate, in mm.
thickness = 3;


/* [Tertiary Poles] */

// Diameter of the hole leading to one of the four side poles, in mm.
pole_diam_top = 20;

// Diameter of the bottom of the four side poles, in mm. Typically smaller than the top diameter for tapering. For minimal support structures, make the poles cone-shaped by keeping this number small so your printer can bridge the center pole gap.
pole_diam_bottom = 6;

// Height of the hollowed pole section (not counting stilt), in mm.
pole_height = 40;

// Height of the stilt (raised area at the bottom of the pole), in mm.
pole_stilt_height = 3;

// Relative position of pole away from center, between 0 and 1. 
poles_center = 2/3;

// Diameter of the drainage hole at the bottom of the pole, in mm.
pole_hole = 3;

/* [Center Pole] */

// Size of the center pole relative to the tertiary ones, as a multiplier.
center_pole_scale = 2.5;


/* [Drainage Panels] */

// Diameter of a drainage hole in the panel, in mm.
hole = 2;

// Number of hole rows in one panel.
hole_rows = 4;

// Number of hole columns in one panel.
hole_cols = 4;

// Distance between holes, in mm.
hole_padding = 3;


/* [Watering tube/indicator] */

// Enable or disable the watering tube attachment.
watering_tube = false;

// Diameter of the watering tube attachment top, in mm.
watering_tube_top = 11.7;

// Diameter of the watering tube attachment bottom, in mm. 
watering_tube_bottom = 11.7;

// Height of the watering tube attachment, in mm.
watering_tube_height = 5;

// Relative position of the watering tube attachment, between 0 and 1.
watering_tube_position = 13/16;

/* [Expert] */

// Quality
$fn=64;

// Pole drainage hole adjustment.
diff = 0.1;

module pole(cent = 0) {
    translate([diam/2*poles_center*(1-cent),0, thickness-diff]) 
        union(){
            cylinder(r1= pole_diam_top/2, r2= pole_diam_bottom/2, h= pole_height+diff);
           
        if(cent==0)
            translate([0,0,pole_height+diff]) {
                difference(){
                        cylinder(r1= pole_diam_bottom/2, r2= pole_diam_bottom/2, h=pole_stilt_height);
                        cylinder(r1= pole_diam_bottom*3/8, r2=pole_diam_bottom*3/8, h=pole_stilt_height);
                        cube([pole_diam_bottom,pole_diam_bottom,pole_stilt_height]);
                    }
                }
            }
}

module pole_in(cent = 0){
    translate([diam/2*poles_center*(1-cent),0, -diff]) cylinder(r1= pole_diam_top/2-thickness/2, r2= pole_diam_bottom/2-thickness/2, h= pole_height+diff);
    
    translate([diam/2*poles_center*(1-cent),0,pole_height-3]) rotate([0,90,0]) scale([1,1/center_pole_scale,1]) translate([0,0,-pole_diam_top/2]) cylinder(r = pole_hole/2, h = pole_diam_top);
    translate([diam/2*poles_center*(1-cent),0,pole_height-3]) rotate([90,0,0]) scale([1/center_pole_scale,1,1]) translate([0,0,-pole_diam_top/2]) cylinder(r = pole_hole/2, h = pole_diam_top);
    
    if(cent==0)
        translate([diam/2*poles_center*(1-cent),0,pole_height-3]) rotate([0,0,0]) translate([0,0,-pole_diam_top/2]) cylinder(r = pole_hole/2, h = pole_diam_top);
}

difference(){
    union(){
        cylinder(r=diam/2, h = thickness);
        scale([center_pole_scale,center_pole_scale,1])
            pole(cent = 1);
        
        for(i=[1:4])
            rotate([0,0,i*90+45])
                pole();
        
        if(watering_tube)        
            translate([-diam/2*watering_tube_position, 0, 0]) cylinder(r1=(watering_tube_top+thickness)/2, r2=(watering_tube_bottom+thickness)/2, h=watering_tube_height);
    }
    
    for(i=[0:(pole_height/(pole_hole * center_pole_scale))-2])
        translate([0,0,i*-(pole_hole * center_pole_scale)])
            scale([center_pole_scale,center_pole_scale,1])
                pole_in(cent = 1);
    for(i=[1:4])
        rotate([0,0,i*90+45])
            pole_in();
    
    for(i=[1:4])
        rotate([0,0,i*90]) {
            translate([-diam/2*poles_center,hole_padding,-diff])
                for(j=[1:hole_rows])
                    for(k=[1:hole_cols]) 
                        translate([((j-(hole_rows/2))*(hole+hole_padding)),(k-1-(hole_cols/2))*(hole+hole_padding), 0]) {
                            cylinder(r= hole/2, h= thickness + 2*diff);
                        }
        }
            
    if(watering_tube)
        translate([-diam/2*watering_tube_position, 0, -diff]) cylinder(r1=(watering_tube_top)/2, r2=(watering_tube_bottom)/2, h=watering_tube_height+2*diff);
}