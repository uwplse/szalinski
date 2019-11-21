// SCAD model SIMATIC_IoT_2000_2020_2040_left_lid_cover_parametric, http://www.thingiverse.com/thing:2250534
// copyright (c) 2017 by Michael Dreher <michael(a)5dot1.de> is licensed under the Creative Commons - Attribution - Non-Commercial - Share Alike license. http://creativecommons.org/licenses/by-nc-nd/3.0/
// note for me: look at http://customizer.makerbot.com/docs for defining customizable parameters

// extra height for the top perimeter, should be a multiple of 0.2
topExtraHeight = 0; // [0:0.2:100]

// thickness of the top perimeter
topThickness = 2.1; // [0.6:0.2:5]

// thickness of the other perimeters
thickness = 1.8; // [1.2:0.1:3.9]

// if you want a hole for the MH-Z19 CO2 sensor in the top perimeter
withMHZ19SensorHole = 0; // [0:no, 1:top, 2:back, 3:front]

// if you want a hole for the Nokia 5110 LCD or a QVGA TFT display
withDisplay = 0; // [0:no_display, 1:Nokia5110, 2:QVGA]

// if you want a hole for a cable at the front.
withCableHole = 0; // [0:no, 1:yes]

// stop the parametric parser
if(0) {}

// my parameters
//topExtraHeight = 28; topThickness = 2.1; thickness = 1.8; withMHZ19SensorHole = 3; withDisplay = 2; withCableHole = 1;

module Triangle(x, h, overlap, thick)
{
    rotate([0, 90, 0])
    translate([-overlap, overlap, -thick / 2])
    linear_extrude(height = thick)
    polygon(points=[[0, 0], [h + overlap, 0], [h + overlap, -overlap], [overlap, -(x + overlap)], [0, -(x + overlap)]]);
}

module Tongue(x, y, z, thick, supportThick, supportCount=2)
{
    translate([-x/2, -y, -thick]) cube([x, y + overlap, thick]);

    if(supportCount < 2) {
        supportCount = 2;     
    }
    for (i = [0:supportCount - 1]) {
        sx = -(x - supportThick)/2 + i * (x - supportThick) / (supportCount - 1);  
        translate([sx, 0, -thick]) Triangle(y, z - thick, overlap, supportThick);
    }      
}

// the support has the whole width
module TongueSmall(x, y, z, thick)
{
    Tongue(x, y, z, thick, x/2 + overlap, 2);
}

module TongueBig(x, y, z, thick)
{
    Tongue(x, y, z, thick, thick, 4);
}

// originally taken from here: http://www.thingiverse.com/thing:9347
module roundedCube(size, radius)
{
    x = size[0];
    y = size[1];
    z = size[2];

    linear_extrude(height = z)
    hull()
    {
        // place 4 circles in the corners, with the given radius
        translate([radius, radius, 0])         circle(r = radius);
        translate([x - radius, radius, 0])     circle(r = radius);
        translate([radius, y - radius, 0])     circle(r = radius);
        translate([x - radius, y - radius, 0]) circle(r = radius);
    }
}

module Nokia_LCD_5110(thick = 5.1, sink = 0.8)
{
    // hole for the sensor
    center = true;
    top_corner_radius = 3.5;
    top_x = 36.4;
    top_y = 26.2;
    inner_x = 40.5;
    inner_y = 34.2;
    inner_y_dist = 1.4;
    pcb_x = 45.3;
    pcb_y = 45.3;
    pcb_z = 1.2;
    pcb_z_dist = 3.8;
    pcb_y_dist = inner_y_dist + 6;
    //y_dist = (inner_y - top_y) - 1.4;

    translate([center ? -top_x / 2 : 0, center ? -top_y / 2 : 0, 0])
    union()
    {
        //translate([0, 0, -(thick + o)]) cube([top_x, top_y, thick + 2*o]);
        translate([0, 0, -(thick + o)]) roundedCube([top_x, top_y, thick + 2*o], top_corner_radius); // rounded corners
        translate([-(inner_x - top_x) / 2, -inner_y_dist, -(thick + o)]) cube([inner_x, inner_y, thick - sink + o]);
        translate([-(pcb_x - top_x) / 2, -pcb_y_dist, -(pcb_z_dist + pcb_z)]) cube([pcb_x, pcb_y, pcb_z]);
    }
}

