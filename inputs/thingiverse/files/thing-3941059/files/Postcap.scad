// Diameter of the container's cap
capdia=30;

// Height of the container's cap
capheight=13;

// Diameter of the post
postdia=60;

// Elements height
elementheight=40;

// Wall strength
wall=2;




capradius=(capdia/2);
postradius=(postdia/2);

// Checks
if (capheight > elementheight)
{
    echo ("Capheight higher than elementheight. Please change it.");
}
else
{
    if((capradius+wall) >= postradius)
    {
        echo ("Your diameter settings don't make sense... Please check");
    } else
    {
        difference(){
            union(){
                difference(){
                    cylinder(h=(elementheight+wall),r=(postradius+wall), $fn = 100);
                    translate([0, 0, wall])
                    cylinder(h=(elementheight+0.1),r=postradius, $fn = 100);
                };

                difference(){
                    cylinder(h=(capheight+wall),r=(capradius+wall), $fn = 100);
                    translate([0, 0, wall])
                    cylinder(h=(capheight+0.1),r=capradius, $fn = 100);
                };
            };
         
            translate([0, 0, elementheight])
            cylinder(h=(wall+0.1),
                    r2=(postradius+wall), 
                    r1=(postradius), 
                    $fn = 100);
        }
    }

}