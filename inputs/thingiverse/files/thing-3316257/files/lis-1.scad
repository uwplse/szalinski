$fn=60;

prumer_1 = 53; // prumer lisovaciho nadstavce
prumer_2 = 45; // prumer lisovaciho nadstavce
vyska = 20; // vzska lisovaciho nadstavce


module plato()
{
    difference()
    {
        union()
        {
            translate([0,0,0]) cylinder(d=prumer_1, h=5);
            translate([0,0,5]) cylinder(d1=prumer_1,d2=prumer_2, h=7);
            translate([0,0,0]) cylinder(d=prumer_2, h=vyska);
        }
        union()
        {
            translate([0,0,0]) cylinder(d1=prumer_1*0.8, d=prumer_1*0.01, h=vyska);
            translate([0,-((prumer_1/2)-1.1),0]) cylinder(d=6, h=vyska);
        }
    }
}

module tvar_1()
{
    translate([-10,-5,0])
    {
        linear_extrude(vyska)
        {
            polygon(points=[[0,-3],[20,-3],[23,5],[20,10],[15,5],[10,10],[5,5],[0,10],[-3,5],]);
        }
    }
}

difference()
{
    plato();
    translate([0,0,0]) tvar_1();
}