module QVGA_TFT(thick = 7.3, sink = 0.8)
{
    // hole for the sensor
    center = true;
    top_corner_radius = 1;
    top_x = 49 - 2;
    top_y = 37 - 2;
    inner_x = 55.4+0.4;
    inner_y = 40.2+0.2;
    inner_x_dist = 5.4 + 1;
    pcb_x = 67.5+0.2;
    pcb_y = 40.5+0.2;
    pcb_z = 1.7;
    pcb_z_dist = 2.6;
    pcb_x_dist = inner_x_dist + 8;

    translate([center ? -top_x / 2 : 0, center ? -top_y / 2 : 0, 0])
    union()
    {
        //translate([0, 0, -(thick + o)]) cube([top_x, top_y, thick + 2*o]);
        translate([0, 0, -(thick + o)]) roundedCube([top_x, top_y, thick + 2*o], top_corner_radius); // rounded corners
        translate([-inner_x_dist, -(inner_y - top_y) / 2, -(thick + o)]) cube([inner_x, inner_y, thick - sink + o]);
        translate([-pcb_x_dist, -(pcb_y - top_y) / 2, -(pcb_z_dist + pcb_z)]) cube([pcb_x, pcb_y, pcb_z]);
    }
}

module Cable_hole(d, h)
{
    translate([0, 0, - h/2])
    union()
    {
        cylinder(d=d, h = h + 2 * o, center=true);
    }
}

module MHZ19SensorHole_orig()
{
    // hole for the sensor
    size = 50;         
    sensor_x = 26.7;
    sensor_y = 19.8; // changed from 19.6; printed value was 19.3 for long part and 19.5 on short part 
    sensorAdd_x = 4.5;
    sensorAdd_width = 11.5;
    sensorAdd_height = 19.9 + 8;
    translate([40, -size/2,20]) cube([sensor_x, size + topExtraHeight, sensor_y]);
    translate([40 + sensorAdd_x, -size/2,20 + sensorAdd_height - sensor_y]) cube([sensorAdd_width, size + topExtraHeight, sensor_y]);
}

module MHZ19SensorHole()
{
    // hole for the sensor
    size = thickness + bottomLandingDepth + 2 * o;         
    sensor_x = 26.7;
    sensor_y = 19.8; // changed from 19.6; printed value was 19.3 for long part and 19.5 on short part 
    sensorAdd_x = 4.5;
    sensorAdd_width = 11.5;
    sensorAdd_height = 19.9 + 8;
    translate([0, -size/2, 0]) cube([sensor_x, size, sensor_y]);
    translate([sensorAdd_x, -size/2, 0 + sensorAdd_height - sensor_y]) cube([sensorAdd_width, size, sensor_y]);
}

module IoT2000_LeftLidCover()
{
    difference()
    {
        union()
        {
            // outer cube
            translate([1.00, 0, 0]) cube([width, depth + topExtraHeight, height]);
        }     

        // remove inner cube
        translate([leftLandingPinHeight + bottomLandingDepth + thickness, -o, bottomLandingDepth + thickness])
            cube([width - 2*(bottomLandingDepth + thickness), depth + topExtraHeight - topThickness + o, height - 2*(thickness + bottomLandingDepth)]);

        if(withMHZ19SensorHole == 1)
        {
            MHZ19SensorHole_orig();
        }
        else if(withMHZ19SensorHole == 2)
        {
            translate([10, 8, (thickness + bottomLandingDepth)/2])
            rotate([-90, 0, 0])
            MHZ19SensorHole();
        }
        else if(withMHZ19SensorHole == 3)
        {
            translate([10 + 26.7, 8, height - (thickness + bottomLandingDepth) + (thickness + bottomLandingDepth)/2])
            rotate([-90, 180, 0])
            MHZ19SensorHole();
        }

        if(withDisplay == 1)
        {
            translate([width / 2, depth + topExtraHeight, height / 2])
            rotate([-90, 0, 0])
            Nokia_LCD_5110(topThickness, 1.1);
        }
        else if(withDisplay == 2)
        {
            translate([5 + (width / 2), depth + topExtraHeight, height / 2])
            rotate([-90, 0, 0])
            QVGA_TFT(topThickness, 1.1);
        }
        
        if(withCableHole == 1)
        {
            translate([45, 15, height])
            Cable_hole(5, thickness + bottomLandingDepth);
        }
        
        // left Landing
        translate([-o, -o, (height - leftLandingWidth) / 2 ]) cube([o + leftLandingPinHeight + leftLandingDepth, o + leftLandingHeight, leftLandingWidth]);

        // bottom Landing
        translate([leftLandingPinHeight - o, -o, -o ]) cube([bottomLandingDepth + o, bottomLandingHeight + o, height + 2 * o]); // left
        translate([leftLandingPinHeight + width - bottomLandingDepthRight, -o, -o ]) cube([bottomLandingDepthRight + o, bottomLandingHeight + o, height + 2 * o]); // right; TODO: original is not using 90° but around 70° here
        translate([leftLandingPinHeight - o, -o, height - bottomLandingDepth]) cube([width + 2 * o, bottomLandingHeight + o, bottomLandingDepth + o]); // front
        translate([leftLandingPinHeight - o, -o, -o]) cube([width + 2 * o, bottomLandingHeight + o, bottomLandingDepth + o]); // back

        // right corner landing
        right_land_depth_min = 2.2 + 0.2;
        right_land_wid = 5.8 + 0.2;
        right_land_hei = 2 + 0.2;
        right_land_depth = max(thickness + bottomLandingDepth + overlap, right_land_depth_min);
        translate([leftLandingPinHeight + width - right_land_depth, bottomLandingHeight - o, -o]) cube([right_land_depth + o, right_land_hei + o, right_land_wid + o]);
    }
  
