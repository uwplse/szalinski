/*

Parametric Print+ Headphones: Mendel Edition
Version 1.1

(Changes to v1.1 (posted February 13, 2018): Fixed customizer formatting, added "Rounded Pattern" option to cups)

Housings and headband designed for the Print+ Headphone kit (http://print.plus), based on their original designs for the headphone housings.

Designed by Michael Jones using OpenSCAD v2015.03-2
Originally Published on http://www.thingiverse.com on November 24, 2017 with a CC BY licence

Thanks for checking out my code! ^_^

*/

/* [General] */

// Render the cup?
show_cup = 1; // [1:Yes,0:No]

// Render the cushion holder?
show_cushion_holder = 0; // [1:Yes,0:No]

// Render the headband? (For the time being will not render on its own)
show_band = 0; // [1:Yes,0:No]

/* [Threaded Rod] */
// Diameter of the threaded rod (in mm)
threaded_rod_diameter = 6.3;

// Width of the threaded rod nut (flat side to flat side) (in mm)
nut_width = 11;

// Thickness of the nut (in mm)
nut_thickness = 5;

/* [Cups] */
// Overall design of the cups
cup_type = 1; // [1:Low Poly,2:Retro,3:Pattern,4:Round Pattern]

// Left cup or right cup?
left_cup = 1; // [1:Left,0:Right]

// Generate supports for the cup?
cup_support = 1; // [1:Yes,0:No]

// Include a cutout for a nut in the housing? Otherwise can hold as a friction fit. (Highly recommended to disable this for Pattern cups!)
cup_nut_trap = 1; // [1:Yes,0:No]

// Draw your shape!
pattern_polygon = [[[-1.00,-14.00],[1.00,-14.00],[1.00,-7.00],[8.00,-9.00],[6.00,-5.00],[13.00,-1.00],[11.00,0.00],[13.00,5.00],[9.00,4.00],[8.00,6.00],[4.00,2.00],[6.00,11.00],[3.00,9.00],[0.00,14.00],[-3.00,9.00],[-6.00,11.00],[-4.00,2.00],[-8.00,6.00],[-9.00,4.00],[-13.00,5.00],[-11.00,0.00],[-13.00,-1.00],[-6.00,-5.00],[-8.00,-9.00],[-1.00,-7.00]],[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]]; // [draw_polygon:100x100]
                    

/* [Headband] */

// Inner diameter of the headband (in mm, 160 mm is a good size for a typical adult)
band_diameter = 160; // [100:1:200]

// Angle of the cups inward (a larger angle = a tighter pinch, will probably need to adjust this if your head is a lot wider than the default 160 mm)
band_angle = 25; // [10:1:45]

// Exit of the stereo wire on the side (like the original Print+) or on the front?
band_exit = 1; // [1:Front,0:Side]

// What kind of bevels on the rod connector?
connector_bevel_type = 2; // [0:None,1:Top Only,2:Top & Front,3:All Sides]


/* [Advanced Options] */

// How much room for error? (A little bit is strongly recommended)
tolerance = 0.25; // [0:0.05:0.4]

// For Low-Poly cups: Number of sides on the outer part of the cup?
cup_outer_segments = 7; // [5:1:12]

// For Low-Poly cups: Number of sides on the top section of the cup?
cup_inner_segments = 4; // [3:1:10]

// For Low-Poly cups: make the top pointy instead of flat? (Will block the nut trap if you have it active)
show_cap = 0; // [1:Yes,2:No]

// For Retro and Pattern cups: how big is the bevel (in mm)? (Set to zero for unbeveled corners)
cup_bevel = 2; // [0:0.05:4]

// For Retro and Pattern cups: flat or rounded bevel?
bevel_type = 0; // [0:Flat,1:Rounded]

// For Pattern cups: is the pattern embossed or raised?
pattern_type = 1; // [0:Embossed,1:Raised]

// For Pattern cups: how deep/tall is the pattern (in mm)?
pattern_depth = 1.5; // [1:0.05:5]

// For Pattern cups: size of empty "border" around pattern, to side of cup (in mm)
pattern_border = 0; // [0:1:25]

// For Pattern cups: rotate your pattern (in degrees)
pattern_rotate = 0; // [0:1:360]

// How big is the bevel for the rod connector on the headband (in mm)?
connector_bevel = 2; // [0:0.05:4]

/* [Hidden] */

