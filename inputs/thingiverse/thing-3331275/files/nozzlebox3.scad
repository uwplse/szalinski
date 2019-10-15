// Lid thickness
thickness = 1.92; 

// Tolerance
tolerance = 0.2; 

// Spacing between nozzles
spacing = [8, 8]; 

// Box fillet radius
fillet = 3; 

// E3D nozzle height
e3d_height = 7.5;

// Volcano nozzle height
volcano_height = 16.5;

// Nozzle diameter
nozzle_dia = 6;

// Lid height (distance from box plane to lid)
nozzle_roof = 10;

// Count of nozzle grid columns
nozzle_cols = 5;

// Array of E3D labels
e3d_names = ["0.1", "0.2", ".25", "0.3", "0.5", "0.4", "0.4", "0.4", "0.4", "0.4", "0.4", "0.4", "0.4", "0.4", "0.4", "0.5", "0.6", "0.8",  "0.8", "1.0"];

// Array of Volcano labels
volcano_names = ["0.4", "0.6", "0.8", "1.0", "1.2", "0.4", "0.6", "0.8", "1.0", "1.2", "0.4", "0.6", "0.8", "1.0", "1.2", "0.4", "0.6", "0.8", "1.0", "1.2"];

// Part
mode = "j"; // [all:All,box:Box,lid_volcano:Volcano Lid,lid_e3d:E3D Lid,lock:Lock handle,label:Labels]

module label(t, va = "bottom") {
    text(t, size = 5, halign = "center", font = "Cantarell:style=Bold", valign = va, $fn = 64);    
}

// E3D Labels
nozzle_rows = max(len(e3d_names) / nozzle_cols, len(volcano_names) / nozzle_cols);

e3d_labels = [ for (i = [0:nozzle_rows-1]) [ for (j = [0:nozzle_cols-1]) e3d_names[i * nozzle_cols + j] ] ];

// Volcano Labels
volcano_labels = [ for (i = [0:nozzle_rows-1]) [ for (j = [0:nozzle_cols-1]) volcano_names[i * nozzle_cols + j] ] ];

e3d_grid = [len(e3d_labels[0]), len(e3d_labels)];
volcano_grid = [len(volcano_labels[0]), len(volcano_labels)];
cell_dim = [nozzle_dia+spacing[0], nozzle_dia+spacing[1]];


function nozzle_grid_dim(grid, height, dia, spacing) = [
    grid[0] * (dia + spacing[0]),
    grid[1] * (dia + spacing[1]),
    height
];

// 8.5, 5.5
module nozzle_grid(grid, height, dia, spacing) {    
    for (j = [0:grid[0] - 1], i = [0:grid[1] - 1])
        translate([j * cell_dim[0] + cell_dim[0]/2, i * cell_dim[1] + cell_dim[1]/2, 0])
            cylinder(d = dia, h = height, $fn = 32);
}


e3d_dim = nozzle_grid_dim(e3d_grid, e3d_height, nozzle_dia, spacing);
volcano_dim = nozzle_grid_dim(volcano_grid, volcano_height, nozzle_dia, spacing);

cube_dim = [max(e3d_dim[0], volcano_dim[0]), max(e3d_dim[1], volcano_dim[1]), e3d_dim[2] + thickness + volcano_dim[2]];
lock_length = cube_dim[0]/2 - thickness;

module box_shape(off = 0) {
    offset(fillet + off)
        square([cube_dim[0], cube_dim[1]]);    
}

module box_belt() {
    hull($fn = 64) {

        translate([0,0,thickness + tolerance])
        linear_extrude(thickness * 4)
            box_shape(thickness);
        linear_extrude(thickness * 6 + tolerance * 2)
            box_shape(-tolerance);
    }
}

module box() {
    
