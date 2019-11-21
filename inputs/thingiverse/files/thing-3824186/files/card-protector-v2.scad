/* [Card Protection] */

// Tolerance
tol = 0.2;

// Card width
card_width = 54;

// Card height
card_height = 85.5;

// Card thickness
card_thickness = 0.7;

// Hole width
hole_width = 10;

// Hole height
hole_height = 3;

// Thickness
t = 1.2;

// Model
mode = "demo"; // [demo, top, bottom]

module to_hide() {
}

/* [Hidden] */ 

card_dim = [card_width, card_height, card_thickness] + [for (i=[0:2]) tol*2];
mount_dim = [hole_width, hole_height];
round_dia = card_dim[2]+t*2;

$fa = 0.1;
$fs = 0.1;

module half_cylinder(d, h) {
    rotate_extrude(angle = 180)
        square([d / 2, h]);
}

module top_profile() {
    translate([-round_dia/2,round_dia/2])
    hull() {
        circle(d = round_dia);
        translate([card_dim[0] + round_dia,0])
            circle(d = round_dia);
    }
}

function shape_layer(y_offset = 0, xz_offset = 0, off = 0) = [
    [-xz_offset - off,y_offset, -off],
    [card_dim[0] + xz_offset+off,y_offset, -off],
    [card_dim[0] + xz_offset+off,y_offset,card_dim[1] + xz_offset + off],
    [-xz_offset - off,y_offset,card_dim[1] + xz_offset + off]
];

module main_shape(inset = 0) {
    polyhedron(concat(
        shape_layer(0), 
        shape_layer(t), 
        shape_layer(card_dim[2] + t),
        shape_layer(card_dim[2] + t, round_dia/2)
    ), [
        [0,1,2,3], 
        [4,7,6,5], 
    
        [4,8,11,7], 
        [7,11,10,6], 
        [6,10,9,5], 
    
        [8,12,15,11], 
        [11,15,14,10], 
        [10,14,13,9], 
    
        [1,13,14,2], 
        [2,14,15,3], 
        [3,15,12,0], 
    
        [0,12,8,4,5,9,13,1]
    ]);
}

module cut_shape() {
    polyhedron(concat(
        shape_layer(-tol, 0, tol), 
        shape_layer(card_dim[2] + t + tol, round_dia/2, off = tol)
    ), [
        [0,1,2,3], 
        [4,7,6,5], 

        [0,4,5,1],
        [0,3,7,4],
        [2,6,7,3],
        [1,5,6,2]
    ]);
}

module half_circle(d) {
    difference() {
        circle(d = d);
        translate([-d/2-tol, -d/2-tol])
        square([d / 2 + tol, d + tol * 2]);
    }
}

module half_sphere(d, a = 180) {
    rotate_extrude(angle = a)
        half_circle(d);
}

module round_shape() {
    translate([0,-round_dia/2])
    half_circle(d = round_dia);
    
    translate([0,-round_dia/2])
    square([round_dia/2, card_dim[0] + round_dia]);
    
    translate([0,card_dim[0] + round_dia/2])
    half_circle(d = round_dia);
}

module lock_spheres() {
    translate([-tol*2,t,round_dia])
    rotate([0,0,120])
    half_sphere(d = round_dia - t);

    translate([card_dim[0] + tol*2,t,round_dia])
    rotate([0,0,210])
    half_sphere(d = round_dia - t);
}

module bottom() {
    color("#10aa10") {
    
        main_shape();
    
        translate([0,round_dia/2,0])
        rotate([-90,0,-90])
            rotate_extrude(angle = 180)
                round_shape();  
        
        translate([card_dim[0] / 4, tol, card_dim[1] / 4])
        half_sphere(t * 2 + card_dim[2] / 2);
        
        translate([card_dim[0] * 3 / 4, tol, card_dim[1] * 3 / 4])
        half_sphere(t * 2 + card_dim[2] / 2);
    
        lock_spheres();
        
    }
}

module top_base() {
    difference() {
        
        render()
        difference() {
            linear_extrude(card_dim[1]+round_dia/2+t*2+mount_dim[1])
                top_profile();
            translate([0,0,-tol])
                cut_shape();
        }

        lock_spheres();
        
        translate([card_dim[0]/2 - mount_dim[0]/2,round_dia+tol,card_dim[1]+round_dia/2+t+mount_dim[1]/2])
        rotate([90,0,0])
        linear_extrude(round_dia + tol*2)
        hull() {
            circle(d = mount_dim[1]);
            translate([mount_dim[0], 0])
                circle(d = mount_dim[1]);
        }       
    }

}

module top() {
    color("#20dd20", 0.7) {
        if ($preview) {
            render() 
                top_base();
        } else {
            top_base();
        }
                    
        translate([0,round_dia/2,card_dim[1]+round_dia/2+mount_dim[1]+t*2])
        rotate([90,0,90])
        rotate_extrude(angle = 180)
            round_shape(); 
        
        translate([card_dim[0] * 3 / 4, round_dia, card_dim[1] / 4])
            rotate([0,0,180])
            half_sphere(t * 2 + card_dim[2] / 2);
    
        translate([card_dim[0] / 4, round_dia, card_dim[1] * 3 / 4])
            rotate([0,0,180])
            half_sphere(t * 2 + card_dim[2] / 2);
        
    }
}

if (mode == "demo") {
    rotate([90,0,0]) {
        translate([0,0,tol + card_dim[1]/2])
            top();
        bottom();
    }
    
    color("white")
    translate([tol,-card_dim[1],t + tol])
    linear_extrude(card_thickness)
    offset(5)
    offset(-5)
    square([card_width, card_height]);
    
} else if (mode == "top") {
    rotate([-90,0,0])
        top();    
} else if (mode == "bottom") {
    rotate([90,0,0])
        bottom();    
}