function sagitta_rad(sag,chrd) = (pow(sag,2)+pow(chrd/2,2))/(2*sag);
function apothem(r,n) = r*cos(180/n);
function circumrad(a,n) = a / cos(180/n);
function circumrad_s(s,n) = s / 2 * sin(180/n);
function poly_side(apo,n) = apo * 2 * tan(180/n);
function hypo(s1,s2) = sqrt(pow(s1,2) + pow(s2,2));
function pythoside(h,s) = sqrt(pow(h,2)-pow(s,2));
function arc_angle(s,r) = s*180/(PI*r);
function axis_range(l,a=0) = max([for (x = l) x[a]]) - min([for (x = l) x[a]]); // Given a nested list l, calculates the total range of values on a given axis a (a = element of each component vector in nested list)


// The number of segments used for "true" circles. More segments = smoother curves, but longer render times and bigger .STL files
circle_seg = 50;

// [Debugging Options]
// When true, and the cups & cushion holders are rendered simultaneously, it will position the cushion holder inside the cup
mockup = false;

// Renders a dummy PCB inside the cup
show_PCB = false;

// Renders a dummy threaded rod into the cup
show_rods = false;

// Makes a cutaway of the cups, for inspecting how everything fits together. First elements turns it on/off, second element sets the axis ("x"/"y"/"z") and the third element sets the direction (1/-1)
cutaway = [false,"y",1];

// [Measured values for Print+ Hardware]
// [Cup housing measurements]
// N.B. The L/R plug and stereo jack are both centered on PCB, with the jack on the underside of the PCB

speaker_cup_dia = 40;
speaker_cup_thick = 10.8; // Includes Magnet + PCB + Cup
inner_ring_dia = 23.7;
PCB_extend = 13.5; // From end to edge of cup (not including jack)
PCB_width = 17.1;
PCB_thick = 1.8;
magnet_thick = 1;


jack_thick = 5.2;
jack_ext = 2; // Extension of the jack from the end of the PCB
jack_total_length = 14; // Including the extension
headphone_cable_dia = 6; // Diameter at its thickest (for clearance into the housing)

plug_back = 9; // Distance from end of PCB to stereo connector
plug_dia = 2; // Diameter of the stereo cable at its widest (i.e. the plug)
plug_con_length = 5; // Length of the plug connector, to prevent making bends that it can't do

// [Cushion holder measurements]
cushion_outer_dia = 72; // Measured from original Print+
cushion_height = 1.5; // Amount of height before indent
cushion_indent = 1; // Approximate indentation for cushion to grip onto

// The following define the friction fit between the cushion holder and the cup. The top is slightly indented to help it fit inside
cushion_link_height = 2.5;
cushion_link_width = 1.5;
cushion_link_outer_indent = 0.5;
cushion_link_inner_indent = 0;
cushion_holder_h = cushion_height*2;

// [Headband measurements]

band_cushion_length = 197; // Total length of the band cushion (including the plastic tabs)

// The following define the headband cushion plastic tabs
band_cushion_thickness = 1.5; // Thickness of the plastic tabs
band_cushion_tab = 15; // Length of the plastic tabs (backwards from the ends of the cushion)
band_cushion_width = 11; // Width of the tabs




// [Calculated/Derived Variables and Arbitrary (Non-Measured) Dimensions]
// [Cup & Threaded Rod Variables]

// Sanitizing inputs for threaded rod variables
threaded_rod_dia = threaded_rod_diameter > 0 ? threaded_rod_diameter : 1;
nut_flat_width = nut_width > 0 ? nut_width : 1;
nut_thick = nut_thickness > 0 ? nut_thickness : 1;

nut_rad = circumrad(nut_flat_width/2,6);

housing_lower_h = speaker_cup_thick+jack_thick/2; // Lower segment height (including the PCB (with headphones jack), channel for L/R cable and cutout for the cushion holder)
housing_total_h = nut_flat_width > housing_lower_h - 2 ? nut_flat_width * 1.5 + housing_lower_h : housing_lower_h * 2; // Arbitrarily double, but accommodates the size of the threaded rod + nut if they're really big
housing_upper_h = housing_total_h - housing_lower_h;

PCB_length = PCB_extend + speaker_cup_dia / 2;
cup_housing_thick = speaker_cup_thick - PCB_thick - magnet_thick;


