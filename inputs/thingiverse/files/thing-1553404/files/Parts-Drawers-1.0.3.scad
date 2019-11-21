// preview[view:north west, tilt:top diagonal]

/* [Basics] */
// Units in mm that make up the width of the drawers
unit_width = 25; // [10:100]
// Units in mm that make up the height of the drawers
unit_height = 20; // [10:100]
// Depth front-to-back of all drawers in mm
unit_depth = 50; // [20:200]
// Thickness of handle in mm
handle_thickness=5; // [3:30]
// Depth of handle in mm
handle_depth=10; // [10:50]
// Thickness of the walls in mm (drawer walls and gap between drawers)
wall = 2; // [1:10]
// Size of bevel in mmon corners 
bevel = 5; // [0:20]
// Space in mm between components on the bed
print_space = 2;

/* [Drawers] */

// ## Complex example ##
// Unit width of each drawer
widths = [[1, 1, 1, 1], [2, 2], [4]];
// Unit height of each drawer
heights = [[2, 2, 2, 2], [3, 3], [4]];
// Number of dividers in each drawer
dividers = [[1, 0, 0, 1], [2, 3], [1]];
// Number of handles on the front of each drawer
handles = [[1, 1, 1, 1], [2, 2], [2]];

module simple_example() {
    // ## Simple example ##
    // Unit width of each drawer
    widths = [[1, 1], [2]];
    // Unit height of each drawer
    heights = [[1, 1], [1]];
    // Number of dividers in each drawer
    dividers = [[1, 1], [1]];
    // Number of handles on the front of each drawer
    handles = [[1, 1], [2]];
}

module super_simple_example() {
    // ## Super Simple Single Drawer example ##
    // Width in width units of each drawer
    widths = [[3]];
    // Height in height units of each drawer
    heights = [[4]];
    // Number of dividers in each drawer
    dividers = [[1]];
    // Number of handles on the front of each drawer
    handles = [[2]];
}

/* [Global] */
// What part(s) do you want to look at?
part = "both"; // [drawers:Drawers Only,frame:Frame Only,both:Drawers and Frame]

// Include the drawers
drawers = part == "drawers" || part == "both";
// Include the frame
frame = part == "frame" || part == "both";

module go() {
    // Tolerance space between sliding parts
    sliding_tol = 0.3;
    // Separator used to avoid congruent vertices/lines/planes
    sep = 0.001;
    hb = bevel / 2;

    // Flatten a vector of vectors
    function flatten(a) = [for (a = l) for (b = a) b];
    // Sum first n terms, defaults to all terms
    function sum(a, n=-1, i=0, t=0) = i < len(a) && i != n ? sum(a, n, i + 1, t + a[i]) : t;

    module bevel(depth) {
        // Build a subtractive bevel with x-section bevel squared and supplied depth 
        rotate(45) translate([-hb, -hb, -1]) cube([bevel, bevel, depth + 2]);
    }

    module bevel_box(width, height, depth, bevel, bevel_top=true) {
        // Build a box with a bevelled edge
        difference() {
            // Box
            cube([width, height, depth]);
            union() {
                // Bevels
                translate([0, 0, -1]) {
                    bevel(depth + 2);
                };
                translate([width, 0, -1]) {
                    bevel(depth + 2);
                };
                if (bevel_top) {
                    translate([0, height, -1]) {
                        bevel(depth + 2);
                    };
                    translate([width, height, -1]) {
                        bevel(depth + 2);
                    };
                }
            };
        }
    }

    module bevel_divider(drawer_id, divider_id, width, height, depth, bevel) {
        // build a bevel divider for given drawer
        // Depth is the mid point of the divider in the drawer
        // echo("Divider", drawer_id=drawer_id, divider_id=divider_id, width=width, height=height, depth=depth, bevel=bevel);
        translate([0, 0, depth])
        intersection() {
            difference() {
                bevel_box(width, height, unit_depth, bevel, true);
                // Keep from face of drawer
                translate([-sep, -sep, wall + sep])
                    cube([width + 2 * sep, height + 2 * sep, unit_depth]);
            }
            // Remove clashing vertices, edges and planes
            translate([sep, sep, -1]) 
                cube([width - 2 * sep, height - 2 * sep, 2]);
        }
    }

