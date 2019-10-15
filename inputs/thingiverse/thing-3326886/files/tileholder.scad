// Diameter of your tray's centre hole, if different from CD standard 15 mm
hole_diameter = 15.0;
// Outer diameter of your tray's recess. CD default is 120 but you can increase it for a better fit to your tray.
outer_diameter = 120.5;
// Tray thickness - you can match this to the recess of your CD tray or just use the default(safe) CD thickness of 1.2mm to avoid catching on your print head or printer's mechanism.
tray_thickness = 1.2;

// Add some tolerance (mm) to the tile holes. They are 45x45 exactly,, you can add some breathing room here for a looser fit if desired. 
tile_hole_tolerance = 0; //[0:0.05:1]

// How far the tile hole should be placed from the inner printable area limit. Use this to fine-tune your tile position in the holder.
tile_hole_offset = 0.2;

// Inner Diameter of your printable area on your printer.
inner_printable_diameter = 17.1;

// The largest printable diameter your printer will let you print on a CD.
outer_printable_diameter = 118;

// Lets you inset the printable area for visualization to make sure your tile holes will fit by recessing non-printable area slightly.
show_print_area = 1;//[0:No,1:Yes]

// If your disc tray has finger recesses, then you can enable this to add a protrusion to ensure the holder stays in the same position every print. Set width to 0 to disable.
alignment_tab_1_width = 19.85;
alignment_tab_1_depth = 5;

// The angle at which your alignment tab is located. 0 degrees = on the positive X axis.
alignment_tab_1_angle = -45;

// If your disc tray has finger recesses, then you can enable this to add a second protrusion to ensure the holder stays in the same position every print. Set width to 0 to disable.
alignment_tab_2_width = 0;
alignment_tab_2_depth = 5;

// The angle at which your alignment tab is located. 0 degrees = on the positive X axis.
alignment_tab_2_angle = 115;

module hub(){
    cylinder(tray_thickness+0.01,d=hole_diameter,$fn=200);
}

module tilehole(){
    tol_offset = tile_hole_tolerance/2;
    print_radius = inner_printable_diameter/2;
    translate([print_radius+tile_hole_offset+tol_offset,-22.5-tol_offset,-0.005]){
        cube(45+tile_hole_tolerance,45+tile_hole_tolerance,tray_thickness + 0.01);
    }
}

module printarea(){
    difference(){
        cylinder(0.3,d=outer_diameter,$fn=360);
        translate([0,0,-0.005]){
            cylinder(0.31,d=outer_printable_diameter,$fn=360);
        }
    }
        cylinder(0.3,d=inner_printable_diameter,$fn=360);
   
}


module disc(){
    difference(){
        cylinder(tray_thickness,d=outer_diameter,$fn=200);
        if (show_print_area==1){
    translate([0,0,tray_thickness-0.29]){
        printarea();
    }
}
    }
}

difference(){
    disc();
    translate([0,0,-0.005]){
        hub();
    }
    tilehole();
    rotate([0,0,-180]){
        tilehole();
    }
}

// Orientation protrusion 1
if (alignment_tab_1_width>0){
    rotate([0,0,alignment_tab_1_angle]){
        inner_dia = outer_diameter/2;
    translate([inner_dia-2,-alignment_tab_1_width/2,0]){
        cube([2+alignment_tab_1_depth,alignment_tab_1_width,,tray_thickness]);
    }
    }
}

// Orientation protrusion 2
if (alignment_tab_2_width>0){
    rotate([0,0,alignment_tab_2_angle]){
        inner_dia = outer_diameter/2;
    translate([inner_dia-2,-alignment_tab_2_width/2,0]){
        cube([2+alignment_tab_2_depth,alignment_tab_2_width,,tray_thickness]);
    }
    }
}