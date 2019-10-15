/* Parametric Quadcopter Stack Shelf by briancmoses */

// What is your quadcopter's electronics stack layout??
layout=30; // [20:20x20mm, 30:30x30mm]

// How thick do you want the shelf stack to be?
shelf_height=1.25;

// What is the diameter of your stand-off's thread(M2=2mm, M3=3mm)?
standoff_thread_diameter=3;

// Do you want notches created for zip ties?
zip_tie_notch=true; //[true:Yes, false: No

//What is your zip tie's width in mm?
zip_tie_width=2.4;

//What is your zip tie's height in mm?
zip_tie_height=1.0;

/* [Hidden] */
padding=3;
modified_standoff_thread_diameter=(standoff_thread_diameter + .1);
modified_zip_tie_width=(zip_tie_width + .1);
modified_zip_tie_height=(zip_tie_height * 2);

stackshelf(layout);

module stackshelf(lo){
    difference(){
        hull(){
            translate([0,0,0]) cylinder(h=shelf_height, d=modified_standoff_thread_diameter+padding);
            translate([lo,0,0]) cylinder(h=shelf_height, d=modified_standoff_thread_diameter+padding);
            translate([lo,lo,0]) cylinder(h=shelf_height, d=modified_standoff_thread_diameter+padding);
            translate([0,lo,0]) cylinder(h=shelf_height, d=modified_standoff_thread_diameter+padding);
        }
        standoff_thread_holes(shelf_height, modified_standoff_thread_diameter, lo);
        if (zip_tie_notch==true) ziptie_notches(modified_zip_tie_height, modified_zip_tie_width, lo, padding, shelf_height, modified_standoff_thread_diameter);
    }
}

module standoff_thread_holes(so_height, so_diameter, so_layout){
    translate([0,0,0]) cylinder(h=so_height, d=so_diameter);
    translate([so_layout,0,0]) cylinder(h=so_height, d=so_diameter);
    translate([so_layout,so_layout,0]) cylinder(h=so_height, d=so_diameter);
    translate([0,so_layout,0]) cylinder(h=so_height, d=so_diameter);
}


module ziptie_notches(zt_height, zt_width, lo_zn, pad, sh_height, so_diameter){
    hull_x =((so_diameter+pad)/2) + lo_zn + ((so_diameter+pad)/2);
    hull_y =((so_diameter+pad)/2) + lo_zn + ((so_diameter+pad)/2);
    so_radius=((so_diameter+pad)/2);
    translate([-so_radius,hull_y/6,-10]) cube([zt_height*1.05,zt_width,20]);
    translate([-so_radius,(lo_zn-(hull_y/6)-zt_width),-10]) cube([zt_height*1.05,zt_width,20]);
    translate([hull_x-so_radius-zt_height,hull_y/6,-10]) cube([zt_height*1.05,zt_width,20]);
    translate([hull_x-so_radius-zt_height,(lo_zn-(hull_y/6)-zt_width),-10]) cube([zt_height*1.05,zt_width,20]);
}