//////////////////////////////////
// Parametric Escutcheon
// 2017-12-11
// Ryan Stachurski
//////////////////////////////////


// Radius of the lower part of the escutcheon flange
bottom_radius           = 15;
// Radius of the upper part of the escutcheon flange
top_radius              = 5.5;
// Total height of the escutcheon
height                  = 6;
// Radius of the hole
hole_radius             = 2.5;
// Height of the lower part of the escutcheon flange as a percent of the total height [0..1]
bottom_height_percent   = 0.15;
// Height of the location of the upper part of the escutcheon flange as a percent of the total height [0..1]
top_height_percent      = 0.5;
// Decorative outside curve radius
curve_radius            = 1;

/* [Hidden] */
$fn=200;
bs = bottom_radius - curve_radius;
ts = top_radius - curve_radius;
hs = height - curve_radius;


rotate_extrude($fn=200) {

    difference (){
        offset(r=curve_radius) polygon( points=[[0,0],[bs,0],[bs,hs*bottom_height_percent],[ts,hs*top_height_percent],[ts,hs],[0,hs]] );
        
        //cut out side slop and for hole
        polygon( points=[[hole_radius,-curve_radius],[-curve_radius,-curve_radius],[-curve_radius,height],[hole_radius,height] ] );
        
        //cut out bottom slop
        polygon( points=[[0,0],[0,-curve_radius],[bottom_radius,-curve_radius],[bottom_radius,0] ]);
    }    

}