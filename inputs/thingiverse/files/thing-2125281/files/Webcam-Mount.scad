/*
This is a mount for the Logitech C270 webcam to attach to the two poles on a car headrest.  May work for other Logitech webcams with similar attachment.
These headrest poles fit a 2016 Subaru Outback.
*/

//Diameter of headrest pole
HeadrestPoleDiameter=10;
//Diameter of the mount (how thick the mount is)
HeadrestPoleMountDiameter=20;
//Height of the mount
HeadrestPoleMountHeight=12;
//Distance between the headrest poles
HeadrestPoleSeparationDistance=84.7;
//Offset of where the webcam mount is located
WebcamAttachmentOffset=40;
PegHeaderHeight=2;

module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}

difference(){
    cylinder(h=HeadrestPoleMountHeight, d=HeadrestPoleMountDiameter, center=true);
    cylinder(h=HeadrestPoleMountHeight, d=HeadrestPoleDiameter, center=true);
    translate([0,1,-HeadrestPoleMountHeight/2]) { rotate([0,0,-135]) { cube([HeadrestPoleMountDiameter,HeadrestPoleMountDiameter,HeadrestPoleMountHeight]); } }
}

translate([0,HeadrestPoleDiameter/2,-HeadrestPoleMountHeight/2]) {
    cube([HeadrestPoleSeparationDistance+HeadrestPoleDiameter, (HeadrestPoleMountDiameter-HeadrestPoleDiameter)/2, HeadrestPoleMountHeight]);
}

translate([HeadrestPoleSeparationDistance+HeadrestPoleDiameter,0,0]) {
    difference(){
        cylinder(h=HeadrestPoleMountHeight, d=HeadrestPoleMountDiameter, center=true);
        cylinder(h=HeadrestPoleMountHeight, d=HeadrestPoleDiameter, center=true);
        translate([0,1,-HeadrestPoleMountHeight/2]) { rotate([0,0,-135]) { cube([HeadrestPoleMountDiameter,HeadrestPoleMountDiameter,HeadrestPoleMountHeight]); } }
    }
}

translate([WebcamAttachmentOffset,HeadrestPoleMountDiameter/2,-(HeadrestPoleMountHeight-6.8)/2]){
    difference(){
        union(){
            cube([12.3,10,6.8]);
            rotate([0,90,0]) {
                translate([-6.8/2,10,12.3/2]) {
                    cylinder(h=12.3, d=6.8, $fn=10, center=true);
                    }
            }
        }
        rotate([0,90,0]) {
            translate([-6.8/2,10,12.3/2]) {
                //cylinder(h=12.3, d=3, , center=true);
                cylinder(h=12.3, r=3.4/2*1/cos(180/10), $fn=10, center=true);
            }
        }
    }
}

translate([WebcamAttachmentOffset+20.3,HeadrestPoleMountDiameter/2,-(HeadrestPoleMountHeight-6.8)/2]){
    difference(){
        union(){
            cube([12.3,10,6.8]);
            rotate([0,90,0]) {
                translate([-6.8/2,10,12.3/2]) {
                    cylinder(h=12.3, d=6.8, $fn=10, center=true);
                }
            }
        }
        rotate([0,90,0]) {
            translate([-6.8/2,10,12.3/2]) {
                cylinder(h=12.3, r=3.4/2*1/cos(180/10), $fn=10, center=true);
            }
        }
        rotate([0,90,0]) {
            translate([-6.8/2,10,12.3/2]) {
                scale([1,1.4,1]) {
                    cylinder(h=12.3, r=3.4/2*1/cos(180/10), $fn=10, center=true);
                }
            }
        }
        rotate([0,90,0]) {
            translate([-6.8/2,10,12.3-(PegHeaderHeight/2)]) {
                cylinder(h=PegHeaderHeight, r=1.4*3.4/2*1/cos(180/10), $fn=10, center=true);
            }
        }
    }
}


echo(version=version());
// Written by xoque (mwifall@gmail.com)
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
