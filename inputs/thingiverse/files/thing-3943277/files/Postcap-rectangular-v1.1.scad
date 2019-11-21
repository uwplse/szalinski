// Diameter of the container's cap
capdia=30;

// Height of the container's cap
capheight=13;

// Width of the post
postwidth=40;

// Lenghth of the post
postlength=50;

// Elements height
elementheight=30;

// Wall strength
wall=2;


capradius=(capdia/2);
widthhalf=((postwidth/2)+(2*wall));
lengthhalf=((postlength/2)+(2*wall));

// Checks
if (capheight > elementheight)
{
    echo ("Capheight higher than elementheight. Please change it.");
}
else
{
    if ((capdia+(2*wall)) >= postlength)
    {
        echo ("Inner radius higher than post length... Please check");
    } else
    {
        if ((capdia+(2*wall)) >= postwidth)
        {
            echo ("Inner radius higher than post width... Please check");
        } else
        {
            
           difference(){
                union(){
                    difference(){
                        translate([0, 0, (elementheight/2)+(wall/2)])
                        cube(size=[(postlength+(2*wall)),(postwidth+(2*wall)),(elementheight+wall)], center = true);
                        translate([0, 0, ((elementheight/2)+(wall/2)+wall)])
                        cube(size=[postlength,postwidth,elementheight], center = true);
                        };

                   difference(){
                        translate([0, 0, wall])
                        cylinder(h=(capheight),r=(capradius+wall), $fn = 100);
                        translate([0, 0, wall])
                        cylinder(h=(capheight+0.1),r=capradius, $fn = 100);
                        };
                    };
                //
               translate([0, 0, (elementheight-wall)+0.1])
                linear_extrude(height=(wall*2), scale =2/1) square([((postlength+(2*wall))/2),((postwidth+(2*wall))/2)], center=true);
                
                };
                
           
            };
        };
}