
//sizes in mm
pad_diam=40;
top_diam=46;
bulge_diam=56.5;
lip_diam=50;
bottom_diam=45;
bulge_height=12.5;
lip_height=2.5;
thickness=10;
top_pad=5;
bottom_pad=40;
screwsize=4;
screwflangedepth=3.5;
screwflangesize=8;
screwoffset=5;
padsize=42;
paddepth=5;

fine=100;

// calculated
total_height=top_pad+bottom_pad+bulge_height+lip_height;
total_width=bulge_diam/2+thickness;
total_depth=bulge_diam/2+thickness;

rotate([90,0,90])
difference()
{
    // Create a block to carve pieces out of via difference()
    // A difference section adds the first command
    // and subtracts all the rest
    translate([-total_width/2,-total_depth/2,-total_height/2])
        cube([total_width,total_depth,total_height]);

    // Remove a large cone as the base of the bannister
    translate([total_width/2,0,-total_height/2-1])
        cylinder(d2=top_diam,d1=bottom_diam,h=total_height+2,$fn=fine);

    // Remove the bulge as a torus
    translate([total_width/2+bulge_height/2,0,-total_height/2+top_pad+bulge_height/2])
        rotate_extrude($fn=fine)
            translate([bulge_diam/2,0,0])
                circle(r=bulge_height/2, $fn=fine);

    // Remove the lip below the bulge
    translate([total_width/2,0,-total_height/2+top_pad+bulge_height-1])
        cylinder(d=lip_diam,h=lip_height+1,$fn=fine);
    
    // Remove the screw hole
    translate([-total_width/2,0,screwoffset])
      rotate([0,90,0])
        cylinder(d=screwsize,h=total_width,$fn=fine);
    

    // Remove the countersink
    translate([(-total_width/2)-screwflangedepth+paddepth,0,screwoffset])
      rotate([0,90,0])
        cylinder(d1=screwflangesize,d2=screwsize,h=screwflangedepth,$fn=fine);
        
    // Remove an indentation for the gate pad
    translate([(-total_width/2),0,-total_height/2+bulge_height/2+lip_height/2+padsize/2])
        rotate([0,90,0])
            minkowski()
            {
                cylinder(d=padsize,h=padheight,$fn=fine);
                sphere(padheight/3,$fn=fine);
            }
}