// [PCB Variables]
cradle_thick = PCB_thick + jack_thick + tolerance;
cradle_PCB_top_diff = PCB_width/2 + tolerance - jack_thick;
round_rad = circumrad(speaker_cup_dia / 2,circle_seg);
cone_height = tolerance; // For the cone supporting the speaker, how much it extends beyond the height of the magnet + PCB
crown_height = cup_housing_thick/2; // How deep the speaker sits into the cups
rad_diff = round_rad - (inner_ring_dia / 2) + tolerance;
cup_bottom_rad = round_rad + (rad_diff/cradle_thick * cone_height);

base_angle = atan(cradle_PCB_top_diff /(jack_thick+tolerance));
new_top = (cradle_thick * tan(base_angle)) + jack_thick;

// This is actually the overall radius of the housing, it's calculated here to fit the PCB
housing_rad = circumrad(hypo(PCB_length,new_top,2)+2,cup_outer_segments);

cap_height = (housing_rad / 2) * (housing_upper_h / (housing_rad/2)) / 2;

pattern_rad = housing_rad - cup_bevel - pattern_border;

// [L/R cable channel Variables]

channel_rad = hypo(PCB_extend - plug_back + speaker_cup_dia/2, new_top);
channel_height = cup_housing_thick/2+tolerance*2;
channel_width = plug_dia*2.5;

channel_turn_rad = 10; // Radius of the turn of the main channel path towards its exit

channel_narrow = plug_dia/2 - 0.1; // Width of the channel at the narrow part
narrow_angle = 15; // Distance from the upwards part of the channel
inner_cutter = channel_rad - channel_narrow;
outer_cutter = channel_rad + channel_narrow;

channel_fillet = channel_width / 2;
inner_cutter_angle = asin(new_top/(inner_cutter-channel_fillet*2));
outer_cutter_angle = asin(new_top/(outer_cutter+channel_fillet)) + asin(channel_fillet/outer_cutter);


minor_turn_angle = acos(channel_turn_rad/(channel_rad+channel_turn_rad));
major_turn_angle = asin(channel_turn_rad/(channel_rad+channel_turn_rad));
channel_turn_ext = pythoside(channel_rad+channel_turn_rad,channel_turn_rad);
channel_ext_to_end = housing_rad - channel_turn_ext;
channel_exit_rise = (housing_lower_h/2);
rise_steepness = channel_exit_rise*1.2;

support_height = cradle_thick + cone_height + crown_height;

cushion_rad = (apothem(housing_rad,cup_outer_segments) - circumrad(channel_rad+channel_width/2,circle_seg))/2 + circumrad(channel_rad+channel_width/2,circle_seg);

band_width = 20; // The width (front-to-back thickness) of the headband

band_thick = plug_dia + 2.4; // How thick the band is overall

nut_connector_length = 25;

band_exit_height = 9;

band_cushion_angle = arc_angle(band_cushion_length,band_diameter/2);
cushion_tab_angle = arc_angle(band_cushion_tab,band_diameter/2);
band_channel_angle = 10;
band_center_rad = band_diameter/2+ band_thick/2;


connector_dim = [(circumrad(nut_rad,6)+1)*2+5,nut_connector_length,band_width];

/* [Fundamental Shape Modules] */
module acylinder(h,r,fn=100,center = false) {
    cylinder(h=h,r=circumrad(r,fn),$fn=fn,center=center);
}

module square_torus(r_out, r_in, h, center=false, fn=circle_seg, pinch = false, r_out_top = 2, r_in_top = 1){
    if (pinch == false) {
        difference(){
            linear_extrude(height = h,center=center)
            difference(){
                circle(r=r_out,$fn=fn);
                circle(r=r_in,$fn=fn);
            }
        }
    }
    else {
        difference(){
            cylinder(r1=r_out,r2=r_out_top,h=h,center=center, $fn = fn);
            cylinder(r1=r_in,r2=r_in_top,h=h,center=center, $fn = fn);
        }
    }   
}


module round_torus(r_in,r_out,h,fn=circle_seg,top_fn=circle_seg){
    rad = (r_out-r_in)/2;
    translate([0,0,rad])
    rotate_extrude(convexity=10,$fn=fn)
    hull(){
        translate([r_in+rad,0]) circle(rad,$fn=top_fn);
        translate([r_in+rad,h-rad*2]) circle(rad,$fn=top_fn);
    }
}
module torus_slice(r_in,r_out,h,angle,fn=circle_seg,axis=false,rounded=false,top_fn=circle_seg){
    
