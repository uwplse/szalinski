$fn=30;
prumer = 10.5; //the diameter of the threaded rod [mm]
vyska  = 20.0; //the height of the threaded rod[mm] 

difference()
{
    union()
    {
        hull() 
        {
            cube([10,(prumer+30),3]);
            translate([0,((prumer+30)/2),vyska]) rotate([0,90,0]) cylinder(d=(prumer*1.5),h=10);
        }
    }
    union()
    {
        translate([-0.5,((prumer+30)/2),vyska]) rotate([0,90,0]) cylinder(d=prumer,h=11);
        translate([5,5,5]) rotate([0,0,0]) cylinder(d=8,h=vyska+prumer);
        translate([5,(prumer+25),5]) rotate([0,0,0]) cylinder(d=8,h=vyska+prumer);
        translate([5,5,0]) rotate([0,0,0]) cylinder(d=4,h=50);
        translate([5,(prumer+25),0]) rotate([0,0,0]) cylinder(d=4,h=50);
        translate([0,15,0]) cube([10,1,vyska]);
        translate([0,(prumer+14),0]) cube([10,1,vyska]);
    }    
}