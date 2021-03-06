// CSG.scad - Basic example of CSG usage

translate([0,0,0]) {
    difference(){
        intersection() {
            cube(15, center=true);
            sphere(10);
        }
        sphere(9.8);
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
