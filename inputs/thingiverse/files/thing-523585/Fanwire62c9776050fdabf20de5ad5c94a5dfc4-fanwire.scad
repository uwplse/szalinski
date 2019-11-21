//The size of the FAN
outer_fansize = 50;
//The distance between the mounting holes (mostly fansize - 8)
distance_mount = 42;

//The thickness of the entire fanwire
fanwire_thickness = 5;

//The thickness of the wires
wire_thickness = 1;

//Spacing between the circular wires
wire_spacing = 3;

module tube(or,ir,h)
{
    difference()
    {
        cylinder(r=or,h=h,center=true,$fn=72);
        cylinder(r=ir,h=h,center=true,$fn=72);
    }
}


module fanwire(fansize,mount,thickness,wt, ws)
{
    rings = floor((fansize/2) / (wt + ws));

    difference()
    {
        union()
        {
            translate([mount/2,mount/2,0]) cylinder(r=4,h=thickness,center=true,$fn=24);
            translate([-mount/2,mount/2,0]) cylinder(r=4,h=thickness,center=true,$fn=24);
            translate([-mount/2,-mount/2,0]) cylinder(r=4,h=thickness,center=true,$fn=24);
            translate([mount/2,-mount/2,0]) cylinder(r=4,h=thickness,center=true,$fn=24);
            
            for(i=[1:1:rings])
            {
                tube((i*(wt+ws)),(i*(wt+ws))-wt,thickness);
            }
            
            fanwire_connect(mount, thickness, ws);

            mirror([1,0,0])
            fanwire_connect(mount, thickness, ws);
        }

        translate([mount/2,mount/2,0]) cylinder(r=1.5,h=thickness+1,center=true,$fn=12);
        translate([-mount/2,mount/2,0]) cylinder(r=1.5,h=thickness+1,center=true,$fn=12);
        translate([-mount/2,-mount/2,0]) cylinder(r=1.5,h=thickness+1,center=true,$fn=12);
        translate([mount/2,-mount/2,0]) cylinder(r=1.5,h=thickness+1,center=true,$fn=12);   
    }
    
    module fanwire_connect(mount, thickness, ws)
    {
        translate([-((mount/2)-2) - ws,0,0])
        difference()
        {
            tube((mount/2)-1.5,(mount/2)-4,thickness);
            translate([-mount/2,0,0])
            cube([mount,mount,thickness+1],center=true);
        }
    }
}

fanwire(outer_fansize,distance_mount, fanwire_thickness, wire_thickness, wire_spacing);
