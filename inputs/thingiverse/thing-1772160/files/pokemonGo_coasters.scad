
//base height
height = 5;
//base radius
radius = 50;
//base thickness
thickness = 2;
//base deep
deep = 2;

//small circle height
sheight = 5;
//small circle radius
sradius = 10;

//lines thickness
line_thickness = 2;

difference()
{
    cylinder(height, radius, radius, false);
    translate([0, 0, height])
    cylinder(deep, radius - thickness, radius - thickness, true);
}

//small circle
difference()
{
   cylinder(sheight + height, 
            sradius + thickness, 
            sradius + thickness, false);
    cylinder(sheight + height, 
            sradius, sradius, false);
}

translate([radius + sradius + 1, 0, 0]) cylinder(sheight, sradius, sradius, false);

//lines
//difference(){
    translate([(sradius + thickness/2), -thickness/2, 0]) cube([radius-sradius-1.5*thickness,line_thickness,sheight + height],false);
    
  //  translate([(radius - thickness), -thickness/2, height]) rotate([-90,0,0]) { cylinder(5, 5, 5, false);}
//}

mirror([1, 0, 0]) 
translate([(sradius + thickness/2), -thickness/2, 0]) cube([radius-sradius-1.5*thickness,line_thickness,sheight + height],false);


//red part
translate([-(2*radius + 1), 0, 0])
difference()
{
    cylinder(sheight+deep, radius - thickness, radius - thickness, false);
    translate([0, -(radius - thickness)+line_thickness, 0])
    cube(2*(radius - thickness), center=true); 
    cylinder(sheight + deep, 
            sradius + thickness, 
            sradius + thickness, false);
}

//white part
translate([-(2*radius + 1), 0, 0])
mirror([0, -(2*radius + 1), 0]) 
difference()
{
    cylinder(sheight+deep, radius - thickness, radius - thickness, false);
    translate([0, -(radius - thickness)+line_thickness, 0])
    cube(2*(radius - thickness), center=true); 
    cylinder(sheight + deep, 
            sradius + thickness, 
            sradius + thickness, false);
}



