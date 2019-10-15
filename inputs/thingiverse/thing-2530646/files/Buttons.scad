//Buttons to be generated. Add any number of "O"s and/or "I"s, part will be scaled accordingly.
buttons = "OOI";

// Height of the enclosure. Enclosure ensures that the exposed cable heads are out of reach.
enclosure_height = 25;

// Thickness of the enclosure. This part will not bear any force, thus it can be quite thin.
enclosure_thickness = 0.8;

// Clearance around the parts. Depends on the machine, generally, 0.25 is extremely tight fit, 0.5 will be movable.
clearance = 0.3;

// Spacing between buttons. If you are having trouble fitting cabling, try increasing this.
spacing = 2.5;

// Thickness of the place that this part will be snapped. Acrylic frame of M505 is 7.5mm.
host_thickness = 7.5;

// Thickness of the front panel. Should be strong enough to withstand pressure while pressing the buttons.
front_thickness = 2;

// Thickness of the support parts that snaps to the host. Should be strong enough to withstand pressure while pressing the buttons. Making this value multiple of extrusion width is a good idea.
support_thickness = 1.6;

// Height of the support parts that snaps to the host. If the panel is trying to turn while pressing the button, increase this height. It should be larger than the host_thickness for best effect.
support_height = 10;

// Width of the side supports. Spacing between supports allows panel to be placed junctions.
support_sides = 5;

// Width of the middle support. Spacing between supports allows panel to be placed junctions.
support_middle = 30;


/* [Advanced] */
// Diameter of the O buttons
o_size = 23.3;

// Diameter of the O buttons
o_space = 21;


// Width of the rectangular buttons
i_width = 14.85;

// Height of the rectangular buttons
i_height = 20.9;

// Width of the rectangular buttons
i_space_width = 12.2;

// Height of the rectangular buttons
i_space_height = 19.5;


/* [Hidden] */

function sumsize(vec, n) = 
    len(vec)-1 == n ? 
        (vec[n] == "O" ? o_size : i_height) : 
        sumsize(vec, n+1) + spacing + (vec[n] == "O" ? o_size : i_height) 
;

function has_o(vec, n) = 
    len(vec)-1 == n ? 
        (vec[n] == "O" ? 1 : 0) : 
        (has_o(vec, n+1) ? 1 : (vec[n] == "O" ? 1 : 0)) 
;

function offset_until(vec, c, n) = 
    c == n ?
        spacing :
        offset_until(vec, c+1, n) + (vec[c] == "O" ? o_size : i_height) + spacing
;

depth = sumsize(buttons, 0) + spacing*2;

support_space = (depth - support_middle - support_sides*2)/2;

support_offset = host_thickness + clearance * 2;

haso = has_o(buttons, 0);

width = (haso ? o_size : i_width) + spacing * 2 + support_offset;
    
module clip() {
    cube([width, depth, front_thickness]);

    cube([support_thickness, support_sides, support_height]);
    
    translate([0, support_space + support_sides])
    cube([support_thickness, support_middle, support_height]);    
    
    translate([0, support_space*2 + support_sides+support_middle])
    cube([support_thickness, support_sides, support_height]);

    translate([support_offset, 0])
    cube([support_thickness, support_sides, support_height]);
    
    translate([support_offset, support_space + support_sides])
    cube([support_thickness, support_middle, support_height]);   
    
    translate([support_offset, support_space*2 + support_sides+support_middle])
    cube([support_thickness, support_sides, support_height]);    
    
    //walls
    translate([support_offset, 0])
    cube([width - support_offset, enclosure_thickness, enclosure_height]);
    
    translate([width-enclosure_thickness,0])
    cube([enclosure_thickness, depth, enclosure_height]);
    
    translate([support_offset, depth - enclosure_thickness])
    cube([width - support_offset, enclosure_thickness, enclosure_height]);
}

module round_button() {
    translate([o_size/2 - clearance, o_size/2 - clearance])
    cylinder(r=o_space/2 + clearance, h=enclosure_height+1, $fn=48);

    /*color(red)
    translate([23.3/2 ,23.3/2])
    #cylinder(r=23.3/2, h=25);*/

}

module button() {
    translate([(i_width - i_space_width - clearance * 2)/2, (i_height - i_space_height - clearance * 2)/2])
    cube([i_space_width + clearance * 2, i_space_height + clearance * 2, enclosure_height+1]);

    /*color(red)
    #cube([14.85, 20.9, 25]);*/
}

module all() {
    difference() {
        clip();
        
        for(b = [0:len(buttons)-1]) {
            if(buttons[b] == "O") {
                translate([support_offset + spacing, offset_until(buttons, 0, b), -0.1])
                round_button();
            }
            else {
                translate([support_offset + spacing + (haso ? (o_size-i_width)/2 : 0), offset_until(buttons, 0, b), -0.1])
                button();
            }
            
            echo(offset_until(buttons, 0, b));
        }
    }
}

rotate([0,0,90])
all();