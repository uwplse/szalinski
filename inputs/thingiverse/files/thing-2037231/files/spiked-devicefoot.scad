// Customizable spiked device foot
// Created by Kjell Kernen
// Date 14.1.2017

/*[Foot Parameters]*/

// of the foot in tens of mm:
base_height=25;// [0:200]

// of the foot in tens of mm:
base_overhang=25;// [0:30]

// of the spike in tens of mm:
diameter=250;      // [50:500]

// of the spike in tens of mm:
height=100;       // [50:500]

/*[Hidden]*/


union()
{
    translate([0,0,base_height/10]) cylinder(r=2, h=height/10, r1=diameter/20);	
    cylinder(r=((diameter + (base_overhang*2))/20), h=base_height/10);	
}


