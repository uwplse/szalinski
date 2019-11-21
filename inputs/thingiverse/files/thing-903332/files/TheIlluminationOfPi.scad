/*
The Illumination of Pi
Copyright (C) 2015 Marcio Teixeira

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

/* [Global] */

// Select preview to see the cup and illumination pattern. Use "printable_object" to render an object to print. Due to the complexity of the object, the preview may have strange artifacts.
what_to_render         = "preview"; // [preview, preview_with_rays, just_the_illumination, printable_cup, printable_lid]

/* [Cup] */
cup_height           = 50;
cup_diameter         = 100;
cup_wall_thickness   = 3;
cup_bottom_thickness = 3;

/* [Lid] */
lid_taper_height     = 10;
lid_taper_percent    = 0.5; // [0:0.1:1]
lid_rim_height       = 10;
lid_wall_thickness   = 3;
lid_top_thickness    = 3;

// Diameter of screw used to secure the lid to the cup
screw_dia            = 2.66;

// Diameter of guide holes for wires
wire_dia             = 5;

/* [Spiral] */
number_of_turns      = 6;   // [1:10]
start_radius         = 70;
spiral_spacing       = 1.75; // [1:0.1:2]

// Fudge to make the numbers more equidistant on the spiral
squashing_factor     = 0.33; // [0:0.01:1]

/* [Digits] */

symbols = "3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679821480865132823066470938446095505822317253594081284811174502841027019385211055596446229489549303819644288109756659334461284756482337867831652712019091456485669234603486104543266482133936072602491412737245870066063155881748815209209628292540917153643678925903600113305305488204665213841469519415116094330572703657595919530921861173819326117931051185480744623799627495673518857527248912279381830119491298336733624406566430860213949463952247371907021798609437027705392171762931767523846748184676694051320005681271452635608277857713427577896091736371787214684409012249534301465495853710507922796892589235420199561121290219608640344181598136297747713099605187072113499999983729780499510597317328160963185950244594553469083026425223082533446850352619311881710100031378387528865875332083814206171776691473035982534904287554687311595628638823537875937519577818577805321712268066130019278766111959092164201989";

label = "Pi";

scale_digit          = 3.0;
// The gap between the segments of each digit
segment_gap            = 0.2;

/* [hidden] */
led_recess           = 0.25;

module segment(h,w,shrink=0.9) {
    translate([w*(1-shrink)/2,h*(1-shrink)/2])
    scale([shrink,shrink])
    polygon([
        [w/2,h],[w,h-w/2],[w,w/2],[w/2,0],[0,w/2],[0,h-w/2]]);
}

segment_lookup = [
//   0 1 2 3 4 5 6 7 8 9 . P i e E - C c ° A b d F H h J L n o q r t u V y _ ' \ " = ! [ ]
    [1,0,1,0,0,0,1,0,1,0,0,1,1,1,0,1,0,1,1,0,1,0,1,1,1,1,1,1,1,1,1,0,0,1,1,0,0,0,0,0,0,1,0], // Lower, left
    [1,1,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,0,1,1,1,0,1,1,0,1,1,1,1,1,0,0,0,0,0,0,1], // Lower, right
    [1,0,0,0,1,1,1,1,1,1,0,1,0,1,0,1,0,1,0,1,1,1,0,1,1,1,0,1,0,0,1,0,0,0,1,1,0,1,1,0,0,1,0], // Upper, left
    [1,1,1,1,1,0,0,1,1,1,0,1,0,1,0,0,0,0,0,1,1,0,1,0,1,0,1,0,0,0,1,0,1,0,1,1,0,0,1,0,1,0,1], // Upper, right
    [1,0,1,1,0,1,1,0,1,1,0,0,0,1,0,1,0,1,1,0,0,1,1,0,0,0,1,1,0,1,0,0,0,1,1,0,1,0,0,1,0,1,1], // Bottom
    [0,0,1,1,1,1,1,0,1,1,0,1,0,1,0,1,1,0,1,1,1,1,1,1,1,1,0,0,1,1,1,1,0,0,0,1,0,0,0,1,0,0,0], // Middle
    [1,0,1,1,0,1,1,1,1,1,0,1,0,1,0,1,0,1,0,1,1,0,0,1,0,0,0,0,0,0,1,0,1,0,0,1,0,0,0,0,0,1,1], // Top
    [0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0], // Period

];

