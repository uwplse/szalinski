// Customizable circular device foot
// Created by Kjell Kernen
// Date 14.1.2017

/*[Foot Parameters]*/

// of the foot in tens of mm:
diameter=250;      // [50:500]

// of the foot in tens of mm:
total_height=100;       // [25:1000]

// of the foot in tens of mm:
flange_height=25;// [0:50]

// of the foot in tens of mm:
flange_width=25;// [0:50]

/*[Hidden]*/


difference()
{
        union()
        {
            cylinder(r=(diameter/20), h=total_height/10);	
            cylinder(r=((diameter + (flange_width*2))/20), h=flange_height/10);	
        }
        translate([0,0,flange_height/10])
            cylinder(r=((diameter-50)/20), h=(total_height/10) + 2);	
}