    module lock_guide() {
        translate([0,-fillet-thickness-tolerance,cube_dim[2]/2])
        rotate([90,0,90]) {
            
            linear_extrude(lock_length*2+tolerance*2)
                lock_guide_shape();
            
            translate([0,0,lock_length*2 + tolerance])
            linear_extrude(thickness)
                lock_guide_shape_close();
        }
    }
    
    
    difference() {
        
        union() {
        
            linear_extrude(cube_dim[2] / 2 - thickness * 3 + tolerance, $fn = 64)
                box_shape(-tolerance);
        
            translate([0, 0, cube_dim[2] / 2 - thickness * 3 - tolerance])
            box_belt();
            
            translate([0,0,cube_dim[2] / 2 + thickness * 3 - tolerance])
            linear_extrude(cube_dim[2] / 2 - thickness * 3 + tolerance, $fn = 64)
                box_shape(-tolerance);
            
            lock_guide();
            
            translate([cube_dim[0], cube_dim[1], 0])
            rotate([0,0,180])
                lock_guide();
            
        }
        
        translate([0,volcano_dim[1],volcano_dim[2] - tolerance])
            rotate([180,0,0])
                nozzle_grid(volcano_grid, volcano_height, nozzle_dia, spacing);

        translate([0,0,volcano_dim[2] + thickness + tolerance])
            nozzle_grid(e3d_grid, e3d_height, nozzle_dia, spacing);
    }
    
}

module lock_tri() {
    //translate([/*cube_dim[0] - lock_length*2 - thickness*2*/0,-fillet-tolerance-thickness,0])
    render()
    rotate([90,0,90]) {
        
        //translate([0,0,thickness])
        
        translate([0,0,-tolerance])
        linear_extrude(lock_length + tolerance*2)
            lock_tri_shape();
        
        translate([0,0,thickness*2])
        sphere(r = thickness, $fn = 64);
        
    }
}


module lid_base() {
    h = nozzle_roof + cube_dim[2]/2 - thickness*2;
    
    module lid_wall() {
        render()
        difference() {
            linear_extrude(h, $fn = 64)
            difference() {
                box_shape(thickness);
                box_shape();
            }
            
            translate([0,0,-thickness*5])
            box_belt();
        }
    }
    
    module lock_tri_aligned() {
        translate([0,-fillet-thickness,-thickness*2])
            lock_tri();
    }
        
    translate([0,0,-thickness]) {
        linear_extrude(thickness, $fn = 64)
            box_shape(thickness);
        
        translate([0,0,-h])
            lid_wall();
            
        lock_tri_aligned();
        
        translate([cube_dim[0], cube_dim[1],0])
        rotate([0,0,180])
            lock_tri_aligned();

    }
}


module lid_e3d() {
    difference() {
        lid_base();
        
        translate([cube_dim[0]/2, cube_dim[1]/2,-thickness/2 + tolerance])
        linear_extrude(thickness/2)
        text("E3D", size = 8, halign = "center", valign = "center", font = "Cantarell", $fn = 64);    
    }
}

module lid_volcano() {
    difference() {
        mirror([0,0,1])
            lid_base();

        translate([cube_dim[0]/2, cube_dim[1]/2,thickness/2 - tolerance])
        rotate([180,0,0])
        linear_extrude(thickness/2)
        text("Volcano", size = 8, halign = "center", valign = "center", font = "Cantarell", $fn = 64); 
    }
}

module lock_guide_shape() {
    h = cube_dim[2]/2;
    t = thickness;
    tol = tolerance;
    polygon([
        [tol, t*2],
        //[0,t*2 - tol],
        [-t-tol, t*2],
        [-t-tol, h],
        [-t*2-tol,h],
        [-t*2-tol,-h],
        [-t-tol, -h],
        [-t-tol, -t*2],
        //[0, -t/2-tol],
        [tol, -t*2]
    ]);
}

module lock_guide_shape_close() {
    h = cube_dim[2]/2;
    t = thickness;
    tol = tolerance;
    polygon([
        [tol, t*2],
        //[0,t*2 - tol],
        //[-t-tol*2, t*2 - tol],
        [-t-tol, h],
        [-t*2-tol,h],
        [-t*2-tol,-h],
        [-t-tol, -h],
        //[-t-tol*2, -t*2 + tol],
        //[0, -t/2-tol],
        [tol, -t*2]
    ]);
}

module lock_tri_shape() {
    b = thickness;
    polygon([
        [tolerance,b],
        [0,b],
        [-b,0],
        [0,-b],
        [tolerance,-b]
    ]);
    
}

module lock_tri_close_shape() {
    b = thickness;
    polygon([
        [tolerance,b],
        [0,b],
        [-b,0],
        [-b,-b*1.5+tolerance],
        [tolerance,-b*1.5+tolerance]
    ]);
}


module fillet(r) {
    offset(r)
        offset(-r)
            children();
}


