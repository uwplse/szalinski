radius=15;
sides=10;
corne_radius=8;
thickness=2;
body_height=30;
body_twist=-45;
body_scale=1.3;
solid="no";




////////////////////////////////////
// RENDERS


// base
//linear_extrude(height=base_height)
/*linear_extrude(height=thickness, twist=body_twist/body_height*thickness, scale=body_scale/body_height*thickness, slices=2*thickness)
polyShape();
*/


// body
//translate([0,0,base_height])
linear_extrude(height=body_height, twist=body_twist, scale=body_scale, slices=2*body_height)
    polyShape(solid);


// rim
/*translate([0,0,body_height-thickness])
linear_extrude(height=thickness, twist=body_twist, scale=1+body_scale*thickness/body_height, slices=2*thickness)
rotate(-body_twist+body_twist*(1-thickness/body_height))
scale(body_scale)
polyShape();*/

/*translate([0,0,body_height])
linear_extrude(height=thickness)
rotate(-body_twist)
scale(body_scale)
polyShape();
*/

////////////////////////////////////
// MODULES
module polyShape(solid) {
    difference (){
        // outside shape
        offset (r=corne_radius,$fn=16)
        circle(r=radius, $fn=sides);
        // inside shape
        if (solid=="no") {    
            offset (r=corne_radius-thickness,$fn=16)
            circle(r=radius, $fn=sides);
        }
    }
}

