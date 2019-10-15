/**** https://www.thingiverse.com/thing:2797727 ****/
/**** author: Svenny                            ****/

/* [Drawer] */
width = 160;
length = 140;
height = 18;
wall_thickness = 0.8;

/* [Cells] */
cells_x = 8; // [1:30]
cells_y = 3; // [1:30]
// see manual!
merged_cells = [];

thickness = wall_thickness;

module organizer_drawer(w, l, h, x_count, y_count, merged=[]) {
    cell_cube = [(w-thickness)/x_count-thickness,
                 (l-thickness)/y_count-thickness,
                 h];
    
    merge_base = [-(w-2*thickness-cell_cube[0])/2,
                 -(l-2*thickness-cell_cube[1])/2,
                 thickness];
    
    difference() {
        union() {
            translate([0,0,(thickness-h)/2])
            cube([w, l, thickness], center=true);
            
            for(x=[-(w-thickness)/2:(w-thickness)/x_count:(w-thickness)/2+1])
                translate([x, 0, 0])
                cube([thickness, l, h], center=true);
            
            for(y=[-(l-thickness)/2:(l-thickness)/y_count:(l-thickness)/2+1])
                translate([0, y, 0])
                cube([w, thickness, h], center=true);
        }
        
        for(m=merged) {
            hull() {
                for(x=[m[0][0], m[1][0]])
                    for(y=[m[0][1], m[1][1]])
                        translate(merge_base 
                            +[x*(cell_cube[0]+thickness), y*(cell_cube[1]+thickness), 0])
                        cube(cell_cube, center=true);
            }
        }
    }
    
    
    // handle
    translate([0, -l/2-3, -h/2+1])
    cube([40, 6, 2], center=true);
}

organizer_drawer(width, length, height, cells_x, cells_y, merged_cells);
