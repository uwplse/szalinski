// Begin parameters
//preview[view:south, tilt:top]

// Draw a path here.
normalized_path = [[[0, 1], [-1, -0.866], [1, -0.866]],[[0, 1, 2]]]; //[draw_polygon:2x2]

// Modify this to produce large deviation without overly-convex points in the cam.
scale_factor = 5; //[1:25]

// Diameter of laser pointer at cam surface.
laser_pointer_diameter = 12; //[5:30]

// Parts to display.
part = "all"; //[left:Cam A,right:Cam B,all:Cams and Laser]

/* [Hidden] */
// Used in OpenSCAD to simulate cam rotation
sim_rotate = $t * 360;

// Nominal radius of cams
cam_radius = 30;

// Baseline distance between center of cams
cam_baseline = 43.5;

// Nominal distance between path points
nom_delta = 0.05;

// Cam scale parameters
cam_thickness = 2.5;
recess_depth = 0.5;
a_flange_thickness = 5.5;
b_flange_thickness = 1.5;
flange_diameter = 17.5;
axle_hole_diameter = 9;
alignment_notch_diameter = 12.5;

// Circle smoothness
$fn = 100;

// End parameters
// Begin functions / modules

// Divides path into parts no larger than nom_delta
function interpolate(pt1, pt2) = let (
    dist = norm(pt2 - pt1),
    delta = dist / round(dist / nom_delta),
    incr = (pt2 - pt1) / dist
) [ for (j = [0 : delta : dist]) pt1 + j * incr ];
    
// Flattens a list of lists into a single list
function flatten(l) = [ for (a = l) for (b = a) b ];

// Offsets a list of points by a pair of distances
function offset(l, p) = [ for (i = l) i + p ];

module motion_cam(src_points, position, dir) {
    points = offset(src_points, position);
    
    // Divide cam into angular increments
    angle_increment = dir * 360 / len(points);
    nom_theta = [ for (i = [0 : len(points) - 1]) i * angle_increment ];

    // Calculate angle and radius to each tangent point
    theta = [ for (i = points) atan2(i[1], i[0]) ];
    radii = [ for (i = points) norm(i) - laser_pointer_diameter / 2 ];
    
    // Apply angles as offsets to nominal, then deform cam in polar coordinates
    adj_theta = nom_theta + theta;
    cam_points = [ for (i = [0:len(points) - 1]) 
        [radii[i] * cos(adj_theta[i]), radii[i] * sin(adj_theta[i])]
    ];

    // Extrude cam & features
    difference(){
        linear_extrude(height = cam_thickness) polygon(cam_points);
        
        translate([0, cam_radius / 2, cam_thickness - recess_depth])
            linear_extrude(height = 1.1 * recess_depth) polygon(src_points);
        
        translate([0, 0, cam_thickness])
            cube(size = [cam_radius * 3, 2, 2.2 * recess_depth], center=true);
    }
}

module laser_pointer(src_points) {
    // Create lookup table for simulation
    angle_increment = 360 / len(src_points);
    nom_theta = [ for (i = [0 : len(src_points) - 1]) i * angle_increment ]; 
    lut = [ for (i = [0 : len(nom_theta) - 1]) [nom_theta[i], i] ];
    
    // Get points via lookup table and interpolate position
    rotate_index = lookup(sim_rotate, lut);
    p1 = points[floor(rotate_index)];
    p2 = points[ceil(rotate_index)];
    
    translate(concat(p1 + norm(p2 - p1) * (rotate_index - floor(rotate_index)) * (p2 - p1), 0)) {
        color("gray") cylinder(h = 2.1 * cam_thickness, r = laser_pointer_diameter / 2);
        color("red") cylinder(h = 3 * cam_thickness, r = 1);
    }
}

module alignment_notch(diameter, thickness) {
    translate([0, 0, -0.1 * thickness]) difference() {
        cylinder(h = thickness * 1.1, d = diameter);
        translate([-diameter / 2, 0, 0]) cube([diameter, 2 * diameter, 4 * thickness], center = true);
    }
}

// End functions / modules
// Begin final instantiation

// Ensure path is closed curve
path_points = normalized_path[0];
dwg_path = normalized_path[1][0];
path = (dwg_path[0] != dwg_path[len(dwg_path)-1]) ? concat(dwg_path, dwg_path[0]) : dwg_path;

// Interpolate between points, scale, then offset to nominal location
interpolated_points = [ for (i = [0:len(path)-2]) let (
    pt1 = path_points[path[i]],
    pt2 = path_points[path[i+1]]
    ) interpolate(pt1, pt2) 
];
points = scale_factor * flatten(interpolated_points);

// Nominal location of laser pointer center on undeformed cam
x0 = cam_baseline / 2;
y0 = sqrt(pow(cam_radius + (laser_pointer_diameter / 2), 2) - pow(x0, 2));

// Draw parts
if (part != "right") color("blue")
    rotate([0, 0, -sim_rotate]) {
        difference() {
            union() {
                motion_cam(points, [x0, y0], 1);
                translate([0, 0, cam_thickness]) cylinder(h = a_flange_thickness, d = flange_diameter);
            }
            cylinder(h = 100, d = axle_hole_diameter, center = true);
            alignment_notch(alignment_notch_diameter, cam_thickness / 2);
        }
    }

if (part != "left") color("green") translate([cam_baseline, 0, 1.6 * cam_thickness])
    rotate([0, 0, sim_rotate]) {
        difference() {
            union() {
                motion_cam(points, [x0 - cam_baseline, y0], -1);
                translate([0, 0, cam_thickness]) cylinder(h = b_flange_thickness, d = flange_diameter);
            }
            cylinder(h = 100, d = axle_hole_diameter, center = true);
            alignment_notch(alignment_notch_diameter, cam_thickness / 2);
        }
    }

if (part == "all") translate([x0, y0, 0]) laser_pointer(points);