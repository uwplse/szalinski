// render nicely
$fn= 20;
//////////////////////////////////////////
// parameters
//////////////////////////////////////////
// length without triangular stops
total_x = 20.5;
// x-length of solid square part
x = 12.48;  
// total y
y = 12;     
// total z
z = 12.1; 

/**
 * Base plate
 */
// the base plate x-thickness
xbase = 2;
ybase = y + 2;
base_end = x/2 + xbase; 

/**
 * Stopper
 */
// triangular stopper thickness 
xstop = 2.5;
// triangular stopper height
zstop = 3;
// triangular stopper width
ystop = 5;

/**
 * round outer shell
 */
// total part X length = 20.5mm
rbase = total_x - xbase - x;
// door sliding pole diameter
dpole = 9.1;
rpole = dpole/2;
dxpole =  y/2;

/**
 * Screw
 */
// screw hole diameter
d_screw = 6.5;
// thread depth
thread_depth = 0.5;

rscrew = (d_screw - thread_depth)/2 ; 

hscrew = x + xbase; // screw hole length

//////////////////////////////////////////
// renderers
//////////////////////////////////////////
main();

//////////////////////////////////////////
// modules
//////////////////////////////////////////
/**
 * triangular prism
 * credits: 
 * https://www.youtube.com/watch?v=R1d_WNjafCo
 */
module triangular_prism(b, d, h, ht, sc){
    color("teal"){
        linear_extrude(height = ht, twist = 0, scale = sc){
            polygon(points = [[0, 0], [b, 0], [d, h]]);
        }
    }
}
/**
 * stoppers
 */
module stop(_x, _y, _z, dx, dir, angle){
    translate([dx, -dir * ybase/2, -dir * z/2]){
        rotate(a = 90, v = [1, 0, 0]){
            rotate(a = angle, v = [0, 1, 0]){
                triangular_prism(_x, 0, _y, _z, 1);
            }
        }
    }
}
/**
 * main block
 */
module block(){
    // main part
    cube([x, y, z], center = true);
    // outer pole shell
    translate([-dxpole,0,-z/2]) {
        cylinder(h = z, r = rbase, center = false); 
    }
    // base plate
    color("teal"){
        translate([x/2,-ybase/2,-z/2]){
            cube ([xbase, ybase, z]);
        }
    }
    stop(zstop, ystop, xstop, base_end, 1, 90);
    stop(zstop, -ystop, xstop, base_end + xstop, -1, -90);

}
/**
 * pole hole
 */
module pole_hole(){
    translate([-dxpole,0,-z/2]) {
            cylinder(h = z, r = rpole, center = false); 
    }
}
/**
 * screw hole
 */
module screw_hole(){
    translate([base_end, 0, 0]) {
        rotate(a = 90, v = [0, -1, 0]){
            cylinder(h = hscrew, r = rscrew, center = false); 
        }
    }
}
/**
 * main method
 */
module main(){
    difference(){
        difference(){
            //        
            block();
            pole_hole();       
        }
        // screw
        screw_hole();
    }
}

