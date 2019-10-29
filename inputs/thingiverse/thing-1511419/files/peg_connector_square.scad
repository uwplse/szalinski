x_number=4;
y_number=2;

$fn=50;
rod_radius=1.5;
tolerance=0.25;

connector_length=15;
connector_thickness=6;


//difference()
//{
//    cube([connector_length, connector_thickness, connector_thickness], center=true);
//    
//    translate([-connector_length,0, 0])
//        rotate([0,90,0])
//            cylinder(r=rod_radius+tolerance, h=connector_length*2);
//}
//
//rotate([0,0,90])
//difference()
//{
//    cube([connector_length, connector_thickness, connector_thickness], center=true);
//    
//    translate([-connector_length,0, 0])
//        rotate([0,90,0])
//            cylinder(r=rod_radius+tolerance, h=connector_length*2);
//}

module peg()
{
 // difference()
{
    cube([connector_length, connector_thickness, connector_thickness], center=true);
    
    //translate([-connector_length,0, 0])
      //  rotate([0,90,0])
        //    cylinder(r=rod_radius+tolerance, h=connector_length*2);
}
}

module connector()
{
difference()
{
union()
    {
for (i=[0:3])
{
    rotate([0,0,i*90])
    translate([connector_length/2,0,0])
    //difference()
    {
    peg();
    //translate([-connector_length,0, 0])
        //rotate([0,90,0])
            //cylinder(r=rod_radius+tolerance, h=connector_length*2);
    }
}

translate([0,0,connector_length/2])
rotate([0,90,0])
peg();
}



for (i=[[0,90,0], [90,0,0], [0,0,0]])
{
    rotate(i)
translate([0,0,-connector_length*2])
cylinder(r=rod_radius+tolerance, h=connector_length*4);
}}}


//for (i=[0:x_number-1], j=[0:y_number -1])
//{
//    translate([connector_length*2.2*i, connector_length*2.2*j, 0])
//    connector();
//}

for(i=[0:3], j=[0:2])
{
    translate([0,connector_length*j*2.3,0])
    {
translate([connector_length*2.75*i,0,0])
    {
connector();
translate([connector_length+5, connector_thickness+5,0])
connector();
    }}
}
//// Diameter Test
//$fn=50;
//// Hole from 2mm to 4mm in increments of 0.2
//
//difference()
//{
//cube([115,6,20]);
//    
//    
//translate([5,3,-1])
//cylinder(r=1, h=25);
//    
//    translate([15,3,-1])
//cylinder(r=1.1, h=25);
//    
//    translate([25,3,-1])
//cylinder(r=1.2, h=25);
//    
//    translate([35,3,-1])
//cylinder(r=1.3, h=25);
//    
//    translate([45,3,-1])
//cylinder(r=1.4, h=25);
//    
//    
//    translate([55,3,-1])
//cylinder(r=1.5, h=25);
//    
//    
//    translate([65,3,-1])
//cylinder(r=1.6, h=25);
//
//
//translate([75,3,-1])
//cylinder(r=1.7, h=25);
//
//
//translate([85,3,-1])
//cylinder(r=1.8, h=25);
//
//translate([95,3,-1])
//cylinder(r=1.9, h=25);
//
//translate([105,3,-1])
//cylinder(r=2, h=25);
//
//}