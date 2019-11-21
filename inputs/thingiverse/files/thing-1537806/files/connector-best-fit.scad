x_number=9;
y_number=6;

$fn=100;
rod_radius=1.5; //1.5 originally
tolerance=0.20; //0.20 originally

connector_length=15;
connector_thickness=6;
//increased size of center hole


////difference()
////{
////    cube([connector_length, connector_thickness, connector_thickness], center=true);
////    
////    translate([-connector_length,0, 0])
////        rotate([0,90,0])
////            cylinder(r=rod_radius+tolerance, h=connector_length*2);
////}
////
////rotate([0,0,90])
////difference()
////{
////    cube([connector_length, connector_thickness, connector_thickness], center=true);
////    
////    translate([-connector_length,0, 0])
////        rotate([0,90,0])
////            cylinder(r=rod_radius+tolerance, h=connector_length*2);
////}
//
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
//
//module connector()
//{
//difference()
//{
//union()
//    {
//        
//for (i=[[0,0,0],[0,0,90],[0,0,180],[0,0,-90],[0,-45,0],[0,-45,90],[0,-45,180],[0,-45,-90]])
//{
//    rotate(i)
//    translate([connector_length/2,0,0])
//    //difference()
//    {
//    peg();
//    //translate([-connector_length,0, 0])
//        //rotate([0,90,0])
//            //cylinder(r=rod_radius+tolerance, h=connector_length*2);
//    }
//}
//
//translate([0,0,connector_length/2])
//rotate([0,90,0])
//peg();
//}
//
//
//
//for (i=[[0,90,0],[0,90,90],[0,90,180],[0,90,-90],[0,-45,0],[0,-45,90],[0,-45,180],[0,-45,-90]])
//{
//    rotate(i)
//translate([0,0,connector_length/3])
//cylinder(r=rod_radius+tolerance, h=connector_length);
//}
//translate([0,0,connector_length/3])
//cylinder(r=rod_radius+tolerance, h=connector_length+5);
//}}
//
//
////for (i=[0:x_number-1], j=[0:y_number -1])
////{
////    translate([connector_length*2.2*i, connector_length*2.2*j, 0])
////    connector();
////}
//
////for(i=[0:1], j=[0:1])
////{
////    translate([0,connector_length*j*2.3,0])
////    {
////translate([connector_length*2.75*i,0,0])
////    {
////connector();
////translate([connector_length+5, connector_thickness+5,0])
////connector();
////    }}
////}
////// Diameter Test
////$fn=100;
////// Hole from 2mm to 4mm in increments of 0.2
////
////difference()
////{
////cube([115,6,20]);
////    
////    
////translate([5,3,-1])
////cylinder(r=1, h=25);
////    
////    translate([15,3,-1])
////cylinder(r=1.1, h=25);
////    
////    translate([25,3,-1])
////cylinder(r=1.2, h=25);
////    
////    translate([35,3,-1])
////cylinder(r=1.3, h=25);
////    
////    translate([45,3,-1])
////cylinder(r=1.4, h=25);
////    
////    
////    translate([55,3,-1])
////cylinder(r=1.5, h=25);
////    
////    
////    translate([65,3,-1])
////cylinder(r=1.6, h=25);
////
////
////translate([75,3,-1])
////cylinder(r=1.7, h=25);
////
////
////translate([85,3,-1])
////cylinder(r=1.8, h=25);
////
////translate([95,3,-1])
////cylinder(r=1.9, h=25);
////
////translate([105,3,-1])
////cylinder(r=2, h=25);
////
////}
//peg();
//connector();

module connector()
{
difference()
{

hull()
{
translate([0,0,connector_length/2])
rotate([0,90,0])
peg();    
    
rotate([0,0,90])
translate([0,-connector_thickness/2,0])
cube([connector_length, connector_thickness,connector_thickness]);

rotate([0,0,180])
translate([0,-connector_thickness/2,0])
cube([connector_length, connector_thickness,connector_thickness]);

rotate([0,0,-90])
translate([0,-connector_thickness/2,0])
cube([connector_length, connector_thickness,connector_thickness]);

translate([0,-connector_thickness/2,0])
cube([connector_length, connector_thickness,connector_thickness]);
}
// TAKE AWAY

for (i=[0:3])
{
    rotate([0,0,90*i])
    translate([connector_thickness/2,connector_thickness/2,-1])
cube([connector_length, connector_length, connector_length*1.2]);
}

translate([0,0,connector_thickness/2])
for (i=[[0,90,0],[0,90,90],[0,90,180],[0,90,-90],[0,-45,0],[0,-45,90],[0,-45,180],[0,-45,-90]])
{
    rotate(i)
translate([0,0,connector_length/3])
cylinder(r=rod_radius+tolerance, h=connector_length);
}
translate([0,0,-1])
cylinder(r=rod_radius+tolerance*1.25, h=connector_length+5);

}}

for (i=[0:x_number-1], j=[0:y_number-1])
{
    translate([0,connector_length*j*1.4,0])
    rotate([0,0,-atan2(connector_thickness*1.1, connector_length*1.25)])
translate([connector_length*i*1.25, connector_thickness*i*1.1,0])
connector();
}

//rotate([0, 0,-19.8])
//for (I=[0:x_number], j=[0:y_number])
//{
//i = I-j/1.37;
//translate([connector_thickness*j*1.1,connector_length*j*1.55,0])
//translate([connector_length*i*1.2, connector_thickness*i*1.1,0])
//connector();
//}