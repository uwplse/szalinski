// Input the Inner Diameter of the "narrow" end
upper_inner_diameter = 3;

// Input the Outer Diameter of the "narrow" end
upper_outer_diameter = 6;

// Input the Inner Diameter of the "wide" end
lower_inner_diameter = 5;

// Input the Outer Diameter of the "wide" end
lower_outer_diameter = 12;

// Input the Height of the "inner" countersink
inner_height = 2;

// Input the Height of the "outer" countersink
outer_height = 4;

// Input the Tolerance of the printer
tolerance = .3;

// Select the Position of the "inner" countersink
inner_pos = "center";//[bottom,top,center]

difference()
{
    $fn = 100;
    
    upper_inner_diameter=upper_inner_diameter+(2*tolerance);
    //upper_outer_diameter=upper_outer_diameter-(2*tolerance);
    lower_inner_diameter=lower_inner_diameter+(2*tolerance);
    //lower_outer_diameter=lower_outer_diameter-(2*tolerance);
    
    cylinder(r1=lower_outer_diameter/2, r2=upper_outer_diameter/2, h=outer_height);
    
    if(inner_pos=="center")
    {
        cylinder(r=lower_inner_diameter/2, h=(outer_height/2)-(inner_height/2));
        translate([0,0,outer_height/2])
        cylinder(r=upper_inner_diameter/2, h=outer_height/2);
        translate([0,0,(outer_height/2)-(inner_height/2)])
        cylinder(r1=lower_inner_diameter/2, r2=upper_inner_diameter/2, h=inner_height);
    }
    else if(inner_pos=="top")
    {
        cylinder(r=upper_inner_diameter/2, h=outer_height);
        cylinder(r1=lower_inner_diameter/2, r2=upper_inner_diameter/2, h=inner_height);
    }
    else
    {
        cylinder(r=lower_inner_diameter/2, h=outer_height-inner_height);
        translate([0,0,outer_height-inner_height])
        cylinder(r1=upper_inner_diameter/2, r2=upper_inner_diameter/2, h=inner_height);
        translate([0,0,outer_height-inner_height])
         cylinder(r1=lower_inner_diameter/2, r2=upper_inner_diameter/2, h=inner_height);
    }
}