// (mm)
inner_width = 50.8;
// (mm)
inner_length = 50.8;
// (mm)
height = 10;
// (mm)
floor_thickness = 0.4;
// (mm)
wall_thickness = 1;

difference(){
    cube([inner_length+(2*wall_thickness),inner_width+(2*wall_thickness),height]);
    translate([wall_thickness,wall_thickness,floor_thickness]) cube([inner_length,inner_width,height]);
}