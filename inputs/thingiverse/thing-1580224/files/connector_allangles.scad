// Variables

hole_size=3.4;
hole_radius=hole_size/2;

connector_thickness=2;
connector_length=25;

$fn=50;

y_number=2;
x_number=2;

module connector()
{
intersection()
{
difference()
{
    sphere(r=connector_length/2);
    
    

for (i = [ [  0,  0,   0], 
        [0, 90, 0],
        [90, 0, 0], 
        [ 90, 0,  45],
        [90,0,-45],
        [45,0,0],
        [45,0,45],
        [45,0,-45],
        [45,0,90],
        [45,0,-90],
        [-45, 0,0],
        [-45,0,45],
        [-45,0,-45],])

{
    rotate(i)
    cylinder(r=hole_radius, h=connector_length*3, center=true);
}
cylinder(r=hole_radius, h=connector_length*3);

}





////translate([0,0,25])
//intersection_for(i=[0:3])
//{
//    sphere(r=connector_length/2);
//    {
//    rotate([0,45*i,45*i])
//    cube(connector_length/1.3, center=true);
//    }
//}}

hull()
{

cylinder(r=connector_length/2, h=hole_size*1.5, center=true);
translate([0,0,connector_length/2])
cube([hole_size*2, hole_size*2, 1], center=true);
    translate([0,0,-connector_length/2])
cube([hole_size*2, hole_size*2, 1], center=true);
}}}

for (i=[0:x_number-1], j=[0:y_number-1])
{translate([(connector_length+2)*i,(connector_length+2)*j,0])
    difference()
    {
    //translate([(connector_length+5)*i,0,0])
    connector();
        translate([0,0,-connector_length+2])
        cube([connector_length*2,connector_length*2,connector_length], center=true);
    }
}