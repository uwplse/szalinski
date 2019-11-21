lipo_length=106;
lipo_height=18;
lipo_width=35;

wire_size=5;

/* [Hidden] */

cell_dia = 23;
cell_length = 133;

difference() {
    //main body is 2x3 nimh sub C size cells
    rotate([-90,0,0]) hull() {
        translate ([-cell_dia/2,0,0])
            cylinder(d=cell_dia, h=cell_length);
        translate ([cell_dia/2,0,0])
            cylinder(d=cell_dia, h=cell_length);
    }
    
    translate([-lipo_width/2, (cell_length-lipo_length)/2, cell_dia/2-lipo_height])
        cube([lipo_width, lipo_length, lipo_height]);
    
    translate([-lipo_width/2,0,cell_dia/2-lipo_height])
            cube([wire_size,(cell_length-lipo_length)/2,cell_dia]);

    translate([lipo_width/2-wire_size,0,cell_dia/2-lipo_height])
            cube([wire_size,(cell_length-lipo_length)/2,cell_dia]);

}