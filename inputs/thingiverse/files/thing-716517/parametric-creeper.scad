
//Pixel size in millimeters
pixel_size = 2;

//Head rotation in degrees
head_angle = 270;

// For use for mold making with thing http://www.thingiverse.com/thing:31581
mold_making = true;

// Extra overlap betwen body and legs (eg for creating a mold)
extra_body_overlap=1;

real_head_angle = (mold_making == true) ? head_angle + 0.01 : head_angle;

scale(pixel_size)
{
    //make it on its side
    translate([0,0,8]) rotate([0,90,0])
    {
        union()
        {
            legs(extra_body_overlap);
            body();
            head(real_head_angle);
        }
    }
}

module legs(extra_body_overlap) {
    cube([8,4,6 + extra_body_overlap + 1]);
    translate([0,8,0]) cube([8,4,6 + extra_body_overlap + 1]);
}

module body() {
    translate([0,4,6]) cube([8,4,10]);
}

module head(rotation) {
    //head
//translate([0,2,16]) cube(8);
//eyes + mouth
translate([4, 6, 20])
    rotate([0, 0, rotation]) {
        translate([-4, -6, -20]) {
            difference()
            {
                translate([0,2,16]) {
                    // head
                    cube(8);
                    }
                union()
                {
                    //mouth
                    translate([2,2,16 - 0.1]) cube([1,0.5,3 + 0.1]);
                    translate([2,2,17]) cube(1);
                    translate([5,2,16 - 0.1]) cube([1,0.5,3 + 0.1]);
                    translate([5,2,17]) cube(1);
                    translate([3,2,17]) cube([2,0.5,3]);
                    translate([3,2,17]) cube([2,1,2]);
                    //left eye
                    translate([1 - 0.1,2,20]) cube([2,1,2]);
                    translate([1 - 0.1,2,20]) cube([1,2,2]);
                    translate([2 - 0.1,2,21]) cube([1,2,1]);
                    //right eye
                    translate([5 + 0.1,2,20]) cube([2,1,2]);
                    translate([6 + 0.1,2,20]) cube([1,2,2]);
                    translate([5 + 0.1,2,21]) cube([1,2,1]);
                }
            }
        }
    }
}