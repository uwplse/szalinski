// OpenSCAD 3D surface plotter, z(x,y)
// Dan Newman, dan newman @ mtbaldy us
// 8 April 2011
// 10 June 2012 (revised)
//
// For 2D plots, please see polymaker's OpenSCAD 2D graphing
// program, http://www.thingiverse.com/thing:11243.

// --- BEGIN EXAMPLES ---


type="bumpsAndDips";//[washBoard, squareRipples, bumpsAndDips]

thing(type);
module thing(type){
if (type=="squareRipples"){
// Square ripples in a pond

3dplot([-4*pi,4*pi],[-4*pi,4*pi],[50,50],-2.5);
}else if(type=="washBoard"){
// A wash board

3dplot([-4*pi,4*pi],[-4*pi-20,4*pi-20],[50,50],-1.1);
}else if(type=="bumpsAndDips"){
// Uniform bumps and dips

3dplot([-2*pi,2*pi],[-2*pi,2*pi],[50,50],-6);
}

}
// --- END EXAMPLES --

// --- Useful code begins here

pi = 3.14159265358979;
e = 2.71828182845904;

// OpenSCAD trig functions use degrees rather than radians
function rad2deg(a) = a * 180 / pi;

// For the cube vertices
//
//   cube_vertices = [ [0,0,0], [1,0,0], [0,0,1], [1,0,1],
//                     [0,1,0], [1,1,0], [0,1,1], [1,1,1] ];
//
// The two upright prisms which the cube can be divided into are
//
//   prism_faces_1 = [[3,2,7],[5,0,1], [0,2,1],[2,3,1], [1,3,5],[3,7,5], [7,2,5],[2,0,5]];
//   prism_faces_2 = [[6,7,2],[4,0,5], [7,6,4],[4,5,7], [6,2,0],[0,4,6], [2,7,5],[5,0,2]];
//
// If you need help visualizing them, you can draw them,
//
//   polyhedron(points=cube_vertices, triangles=prism_faces_1);
//   polyhedron(points=cube_vertices, triangles=prism_faces_2);
//
// However, since we want to evaluate z(x,y) at each vertex of a prism
// AND each prism doesn't need all the cube vertices, we can save a few
// calculations by having two sets of vertices,
//
//   prism_vertices_1 = [ [0,0,0], [1,0,0], [0,0,1], [1,0,1], [1,1,0], [1,1,1] ];
//   prism_faces_1    = [ [3,2,5],[4,0,1], [0,2,1],[2,3,1], [1,3,4],[3,5,4], [5,2,4],[2,0,4] ];
//   prism_vertices_2 = [ [0,0,0], [0,0,1], [0,1,0], [1,1,0], [0,1,1], [1,1,1] ];
//   prism_faces_2    = [[4,5,1],[2,0,3], [5,4,2],[2,3,5], [4,1,0],[0,2,4], [1,5,3],[3,0,1]];
//
//   polyhedron(points=prism_vertices_1, triangles=prism_faces_1);
//   polyhedron(points=prism_vertices_2, triangles=prism_faces_2);

// Our NxM grid is NxM cubes, each cube split into 2 upright prisms
prism_faces_1 = [ [3,2,5],[4,0,1], [0,2,1],[2,3,1], [1,3,4],[3,5,4], [5,2,4],[2,0,4] ];
prism_faces_2 = [[4,5,1],[2,0,3], [5,4,2],[2,3,5], [4,1,0],[0,2,4], [1,5,3],[3,0,1]];

// 3dplot -- the 3d surface generator
//
// x_range -- 2-tuple [x_min, x_max], the minimum and maximum x values
// y_range -- 2-tuple [y_min, y_max], the minimum and maximum y values
//    grid -- 2-tuple [grid_x, grid_y] indicating the number of grid cells
//              along the x and y axes
//   z_min -- Minimum expected z-value; used to bound the underside of the surface
//    dims -- 2-tuple [x_length, y_length], the physical dimensions in millimeters

module 3dplot(x_range=[-10, +10], y_range=[-10,10], grid=[50,50], z_min=-5, dims=[80,80])
{
    dx = ( x_range[1] - x_range[0] ) / grid[0];
    dy = ( y_range[1] - y_range[0] ) / grid[1];

    // The translation moves the object so that its center is at (x,y)=(0,0)
    // and the underside rests on the plane z=0

    scale([dims[0]/(max(x_range[1],x_range[0])-min(x_range[0],x_range[1])),
           dims[1]/(max(y_range[1],y_range[0])-min(y_range[0],y_range[1])),1])
    translate([-(x_range[0]+x_range[1])/2, -(y_range[0]+y_range[1])/2, -z_min])
    union()
    {
        for ( x = [x_range[0] : dx  : x_range[1]] )
        {
            for ( y = [y_range[0] : dy : y_range[1]] )
            {
                
if (type=="washBoard"){polyhedron(points=[[x,y,z_min], [x+dx,y,z_min], [x,y,cos(rad2deg(abs(x)+abs(y)))], [x+dx,y,cos(rad2deg(abs(x+dx)+abs(y)))],
                                   [x+dx,y+dy,z_min], [x+dx,y+dy,cos(rad2deg(abs(x+dx)+abs(y+dy)))]],
                           triangles=prism_faces_1);
                polyhedron(points=[[x,y,z_min], [x,y,cos(rad2deg(abs(x)+abs(y)))], [x,y+dy,z_min], [x+dx,y+dy,z_min],
                                   [x,y+dy,cos(rad2deg(abs(x)+abs(y+dy)))], [x+dx,y+dy,cos(rad2deg(abs(x+dx)+abs(y+dy)))]],
                           triangles=prism_faces_2);
}
else if (type=="squareRipples"){
polyhedron(points=[[x,y,z_min], [x+dx,y,z_min], [x,y,2*cos(rad2deg(abs(x)+abs(y)))], [x+dx,y,2*cos(rad2deg(abs(x+dx)+abs(y)))],
                                   [x+dx,y+dy,z_min], [x+dx,y+dy,2*cos(rad2deg(abs(x+dx)+abs(y+dy)))]],
                           triangles=prism_faces_1);
                polyhedron(points=[[x,y,z_min], [x,y,2*cos(rad2deg(abs(x)+abs(y)))], [x,y+dy,z_min], [x+dx,y+dy,z_min],
                                   [x,y+dy,2*cos(rad2deg(abs(x)+abs(y+dy)))], [x+dx,y+dy,2*cos(rad2deg(abs(x+dx)+abs(y+dy)))]],
                           triangles=prism_faces_2);
}

else if (type=="bumpsAndDips"){
polyhedron(points=[[x,y,z_min], [x+dx,y,z_min], [x,y,5*cos(rad2deg(x)) * sin(rad2deg(y))], [x+dx,y,5*cos(rad2deg(x+dx)) * sin(rad2deg(y))],
                                   [x+dx,y+dy,z_min], [x+dx,y+dy,5*cos(rad2deg(x+dx)) * sin(rad2deg(y+dy))]],
                           triangles=prism_faces_1);
                polyhedron(points=[[x,y,z_min], [x,y,5*cos(rad2deg(x)) * sin(rad2deg(y))], [x,y+dy,z_min], [x+dx,y+dy,z_min],
                                   [x,y+dy,5*cos(rad2deg(x)) * sin(rad2deg(y+dy))], [x+dx,y+dy,5*cos(rad2deg(x+dx)) * sin(rad2deg(y+dy))]],
                           triangles=prism_faces_2);
}


            }
        }
    }
}

