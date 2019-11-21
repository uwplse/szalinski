//Enter # of wires you wanna hang (at least 3)
NumberOfCables = 5; // [3:20]
cable_d = 10; // [5:Small(5mm),10:Medium(10mm),15:Large(15mm)]
//Enter hanger thickness
plate_h = 5; // [5,6,7,8,9,10,11,12,13,14,15]
//Clearance between slots, slots and wall
c = 10; // [10:20]
plate_l = cable_d+(1.5*c); //Hanger length
plate_w = (NumberOfCables*(cable_d+c)) + c; //Hanger width
difference()
{
    union()
    {
        translate([0, 0, plate_h]) cube([plate_h, 15, 15]);
        translate([0, plate_w-15, plate_h]) cube([plate_h, 15, 15]);
        difference()
        {
            cube([plate_l, plate_w, plate_h], center=[plate_l/2, plate_w/2, plate_h/2]);
            for(i = [1:NumberOfCables])
            {
                translate([(c+(cable_d/2)), (i*(c+(cable_d))-(cable_d/2)), plate_h/2]) cylinder(plate_h+0.2, cable_d/2+2, cable_d/2+2, center = true);
                translate([plate_l-cable_d/2, (i*(c+(cable_d))-(cable_d/2)), plate_h/2]) cube([cable_d+0.1, cable_d, plate_h+0.2], center = true);
            }
        }
    }
translate([plate_h/2, 7.5, plate_h+7.5]) rotate([0, 90, 0]) cylinder(plate_h+0.2, 2.5, 2.5, center = true);
translate([plate_h/2, plate_w-7.5, plate_h+7.5]) rotate([0, 90, 0]) cylinder(plate_h+0.2, 2.5, 2.5, center = true);    
}