    // left pins
    translate([                   0, 9, (height - leftLandingWidthMid) / 2 - leftLandingPinWidth])
        cube([leftLandingPinHeight + leftLandingDepth + overlap, leftLandingPinDepth, leftLandingPinWidth]);
    translate([leftLandingPinHeight, 9 + leftLandingPinDepth - overlap, (height + leftLandingWidthMid) / 2                      ])
        cube([leftLandingDepth + overlap, 2 * overlap, leftLandingPinWidth]); // Y-overlap
    translate([                   0, 9, (height + leftLandingWidthMid) / 2                      ])                                 
        cube([leftLandingPinHeight + leftLandingDepth + overlap, leftLandingPinDepth, leftLandingPinWidth]);
    translate([leftLandingPinHeight, 9 + leftLandingPinDepth - overlap, (height - leftLandingWidthMid) / 2 - leftLandingPinWidth])
        cube([leftLandingDepth + overlap, 2 * overlap, leftLandingPinWidth]); // Y-overlap

    // tongue front
    translate([71.8, 1.8, height - bottomLandingDepth]) rotate([-90, 0, 0]) TongueSmall(3.6, 1, 1.8, 0.2);
    //translate([71.8, 1.8-0.1, height - bottomLandingDepth]) rotate([-90, 0, 180]) TongueSmall(3.6, 1, 1, 0.2);

    // tongue back
    translate([71.8, 1.8, bottomLandingDepth]) rotate([-90, 180, 0]) TongueSmall(3.6, 1, 1.8, 0.2);
    //translate([71.8, 1.8-0.1, bottomLandingDepth]) rotate([-90, 180, 180]) TongueSmall(3.6, 1, 1, 0.2);

    // tongue right
    translate([leftLandingPinHeight + width , 10, height/2]) rotate([-90, 90, 0]) TongueBig(26, 5, 4.5, 2);
}

// resolution
$fn = 100; // [50:medium, 100: high]
o = 1; // used to avoid edge collision when cutting material away
overlap = 0.1; // used to avoid edge collision when merging modules

height = 59.8;
width = 83.8;
depth = 12 - 0.1; // first layer is 0.3, all others are 0.2, so 12.0 is a number

// the landing on the left side
leftLandingPinWidth = 3.9;
leftLandingPinDepth = 1.2;
leftLandingPinHeight = 1;
leftLandingWidth = 42.8;
leftLandingHeight = 10.2;
leftLandingWidthMid = 22;
leftLandingWidthSide = (leftLandingWidth - leftLandingWidthMid - 2*leftLandingPinWidth) / 2;
leftLandingDepth = 1;

// the landings around on the bottom
bottomLandingHeight = 4.7;
bottomLandingDepth = 1;
bottomLandingDepthRight = 5;

IoT2000_LeftLidCover();

