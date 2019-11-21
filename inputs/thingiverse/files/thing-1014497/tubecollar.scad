// Customizable tube collar
// Created by Kjell Kernen
// Date 14.9.2015

/*[Colar Parameters]*/
// of the collar in tens of mm:
inner_diameter=254;       // [20:1000]

// of the collar in tens of mm:
outer_diameter=275;      // [30:1010]

// of the collar in tens of mm:
total_height=400;       // [30:1000]

// of the flange in tens of mm:
flange_height=20;// [10:100]

// of the flange in tens of mm:
flange_width=40;// [10:100]

/*[Hidden]*/


difference()
{
    difference()
    {
        union()
        {
            cylinder(r=(outer_diameter/20), h=total_height/10);	
            cylinder(r=((outer_diameter + flange_width)/20), h=flange_height/10);	
        }
        translate([0,0,-1])
            cylinder(r=(inner_diameter/20), h=(total_height/10) + 2);	
    }
    translate([0,-inner_diameter/80,-1]) 
        cube(size=[(inner_diameter + flange_width + 100 ) /20, inner_diameter/40 , total_height/10 + 2]);
}
