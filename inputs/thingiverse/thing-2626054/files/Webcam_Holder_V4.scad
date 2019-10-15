//Set the wiggle room around things to cope with non-exact prints
wiggle=0.25;

//moving webcam down by 15mm measured from screw
heigt_from_screw=15;

/* [Hidden] */
//----------------------------------------------------------------------------

$fn=20;

thick=9.8-1.5*wiggle;
rotation_free=0.5;
wide=10.7-2*rotation_free;
holedia=4+2*wiggle;
length=wide+1;
height=heigt_from_screw;

wc_screw=5+2*wiggle;
wc_hole=4+wiggle;
wc_wall=1.5+wiggle;

difference()
{
    union()
        {
            cylinder(d=wide,h=thick);
            
            translate([-wide/2,0,0])
                cube([wide,height,thick]);
            
            *hull()
            {
                translate([-wide/2,0,0])
                    cube([wide,0.1,thick]);
                translate([0,height,wide/2])
                    rotate([90,0,0])
                        cylinder(d=wide,h=.5);
            }
        }
        
    translate([0,0,-wiggle])
        cylinder(d=holedia,h=thick+2*wiggle);
        
    //mounting screw hole
    translate([0,-wide/2-wc_wall,thick/2])
        rotate([-90,0,0])
            cylinder(d=wc_screw,h=wide/2+height);
        
    translate([0,-wide/2+1,thick/2])
        rotate([-90,0,0])
            cylinder(d=wc_hole,h=wide/2+height);        
}
