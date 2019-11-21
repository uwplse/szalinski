
// outher length from the corner into the plates' center
length = 50;

// in mm, increases the slot width for your plates
tolerance = 0.6;

// wudth along the edge
width = 30;

// two in case you use different plates for the sides
plate_a_thickness = 5;
plate_b_thickness = 5;

clip_wall = 3;

union() {

    linear_extrude(width) union() {
        // outer side
        x = length;
        y = length;
        w = clip_wall;
        x1 = x - w;
        y1 = y - w;
        polygon([
            [0, 0], [0, x], [x, y],
            [x, y1], [w, y1], [w, 0]
        ]);
        // inner side
        a = w + plate_a_thickness + tolerance;
        b = length - w - plate_b_thickness - tolerance;
        polygon([
            [a, 0], [a, b], [length, b], [ length, b - w],
            [a + w, b - w], [a + w, 0]
        ]);
    
        polygon([
            [0, b - w], [a + w, b - w], [a + w, b], [0, b]
        ]);
        
        k = 3 * w;
        m = length /2 - k/2;
        polygon([
            [a, m], [a, m + k], [m, b], [m + k, b]
        ]); 
    }
    r = 0.5;
    linear_extrude(clip_wall)
        polygon([
            [0, 0], [0, length], [length, length], [length, length * (1-r)], [length * r, 00]
     ]);
 }