    module handle(drawer_id, handle_id, height, width, depth, thickness=handle_thickness) {
        // Build a handle with given width height and depth
        // Thickness is the handle size in mm
        // echo("Handle", drawer_id=drawer_id, handle_id=handle_id, height=height, width=width, depth=depth);
        
        module handle_shell(h, w, d, b) {
            // Build extruded trapezoid for handle
            difference() {
                cube([w, h, d]);
                translate([-sep, -sep, -d])
                    rotate([45, 0, 0]) 
                        cube([w + 2 * sep, b + 2 * sep, b]);
                translate([-sep, h - sep, -d])
                    rotate([45, 0, 0]) 
                        cube([w + 2 * sep, b + 2 * sep, b]);
            
            }
        }
        
        // Calculate the bevel edge length
        function bev(d, h) = pow(2 * pow(min(d, h/2), 2), 0.5);
        
        // Calculate handle cutout dimensions
        d2 = depth - thickness;
        h2 = height - 2 * thickness;
        // Calculate bevel size for exterior and interior
        b1 = bev(depth, height);
        b2 = bev(d2, h2);
        
        
        difference(){ 
            // Exterior of handle
            handle_shell(height, width, depth, b1);
            // Inner cut out of handle
            translate([-sep, thickness, thickness + sep]) 
                handle_shell(h2, width + 2 * sep, d2, b2);
        }
    }

    module lay() {
        // debug method
        if (true) {
            translate([0, unit_depth, 0])
                rotate([90, 0, 0])
                    children();
        } else {
            children();
        }
    }

    module drawer(id=1, width=1, height=1, handles=1, dividers=1, bevel=bevel, extra=0) {
        // Build a drawer with:
        //  width: mutiple of standard width
        //  height: mutiple of standard height
        //  handles: Given number of handles
        //  dividers: Number of drawer dividers
        //  bevel: Size of corner bevel
        //  extra: Extra value added to all dimensions for tolerances
        
        w = width * unit_width + (width - 1) * wall + extra;
        h = height * unit_height + extra;
        d = unit_depth + extra;
        // echo("Drawer", id=id, w=w, h=h, d=d);
        // echo(bevel=bevel, extra=extra);
        // echo(handles=handles, dividers=dividers);
        lay()
        union() {
            // Add drawer
            if (true) {
                difference() {
                    // Outer box
                    bevel_box(w, h, d, bevel);
                    // Inner space
                    translate([wall, wall, wall]) {
                        bevel_box(
                                w - 2 * wall, 
                                h + 2 * wall, 
                                d - 2 * wall,
                                bevel,
                                false);
                    };
                    hxb = pow(2 * pow(hb, 2), 0.5);
                    translate([-1, h - hxb, wall + sep]) {
                        cube([w + 2, hb + 2, d - 2 * wall - 2 * sep]);
                    }
                }
            }
            // Add dividers
            if (dividers > 0) {
                // echo(dividers=dividers);
                div_offset = d / (dividers + 1);
                for (divider = [0 + 1:dividers]) {
                    // echo(divider=divider);
                    bevel_divider(id, divider, w, h, div_offset * divider - wall / 2, bevel);
                }
            }
            // Add handles
            if (handles > 0) {
                // echo(handles=handles);
                handle_height = h / 1.5;
                handle_offset = w / (handles + 1);
                
                for (handle = [0 + 1:handles]) {
                    // echo(handle=handle);
                    offset_x = handle_offset * handle - handle_thickness / 2;
                    offset_y = (h - handle_height) / 2;
                    translate([offset_x, offset_y, -handle_depth + sep]) {
                        handle(id, handle, handle_height, handle_thickness, handle_depth);
                    }
                }
            }
        }
    }