module lock_handle_shape() {
    t = thickness;
    difference() {
        fillet(1, $fn = 64)
        translate([-t*3-tolerance*2, -cube_dim[2]/2-thickness-nozzle_roof]) {
            square([t*3+tolerance*2, cube_dim[2] + nozzle_roof * 2 + thickness*2]);
        }
        
        offset(tolerance, $fn = 32)
            lock_guide_shape();
    }
}

module lock_icon() {
       
    module arrow() {
        l = 4;
        t = 2;
        polygon([[0,0], [l,0], [l,-1], [l*2,t/2], [l,t+1], [l,t], [0,t]]);
    }
    

    module lock(closed = true) {
        translate([closed ? 0 : -3, 0])
        difference() {
        
            translate([1,4]) {
                translate([2,3], $fn = 32)
                    circle(r = 2);
                square([4, 3]);
            }
        
            translate([2,3]) {
                translate([1,4])
                circle(r = 1, $fn = 32);
                square([2, 4]);
            }
        }
        
        square([6,4]);
    }
    
    lock(true);
    
    translate([8,6])
    arrow();
    
    translate([16,2])
    rotate(180)
    arrow();
    
    translate([20,0,0])
    lock(false);

}

module nozzle_label(txt) {
    
    cell_dim = [nozzle_dia + spacing[0], nozzle_dia + spacing[1]];
    
    dim = [cell_dim[0] - tolerance*2, cell_dim[1] - tolerance*2];
    
    translate([tolerance, tolerance,0])
    difference() {
        linear_extrude(thickness)
        difference() {
            fillet(fillet, $fn = 32)
                square(dim);
            translate([dim[0]/2, spacing[1]])
                circle(d = nozzle_dia + tolerance*2, $fn = 32);            
        }
        
        translate([dim[0]/2, tolerance*2, thickness/2 + tolerance])
            linear_extrude(thickness/2)
                label(txt);
        
    }

}

module lock_guide() {
    guide_length = lock_length * 2 + tolerance + thickness;
    translate([cube_dim[0] - guide_length,-fillet-tolerance,cube_dim[2]/2])
    rotate([90,0,90]) {
        linear_extrude(guide_length)
            lock_guide_shape();
        translate([0,0,guide_length - thickness])
            linear_extrude(thickness)
                lock_guide_shape_close();
    }
}


module lock_handle() {
    difference() {
    
        linear_extrude(lock_length)    
            lock_handle_shape();
        
        lock_offset = cube_dim[2]/2 + nozzle_roof - thickness*2;
        
        translate([0,lock_offset,0])
            rotate([90,-90,180])
                lock_tri();
        
        translate([0,-lock_offset,0])
            rotate([90,-90,180])
                lock_tri();
            
    }
}


module lock_handle_aligned() {
    
    translate([cube_dim[0] - thickness*2 - tolerance,-fillet - thickness - tolerance,cube_dim[2]/2])
    rotate([90,0,90])
    lock_handle();
}


module label_grid(grid) {
    for (i = [0:len(grid) - 1], j = [0:len(grid[0])-1]) 
        translate([j * cell_dim[0], ((len(grid)-1) - i) * cell_dim[1] - (spacing[1] - nozzle_dia + tolerance)/2, 0])
            nozzle_label(grid[i][j]);
}

if (mode == "box") {
    box();
} else if (mode == "lock") {
    lock_handle();
} else if (mode == "lid_e3d") {
    
    translate([0,cube_dim[1],0])
    rotate([180,0,0])
    lid_e3d();
    
} else if (mode == "lid_volcano") {
    lid_volcano();
} else if (mode == "label") {
    
    label_grid(concat(e3d_labels, volcano_labels));

} else if (mode == "all") {
    
    
    color("Lavender")
    render()
    translate([-abs($t*2-1) * lock_length,0,0]) {
        lock_handle_aligned();


        translate([cube_dim[0] + lock_length * 2, cube_dim[1],0])
        rotate([0,0,180])
        lock_handle_aligned();
    }
    
    color("LightSlateGray")
    box();
    
    color("Gainsboro")
    translate([0,0,cube_dim[2]])
    label_grid(e3d_labels);
    
    color("Gainsboro")
    translate([0,cube_dim[1],0])
    rotate([180,0,0])
    label_grid(volcano_labels);
    
    color("SpringGreen",0.7)
    translate([0,0,cube_dim[2] + thickness + nozzle_roof])
        lid_e3d();
   
    color("LightSteelBlue",0.7)
    translate([0,0,-thickness - nozzle_roof])
        lid_volcano();
    
}