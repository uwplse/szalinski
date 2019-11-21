

/* [Options] */

//add cavidy for nut?
nut_hole = 1; //[0:no,1:yes]
//add cutaway?
cutaway = 0; //[0:no,1:yes]
//screw head counter bore size.  0 for no counterbore
screw_head_counterbore = 7.5;
//make body oval
oval_body = 0; //[0:no,1:yes]

/* [Shape] */

// smooth corner radius
Corner_radius = 3;
// 
Overall_width = 25;
// 
Overall_height = 25*1.5;
// overall depth
depth = 50;

/* [Hidden] */

tap_hole_632 = 2.95;

rad = Corner_radius;
wid = Overall_width;
height = Overall_height;

//make right side up for printing
translate([0,0,depth])
rotate([0,180,0])
difference(){
    //body
    if (oval_body){
        union() {
            translate ([0,0,depth/2 ])
            resize([wid,height,depth])
            hull(){
                for( zz = [depth/2-rad,-(depth/2-rad)] ){
                    translate([0,0,zz])
                    torus(wid,rad,$fn=50); 
                } 
            }
        }
    } else {
        hull(){
            translate([0,height/2-wid/2,+rad])
            torus(wid,rad,$fn=50);
            translate([0,-(height/2-wid/2),+rad])
            torus(wid,rad,$fn=50);            
            translate([0,height/2-wid/2,+depth-rad])
            torus(wid,rad,$fn=50);
            translate([0,-(height/2-wid/2),+depth-rad])
            torus(wid,rad,$fn=50);
            
        }
    }
    
    
    // lock core hole
    core(d=16.5,oah=27,w=6,depth = 33);


    //cutaway viewing hole
    if (cutaway){
        translate([0,0,-0.1])
        cube([30,27/2-4,24.1]);
    }

    //set screw hole, 6-32
    translate([0,27/4,10])
    rotate([0,-90,0])
    union(){
        cylinder(d=tap_hole_632,h=30,$fn=20);
        //counterbore
        translate([0,0,wid/2-4.4])
        cylinder(d=screw_head_counterbore,h=10,$fn=20);
        if(nut_hole){
            //hexagon, d=9.2 makes a nice interference fit
            cylinder(d=9.4,h=6,$fn=6); 
            cylinder(d=tap_hole_632+1,h=30,$fn=20);
        }
    }
}


module torus(od,r){
    rotate_extrude(angle=360){
        translate([od/2-r,0,0])
        circle(r=r);
    }
}

module core(d,oah,w,depth){
    translate([0,d/2-oah/2,0])
    cylinder(d=d,h=depth);
    
    //add another 2mm of clearance at the back to allow to spin freely
    translate([0,d/2-oah/2,-2])
    cylinder(d=d,h=depth);
    translate([-w/2,0,0])
    cube([w,oah/2,depth-7]);
    
}