    a = angle % 180;
    intersection(){
        if (rounded == false) 
        square_torus(r_in=r_in, r_out=r_out,h=h,fn=fn);
        else round_torus(r_in=r_in, r_out=r_out,h=h,top_fn=top_fn,fn=fn);
        int_len = r_out/cos(angle/2);
        if (a > 0) {
            hull(){
                rotate([0,0,axis == false ? 0 : -90 + a/2]) translate([-int_len,0,0]) cube([int_len,1,h]);
                rotate([0,0,axis == false ? 180 - a : 90 - a/2]) cube([int_len,1,h]);
            }
        } else {
          translate([0,r_out,0]) cube(r_out*2,center=true);
        }  
    }
}
/* [PCB-related Modules] */
module PCB_cradle_cut(){
    hull(){
        translate([-new_top,-cup_housing_thick/2-tolerance,0]) cube([new_top*2,cup_housing_thick/2+tolerance,PCB_length+tolerance*2]);
        translate([-jack_thick,0,0]) cube([jack_thick*2,cradle_thick,PCB_length+tolerance*2]);
    }
}
module speaker_PCB(left = true,dummy=false){
    
    if (dummy == true) {
        cylinder(h=cup_housing_thick, r=round_rad, $fn = circle_seg);
        translate([0,-PCB_width/2, -PCB_thick]) cube([PCB_length, PCB_width,  PCB_thick]);
        translate([0,0,-PCB_thick-magnet_thick]) acylinder(h=PCB_thick+magnet_thick,r=inner_ring_dia/2);
    }
    else {
                
        translate([0,0,-cradle_thick]) cylinder(r2=cup_bottom_rad, r1=inner_ring_dia/2, h=cradle_thick+cone_height,$fn=circle_seg);
        translate([0,0,cone_height]) cylinder(r=round_rad + (rad_diff/cradle_thick * cone_height), h=crown_height,$fn=circle_seg);
        
        rotate([-90,0,-90]) PCB_cradle_cut();
                
    }
    
    if (left == true && dummy == true){
        translate([PCB_length-jack_total_length+jack_ext,-jack_thick/2,-PCB_thick-jack_thick]) cube([jack_total_length-jack_ext,jack_thick,jack_thick]);
        translate([PCB_length + jack_ext / 2, 0, -PCB_thick-jack_thick/2]) rotate([0,90,0]) acylinder(h=jack_ext,r=jack_thick/2,center=true);
    }
    else if (left == true && dummy == false){
        // Inner hole (for the jack to poke out)
        translate([PCB_length + 10 + tolerance*2, 0, -PCB_thick-jack_thick/2]) rotate([0,90,0]) acylinder(h=20,r=jack_thick/2+(tolerance*2),center=true);
        // Outer hole (for the headphone wire to fit inside
        translate([PCB_length + 10 + jack_ext + tolerance*2, 0, -PCB_thick-jack_thick/2]) rotate([0,90,0]) acylinder(h=20,r=headphone_cable_dia*0.75,center=true);
    }
}
/* [L/R Cable Channel Modules] */
module channel_run(){
    intersection(){
        square_torus(channel_rad+channel_width/2,channel_rad-channel_width/2,channel_height+channel_exit_rise);

        hull(){
            translate([0,channel_rad,(channel_height-tolerance)/2]) rotate([90,0,0]) cylinder(h=channel_width*3,r=(channel_height-tolerance)/2,center=true,$fn=25);
            translate([rise_steepness,channel_rad,channel_exit_rise+tolerance]) rotate([90,0,0]) cylinder(h=channel_width*3,r=channel_height/2,center=true,$fn=25);
            
        
        translate([(channel_height/2+rise_steepness)/2,channel_rad,(channel_height-tolerance)/2]) cube([channel_height/2 + rise_steepness,channel_height*3,channel_height-tolerance],center=true);
        }
    
    }
    
    intersection(){
        square_torus(channel_rad+channel_width/2,channel_rad-channel_width/2,channel_height-tolerance);
        
        translate([-channel_rad*1.25,channel_rad*1.25,0]) cube(channel_rad*2.5,center=true);
    }
        
