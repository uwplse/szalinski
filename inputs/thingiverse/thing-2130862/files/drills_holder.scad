


// !!! just put the needed diameters here
all = // all the diameters of drill bits 
[
[10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
[10, 10, 10, 10, 10, 8,8,8,8,8],
[6,6,6,6,6,5,5,5,5,5],
];
cover_height = 130; // the height of the cover 
cover_overlap = 30; // how much the cover fits onto bottom 
print_numbers = false; // printing numbers on the cover


/*
// these are test settings in case you want to run a small print first
all = // all the diameters of drill bits 
[
[12,10],
[10,8],
];
cover_height = 130; // the height of the cover 
cover_overlap = 30; // how much the cover fits onto bottom  
*/

// set to true if you want to see hows it looks inside
vivisect = false; 

ny = len(all);    // number of columns in the grid 
nx = max([ for (i = [0 : 1 : len(all) - 1]) max(len(all[i])) ]);    // number of rows in the grid 
maxD = max([ for (i = [0 : 1 : len(all) - 1]) max(all[i]) ]);       // max diameter
xstep = 2.80;  // step in the grid on columns
ystep = 2.0;  // step in the grid on rows
brim = 2.0;
cover_cut = 1.6;
coverLettersDepth = 1;
clearance = 0.3; // clearance in holes
cover_clearance = 0.5; // clearance of cover (how tight cover fits)
wall_width = 2.4; 

width = brim * 2 + nx * (maxD + clearance * 2.0 + xstep);
depth = brim * 2 + ny * (maxD + clearance * 2.0 + ystep);
height = maxD * 5 + brim; 

text_size = maxD * 0.5; 
text_circle_r1 = maxD / 2 + 1; 
text_circle_r2 = maxD / 2; 


module BoxAndCover()
{
    difference()
    {
        union()
        {
            difference()
            {
                cube([width,depth,height - cover_overlap],false);
                translate([wall_width + cover_clearance, wall_width + cover_clearance, wall_width])
                    cube([width - wall_width * 2 - cover_clearance * 2,depth - wall_width * 2 - cover_clearance * 2, height - cover_overlap - wall_width + 0.02],false);

                }
            
            translate([cover_cut + cover_clearance * 2,cover_cut + cover_clearance,height - cover_overlap - wall_width])
                difference()
                {
                    cube([width - (cover_cut + cover_clearance) * 2, depth - (cover_cut + cover_clearance) * 2, cover_overlap + wall_width],false);
                    translate([wall_width, wall_width, -0.02])
                        cube([width - (cover_cut + cover_clearance) * 2 - wall_width * 2, depth - (cover_cut + cover_clearance) * 2 - wall_width * 2,cover_overlap - wall_width],false);
                }
            for(i = [0:nx-1])
            {
                for(j = [0:ny-1])
                {
                    y = brim + (maxD + clearance * 2.0 + ystep) * j;
                    x = brim + (maxD + clearance * 2.0 + xstep) * i;
                    
                    holeD = all[j][i];
                    hh = holeD * 5.0;
                    rr = holeD / 2.0;
                    translate([x + (maxD + clearance * 2.0 + xstep) / 2, y + (maxD + clearance * 2.0 + ystep) / 2,  0])
                    {
                        difference()
                        {
                            translate([0, 0,  height / 2  + 1])
                                cylinder(h = height, r = rr + clearance + 0.8, center = true, $fn = 18);
                            translate([0, 0,  height - hh / 2  + 1.02])
                                cylinder(h = hh + 0.02, r = rr + clearance, center = true, $fn = 18);
                        }
                    }
                }
            }
        }
        union()
        {
            for(i = [0:nx-1])
            {
                for(j = [0:ny-1])
                {
                    y = brim + (maxD + clearance * 2.0 + ystep) * j;
                    x = brim + (maxD + clearance * 2.0 + xstep) * i;
                    
                    holeD = all[j][i];
                    hh = holeD * 5.0;
                    rr = holeD / 2.0;
                    translate([x + (maxD + clearance * 2.0 + xstep) / 2, y + (maxD + clearance * 2.0 + ystep) / 2,  0])
                    {
                            translate([0, 0,  height - hh / 2  + 0.04])
                                cylinder(h = hh + 0.02, r = rr + clearance, center = true, $fn = 18);
                    }
                }
            }
        }
    }

    translate([0,depth + 10,0])
        difference()
        {
            cube([width,depth,cover_height],false);
            translate([cover_cut, cover_cut, brim + coverLettersDepth])
                cube([width - cover_cut * 2,depth - cover_cut * 2,cover_height],false);
            if (print_numbers)
            for(i = [0:nx-1])
            {
                for(j = [0:ny-1])
                {
                    y = brim + ystep / 2 + maxD / 2 + (maxD + clearance * 2.0 + ystep) * j;
                    x = brim + xstep / 2 + maxD / 2 + (maxD + clearance * 2.0 + xstep) * i;
                    
                    holeD = all[ny - j - 1][i];
                    translate([x, y + text_size / 2, -0.02])
                    {
                        linear_extrude(coverLettersDepth)
                            rotate([180,0,0])
                                text(str(holeD), size = text_size, font = "Liberation Sans", halign = "center", $fn = 18);
                        translate([0, -text_size / 2, +coverLettersDepth/2])
                        difference()
                        {
                            cylinder(h = coverLettersDepth, r = text_circle_r1,  center = true, $fn = 18);
                            cylinder(h = coverLettersDepth, r = text_circle_r2,  center = true, $fn = 18);
                        }
                        
                    }
                }
            }
        }
}
 
difference()
{
    BoxAndCover();
    if (vivisect)
        cube([16, 1000, 1000], center = true);
}
        