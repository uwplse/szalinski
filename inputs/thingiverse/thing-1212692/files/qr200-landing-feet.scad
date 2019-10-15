/*
Quadrysteria QR200 landing feet  (c) by Jorge Monteiro

Quadrysteria QR200 landing feet is licensed under a
Creative Commons Attribution-ShareAlike 4.0 International.

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.
*/
/* [Basics] */
// Set 0 to use M2.5 screw and nuts or 1 to use M3 screw and nuts
useM3nut=0;//[0:1]

/* [Ignore] */
$fn=40*1;
m25nut=5*1;
m25nuth=2*1;
m25screw=2.5*1;
m3nut=5.5*1;
m3nuth=2.4*1;
m3screw=3*1;
gap=0.5*1;

if (useM3nut==1) {
    echo("M3");
    screw=m3screw+gap;
    nut=m3nut+gap*3;
    nutHeight=m3nuth+gap*1.5;
    drawFoot(screw, nut, nutHeight);

} else {
    screw=m25screw+gap;
    nut=m25nut+gap*3;
    nutHeight=m25nuth+gap*1.5;
    
    drawFoot(screw, nut, nutHeight);
}

module drawFoot(screw, nut, nutHeight) {
    difference() {
        translate([0,0,-5])
        difference() {
            union(){
                cylinder(10, 5, 5);
                sphere(r=5);
            }
            cylinder(10, screw/2, screw/2);
        }
        // draw the nut hole
        cylinder(nutHeight, nut/2, nut/2, $fn=6);
        // and the openning to insert the nut
        translate([-nut/2,0,0]) cube([nut,nut,nutHeight]);
        
    }
};
