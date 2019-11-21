$fn=50;


prumer_1 = 53; // prumer lisovaciho nadstavce
prumer_2 = 30; // prumer lisovaciho nadstavce
vyska = 30; // vzska lisovaciho nadstavce


module plato()
{
    difference()
    {
        union()
        {
            translate([0,0,0]) cylinder(d=prumer_1, h=4);
            translate([0,0,4]) cylinder(d1=prumer_1,d2=prumer_2, h=15);
            translate([0,0,0]) cylinder(d=prumer_2, h=vyska);
        }
        union()
        {
            translate([0,0,0]) cylinder(d1=prumer_1*0.7, d=prumer_1*0.05, h=vyska);
            translate([0,-((prumer_1/2)-1.1),0]) cylinder(d=6, h=vyska);
        }
    }
}

module tvar_2()
{
    translate([-5,-6,0]) cube([10,5,vyska]);
    for(i=[-15:30:210])
    {
        rotate([0,0,-i])
        {
            hull()
            {
                translate([0,0,0]) cylinder(d=8, h=vyska);
                translate([-7,0,0]) cylinder(d=1, h=vyska);
            }
        }
    }
}

difference()
{
    plato();
    translate([0,0,0]) tvar_2();
}