// Robert Niemöller [Robert2611]
// www.thingiverse.com/thing:1404809

/* [General] */

//Thickness of the ground plate
ground_plate_thickness  = 5;     //[1:20]
//Outer diameter at bottom
basediameter            = 50;    //[20:100]
//relative to the basediameter
wall_thickness          = 4;     //[1:10]
height                  = 100;   //[5:200]
polygon_edges           = 5;    //[3:1:20]

/* [Edvanced] */

//Stepsize in height for generating elements
delta_h                 = 1;     //[1:1:10]
//Radius for rounding the main polygon
polygon_rounding_radius = 3;     //[1:20]
//Total twist
twist                   = 1000;   //[0:1000]


//function for modulating the diameter
function func(z) = ( 0.25 * sin( z / height * 360 ) + 1 ) * basediameter;

$fn = 20;


difference(){
    union(){
        for( z = [ 0:delta_h:height ] ){
            d1 = func( z ); //this elements diameter
            d2 = func( z + delta_h ); //next elements diameter
            dt = twist / ( height / delta_h ); //only twist each part a fraction of the total twist
            difference(){
                //rotate so the orientation fits the twist of the element before
                rotate( [0, 0, -twist * z / height] ) 
                //move it to the right z position
                translate( [0, 0, z-0.01] )
                //extrude it with the partial twist and scale to fit the next elements size
                linear_extrude( height = delta_h+0.02, scale = d2 / d1, twist = dt, slices = 2) 
                rounded_regular_polygon( d = d1, r = polygon_rounding_radius, n = polygon_edges );
            }
        }
    }
    union(){
        for( z = [ ground_plate_thickness:delta_h:height+delta_h ] ){
            //calculate the inner circle of the polygon
            //so the wall_tickness applies correctly for all values of polygon_edges
            d1i = func( z ) * cos( 180 / polygon_edges );
            d2i = func( z + delta_h ) * cos( 180 / polygon_edges );
            translate( [0, 0, z-0.01] )
            //linear_extrude( height = delta_h+0.2, scale = (d2i - 2*wall_thickness) / (d1i - 2*wall_thickness))
            //circle( d = d1i - 2*wall_thickness );
            cylinder(d1 = d1i - 2*wall_thickness, d2 = d2i - 2*wall_thickness, h=delta_h+0.02);
        }
    }
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
