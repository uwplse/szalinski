// preview[view:south, tilt:top]

/* [Shape] */

cell_shape = 6; // [6:hexagon,4:square,3:triangle]

cell_size = 28; // [5:0.5:50]

cell_border = 1; // [1:0.5:10]

grid_width = 8; // [1:50]

grid_length = 6; // [1:50]

thickness = 2.5; // [1:0.25:10]

/* [Magnets] */

// Adds slots to the face of the plate for inserting magnets
enable_magnets = "yes"; // [yes,no]

magnet_shape = "circle"; // [circle,square]

magnet_diameter = 5; // [1:0.1:20]

magnet_depth = 1; // [1:0.1:10]



{
    function plot(corners,diameter) =
        let(angle = 360/corners/2)
        let(base = [for(a=[angle:360/corners:360+angle]) [sin(a)*diameter/2,cos(a)*diameter/2]])
        let(vert = (max([for(p=base)p[1]])- -min([for(p=base)p[1]]))/2)
        let(horz = (max([for(p=base)p[0]])- -min([for(p=base)p[0]]))/2)
        let(cent = [for(p=base) [p[0]-horz,p[1]-vert]])
        let(scale = diameter/2 / max(max([for(p=cent)p[0]]),max([for(p=cent)p[1]])))
        [for(p=cent) [p[0]*scale,p[1]*scale]];
                
    cell = plot(cell_shape,cell_size);
    cell_face = plot(cell_shape,cell_size-cell_border);
    magnet = plot(magnet_shape=="circle" ? 90 : 4, magnet_diameter);
    depth = max(thickness, enable_magnets ? magnet_depth + 1 : 0);
    width = max([for(p=cell)abs(p[0])])*2;
    length = max([for(p=cell)abs(p[1])])*2;
    cut = min([for(p=cell)abs(p[0])]);
    col_spacing = width/2+cut;
    row_spacing = length;
    col_size = row_spacing*(grid_length-1);
    row_size = col_spacing*(grid_width-1);
    stagger = cell_shape>4;
    
    union() {
        for (row = [0:grid_length-1]) {
            for (col = [0:grid_width-1]) {
                offset = stagger ? (col%2 ? -row_spacing/4 : row_spacing/4) : 0;
                orientation = col%2 ? 0 : 180;
                x = -row_size/2+col*col_spacing;
                y = -col_size/2+row*row_spacing+offset;
                translate([x,y]) {
                    rotate([0,0,orientation]) {
                        difference() {
                            union() {
                                linear_extrude(depth-0.5) {
                                    polygon(cell);
                                }
                                linear_extrude(depth) {
                                    polygon(cell_face);
                                }
                            }
                            if (enable_magnets == "yes") {
                                translate([0,0,depth-magnet_depth]) {
                                    linear_extrude(depth) {
                                        polygon(magnet);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}