    intersection(){
        translate([0,0,channel_exit_rise+tolerance]) square_torus(channel_rad+channel_width/2,channel_rad-channel_width/2,channel_height,center=true);
        
        translate([channel_rad*1.25+rise_steepness,channel_rad*1.25,0]) cube(channel_rad*2.5,center=true);
    }
}



module minor_channel_turn(){
    difference(){
        rotate_extrude(convexity = 10, $fn = 64) translate([channel_turn_rad,0]) square([channel_width,channel_height],center=true);
        translate([channel_turn_rad*1.25,0,0]) cube(channel_turn_rad*2.5,center=true);
        rotate([0,0,-minor_turn_angle]) translate([-channel_turn_rad*1.25,0,0]) cube(channel_turn_rad*2.5,center=true);
    }
    
}

module channel_path(){
    difference(){
        channel_run();
        
        rotate([0,0,major_turn_angle]) translate([0,-channel_rad*1.25,0]) cube(channel_rad*2.5,center=true);
        
        rotate([0,0,-inner_cutter_angle]) torus_slice(r_in = inner_cutter - channel_fillet * 2, r_out = inner_cutter, h = channel_height, angle = 90 - narrow_angle - inner_cutter_angle, fn=circle_seg);
        
        rotate([0,0,-outer_cutter_angle]) torus_slice(r_in = outer_cutter, r_out = outer_cutter + channel_fillet * 2, h = channel_height, angle = 90 - narrow_angle - outer_cutter_angle, fn=circle_seg);
        
        for (x=[[inner_cutter,inner_cutter_angle,1],[outer_cutter,outer_cutter_angle,-1]]){
            
            rotate([0,0,-x[1]]) translate([-x[0]+channel_fillet*x[2],0,0]) cylinder(h=channel_height,r=channel_fillet,$fn=circle_seg);
            
            rotate([0,0,-90+narrow_angle]) translate([-x[0]+channel_fillet*x[2],0,0]) cylinder(h=channel_height,r=channel_fillet,$fn=circle_seg);
        }

    }
    
    translate([channel_turn_ext,channel_turn_rad,channel_exit_rise+tolerance]) minor_channel_turn();
    
    translate([channel_ext_to_end/2+channel_turn_ext,0,channel_exit_rise+tolerance]) cube([channel_ext_to_end,channel_width, channel_height],center=true);
}

/* [Cup Housing Modules] */
module threaded_rod_subtractor(demo=false,nut=true){
    if (demo == true){
        translate([housing_rad*0.75,0,housing_total_h - housing_upper_h / 2]) rotate([0,90,0]) cylinder(d=threaded_rod_dia,h=housing_rad*2,center=true,$fn=50);
    translate([0,0,housing_total_h - housing_upper_h / 2]) rotate([0,90,0]) rotate([0,0,30]) acylinder(r=nut_flat_width/2,h=nut_thick, fn = 6, center = true);
    } else {
        translate([housing_rad-(nut_thick + tolerance)/2,0,housing_total_h - housing_upper_h / 2]) rotate([0,90,0]) acylinder(r=threaded_rod_dia/2,h=housing_rad*2,center=true,fn=6);
        
        translate([-(nut_thick + tolerance)/2,0,housing_total_h - housing_upper_h / 2]) rotate([0,-90,0]) cylinder(r1=circumrad(threaded_rod_dia/2,6), r2 = threaded_rod_dia / 2, h=housing_rad/4-(nut_thick + tolerance)/2,$fn=6);
        
        if (nut == true) translate([0,0,housing_total_h + 10 - nut_flat_width / 2]) cube([nut_thick + tolerance * 2, circumrad(nut_flat_width/2,6) * 2 + tolerance * 2,housing_upper_h + tolerance * 2 + 20], center = true);
    }
}

module extruded_pattern(){
    max_x = axis_range(pattern_polygon[0],0);
    max_y = axis_range(pattern_polygon[0],1);
    
    rotate([0,0,-90-pattern_rotate]) resize([max_x >= max_y ? pattern_rad * 2 : 0, max_y > max_x ? pattern_rad * 2 : 0, 0], auto = [true,true,false]) linear_extrude(height = cup_type < 4 ? pattern_depth : housing_upper_h*2, convexity = 20) polygon(points = pattern_polygon[0], path = pattern_polygon[1]);
}

