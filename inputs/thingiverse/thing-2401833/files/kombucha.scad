r=47.5; //radius
rays=6; //number of rays
t=2; //material tickness
h=10; // neck border height
holeR=r/5; 
$fn=180;



d=2*r;  //diameter
l=d/(2*rays);
module rays(){
    translate([0,0,t/2])  

        for(i=[0:2*rays])
        {


            rotate([0,0,i*(360/(2*rays))])    
                cube([2*t+d,l,t],true);


        }
}

module oCylinder()
{
    cylinder (h+t,r+t,r+t,true);
}

module iCylinder()
{
    cylinder (h+t,r,r,true);
}
module cCylinder()
{
    cylinder (h+t,r+5*t,r+5*t,true);
}
module main()
{
    union()
    {
        translate([0,0,((h+t)/2)])
            difference()
            {
                oCylinder();
                iCylinder();
            }

        union()
        {      
            difference()
            {
                rays();
                difference()
                {
                    cCylinder();
                    iCylinder();
                }
            }
            translate([r+t,0,t/2])
                cylinder(t,l/2,l/2,true);
        }

    }
}
difference()
{
    main();
    translate([0,0,t/2])
        cylinder(t,holeR,holeR,true);
}
