// [mm] disameter of the tube 
tube_diameter=8;    
// round plattform(0) or rectangle(1) 
plattform_type=1;    
// [mm] distance plattform to tube 
plattform_distance=7; 
//[mm] size of the plattform 
plattform_size=27; 
$fn=50;

module torus( ra, di )
{
    rotate_extrude(convexity = 10)
        translate([ra, 0, 0])
            circle(d = di);
}




difference()
{
    hull()
    {
        cylinder( d=tube_diameter, h=plattform_size );
        if( plattform_type == 0 )
            translate([plattform_distance,0,plattform_size/2]) rotate( [0,90,0] ) cylinder( d=plattform_size, h=1 );
        else
            translate([plattform_distance,0,plattform_size/2]) rotate( [0,90,0] ) cube( [plattform_size,plattform_size,1], center=true );
    }
    translate([0,0,-.1]) cylinder( d=tube_diameter+0.1, h=plattform_size+0.2 );
    translate([-plattform_distance/2,0,plattform_size/2]) cube( [5,plattform_size,plattform_size], center=true );
    
    if( plattform_type == 0 ){
        translate([0,0,0]) cube( [plattform_size,plattform_size,5], center=true );
        translate([0,0,plattform_size]) cube( [plattform_size,plattform_size,5], center=true );
    }
    
    translate([0,0,plattform_size/3]) torus( plattform_distance, 3 );
    translate([0,0,2*plattform_size/3]) torus( plattform_distance, 3 );
}