    module build_drawers(widths, heights, dividers, handles) {
        // echo("===DRAWERS===");
        // Build each of the drawers
        for (row_id=[0:len(widths) - 1]) {
            row_widths = widths[row_id];
            row_heights = heights[row_id];
            row_dividers = dividers[row_id];
            row_handles = handles[row_id];
            
            max_row_width = max(row_widths);
            translate([0, row_id * (unit_depth + handle_depth + print_space), 0]) {
                for (drawer_id=[0:len(row_widths) - 1]) {
                    drawer_widths = row_widths[drawer_id];
                    drawer_heights = row_heights[drawer_id];
                    drawer_divides = row_dividers[drawer_id];
                    drawer_handles = row_handles[drawer_id];

                    // echo(row_id=row_id, drawer_id=drawer_id);
                    // echo(widths=drawer_widths, dividers=drawer_divides, handles=drawer_handles);
                    x_offset = drawer_id * max_row_width * unit_width + drawer_id * (wall + print_space);
                    translate([x_offset, 0, 0]) {
                        drawer(
                            [row_id, drawer_id], 
                            width=drawer_widths, 
                            height=drawer_heights, 
                            handles=drawer_handles, 
                            dividers=drawer_divides,
                            extra=-sliding_tol);
                    }
                }
            }
        }
    }

    module build_frame(widths, heights) {
        // echo("===FRAME===");
        // Max drawer height on a row
        function row_height(n) = max(heights[n]);

        full_drawer_width = max([for (r = widths) sum(r)]);
        full_drawer_height = sum([for (r = heights) max(r)]);
        
        // echo(full_drawer_width=full_drawer_width, full_drawer_height=full_drawer_height);
        rows = len(widths);
        
        frame_width = full_drawer_width * unit_width + (full_drawer_width + 1) * wall;
        frame_height = full_drawer_height * unit_height + (rows + 1) * wall;
        frame_depth = unit_depth + wall;
        // echo(frame_width=frame_width);
        // echo(frame_height=frame_height);
        // echo(frame_depth=frame_depth);
        
        // Allow for the previously printed drawers
        offset_y = drawers ? rows * (unit_depth + handle_depth + print_space) : 0;
        translate([0, offset_y, 0]) {
            difference() {
                // Frame outline
                bevel_box(frame_width, frame_height, frame_depth);
                // All drawers
                union() {
                    for (row_id=[0:len(widths) - 1]) {
                        row_widths = widths[row_id];
                        row_heights = heights[row_id];
                        total_drawer_heights = row_id == 0 ? 0 : sum([for (x=[0:row_id - 1]) row_height(x) * unit_height]);
                        // echo(total_drawer_heights=total_drawer_heights);
                        row_offset = (row_id + 1) * wall + total_drawer_heights;
                        // echo(row_id=row_id, row_offset=row_offset);
                        translate([0, row_offset, wall]) {
                            for (drawer_id=[0:len(row_widths) - 1]) {
                                drawer_widths = row_widths[drawer_id];
                                drawer_heights = row_heights[drawer_id];
                                
                                previous_drawers = sum(row_widths, drawer_id);
                                col_offset = wall + previous_drawers*(unit_width + wall);
                                translate([col_offset, 0, 0]) {
                                    //echo(drawer_id=drawer_id, col_offset=col_offset);
                                    //echo(previous_drawers=previous_drawers);
                                    dw = drawer_widths * unit_width + (drawer_widths - 1) * wall;
                                    dh = drawer_heights * unit_height;
                                    bevel_box(dw, dh, unit_depth + 10);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Build and layout the drawers
    if (drawers)
        build_drawers(widths, heights, dividers, handles);
    
    // Build and layout the frame
    if (frame)
        build_frame(widths, heights);
}

go();

