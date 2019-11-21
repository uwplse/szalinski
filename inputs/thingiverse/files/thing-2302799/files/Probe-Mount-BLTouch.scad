// Proximity Sensor mount by ChiefSwiftNick 01/07/2016
// Feel free to reuse, tweak and learn from my design
// But dont charge for it!

// Distance from top of bracket to nozzle tip 70mm
// Probe length retracted = 42.0 mm
// Probe length deployed  = 46.5 mm
// retracted clearance    = 2mm
// Bracket length = 70mm - 42 mm - 2 mm  = 26mm 

$fn=40;

// Tweak the probe height here (mm)
probe_height_adjustment = 0;

// Mount holes 1 or 2
mount_holes = 1;

rotate([180,0,0])difference()
{
    body();  
    holes();
}

module body()
{
    minkowski()
    {
      curved_body();
      sphere(1);
    }
    translate([-2,-1,0])cube([2,32,14]); 
    translate([-3,-1,0])cube([1,32,12]); 
}

module curved_body()
{
    bracket_body();
    probe_mount_body();
}

module holes()
{
    bracket_holes();
    probe_mount_holes();
}

module bracket_body()
{
   cube([3,30,14]); 
   rotate([90,90,0])translate([-probe_height_adjustment-21,3,-15])fillet(5,30); 
    
}
module bracket_holes()
{
    // Mouting holes
    if(mount_holes == 2)
    {
      rotate([0,90,0])translate([-6,6,2])cylinder(h=10,d=6, center = true);
      rotate([0,90,0])translate([-6,24,2])cylinder(h=10,d=6, center = true);
    }
    else
    {
      rotate([0,90,0])translate([-6,15,2])cylinder(h=10,d=6, center = true);
    }
}


module probe_mount_body()
{
    translate([0,0,14])cube([3,30,11+probe_height_adjustment]);
    translate([0,0,probe_height_adjustment+21])cube([20,30,5]);
}
module probe_mount_holes()
{
    translate([14,6,probe_height_adjustment+19])cylinder(d=3.2,h=10);
    translate([14,6,probe_height_adjustment+20])hexagon(5.3,1,2);
    
    translate([14,15,probe_height_adjustment+19])cylinder(d=5,h=10);
    
    translate([14,24,probe_height_adjustment+19])cylinder(d=3.2,h=10);
    translate([14,24,probe_height_adjustment+20])hexagon(5.3,1,2);
}


// Hexagonal polygon 
// Credit to Chris Bate
// https://www.youtube.com/watch?v=KAKEk1falNg
module hexagon(wid,rad,height)
{
    hull()
    {
        translate([wid/2-rad,0,0])cylinder(r=rad,h=height); 
        rotate([0,0,60])translate([wid/2-rad,0,0])cylinder(r=rad,h=height); 
        rotate([0,0,120])translate([wid/2-rad,0,0])cylinder(r=rad,h=height); 
        rotate([0,0,180])translate([wid/2-rad,0,0])cylinder(r=rad,h=height); 
        rotate([0,0,240])translate([wid/2-rad,0,0])cylinder(r=rad,h=height); 
        rotate([0,0,300])translate([wid/2-rad,0,0])cylinder(r=rad,h=height); 
    }
}

module fillet(r, h) {
    translate([r / 2, r / 2, 0])

        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);

            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);

        }
}