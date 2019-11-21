// Cartridge Radius (.38 = 4.85)
radius = 4.85; // (Diameter+0.05 clearance)/2

// Cartridge Count
ccount = 6; // [5-7]

// Spacing between cartridges
cspacing = 2; // [1.8-2.8]

// Tray Height
height = 18; // [12:35]

// Grouping Count - Wide
wgroupings = 4; // [1:4]

// Grouping Count - Deep
dgroupings = 4; // [1:4]

// Spacing between clusters
spacing = radius*6; // [5:10]

// Tray bottom thickness
base = 2;

// Outer Corner Radius
outRadius = 2;

// Font Size
fontsize = 6;

// Font -- You can use a local font if you want
font = "Liberation Sans";

// Inset Text
content = "Rhino .357 Magnum/.38 Special";

// Text Spacing -- 1.0 is normal
tspacing = 0.9;

// -- Rookie Line - Stay above this unless you know what you're doing --
module tray(width) {
    clusterSize = radius * 2;
    width = (clusterSize + spacing) * wgroupings + spacing * 2;
    depth = (clusterSize + spacing) * dgroupings + spacing * 2;
    xstart = -width/2 + spacing * 1.5 + clusterSize/2;
    ystart = -depth/2 + spacing * 1.5 + clusterSize/2;
    
    difference () {
        hull ()
        for (x=[-width/2 + outRadius, width/2 - outRadius])
        for (y=[-depth/2 + outRadius, depth/2 - outRadius])
            translate([0,0,(height+base)/2]) {
              union () {
              cube([radius*6.4*wgroupings, radius*7*dgroupings,height+base],true);
                    translate ([radius*4*wgroupings,radius*4*dgroupings,0]) {
                        cylinder(height+base, radius*1, radius*1, center=true, $fn=36);
                    }
                    translate ([-radius*4*wgroupings,radius*4*dgroupings,0]) {
                        cylinder(height+base, radius*1, radius*1, center=true, $fn=36);
                    }
                    translate ([radius*4*wgroupings,-radius*4*dgroupings,0]) {
                        cylinder(height+base, radius*1, radius*1, center=true, $fn=36);
                    }
                    translate ([-radius*4*wgroupings,-radius*4*dgroupings,0]) {
                        cylinder(height+base, radius*1, radius*1, center=true, $fn=36);
                    }
                }
            }
            translate([0,0,0]) {
                for (x=[0:1:wgroupings-1])
                for (y=[0:1:dgroupings-1]) {
                    translate([xstart + (clusterSize + spacing)*x,
                        ystart + (clusterSize + spacing)*y,0]) {
                            cluster(radius, height);
                        }
                }
            }
    }
}
module cluster() {
    translate([0,0,0]) {
       for (i=[0:ccount-1]) {
           rotate([0,0,i*360/ccount])
           translate([radius+cspacing*3.5,0,base])
           #cylinder(height,radius,radius, $fn=36);
       }
   }
}
module t() {
    translate([0,0,1]) {
        rotate ([0,180,0]) {
            linear_extrude(height = 1) {
                text(content, font = font, size = fontsize, halign="center", valign="center", spacing = tspacing);
            }
        }
    }
}
difference() {
    tray();
    #t();
}