module digit(d="8",h=3, w=1, gap = segment_gap ) {
    which = search(d, "0123456789.Pie E-Cc°AbdFHhJLnoqrtuVy_'\"=![]")[0];

    shrink = 1 - gap;
    
    // Lower, left
    if(segment_lookup[0][which])
    translate([0,0])
        segment(h,w,shrink);
    
    // Lower, right
    if(segment_lookup[1][which])
    translate([h,0])
        segment(h,w,shrink);
    
    // Upper, left
    if(segment_lookup[2][which])
    translate([0,h])
        segment(h,w,shrink);
    
    // Upper,   ght
    if(segment_lookup[3][which])
    translate([h,h])
        segment(h,w,shrink);
    
    rotate([0,0,-90]) {
        // Bottom
        if(segment_lookup[4][which])
        translate([-w/2,w/2])
            segment(h,w,shrink);
        
        // Middle
        if(segment_lookup[5][which])
        translate([-w/2 - h,w/2])
            segment(h,w,shrink);
        
        // Upper
        if(segment_lookup[6][which])
        translate([-w/2 - 2*h,w/2])
            segment(h,w,shrink);
    }
    
    // Period
    if(segment_lookup[7][which])
        translate([h+w,-w/2])
            square(size = [w/1.4,w/1.4]);
}

segment_h = 3 * scale_digit;
segment_w = 1 * scale_digit;
digit_h   = 8 * scale_digit;
digit_w   = 5 * scale_digit;

function linear(x, end_x, start_y, end_y) = start_y * (1-x/end_x) + end_y * (x/end_x);

// The following is the cumulative sum of the function linear, computed with wolfram alpha.

function sum_lin(x,end_x,start_y,end_y) = ((x+1)*(start_y*(2*end_x-x)+end_y*x))/(2*end_x);

module archimedean_spiral(innerRadius, outerRadius, nTurns, nPoints) {
    a           = innerRadius;
    totalSweep  = 360 * nTurns;
    b           = (outerRadius - innerRadius)/nTurns/360;
    delta_angle = totalSweep/nPoints;
    
    for($i = [0:nPoints]) {
        
        angle = sum_lin($i, nPoints, delta_angle, delta_angle*squashing_factor);
        r = a + b * angle;
        
        translate([r*cos(angle),r*sin(angle)])
            rotate([0,0,angle+90])
                children();
    }
}

module extrude_to_point(p, plane_z, preview = false) {
    translate([p[0], p[1], plane_z])
        linear_extrude(height = preview ? 0.01 : (p[2] - plane_z), scale = preview ? 1 : 0.0001)
            translate([-p[0], -p[1], 0])
                children();
}

module inscribe_in_a_spiral(str) {
    innerRadius = start_radius;
    outerRadius = innerRadius + number_of_turns * (digit_h * spiral_spacing);
    circ        = 2 * PI * number_of_turns * innerRadius;
    nPoints     = circ / digit_w;
    
    echo("innerRadius", innerRadius);
    echo("outerRadius", outerRadius);
    echo("nPoints", nPoints);

    rotate([0,0,-90])
        archimedean_spiral(innerRadius, outerRadius,
            number_of_turns, min(nPoints,len(str)))
                digit(str[$i], segment_h, segment_w);
}

/* Prints a string horizontally */
module inscribe_in_a_line(str, center=false) {
    translate(center == true ? [-digit_w*len(str)/2 + segment_w/2, -digit_h/2 +segment_w] : 0)
    for( i = [0:len(str)] ) {
        translate([5*scale_digit*i,0])
            digit(str[i], segment_h, segment_w);
    }
}

/* Bottle caps make for cheap heat sinks for LEDs */

bottle_cap_d1 = 30.9;
bottle_cap_d2 = 26.70;
bottle_cap_h  = 5.41;

module bottle_cap() {
    difference() {
        w = 0.3;
        cylinder(
            d2 = bottle_cap_d2,
            d1 = bottle_cap_d1,
            h  = bottle_cap_h
        );
        translate([0,0,-0.1])
            cylinder(
                d2 = bottle_cap_d2 - w,
                d1 = bottle_cap_d1 - w,
                h = bottle_cap_h - w
            );
    }
}

