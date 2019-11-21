// 20150520 (c) Ewald Beekman
// this is the design for a clip to hold the lid of a pan on the inside of cupboard doors
// the design is parametric so it can be easily adjusted to any lid (or whatever you want to do with it)
//
// the design is made of three pieces, a base cube, a "piece of pie" and and a beam
// and two cylinders which make up for the recessed hole where the screw goes.
//
// the three pieces are in different colours so you can see what happens if you change the parameters

// the arc library is now included in this code so we can use customizer in Thingiverse
// use <arc.scad>
// arc.scad contains to functions:
// 2D_arc(w=thickness_of_arc, r=radius_of_arc, deg=degrees_of_arc_angle, fn=resolution);
// 3D_arc(w=thickness_of_arc, r=radius_of_arc, deg=degrees_of_arc_angle, fn=resolution, h=height_of_arc);

$fn=5*10;   // by using a multiply here, it won't show up in customizer

// size of the base, this is the base yellow brick
base_size=13;   //[3:30]

// the height of the yellow base brick
base_height=10; //[0:100]

// what diameter mounting screws are you going to use
mounting_hole=4;    //[2:10]

// what's the diameter of the screw head
screw_head=8;   //[2:16]

// how much length for the screw to grab om before it reaches the cupboard
keep=8; // [2:20]

//length of the part which angles away from the base
beam_length=30; //[0:100]

// thickness of the angled part is the same as the base size
beam_thickness=base_size;

// what's the angle you want, 0 means a square angle
angle=40;   //[0:90]

module beam() {
color("Green")
    translate([-base_size/2,base_size/2,base_height/2]) 
        rotate([angle,0,0]) 
            cube(size=[base_size,beam_length,beam_thickness]);
}
module pie() {
color("Red")
    translate([-(base_size/2),base_size/2,base_height/2])
        rotate([135,0,0])
            rotate([0,90,0])  //have to use 2x rotate because we need first y (this one), and then x
                3D_arc(w=base_size*2,r=0,deg=90,fn=50,h=base_size);
}

module brick() {
color("Yellow")
    cube(size=[base_size,base_size,base_height],center=true);   // this is our base block
}
    
// "drill" the two holes in the base cube
difference() {
//union(){         // for debug, if you uncomment this, and comment out "difference", cube and pie, you can see the cylinders
    union() {
       brick();
       pie();
       beam();
       }
       
// the is the hole for the screw      
    cylinder(h=base_size*2, r=mounting_hole/2, center=true);
 
// and this the one for the screw head       
// keep has to be subtracted with half base_height because the cube is positioned with center=true, so it floats on the x/y plane
    translate([0,0,keep - (base_height/2)])     
        cylinder(h=base_size*2, r=screw_head/2 );
}

/*
Plot a 2D or 3D arc from 0.1 to ~358 degrees.

Set Width of drawn arc, Radius, Thickness, resolution ($fn) and height for the 3D arc. Arc is centered around the origin

By tony@think3dprint3d.com
GPLv3

*/

module 2D_arc(w, r, deg=90,fn = 100 ) {
        render() {
                difference() {
                        // outer circle
                        circle(r=r+w/2,center=true,$fn=fn);
                        // outer circle
                        circle(r=r-w/2,center=true,$fn=fn);

                //remove the areas not covered by the arc
                translate([sin(90-deg/2)*((r+w/2)*2),
                                                -sin(deg/2)*((r+w/2)*2)])
                        rotate([0,0,90-deg/2])
                                translate([((r+w/2))-sin(90-(deg)/4)*((r+w/2)),
                                                        ((r+w/2))*2-sin(90-(deg)/4)*((r+w/2))])
                                        square([sin(90-deg/4)*((r+w/2)*2),
                                                                sin(90-deg/4)*((r+w/2)*2)],center=true);
                translate([-sin(90-(deg)/2)*((r+w/2)*2),
                                                -sin(deg/2)*((r+w/2)*2)])
                        rotate([0,0,-(90-deg/2)])
                          translate([-((r+w/2))+sin(90-(deg)/4)*((r+w/2)),
                                                        ((r+w/2))*2-sin(90-(deg)/4)*((r+w/2))])
                                        square([sin(90-deg/4)*((r+w/2)*2),
                                                                sin(90-deg/4)*((r+w/2)*2)],center=true);
                }
                //line to see the arc
                //#translate([-((r)*2)/2, sin((180-deg)/2)*(r)]) square([(r+w/2)*2+1,0.01]);
        }
}

module 3D_arc(w, r, deg, h,fn) {
        linear_extrude(h)
                        2D_arc(w, r, deg,fn);

}