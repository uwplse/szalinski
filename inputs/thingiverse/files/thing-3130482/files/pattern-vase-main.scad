/* [Size] */
HEIGHT = 140; // [10:300]
RADIUS = 40; // [5:200]
WALL_WIDTH = 0.8; // [0.4:0.05:2]
BOTTOM_HEIGHT = 0.8; // [0.4:0.05:2]
/* [Pattern] */
ROWS = 12; // [1:36]
COLS = 24; // [3:36]
// direction and size of pin
OFFSET = -4.0; // [-10:0.1:10]
/* [Twist] */
TWIST_TYPE = 2; // [1:Linear, 2:Sinus]
TWIST = 60; // [0:360]
TWIST_PERIOD = 0.25; // [0.05:0.05:18]
/* [Shape] */
// Count of bezier curve segments
BEZIER_SEGMENTS = 2; //[1:1 - Used 0-2 points, 2:2 - Used 0-4 points, 3:3 - Used 0-6 points]
// Point 0 X 
X0 = 1.1; // [0.25:0.05:3]
// Point 0 Y 
Y0 = 1.0;// [0.25:0.05:3]
// Point 1 X 
X1 = 1.75;// [0.25:0.05:3]
// Point 1 Y 
Y1 = 1.0;// [0.25:0.05:3]
// Point 2 X 
X2 = 1.5; // [0.25:0.05:3]
// Point 2 Y 
Y2 = 1.2;// [0.25:0.05:3]
// Point 3 X 
X3 = 1.1;// [0.25:0.05:3]
// Point 3 Y 
Y3 = 1.4;// [0.25:0.05:3]
// Point 4 X 
X4 = 1.0;// [0.25:0.05:3]
// Point 4 Y 
Y4 = 1.0;// [0.25:0.05:3]
// Point 5 X 
X5 = 0.9;// [0.25:0.05:3]
// Point 5 Y 
Y5 = 0.7;// [0.25:0.05:3]
// Point 6 X 
X6 = 1.1;// [0.25:0.05:3]
// Point 6 Y 
Y6 = 1.1;// [0.25:0.05:3]





/* [HIDDEN] */
bezier_points_X = [X0, X1, X2, X3, X4, X5, X6];
bezier_points_Y = [Y0, Y1, Y2, Y3, Y4, Y5, Y6];

CELL_H = HEIGHT/ROWS;
CELL_A = 360/COLS;


function bezier(t, p) = 
    let (
        l = 1/BEZIER_SEGMENTS,
        s = (t <= l) ? 0 : ((t <= 2*l) ? 1 : 2),
        x = (t - s*l)/l
    )
    (1-x)*(1-x)*p[s*2] + 2*x*(1-x)*p[s*2+1] + x*x*p[s*2+2];

pattern_points = [
        [0,0,0], [0, 1.01, 0], [1.01, 1.01, 0], [1.01, 0, 0], [0.5, 0.5, 1.01],
        [0,0,WALL_WIDTH/OFFSET], [0, 1.01, WALL_WIDTH/OFFSET], [1.01, 1.01, WALL_WIDTH/OFFSET], [1.01, 0, WALL_WIDTH/OFFSET], [0.5, 0.5, 1+WALL_WIDTH/OFFSET]
    ];
pattern_faces = [
        [0, 1, 4], [1, 2, 4], [2, 3, 4], [3, 0, 4],
        [6, 5, 9], [7, 6, 9], [8, 7, 9], [5, 8, 9],
        [1, 0, 6], [2, 1, 7], [3, 2, 8], [0, 3, 5],
        [0, 5, 6], [1, 6, 7], [2, 7, 8], [3, 8, 5]
    ];
bottom_points = [for (i=[0:COLS-1]) 
        let (
            a = i*CELL_A, 
            x = RADIUS*cos(a)*bezier_points_X[0],
            y = RADIUS*sin(a)*bezier_points_Y[0]
        ) 
        [x, y]
    ];

function surface_transform_points(r, c, points) = 
    [for (p=points) 
        let(
            z = (r + p[1])*CELL_H,
            a = (c + p[0])*CELL_A - TWIST*(TWIST_TYPE == 1 ? (z/HEIGHT) : sin(360*TWIST_PERIOD*z/HEIGHT)),
            x = RADIUS*cos(a)*bezier(z/HEIGHT, bezier_points_X) + OFFSET*p[2]*cos(a),
            y = RADIUS*sin(a)*bezier(z/HEIGHT, bezier_points_Y) + OFFSET*p[2]*sin(a)
        ) [x, y, z]
    ];

function surface() = [for (r=[0:ROWS-1], c=[0:COLS-1]) 
    surface_transform_points(r, c, pattern_points)];
    
module draw_surface(){
    union(){
        for (s=surface()) 
            polyhedron(points=s, faces = pattern_faces);
        linear_extrude(height = BOTTOM_HEIGHT, center=false) polygon(points=bottom_points);
    }
}

draw_surface();

