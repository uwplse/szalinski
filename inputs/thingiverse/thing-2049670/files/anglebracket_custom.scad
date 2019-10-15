/////---Variables----//////

br_width = 15;
br_length = 15;
br_thickness = 2;
br_hole = 5;
br_support = "yes"; //[yes,no]
br_dual = "yes"; //[yes,no]

/////---Render---/////

bracket();

//cube([width,length,thickness],center=true);
//translate([width/2,0,length/2])rotate([0,90,0])cube([width,length,thickness],center=true);
//translate([width/2,0,0])rotate([90,0,0])cylinder(d=thickness,h=length,center=true, $fn=30);

/////---Modules---/////

module plate(w,l,h)
{
   difference()
   {
       union()
       {
           cube([br_width,br_length,br_thickness],center=true); 
           translate([br_width/2,0,0])rotate([90,0,0])cylinder(d=br_thickness,h=br_length,center=true, $fn=30);
           
       }
       cylinder(d=br_hole,h=br_thickness+1,center=true,$fn=30);
   }
}

module bracket()
{
    plate(br_width,br_length,br_thickness);
translate([br_width/2,0,br_width/2])rotate([0,90,0])plate(br_width,br_length,br_thickness);

    if (br_support == "yes")
    {
        hull()
        {
            translate([(br_width/2)-(br_thickness/2),(br_length/2)-(br_thickness/2),0])cube(br_thickness,center=true);
            translate([(-br_width/2)+(br_thickness/2),(br_length/2)-(br_thickness/2),0])cube(br_thickness,center=true);
            translate([br_width/2,(br_length/2)-(br_thickness/2),(br_width)-(br_thickness/2)])cube(br_thickness,center=true);
        }
    }
    mirror([0,1,0])
    {
       if (br_dual == "yes")
    {
        hull()
        {
            translate([(br_width/2)-(br_thickness/2),(br_length/2)-(br_thickness/2),0])cube(br_thickness,center=true);
            translate([(-br_width/2)+(br_thickness/2),(br_length/2)-(br_thickness/2),0])cube(br_thickness,center=true);
            translate([br_width/2,(br_length/2)-(br_thickness/2),(br_width)-(br_thickness/2)])cube(br_thickness,center=true);
        }
    } 
    }
}