module cups(type = 1, seg_out = cup_outer_segments, seg_in = cup_inner_segments, rounded = false, bevel = 2){
    if (type == 1) { // Low Poly
        hull(){
            cylinder(h=housing_lower_h,r=housing_rad,$fn=seg_out);
            rotate([0,0,0]) cylinder(h=housing_total_h,r=housing_rad/2,$fn=seg_in);
        }
    }
    else if (type == 2) { // Retro
        cylinder(h=housing_lower_h-bevel/2,r=housing_rad,$fn=seg_out);
        cylinder(h=housing_total_h-bevel/2,r=housing_rad/2,$fn=seg_in);
        translate([0,0,housing_lower_h-bevel/2]) cylinder(h=bevel,r1=housing_rad,r2=housing_rad-bevel ,$fn=seg_in);
        translate([0,0,housing_total_h-bevel/2]) cylinder(h=bevel,r1=housing_rad/2,r2=housing_rad/2-bevel ,$fn=seg_in);
    }
    else if (type == 3) { // Pattern
        cylinder(h=housing_total_h-bevel/2,r=housing_rad,$fn=seg_out);
        translate([0,0,housing_total_h-bevel/2]) cylinder(h=bevel,r1=housing_rad,r2=housing_rad-bevel ,$fn=seg_in);
        if (pattern_type == 1) translate([0,0,housing_total_h+bevel/2]) extruded_pattern();
    }
    else if (type == 4) { // Rounded Pattern
        cylinder(h=housing_lower_h-bevel/2,r=housing_rad,$fn=seg_out);
        translate([0,0,housing_lower_h-bevel/2]) cylinder(h=bevel,r1=housing_rad,r2=housing_rad-bevel ,$fn=seg_in);
        intersection(){
            translate([0,0,housing_lower_h]) resize([0,0,circumrad(threaded_rod_dia/2,6)*2+housing_upper_h+10]) sphere(r=housing_rad, $fn=seg_in);
            translate([0,0,housing_lower_h]) extruded_pattern();
        }
    }
    
    if ((rounded == true) && (type != 1)) {
        translate([0,0,type == 2 ? housing_lower_h - bevel * 1.5 : housing_total_h-bevel*1.5]) round_torus(r_in = housing_rad - bevel * 2, r_out = housing_rad, h = 0, fn = seg_in, top_fn = 24);
        if (type == 2) translate([0,0,housing_total_h-bevel*1.5]) round_torus(r_in = housing_rad / 2 - bevel * 2, r_out = housing_rad / 2, h = 0, fn = seg_in, top_fn = 24);
    }
}




module housings(){
    difference(){
        cups(type = cup_type, seg_out = cup_type == 1 ? cup_outer_segments : circle_seg, seg_in = cup_type == 1 ? cup_inner_segments :  circle_seg, rounded = bevel_type == 0 ? false : true, bevel = cup_bevel);
        
        //Subtract the space for the PCB
        translate([0,0,cup_housing_thick / 2]) rotate([180,0,180]) speaker_PCB(left = left_cup == 1 ? true : false,dummy = false);
        
        //Subtract the holes for the threaded rod
        threaded_rod_subtractor(nut = cup_nut_trap == 1 ? true : false);
        
        //Subtract the channel for the stereo wire
        translate([0,0,-tolerance]) channel_path();
        
        //Subtract the mating space for the cushion holder
        square_torus(r_out=circumrad(cushion_rad,circle_seg), r_in = apothem(cushion_rad - cushion_link_width - tolerance, circle_seg),h=cushion_link_height,fn=circle_seg);
        
        if ((cup_type == 3) && (pattern_type == 0)) translate([0,0,housing_total_h+cup_bevel/2-pattern_depth]) extruded_pattern();
            
        if (cutaway[0] == true) translate([cutaway[1] == "x" ? (housing_rad + 5) * cutaway[2] : 0, cutaway[1] == "y" ? (housing_rad + 5)  * cutaway[2] : 0, cutaway[1] == "z" ? (housing_rad + 5)  * cutaway[2] : 0]) cube(housing_rad*2+10,center=true);
    }
}

module housing_support(){
    //Some concentric rings for simple support. Width set at 0.4 mm to match the nozzle size
    square_torus(r_out=inner_ring_dia/4,r_in=inner_ring_dia/4-0.4,h=support_height);
    square_torus(r_out=inner_ring_dia*3/8,r_in=inner_ring_dia*3/8-0.4,h=support_height);
    square_torus(r_out=inner_ring_dia/2,r_in=inner_ring_dia/2-0.4,h=support_height);
}

