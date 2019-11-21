/*
 * Cubemail Fabric
 * Idea by Devin Montes, @MakeAnything
 * https://www.myminifactory.com/object/cubemail-bowl-49476
 * Video: https://www.youtube.com/watch?v=ge-q6iXDAoc
 * Implementation in OpenSCAD by Marcel Bieberbach, @ThreeLittlePrintz
 * https://threelittleprintz.de
 *
 */

/*[Cubemail Settings]*/
//in mm between chain links in x- and y-direction; bigger gaps make the fabric more flexible
horizontal_gap = 0.7; //[0.2:0.05:2.0]
//in mm gap between chain and inverted chain in z-direction
vertical_gap = 0.4; //[0.1:0.05:2.0]
//in mm of a chain link bridge, 1/4 of chain link size without gaps; thicker chains make the fabric more durable
width = 1.2; //[0.5:0.1:4.0]
//in mm of a chain link bridge
height =  0.8; //[0.2:0.1:4.0]

//- number of adjacent chain links in x-direction
num_elements_x = 6; //[1:50]
//- number of adjacent chain links in y-direction
num_elements_y = 8; //[1:50]

// the following values comes close to Devin Montes' design file dimensions
//horizontal_gap = 0.8;
//vertical_gap = 0.5;
//width = 1.5;
//height =  1;

length = 4*width + 3*horizontal_gap;

chain_offset = 2*width + 2*horizontal_gap;
module_offset = 4*width + 4*horizontal_gap;

slength = 3*width + 2*horizontal_gap;
soffset = width + horizontal_gap;

// bridge module generates a single chain link bridge with skewed ends
module bridge(l) {
    polyhedron(
        points=[[height, 0, 0], [l - height, 0, 0], [l - height, width, 0], [height, width, 0], [0, 0, height], [l, 0, height], [l, width, height], [0, width, height]],
        faces=[[0, 1, 2, 3], [4, 7, 6, 5], [0, 3, 7, 4], [1, 5, 6, 2], [0, 4, 5, 1], [3, 2, 6, 7]]
    );
}

// block module generates a single chain link
module block() {
    bridge(length);
    translate([0, length - width, 0]) bridge(length);
    
    translate([0, 0, height]) cube([width, width, vertical_gap]);
    translate([0, length - width, height]) cube([width, width, vertical_gap]);
    translate([length - width, 0, height]) cube([width, width, vertical_gap]);
    translate([length - width, length - width, height]) cube([width, width, vertical_gap]);
    
    translate([0, 0, 2*height + vertical_gap]) rotate([180, 0, 90]) bridge(length);
    translate([length - width, 0, 2*height + vertical_gap]) rotate([180, 0, 90]) bridge(length);
}
// smaller block for first and last element in x-direction
module small_x_block() {
    bridge(slength);
    translate([0, length - width, 0]) bridge(slength);
    
    translate([0, 0, height]) cube([width, width, vertical_gap]);
    translate([0, length - width, height]) cube([width, width, vertical_gap]);
    translate([slength - width, 0, height]) cube([width, width, vertical_gap]);
    translate([slength - width, length - width, height]) cube([width, width, vertical_gap]);
    
    translate([0, 0, 2*height + vertical_gap]) rotate([180, 0, 90]) bridge(length);
    translate([slength - width, 0, 2*height + vertical_gap]) rotate([180, 0, 90]) bridge(length);
}
// smaller block for first and last element in y-direction
module small_y_block() {
    bridge(length);
    translate([0, slength - width, 0]) bridge(length);
    
    translate([0, 0, height]) cube([width, width, vertical_gap]);
    translate([0, slength - width, height]) cube([width, width, vertical_gap]);
    translate([length - width, 0, height]) cube([width, width, vertical_gap]);
    translate([length - width, slength - width, height]) cube([width, width, vertical_gap]);
    
    translate([0, 0, 2*height + vertical_gap]) rotate([180, 0, 90]) bridge(slength);
    translate([length - width, 0, 2*height + vertical_gap]) rotate([180, 0, 90]) bridge(slength);
}
// row of chains including the shifted previous row
module row(count, first) {
    translate([soffset, 0, 0]) small_x_block();
    translate([count*module_offset, 0, 0]) small_x_block();
    for (i = [1 : count - 1]) {
        translate([i*module_offset, 0, 0]) block();
    }
    if (!first) {
        for (i = [0 : count - 1]) {
            translate([i*module_offset + chain_offset, -chain_offset, 0]) block();
        }
    } else {
        for (i = [0 : count - 1]) {
            translate([i*module_offset + chain_offset, -soffset, 0]) small_y_block();
        }
    }
}
// row of smaller first chain elements
module srow(count, start) {
    for (i = [start : count - 1]) {
        translate([i*module_offset, 0, 0]) small_y_block();
    }
}

module fabric(x, y) {
    translate([0, 0, 0]) row(x, true);
    for (i = [1 : y - 1]) {
        translate([0, i*module_offset, 0]) row(x, false);
    }
    translate([chain_offset, (y-1)*module_offset + chain_offset, 0]) srow(x, 0);
}

fabric(num_elements_x, num_elements_y);