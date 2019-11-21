/*
Magnetic holder fan (c) by Juanjo CG (2018)

Magnetic holder fan is licensed under a
Creative Commons Attribution 3.0 Unported License.

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/3.0/>.
*/

////////////////////////////////////////////////////////////
//                    PARAMETERS
////////////////////////////////////////////////////////////
{
    fan=true;       // To print the fan part
    motor=false;    // To print the motor part
    dm = 4;         // Diameter of magnet. MAX = 10mm.
    hm = 1.5;       // High of magnet. MAX = 3.5mm
    tow1=false;     // Test tower 1
    tow2=false;     // Test tower 2
}
////////////////////////////////////////////////////////////
//                    DRAW
////////////////////////////////////////////////////////////
module tower1(){
    difference(){
        union(){
            translate ([0, 0, 0]) cube([9,8,16]);
            translate ([0, 4, 16]) rotate ([0, 90, 0]) cylinder(h=9, d=8);
            if (dm>7){
                translate ([0, 3.5-dm/2, 0]) cube([5,dm+1,dm+1]);
            }
        }
        translate ([0, 4, 16]) rotate ([0, 90, 0]) cylinder(h=9, d=4);

        if (dm<=7){
            translate ([5, 0, 0]) cube([4,8,8]);
            translate ([0, 4, 4]) rotate ([0, 90, 0]) cylinder(h=9, d=2.5);
            translate ([5-hm, 4, 4]) rotate ([0, 90, 0]) cylinder(h=6, d=dm+0.2);
        }
        else{
            translate ([5, 0, 0]) cube([4,8,dm+1]);
            translate ([0, 4, dm/2+0.5]) rotate ([0, 90, 0]) cylinder(h=9, d=2.5);
            translate ([5-hm, 4, dm/2+0.5]) rotate ([0, 90, 0]) cylinder(h=6, d=dm+0.2);
        }
    }
}
if(tow1) tower1();
module tower2(){
    translate ([0,0,0])
    rotate ([0,0,0])
    if (dm<=7){
        difference(){
            translate ([0, 0, 0]) cube([4,8,8]);
            translate ([0, 4, 4]) rotate ([0, 90, 0]) cylinder(h=5, d=2.5);
            translate ([0, 4, 4]) rotate ([0, 90, 0]) cylinder(h=hm, d=dm+0.2);
        }
    }
    else {
        difference(){
            translate ([0, 3.5-dm/2, 0]) cube([4,dm+1,dm+1]);
            translate ([0, 4, dm/2+0.5]) rotate ([0, 90, 0]) cylinder(h=5, d=2.5);
            translate ([0, 4, dm/2+0.5]) rotate ([0, 90, 0]) cylinder(h=hm, d=dm+0.2);
        }
    }
}
if(tow2) tower2();
{
$fn=100;
if(fan){
    translate ([0, 4+dm/2+0.5, 0]) cube ([5, 32-(dm+1), 8]);
    translate ([0, 00, 0]) tower1();
    translate ([0, 32, 0]) tower1();
}

if(motor){
    difference(){
        union(){
            translate ([05, 4+dm/2+0.5, 00]) cube([04,32-(dm+1),3]); // |  
            translate ([08, 16, 00]) cube([34,08,3]); // - caña 1
            translate ([35, 16, 00]) cube([13,08,3]); // - caña 2
            translate ([48, 07, 00]) cube([05,26,09]);// | medio
            translate ([48, 07, 00]) cube([17,05,09]);// - inf
            translate ([48, 28, 00]) cube([17,05,09]);// - sup
            translate ([65, 07, 00]) cube([03,26,15]);// | final
            translate ([5, 00, 0]) tower2();
            translate ([5, 32, 0]) tower2();
        }
        translate ([62, 11.5, 00]) cube([03,17,15]);
        translate ([65, 20, 10]) rotate ([0, 90, 0]) cylinder(h=5, d=5);
    }
}
}