/* A hexagon with parallel sizes d units apart */
module hexagon(d, nSides=6) {
    w = (d/2)*tan(360/(nSides*2))*2;
    for( a = [0:360/nSides:360] ) {
        rotate([0,0,a])
            square([d,w],center=true);
    }
}

/* An 20mm LED star with the emitter at the origin,
 * optionally w/ a heat sink */

led_diameter        = 20;
led_emitter_to_base = 4;

module led_star_profile() {
    hexagon(led_diameter);
}

module led_star(heat_sink = false) {
    translate([0,0,-led_emitter_to_base]) {
        if(heat_sink)
            color("gray", 0.25)
                mirror([0,0,1])
                    bottle_cap();
        linear_extrude(1.4)
            led_star_profile();
        cylinder(d = 8, h = led_emitter_to_base);
    }
    sphere(d = 5.5);
}

module lid_of_pi(clearance = 1.0) {
    translate([0,0,-lid_rim_height - clearance])
    difference() {
        lid_inner_diameter = cup_diameter + clearance*2;
        lid_outer_diameter = lid_inner_diameter + lid_wall_thickness * 2;
        
        rim_total_h = lid_rim_height + clearance + lid_wall_thickness;
        
        union() {
            // Crown piece
            translate([0,0, rim_total_h])
            cylinder(
                d2 = lid_outer_diameter * lid_taper_percent,
                d1 = lid_outer_diameter - 10,
                h = lid_taper_height);
            
            // Rim portion
            cylinder(
                d = lid_outer_diameter,
                h = rim_total_h);
        }
        
        
        // Cut out the insides
        
        translate([0,0,-0.1])
            cylinder(
                d = lid_inner_diameter,
                h = lid_rim_height + clearance
            );
        
        lid_holes();
        
        // Hole for wires
        
        for(dx=[-led_diameter/2, led_diameter/2])
            hull() {
                translate([0,0,rim_total_h+lid_taper_height])
                    cylinder(d=wire_dia);
                translate([dx,0,lid_rim_height])
                    cylinder(d=wire_dia);
            }
            
        // Outline for LED
        linear_extrude(led_recess)
            hexagon(led_diameter+1);
    }
}

/* Since the LED sits on the lid, it always sits on the height,
 * of the cup.
 */
led_height           = cup_height - led_emitter_to_base + led_recess;

// Screw holes for the lid

module lid_holes() {
    translate([0,0, lid_rim_height/2])
        rotate([0,90,0])
            cylinder(d = screw_dia, h = cup_diameter + 10, center = true);
}

module cup_of_pi() {
    difference() {

        cylinder(d = cup_diameter, h = cup_height);
            
        // Cut out the screw holes
        translate([0,0,cup_height - lid_rim_height])
            lid_holes();
        
        // Cut out the insides
        translate([0,0,cup_bottom_thickness])
            cylinder(
                d = cup_diameter - cup_wall_thickness * 2,
                h = cup_height
            );
    }
}

module desired_shadow() {
    scale_factor = cup_diameter/(digit_w*len(label));
    
    inscribe_in_a_spiral(symbols);
    
    scale([scale_factor,scale_factor])
        translate([(label[len(label)-1] == "i" ? digit_w/4 : 0),0,0])
                inscribe_in_a_line(label, center = true);
}

module ray_volume(preview = false) {
    extrude_to_point([0,0,led_height], -0.1, preview)
        desired_shadow();
}

raise_lid_by = 2;

module illumination_of_pie() {
    
    if(what_to_render == "preview" ||
       what_to_render == "preview_with_rays" ||
       what_to_render == "printable_cup")
        difference() {
            cup_of_pi();

            // Cut out the illumination cones
            ray_volume(preview = false);
        }

    if(what_to_render == "preview" ||
       what_to_render == "preview_with_rays") {
        // The LED
        translate([0,0, cup_height * raise_lid_by - led_emitter_to_base])
            mirror([0,0,1])
                led_star(heat_sink=false);
       
        // The shadow
        color("red",0.5)
            ray_volume(what_to_render == "preview");
    }
    
    if( what_to_render == "preview" ||
        what_to_render == "preview_with_rays" ||
        what_to_render == "printable_lid") {
            
        translate([0,0,cup_height * raise_lid_by])
            lid_of_pi();
    }
    
    if( what_to_render == "just_the_illumination" ) {
        desired_shadow();
    }
    
}

illumination_of_pie();