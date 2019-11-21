// Pointed OpenSCAD Vase
// Originally designed by Robert Niemöller [Robert2611]
// Modified by Michael Jones [DechAmim]
// Remixed from www.thingiverse.com/thing:1404809

/* [General] */

//Thickness of the ground plate
ground_plate_thickness  = 5;     //[1:20]
//Outer diameter at the bottom
basediameter            = 50;    //[20:100]
//Relative to the basediameter
wall_thickness          = 4;     //[1:10]
//Total height (in mm)
height                  = 100;   //[5:200]
star_points             = 8;     //[5:1:12]
//The indentation of the star (i.e. its "pointy-ness") 
indent                  = 0.8;   //[0.6:0.05:1.0]


/* [Advanced] */
//Render with a hollow center (like the original) or as a solid (for printing in vase mode)?
solid                   = 1;     //[0:Hollow,1:Solid]
//Stepsize in height for generating elements
delta_h                 = 1;     //[1:1:10]
//Ratio of the indent at the neck
pinch                   = 0.4;     //[0.2:0.05:0.5]
//Total twist across the entire height
twist                   = 100;   //[0:300]



function dia_mod(z) = ( pinch * sin( z / height * 360 ) + 1 ) * basediameter;
function scaler(a,b,i) = a[i] * b[i] / b[i-1];
function polar_to_cart(r,a) = [r*cos(a),r*sin(a)];
function star_coords(n,r_in,r_out) = [for(i=[0:2*n-1]) [i % 2 > 0 ? r_in : r_out,360/(n*2)*i]];

$fn = 20;


difference(){
    union(){
        for( z = [ 0:delta_h:height ] ){
            d1 = dia_mod( z ); //this elements diameter
            d2 = dia_mod( z + delta_h ); //next elements diameter
            dt = twist / ( height / delta_h ); //only twist each part a fraction of the total twist
            difference(){
                //rotate so the orientation fits the twist of the element before
                rotate( [0, 0, -twist * z / height] ) 
                //move it to the right z position
                translate( [0, 0, z-0.01] )
                //extrude it with the partial twist and scale to fit the next elements size
                linear_extrude( height = delta_h+0.02, scale = d2 / d1, twist = dt, slices = 2) 
                //rounded_regular_polygon( d = d1, r = polygon_rounding_radius, n = polygon_edges );
                star(star_points,d1);
            }
        }
    }
    if (solid == 0)
    union(){
        for( z = [ ground_plate_thickness:delta_h:height+delta_h ] ){
            // Uses the diameter of the inner points of the star, which equals the outer diameter * indent 
            d1i = dia_mod( z ) * indent;
            d2i = dia_mod( z + delta_h ) * indent;
            translate( [0, 0, z-0.01] )
            cylinder(d1 = d1i - 2*wall_thickness, d2 = d2i - 2*wall_thickness, h=delta_h+0.02);
        }
    }
}

module star(p, dia) {
    //Define the points in polar coordinates
    polar_points = star_coords(p,dia/2*indent,dia/2);
    //Convert the polar coordinates into cartesian coordinates
    poly_points = [for(i=polar_points) polar_to_cart(i[0],i[1])];
    polygon(poly_points);
}

module rounded_regular_polygon( d = 10, r = 2, n = 5 ){
    if( r == 0){
        circle(d = d - 2 * r, $fn = n); //creates a regular polygon
    }else{
        minkowski(){
            circle(d = d - 2 * r, $fn = n);
            circle(r = r);
        }
    }
}

