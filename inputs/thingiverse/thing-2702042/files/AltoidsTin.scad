// preview[view:south west, tilt:top diagonal]

$fn=50 * 1;

part="both";// [first:Tin Only, second:Lid Only, both: Tin and Lid]

layer_height=.28;

nozzle_diameter=.4;

//(Used with Layer Height and Nozzle Diameter to calculate walls and top/bottom thickness)
perimeters=3;

//(Used with Nozzle Diameter to calculate the corner radius)
radius_perimeters=25;

//(Amount of extra space to put around the lid overlap)
tolerance=.2;

length=93;
width=58;
height=20;
lid_lip=8;

print_part();

module print_part()
{
        
    if(part=="first")
    {
        tin();
    }
    else if(part=="second")
    {
        lid();
    }
    else if(part=="both")
    {
        both();
    }else
    {
        both();
    }
}

module both()
{
    tin();
    translate([0,-length*.8,0])
    lid();
}

module tin()
{
    difference()
    {
        hull()
        {
            translate([-length/2+nozzle_diameter*radius_perimeters,-width/2+nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters,h=height);

            translate([length/2-nozzle_diameter*radius_perimeters,-width/2+nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters,h=height);

            translate([length/2-nozzle_diameter*radius_perimeters,width/2-nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters,h=height);

            translate([-length/2+nozzle_diameter*radius_perimeters,width/2-nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters,h=height);
        }

        translate([0,0,perimeters*layer_height])
        hull()
        {
            translate([-length/2+nozzle_diameter*radius_perimeters,-width/2+nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters-(perimeters*nozzle_diameter),h=height);

            translate([length/2-nozzle_diameter*radius_perimeters,-width/2+nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters-(perimeters*nozzle_diameter),h=height);

            translate([length/2-nozzle_diameter*radius_perimeters,width/2-nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters-(perimeters*nozzle_diameter),h=height);

            translate([-length/2+nozzle_diameter*radius_perimeters,width/2-nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters-(perimeters*nozzle_diameter),h=height);
        }
    }
}

module lid()
{
    difference()
    {       
        hull()
        {
            translate([-length/2+nozzle_diameter*radius_perimeters,-width/2+nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters+(perimeters*nozzle_diameter)+tolerance,h=lid_lip);

            translate([length/2-nozzle_diameter*radius_perimeters,-width/2+nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters+(perimeters*nozzle_diameter)+tolerance,h=lid_lip);

            translate([length/2-nozzle_diameter*radius_perimeters,width/2-nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters+(perimeters*nozzle_diameter)+tolerance,h=lid_lip);

            translate([-length/2+nozzle_diameter*radius_perimeters,width/2-nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters+(perimeters*nozzle_diameter)+tolerance,h=lid_lip);
        }

        translate([0,0,perimeters*layer_height])
        hull()
        {
            translate([-length/2+nozzle_diameter*radius_perimeters,-width/2+nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters+tolerance,h=lid_lip);

            translate([length/2-nozzle_diameter*radius_perimeters,-width/2+nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters+tolerance,h=lid_lip);

            translate([length/2-nozzle_diameter*radius_perimeters,width/2-nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters+tolerance,h=lid_lip);

            translate([-length/2+nozzle_diameter*radius_perimeters,width/2-nozzle_diameter*radius_perimeters,0])
            cylinder(r=nozzle_diameter*radius_perimeters+tolerance,h=lid_lip);
        }
    }
}