module low_poly_cap(){
    rotate([0,0,0]) cylinder(r1=housing_rad/2,r2=0,h=cap_height,$fn=cup_inner_segments);
}

/* [Cushion Holder Modules] */
module cushion_base(seg=circle_seg){
    cylinder(h = cushion_height, r = cushion_outer_dia/2, $fn = seg);
    translate([0,0,cushion_height]) cylinder(h = cushion_height, r1 = cushion_rad - cushion_indent, r2 = cushion_rad,$fn=seg);
    //translate([0,0,cushion_height*2]) cylinder(h = cushion_height/2, r = cushion_rad,$fn=seg);
    
    translate([0,0,cushion_height*2]) square_torus(r_out = cushion_rad, r_in = cushion_rad - cushion_link_width, h = cushion_link_height, fn = seg, pinch = true, r_out_top = cushion_rad - cushion_link_outer_indent, r_in_top = cushion_rad - cushion_link_width + cushion_link_inner_indent);
}

module cushion_holder(seg=circle_seg){
    difference(){
        cushion_base();
        translate([0,0,-1]) cylinder(h=cup_housing_thick, r=circumrad(speaker_cup_dia/2,circle_seg),$fn=seg);
    }
}
/* [Headband Modules] */
module band_clip(fn=circle_seg,top_fn=circle_seg){
    torus_slice(r_in = band_diameter/2-band_cushion_thickness*2, r_out = band_diameter/2+band_cushion_thickness*2, h = band_cushion_width*1.5, fn = fn,angle=cushion_tab_angle,axis=false,rounded=true,top_fn=top_fn);
    
    hull(){
        translate([-band_diameter/2,0,0]) cylinder(r2=band_cushion_thickness*2,r1=0,h=band_cushion_thickness*2,$fn=4);
        
        translate([-band_diameter/2,0,band_cushion_width*1.5-band_cushion_thickness*2]) cylinder(r1=band_cushion_thickness*2,r2=0,h=band_cushion_thickness*2,$fn=4);
    }
}


module band_cable_exit(front=false){
    
    hull(){
        translate([0,0,band_width/2]) cylinder(r=plug_dia*0.75,h=band_width/2,$fn=20);
        if (front==false) {
            translate([0,-plug_dia*0.75,band_width/2]) cylinder(r=plug_dia*0.75,h=band_width/2,$fn=20);
        } else {
            translate([0,-plug_dia*0.75,band_width]) cube([plug_dia*1.5,plug_dia*1.5,band_width/2],center=true);
        }
    }
    
    hull(){
        hull(){
            translate([0,0,band_width/2]) cylinder(r=plug_dia*0.75,h=band_exit_height/2,$fn=20);
            translate([0,-plug_dia*0.75,band_width/2]) cylinder(r=plug_dia*0.75,h=band_exit_height/2,$fn=20);
        }
        if (front == false) {
            translate([plug_dia/2+band_thick/2,-plug_dia*0.75/2,band_width/2]) cube([plug_dia,plug_dia,band_exit_height],center=true);
        } else {
            translate([band_diameter/2+band_thick/2,0,band_width/2]) rotate([0,0,band_channel_angle/2]) translate([-band_diameter/2-band_thick/2,-plug_dia/2,0]) cube([plug_dia,plug_dia,band_exit_height],center=true);
        }
    }
}


module rod_connector(dummy=false){
    if (dummy==true) rotate([90,0,0]) cylinder(d=threaded_rod_dia,h=50,center=true,$fn=circle_seg);
    
    if (dummy==true) rotate([90,30,0]) acylinder(r=nut_flat_width/2,h=nut_thick, fn = 6, center = true);
    
