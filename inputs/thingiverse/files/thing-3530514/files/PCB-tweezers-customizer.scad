//height
ph=10; // [6:30] 
//thickness
pt=3; // [1:0.1:5]
//claw length
pl=30; // [10:1:100]
//width (pcb)
pw=60; //[0:1:200]

difference()
{
    union()
    {
        rotate([-75,0,0])
        translate([-pt-(pw/2),-pl,0])
        difference()
        {
            translate([-1,0,0])
            cube([pt+1,2*pl,ph]);
            translate([pt,0,2.3])
            scale([1,1,1.5])
            rotate([0,45,0])
            translate([-1,-1,-1])
            cube([2,2*pl,2]);
        }
        rotate([-75,0,0])
        translate([pw/2,-pl,0])
        difference()
        {
            cube([pt+1,2*pl,ph]);
            translate([0,0,2.3])
            scale([1,1,1.5])
            rotate([0,45,0])
            translate([-1,-1,-1])
            cube([2,2*pl,2]);
        }
    }
    translate([-pw,-pw,-2*pw])
    cube(2*pw);
}

translate([-pt-(pw/2),5,0])
cube([pt,25,ph]);
translate([pw/2,5,0])
cube([pt,25,ph]);

hull()
{
    translate([pw/2,30,0])
    cube([pt,0.1,ph]);
    translate([20,50,0])
    cube([pt,0.1,ph]);
}
hull()
{
    translate([-pt-(pw/2),30,0])
    cube([pt,0.1,ph]);
    translate([-20-pt,50,0])
    cube([pt,0.1,ph]);
}

hull()
{
    translate([20,50,0])
    cube([pt,0.1,ph]);
    translate([0,150,0])
    cube([pt,0.1,ph]);
}
hull()
{
    translate([-20-pt,50,0])
    cube([pt,0.1,ph]);
    translate([-pt,150,0])
    cube([pt,0.1,ph]);
}
translate([-pt,150,0])
cube([2*pt,10,ph]);
hull()
{
    translate([20,50,0])
    cube([pt,0.1,ph]);
    translate([0,100,0])
    cube([1,0.1,ph]);
}
hull()
{
    translate([-20-pt,50,0])
    cube([pt,0.1,ph]);
    translate([-1,100,0])
    cube([1,0.1,ph]);
}
translate([0,100,0])
cylinder(r=2,h=ph,$fn=50);


