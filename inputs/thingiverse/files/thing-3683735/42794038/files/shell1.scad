/*
 * Customize-able Nuatilus Shell
 * Originally desinged by Robert Marchese (bobm123)
 * https://www.thingiverse.com/thing:3370200
 * Modified by Wayne Wilcox (wrw60543)
 * version v1.1
 *
 * Changelog
 * --------------
 * v1.1 - 2019-xx-xx:
 *  - fixed arguments warnings with rotate()
 *  - added descriptions to parameters shown in the Customizer GUI
 *  - added parameter to pull the shell in the Z axis
 *  - added parameter to control angle used to add rings to the shell
 *  - added parameters to orient shell in XYZ axis
 *
 * v1.0 - 2019-06-10:
 *  - new features:
 *    * Added parameters compatible with Thingiverse Customizer
 *    * parameter to change the shape of the ring
 *          cylinder (original design)
 *          polygon
 *          sphere (work in progress)
 *    * parameter to control the number of rings used
 *    * 2 parameters create elliptical rings
 *    * parameter control number of sides a polygon has
 *    * parameter to control whether or not to spin the polygon rings
 *    * parameter to set the angle that each polygon ring spins relative to the pervious ring 
 *  
 * --------------
 */

// Parameter Section //
//-------------------//


/* [Global Parameters]*/
//Select shape used to create rings
ring_shape="cylinder"; //[cylinder:Cylinder, polygon:Polygon, sphere:Sphere]

//Number of rings used in the shell
number_rings = 40; //[1:1:100]

//X axis scale multiplier of the first ring (other than 1 creates an eliptical shape)
scale_xstart = 1.5; //[0.1: 0.1: 3]

//X axis scale multiplier of the last ring (other than 1 creates an eliptical shape)
scale_xend   = .7; //[0.1: 0.1: 3]

//Stretch the shell in the Z axis
Zpull_shell  = 0; //[0:1:50]

//Multiplier to control the angle used to add rings to the shell
ring_madd = 1; //[.1:.1:2]

/* [Polygon Ring Parameters] */
//Number of sides used to create the polygon
number_sides = 10; //[3:1:20]

//Angle in degrees used to spin ring relative to each other (0 = no spin)
spin_angle = 5;    //[0: .2: 20]

/* [Shell Orientation Parameters] */
//X axis Angle
Xorient_angle = 90; //[0:10:360]

//Y axis Angle
Yorient_angle = 0; //[0:10:360]

//Z axis Angle
Zorient_angle = 180; //[0:10:360]

// Start of code //
//---------------//
/* [Hidden] */
$fn=30+0; // number of fragments

xinc = (scale_xend-scale_xstart)/number_rings;
rotate([Xorient_angle, Yorient_angle, Zorient_angle]) scale(.06) for (i = [0:1:number_rings-1]) {
    size=60+(i*10);   // calculate new size and angle
    
    // calculate scaling factor x axis in ring
    scale_x=scale_xstart + (xinc*i);
    // create a ring, rotate by angle in x and z axis
    rotate([0, size*ring_madd, 0]) translate([size, i*Zpull_shell, 0])
      ring(size, size, scale_x, spin_angle*i);
}


module ring(size, angle, scale_x, spin_angle) {
    if (ring_shape == "cylinder") {
        scale([1, scale_x]) difference() {
            cylinder(h=60, r1=size, r2=size-15);
            translate([0,0,-.1]) cylinder(h=60.2, r1=(size-50), r2=size-60);
            }
    } else if(ring_shape == "polygon") {
        d=size*2;
        rotate(spin_angle)
          scale([1, scale_x]) difference() {
              mypoly(number_sides,d,60);
              mypoly(number_sides,d*.9,60.2);
              }

    } else if(ring_shape == "sphere") {
        scale([1, scale_x]) difference() {
            sphere(r=size);
            scale([.5,.5,1.1]) 
            translate([-(size/3),0,size/3]) sphere(r=size*1.8);
        }
    }
}

module mypoly(sides, size, height){
    rot_angle=360/sides;

    hull() {
        for(i=[0:sides]){
            rotate([0,0,rot_angle*i])
            translate([size/2,0,-(height/2)])
            //cylinder(d=0.1,h=height);
            cube([0.01,0.01,height],true);
       }
    }
}