    difference(){
        
        cube(connector_dim,center=true);
        //Central rod clearance
        rotate([90,0,0]) cylinder(r=circumrad(threaded_rod_dia/2,6)+tolerance,h=50,center=true,$fn=6);
        
        //Space for nut to rotate
        rotate([90,0,0]) cylinder(r=circumrad(nut_rad,6)+1,h=nut_thick+tolerance*2,center=true,$fn=6);
        
        //Total cut for nut
        translate([-nut_rad,0,0]) cube([nut_rad*2,nut_thick+tolerance*2,nut_rad*4],center=true);
        
        //Cylinder to make a chamfer for the nut cutout
        translate([-nut_rad*2,0,0]) cylinder(h=nut_rad*4,r=nut_thick*2,center=true,$fn=6);
        
        
        //Slice off the side to get at nut
        translate([-connector_dim[0]/2 - circumrad(threaded_rod_dia/2,6)-tolerance-2.5,0,0]) cube(connector_dim+[0,10,0],center=true);
        
        //Chamfering edges
        if (connector_bevel_type != 0){
            translate([connector_dim[0]/2,connector_dim[1]/2,0]) cylinder(h=connector_dim[2]+10,r=connector_bevel,$fn=4,center=true);
            for (x=[1,-1]) {       
                translate([-circumrad(threaded_rod_dia/2,6)-tolerance-2.5,0,connector_bevel_type == 3 ? connector_dim[2]/2*x : connector_dim[2]/2]) rotate([90,0,0]) cylinder(h=connector_dim[1]+10,r=connector_bevel,$fn=4,center=true);
                translate([0,connector_dim[1]/2,connector_bevel_type == 3 ? connector_dim[2]/2*x : connector_dim[2]/2]) rotate([0,90,0]) cylinder(h=connector_dim[0]+10,r=connector_bevel,$fn=4,center=true);
            }
        }
    }
}
module band_crown(front=false){
    connector_trans = [-band_center_rad+band_thick/2,0,0];
    
    difference(){
        union(){
            torus_slice(r_in = band_diameter/2, r_out = band_diameter/2+ band_thick, h = band_width, fn = circle_seg,angle=180,axis=false);
            rotate([0,0,-(180-band_cushion_angle)/2]) translate([0,0,band_width/2-(band_cushion_width*1.5)/2]) band_clip(fn=circle_seg*5,top_fn=4);
            mirror([1,0,0]) rotate([0,0,-(180-band_cushion_angle)/2]) translate([0,0,band_width/2-(band_cushion_width*1.5)/2]) band_clip(fn=circle_seg*5,top_fn=4);
            
            for (x=[0,1]) mirror([x,0,0]) translate(connector_trans) rotate([0,0,band_angle]) translate([-connector_dim[0]/2,connector_dim[1]/2,connector_dim[2]/2]) rod_connector(false);
        }
        
        //Chamfering connector/band interface
        if (connector_bevel_type != 0) for (x=[connector_bevel_type != 1 ? 0 : connector_dim[2],connector_dim[2]],y=[0,1]) mirror([y,0,0]) translate(connector_trans+[0,0,x]) rotate([0,90,band_angle]) cylinder(h=connector_dim[0]*2,r=connector_bevel,$fn=4,center=true);
        
        //The cable channel
        translate([0,0,band_width-plug_dia*2])
        torus_slice(r_in = band_center_rad - plug_dia/2 + 0.1,r_out = band_center_rad + plug_dia/2 - 0.1,h=band_width,fn=circle_seg,angle=180-band_channel_angle,axis=true);
        
        //The band cushion subtractor
        translate([0,0,-band_cushion_width/2 + band_width/2])
    torus_slice(r_in = band_diameter/2 - band_cushion_thickness, r_out = band_diameter/2, h = band_cushion_width, fn = circle_seg,angle=band_cushion_angle,axis=true);
        
        //The exits for the cable
        for (x=[0,1])
        mirror([x,0,0]) rotate([0,0,-band_channel_angle/2]) translate([-band_diameter/2-band_thick/2,0,0]) band_cable_exit(front);
        
    }  
}


/* [Rendering Logic] */

// For the time being, will not render the band if anything else is on the plate
if ((show_band == 1) && (show_cup == 0) && (show_cushion_holder == 0)) band_crown(front = band_exit == 1 ? true : false);

if (show_cup == 1) {
    housings();
    if (cup_support == 1) housing_support();
}

if (show_cushion_holder == 1) translate([(show_cup == 1) && (mockup == false) ? housing_rad + cushion_rad + 10 : 0,0,(show_cup == 1) && (mockup == true) ? -cushion_holder_h : 0]) cushion_holder();

if (show_PCB == true) translate([0,0,cup_housing_thick / 2]) rotate([180,0,180]) speaker_PCB(true,false);
    
if (show_rods == true) threaded_rod_subtractor(true);

if ((show_cap == 1) && (cup_type == 1)) translate([0,0,housing_total_h]) low_poly_cap();