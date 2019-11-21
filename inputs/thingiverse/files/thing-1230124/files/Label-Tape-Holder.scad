// label tape holder
// by ido roseman, 2015

// variable description
number_of_tapes = 5; // [1:10]
wall_width = 4; // [3:5]

//cartridge size
cx = +88;
cy = +16.5;
cz = +68;



module Cartridge ()
{
    difference()
    {
        cube([cx,cy,cz]);
        translate([0, cy, 0])
          rotate([90, 0, 0]) 
            linear_extrude(height=cy)
              polygon([[0,0],[0,8],[30,0]]);
    }
}


difference()
{
    cube([cx+2*wall_width, number_of_tapes*(cy+wall_width)+wall_width, (cz/2)+wall_width]);
    for (i=[0:number_of_tapes-1])
        translate([wall_width,i*(cy+wall_width)+wall_width,wall_width])
            Cartridge();
}
