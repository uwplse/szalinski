diameter = 27;
height = 60;

difference ()
{
    cylinder(height,d=diameter+5);
    translate([0,0,5]) cylinder(height,d=diameter);    

    translate([0,diameter, height*3/4]) rotate([90,0,0]) cylinder(2*diameter,d=5);
    translate([0,diameter/2+1,height*3/4]) rotate([90,0,0]) cylinder(2*diameter,d=10);
    translate([-diameter,0,height*1/4]) rotate([90,0,90]) cylinder(2*diameter,d=5);
    translate([-diameter/2-1,0,height*1/4]) rotate([90,0,90]) cylinder(2*diameter,d=10);
    
}