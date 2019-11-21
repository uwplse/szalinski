/* [ Global ] */

// Width will be rounded down to fit the space the triangles on the surface take.  (in mm)
width = 24; //  [10:1:200]
// Height  (or length, not thickness)  (in mm)
height = 18;//  [10:1:200]
// Thickness of pad base (in mm)
bottom_thickness = 1; //[0.1:0.1:5]

/* [ Advanced ] */

// Width of flat top surface, intended to be extrusion width of the nozzle, but you can set it to large values if you want a bigger cut-off flat top. (in mm)
extrude_width = 0.4;//  [0.1:0.1:20]
// Height of individual triangle (in mm)
tri_height = 4;//  [1:1:20]
// width of triangle base, extrude width will be added to this (in mm)
tri_width = 2.1;//  [1:1:20]

/* [ Hidden ] */

tri_w = tri_width + extrude_width;

x = floor(width /tri_w) * tri_w;
y = height;
z = bottom_thickness;



tri_points = [
    [0,0,0],
    [tri_w,0,0],
    [(tri_w - extrude_width)/ 2 ,0, tri_height],
    [((tri_w - extrude_width)/ 2) +extrude_width,0 ,tri_height],
    [0,y,0],
    [tri_w,y,0],
    [(tri_w - extrude_width)/ 2 ,y, tri_height],
    [((tri_w - extrude_width)/ 2) +extrude_width,y ,tri_height]
];
tri_faces = [
    [0,2,3,1],
    [0,4,6,2],
    [4,5,7,6],
    [2,6,7,3],
    [3,7,5,1],
    [0,1,5,4]
];
echo(x, "x", y);
union(){
    for (a = [0:tri_w:x - tri_w]){
        union(){
            translate([a,0,z])polyhedron( tri_points, tri_faces );
            translate([a,0,0])cube([tri_w, y, z]);
        };
    };
}