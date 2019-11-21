thick = 5; // z

$fn = 50;

module CylinderHolder(diameter, height, thickness, inner_only)
{
    difference()
    {
        if(!inner_only)
        {
            cylinder(d = diameter + thickness * 2, h = height, center = true);
        }
        
        cylinder(d = diameter, h = 1.1*height, center = true);
    }
}

module CupsCylinders(width, height, diameter = 9.2, d_thick = 5, inner_only = true)
{
    distance = 0;
    translate([(width/2 - diameter/2 - distance), 0, 0])
    {
        translate([0, (height/2 - diameter/2 - distance), 0])
        CylinderHolder(diameter, thick, d_thick, inner_only);
        
        translate([0, -(height/2 - diameter/2 - distance), 0])
        CylinderHolder(diameter, thick, d_thick, inner_only);
    }
    
    translate([-(width/2 - diameter/2 - distance), 0, 0])
    {
        translate([0, (height/2 - diameter/2 - distance), 0])
        CylinderHolder(diameter, thick, d_thick, inner_only);
        
        translate([0, -(height/2 - diameter/2 - distance), 0])
        CylinderHolder(diameter, thick, d_thick, inner_only);
    }
}

module Holder(width = 15, height = 3*3, separation = 3, extra_h = 2)
{
    h = width / 2;
    
    difference()
    {
        union()
        {
            translate([0, 0, (h + extra_h + thick)/2])
                cube([width, height, h + extra_h], center = true);
            translate([0, 0, h + extra_h + thick])
                rotate([90, 0, 0])
                cylinder(d = width, h = height, center = true);
        }
        translate([0, 0, h + extra_h + thick])
        {
            rotate([90, 0, 0])
            cylinder(d = 5, h = 1.1*height, center = true);
            cube([1.1*width, separation, width], center = true);
        }
    }
}    

module InfillCube(width, height, thick, l_thick, infill)
{
    n_x = floor(infill * (width / (2 * l_thick)));
    n_y = floor(infill * (height / (2 * l_thick)));
    n = n_x * n_y;
    t = thick * 1.1;
    echo(n_x, n_y, n);
    
    difference()
    {
        cube([width, height, thick], center = true);
     
        for(i = [0:n])
        {
            col = floor(i % n_x);
            row = floor(i / n_x);
            w = width / n_x;
            h = height / n_y;
            
            translate([w * (col + 0.5) - width/2, h * (row + 0.5) - height/2, 0])
            rotate([0, 0, 0])
            cube([w - 2*l_thick, h - 2*l_thick, t], center = true);
        }
    }
}

module Base(width, height, l_thick, diameter = 9.2)
{
    d = 12;
    l = sqrt(width*width + height*height);
    
    difference()
    {
        union()
        {
            cube([25, 25, thick], center = true);
            CupsCylinders(width, height, diameter, inner_only = false);
            
            rotate([0, 0, atan(height/width)])
            cube([l, l_thick, thick], center = true);
            
            rotate([0, 0, -atan(height/width)])
            cube([l, l_thick, thick], center = true);
            
            difference()
            {
                cube([width, height, thick], center = true);
                cube([width - 2*l_thick, height - 2*l_thick, thick*1.1], center = true);
            }
        }
        CupsCylinders(width, height, diameter, inner_only = true);
    }
    
    Holder();
}

Base(width = 65, height = 80, l_thick = 5);