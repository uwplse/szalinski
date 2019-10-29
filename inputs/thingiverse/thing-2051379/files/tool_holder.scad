$fn = 50;
min_tool_width = 33.5;
min_tool_thickness = 13.5;
num_tools = 5;

tweezer_width = 11.7;
tweezer_thickness = 3.25;

plat_thickness = 3;

knife_width = 16;
knife_thickness = 7.86;

// Pliers, cutters, scissors

for (i=[0:num_tools-1]) {
    translate([0,i*(plat_thickness*2+min_tool_thickness),0])
    difference(){
        cube([min_tool_width+2*plat_thickness, min_tool_thickness+2*plat_thickness, plat_thickness]);
        translate([plat_thickness,plat_thickness,-0.5])cube([min_tool_width, min_tool_thickness, plat_thickness+1]);
    }
}

// Tweezers

tool_tray_width = num_tools*(plat_thickness*2+min_tool_thickness);

for (i=[0:1]) {
    translate([0,i*(knife_thickness + 2*plat_thickness) + tool_tray_width,0])
    difference(){
        cube([knife_width+2*plat_thickness, knife_thickness+2*plat_thickness, plat_thickness]);
        translate([plat_thickness,plat_thickness,-0.5])cube([knife_width, knife_thickness, plat_thickness+1]);
    }
}

// Sharp stuff

translate([2*plat_thickness + knife_width,0,0])
for (i=[0:2]) {
    translate([0,i*(tweezer_thickness + 2*plat_thickness)+tool_tray_width,0])
    difference(){
        cube([tweezer_width+2*plat_thickness, tweezer_thickness+2*plat_thickness, plat_thickness]);
        translate([plat_thickness,plat_thickness,-0.5])cube([tweezer_width, tweezer_thickness, plat_thickness+1]);
    }
}

// Ruler holder

translate([-plat_thickness,0,plat_thickness])
cube([plat_thickness,  3*(tweezer_thickness + 2*plat_thickness)+tool_tray_width, plat_thickness*2]);

translate([-2*plat_thickness - 2.5,0,plat_thickness])
cube([plat_thickness,  3*(tweezer_thickness + 2*plat_thickness)+tool_tray_width, plat_thickness*3]);

translate([-2*plat_thickness -2.5,0,0])
cube([plat_thickness*2 + 2.5,  3*(tweezer_thickness + 2*plat_thickness)+tool_tray_width, plat_thickness]);

// Hanging
for (i=[0:1]) {
    translate([-(2.5 + 2*plat_thickness),i*(3*(tweezer_thickness + 2*plat_thickness)+tool_tray_width - 5*plat_thickness),4*plat_thickness]){
        difference(){
            difference(){
                cube([plat_thickness,  plat_thickness*5, 5*plat_thickness]);
                translate([-2.5*plat_thickness+0.5, 2.5*plat_thickness,2.5*plat_thickness])
                rotate([0,90,0])
                cylinder(h = 3*plat_thickness, r = 4.75/2);
            }
            translate([1.2, 2.5*plat_thickness,2.5*plat_thickness])
            rotate([0,90,0])
            cylinder(h = 3*plat_thickness, r = 7/2);
        }
    }
}
