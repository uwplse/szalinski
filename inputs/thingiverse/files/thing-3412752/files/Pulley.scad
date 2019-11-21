// overall heights of the pulley
height=15;

// radius of the pulley
radius=11.5;

// bearing radius
bearing=4;

// wall thickness
thickness=2;




cutradius=(height/2)-thickness;

if(radius <= bearing)
{
    echo("radius needs to be bigger than bearing");
}
else
{
    if(bearing >= radius-cutradius)
    {
        echo("bearing would break through");
    } else
    {
        difference(){
            cylinder(h=height,r=radius, $fn=100);

            rotate_extrude(convexity = 10, $fn = 100)
            translate([radius, height/2, 0])
            circle(r = cutradius, $fn = 100);
                
            translate([0, 0, -1])
            cylinder(h=height+2,r=(bearing), $fn = 100);
        };
        
    };
};