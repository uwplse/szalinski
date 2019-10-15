// Customizable square device foot
// Created by Kjell Kernen
// Date 14.1.2017

/*[Foot Parameters]*/

// of the foot in mm:
length=20;         // [5:100]

// of the foot in mm:
width=30;          // [5:100]

// of the foot in mm:
total_heigth=8;   // [5:50]

// of the foot in mm:
flange_heigth=3;   // [0:5]

// of the foot in mm:
flange_width=2;    // [0:5]

/*[Hidden]*/
base_heigth=total_heigth-flange_heigth;

difference()
{
    union()
    {
        difference()
        {
            translate([0,0,total_heigth/2])
                cube(size = [length, width, total_heigth], center=true);  
            translate([0,0,(total_heigth+1)/2 + flange_heigth])
                cube(size = [length-5, width-5, total_heigth+1], center=true); 
        }
        translate([0,0,flange_heigth/2])        
            cube(size = [length+flange_width*2, width+flange_width*2, flange_heigth], center=true);
    }       
}
