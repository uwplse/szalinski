//**************************************************************************
//*   
//*   Configurable Pencil holder
//*   dimensions (all in mm)
//*   Created by Keith Welker
//*   9 April 2016
//**************************************************************************

FN = 36;//$fn for cylinders
count = 13; //# of holders (3-50 range)
rows = 3; //# of rows 2 min
THK = 3;  // wall thickness
D = 15; //pencil diamter (mm), 8 for pencils, 12 for sharpies, etc...
Hmax = 75; // tallest holder (mm)
Hmin = 20; // shortest holder (mm)
delta = .2; //small delta differnce for fixing offsets

rotate([0,0,180])    
Pencil_holder();

module Pencil_holder()
{

    Hdif = (Hmax-Hmin)/count;
    echo("Hmax", Hmax, "Hmin", Hmin,"Hdif", Hdif);
    Hstart = Hmax+Hdif;
    perRow = ceil(count/rows);
    echo("holders", count, "rows", rows,"PerRow", perRow);
    //loop through each row
    for(i = [1:rows])
    {
        row_os = i*(D+THK);
        //make a holder 
        for(j = [1:perRow])
        {
            if( ((i-1)*perRow + j) <= count)
            {
                translate([j*(D+THK),i*(D+THK),0])
                holder((Hstart-((i-1)*perRow + j)*Hdif));
            }
        }
    }
}

module holder(h1)
{
    difference()
    {
        cylinder(h1, r=THK+D/2, $fn = FN);
        translate([0,0,THK+delta])
        cylinder(h1-THK, r=D/2, $fn = FN);
    }
}

