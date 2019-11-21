// [CZ]  Nahradni uchyt napajecky pro morcata
// [ENG] Replacement handle for guinea pigs


bottle  = 65.0;     // bottle diameter
gap     = -0.5;      // bottle distance from the cage
wire    = 2.0;      //wire diameter from the cage
height  = 15.0;     //height of the handle (gap mesh wire)
wall    = 3.5;      //the width of the wall of the handle
$fn     = 60;       //smoothness of the circle 



// varianta s vertikalni fixaci
module holder_v2()
{
    difference()
    {
        union()
        {
            hull()
            { 
                translate([((bottle/2)+(wall)),((bottle/2)+wall),0]) cylinder(d=(bottle+(2*wall)),h=height);
                translate([0,-(wire+wall),0]) cube([(bottle+(3*wall)+wire),(2*wire+wall),height]);
            }
        }
        union()
        {
            hull()
            { 
                translate([((bottle/2)+wall),((bottle/2)+wall),0]) cylinder(d=bottle,h=height);
                translate([wall,-(wire+wall),0]) cube([bottle,(wire+wall),height]);
            }
            hull()
            {
                translate([0,-(wire/2),(height*0.6)]) rotate([0,90,0]) cylinder(d=wire,h=(bottle+(3*wall)+wire));
                translate([0,-0,-wire]) rotate([0,90,0]) cylinder(d=(wire*2),h=(bottle+(3*wall)+wire));
            }
            hull()
            {
                translate([(bottle+(2*wall)+(wire/2)),-((wire)+wall),0]) cylinder(d=(wire*1.5),h=height);
                translate([(bottle+(2*wall)+(wire/2)),((wire)),0]) cylinder(d=(wire*1.5),h=height);
            }
        }
    }

}


holder_v2();