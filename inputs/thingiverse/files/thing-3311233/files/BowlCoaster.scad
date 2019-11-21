//variables
OuterRadius = 62;
InnerRadius = 52;
R1 = (OuterRadius-InnerRadius)/2-1; //radius of torus
R2 = OuterRadius-R1-1; //radius of ring
Zscale = 4/R1;

difference()
{
    translate([0,0,0])
    {
        difference()
        {
            cylinder(4, r = OuterRadius, center = true, $fn=256);
            cylinder(5, r = InnerRadius, center = true, $fn=256);
        }
    }
    translate([0,0,1.2])
        {
        scale([1,1,Zscale])
            {    
            torus(R1,R2);
            }
        }    
}    

module torus(R1,R2)
{
rotate_extrude(convexity = 10, $fn = 256)
    { 
    translate([R2, R1/2, 0])
    circle(r = R1, $fn = 32); 
    }
}
    