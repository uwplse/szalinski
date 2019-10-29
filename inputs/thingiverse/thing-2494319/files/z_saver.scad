

//screw_diameter (mm)
screw_diameter = 4;  //[3,4,5,6]

//screw_diameter_offset (mm)
screw_diameter_offset = 0;  //[-0.1, 0, +0.1]

//length of the support (mm)
length = 35;

/* [Hidden] */

$fn = 50;
angle = 27;
//length of the support (mm)
length = 35;

difference() {  // diff 1
    union(){
        difference(){
            union (){
                cylinder ( d = 8+4, h = length, center = true);
                translate ([0,-10,0]) cylinder ( d = 11, h = length, center = true);
            } // end union

            // drill the clip and open it
            cylinder ( d = 8, h = length, center = true);
            rotate ([0,0,angle]) translate ([0,0,-length/2-5]) cube( [10,10,length+10], center = false);
            rotate ([0,0,-angle])  translate ([-10,0,-length/2-5]) cube( [10,10,length+10], center = false);

            // drill the screw hole
            translate ([0,-10,0])  cylinder ( d = screw_diameter+screw_diameter_offset, h = length, center = true);
        } // end diff

        // add two lips
        union (){rotate ([0,0,angle]) translate ([4+1,0,0]) cylinder (d= 2, h = length,center = true);
        rotate ([0,0,-angle]) translate ([-4-1,0,0]) cylinder (d= 2, h = length,center = true);}
    } // end union


    // make two clips     
   hull () {
        translate ([0,4,(length - 15)/2]) rotate([0,90,0]) cylinder (r= 3, h = 50, center = true);
        translate ([0,4,-(length - 15)/2]) rotate([0,90,0]) cylinder (r= 3, h = 50, center = true);
   }     
} // end diff 1



