$diameter=75;
$thickness=3;
$lip=4;
$height=8;
$fine=100;

rotate([180,0,0])
{
    union()
    {
        //Cap
        difference()
        {
            union()
            {
                 //Wings
                translate([-($diameter*1.20)/2,(-$diameter*0.3)/2,$height-$thickness-1])
                {
                    minkowski() //rounded edge
                    {
                        cylinder(r=3,$fn=$fine);
                        cube([$diameter*1.20,$diameter*0.3,$thickness]);
                    }
                }

                cylinder(h=$height,d=$diameter+($thickness*2),$fn=$fine);
            }

            translate([0,0,-$thickness])
            {
                cylinder(h=$height,d=$diameter,$fn=$fine);
            }
            //Text
            translate([0,0,$height-1])
            {
                linear_extrude(height=2)
                {
                    text(text="WIPER FLUID",size=9, halign="center", valign="center");
                }
            }
        }
        
        //Lip
        translate([0,0,$height/10])
        {
            rotate_extrude($fn=$fine)
                translate([($diameter-($lip/2)+$thickness)/2, 0,])
                    circle(r1=$lip,$fn=$fine/2);

        }

            
    }
}