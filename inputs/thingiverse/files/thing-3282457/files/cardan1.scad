// CSG.scad - Basic example of CSG usage

lenght = 390;
angle = 0;


union(){
    head_1();
    cyl_1();
    cyl_2();
     head_2();
}



 module head_1(){   rotate([0,90,0]) union() {
        cylinder(h = 60, r = 10,center=true);
        sphere(r = 20);
    }
}

module cyl_1(){
    cylinder(h = (lenght), r = 10, center = false);
}

module cyl_2(){
    translate([0,0,lenght/2])
    cylinder(h = 60, r = 20, center = true);
}



 module head_2(){
     
    translate([00,0,lenght])
     rotate([0,90,angle])
     union() {
        cylinder(h = 60, r = 10,center=true);
        sphere(r = 20);
    }
}

echo(version=version());
// Written by Marius Kintel <marius@kintel.net>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
