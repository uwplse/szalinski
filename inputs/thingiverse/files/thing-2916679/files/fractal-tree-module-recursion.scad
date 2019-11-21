
//number of brenches
levels = 5; 
// length of the first segment in mm
segment_length = 40; 
// thickness of the first segment
thickness = 4; 
// extrusion heigh of the whole tree, if 0 you see a flat tree in color
height = 4;
// max and min angle of the branches
min_angle = 20;
max_angle = 50;
// random trees or repeatable result
random_trees = true;
// a number used as seed for random number generation
random_number = 7;//[-100000,100000]

// Settings END //
identity = [ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];

rcnt = 1000;
random = (random_trees==true) ? rands(0, 1, rcnt) : rands(0, 1, rcnt, random_number);

function rnd(s, e, r) = random[r % rcnt] * (e - s) + s;

// generate 4x4 translation matrix
function mt(x, y) = [ [ 1, 0, 0, x ], [ 0, 1, 0, y ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];

// generate 4x4 rotation matrix around Z axis
function mr(a) = [ [ cos(a), -sin(a), 0, 0 ], [ sin(a), cos(a), 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];

module tree(length, thickness, count, m = identity, r = 1) {
    color([0, 1 - (0.8 / levels * count), 0])
        multmatrix(m)
            translate ([-thickness/2,0,0]) square([thickness, length]);

    if (count > 0) {
        tree(rnd(0.6, 0.8, r) * length, 0.8 * thickness, count - 1, m * mt(0, length-0.8*thickness/2) * mr(rnd(min_angle, max_angle, r + 1)), 8 * r);
        tree(rnd(0.6, 0.8, r) * length, 0.8 * thickness, count - 1, m * mt(0, length-0.8*thickness/2) * mr(-rnd(min_angle, max_angle, r + 3)), 8 * r + 4);
    }
}

if(height == 0)
    tree(segment_length, thickness, levels);
else
    linear_extrude(height = height)
        tree(segment_length, thickness, levels);

