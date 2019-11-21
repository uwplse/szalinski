//
//  NineHoseWashers.scad
//
//  EvilTeach
//
//  05/27/2017

//
//  Filament    Ninjaflex
//  infill      100
//  layer       .2
//  shells      0
//  feedrate    10/10
//  temp        250/60
//

outerDiameter = 27.0;
innerDiameter = 14.0;
height        =  3.0;

for (x = [-outerDiameter : outerDiameter : outerDiameter])
{
    for (y = [-outerDiameter : outerDiameter : outerDiameter])
    {
        translate([x, y, 0])
        //    import("C:/Users/jan/Desktop/hosewasher1.stl");
        difference()
        {
            cylinder(d = outerDiameter, h = height, $fn = 90);
            cylinder(d = innerDiameter, h = height, $fn = 90);
        }
    }
}


