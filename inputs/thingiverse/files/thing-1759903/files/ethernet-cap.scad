// Ethernet plug cap generator
// All values are in millimetres (mm)
// By gammy
// Thanks Koen Tavernier for showing me how to "get rid" of modulo operations! :)

// Switch properties
plug_spacing = 4.2; // Standard ethernet port spacing
num_plugs = 8;

// My switch consists of 2 modules of 4 ports each.
// There is therefore an additional space between each module
module_padding_every = 4;
padding_module = 4;

// Cover properties
thickness = 1.5;
padding_top = 10;
padding_bottom = 7;
padding_left = 7;
padding_right = 7;

// 8P8C plug dimensions (don't change these)
plug_w = 11.5;
plug_h = 6.5;
plug_d = 10;

module renderPlug() {
    wall_thickness = 1.5;
    difference() {
        cube([plug_w, plug_h, plug_d]);        
        cavity_w = plug_w - wall_thickness;
        cavity_h = plug_h;
        cx = (.5 * plug_w) - (.5 * cavity_w);        
        translate([cx, (.5 * wall_thickness), 0]) {
            cube([cavity_w, cavity_h + 1, plug_d]);
        }
    }
}

module renderPlugs(count, spacing) {    
    for(i = [1 : count]) {        
        offset = (i - 1) 
            * (plug_w + spacing) 
            + (round((i + 1) / module_padding_every) - 1) 
            * padding_module;
        
        translate([offset, 0, 0]) {
            renderPlug();
        }
    }
}

module renderPlate(count, spacing) {
    plate_plug_w = (num_plugs * (plug_w + plug_spacing)) - plug_spacing;    
    more = (round(num_plugs / module_padding_every) - 1) * padding_module;
    plate_w = padding_left + plate_plug_w + padding_right;
    plate_h = padding_bottom + plug_h + padding_top;
    translate([-padding_right, -padding_bottom, -thickness]) {
        cube([plate_w + more, plate_h, thickness]);
    }
}

renderPlate(num_plugs, plug_spacing);
renderPlugs(num_plugs, plug_spacing);