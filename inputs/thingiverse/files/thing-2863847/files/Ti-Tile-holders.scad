//================================================
// Twilight Imperium Map Hex holders by mhendricks
// v1.3
//================================================
// All sizes are mm.
/*  Based on: Parametric tile holder for boardgame tiles
    By: satanin
    URL: https://www.thingiverse.com/thing:2762883
*/

/* Notes:
    See the "Control text and customization" section
    to choose see the settings used to create the
    example .stl files.
*/

// preview[view:south east, tilt:top]

/* [General] */
// Create the holder or cover
part="both"; //[both, cover, holder]
// Add pre-defined accents
accent="None";//[None,Stars,Planets,Border]
// Text displayed in perferation
display_text="TI";
// Height of the tiles this will contain
internalHeight=33;//[1:200]
// Hexagonal Tile Diameter (point to point) Ti3=114, Ti4=118
diameter=114;//[1:200]

/* [Structure] */
// Wall, base and cover thickness
wall=3;//[1:5]
// use minimalistic structure for holder (fewer vertical sides)
minimalistic="no";//[yes,no]
// Add more support to holder uprights for taller holders.
use_reinforced_structure="no";//[yes,no]
// use perforations?
use_perforation="yes";//[yes,no]
// Perforation percentage
perforation_percentage=60;//[1:86]
// For quicker prints when testing the holder walls set to no. If set to no, just the walls are printed
create_base="yes";//[yes,no]
// Set to no if you don't want the cover cutout or cover
use_cover="yes"; //[yes,no]

/*[Text]*/
// Display text in perforation
use_text="yes";//[yes,no]
// Change the font. See the Help menu -> Font List dialog for values. Default: "Liberation Sans:style=Regular"
font = "";
// The size passed to text
text_size=14;//[1:50]

//===============================================
//       Control text and customization
//===============================================
/* internalHeight is the total thickness of the stack of tiles
    contained by the holder and cover. I would recommend adding
    1 mm to the measured value. These values are including all
    the tiles from all 3 expansions.
    I chose to use a single holder for planets so I'm using
    use_reinforced_structure just for that one.
*/

//Comment out all of the lines other than the one you want to print.

// Ti3 Holders
//display_text="Homes"; internalHeight=44; accent="Border";
//display_text="Planets"; internalHeight=89; use_reinforced_structure="yes"; accent="Planets";
//display_text="Space"; internalHeight=33; accent="Stars";
//display_text="Special"; internalHeight=33; accent="Border";
//use_text="no"; internalHeight=33; // No customization

// Ti4 Holders
//diameter=118; // The hexes are larger in 4th edition
//display_text="Homes"; internalHeight=36; accent="Border";
//display_text="Planets"; internalHeight=33; accent="Planets";
//display_text="Space"; internalHeight=23; accent="Stars";
//===============================================
/* [Hidden] */

sides=6;
spacer=1;
radius=diameter/2;

just_the_cover = part=="cover";

// internalHeight is the total space being contained vertically
$height=internalHeight + (use_cover=="yes" ? wall*2 : wall);

cover_position_spacer=radius*0.35;

$reinforced_structure_z= use_reinforced_structure=="yes" ? diameter/5 : wall;

// https://gist.github.com/coolsa/819a7863115a06df33e77bee8862b866
// points = number of points (minimum 3)
// outer  = radius to outer points
// inner  = radius to inner points
module Star(points, outer, inner) {
	
	// polar to cartesian: radius/angle to x/y
	function x(r, a) = r * cos(a);
	function y(r, a) = r * sin(a);
	
	// angular width of each pie slice of the star
	increment = 360/points;
	
	union() {
		for (p = [0 : points-1]) {
			
			// outer is outer point p
			// inner is inner point following p
			// next is next outer point following p

			x_outer = x(outer, increment * p);
            y_outer = y(outer, increment * p);
            x_inner = x(inner, (increment * p) + (increment/2));
            y_inner = y(inner, (increment * p) + (increment/2));
            x_next  = x(outer, increment * (p+1));
            y_next  = y(outer, increment * (p+1));

			linear_extrude(height=wall, center=true) {
                polygon(
                    points = [[x_outer, y_outer],
                        [x_inner, y_inner],
                        [x_next, y_next],
                        [0, 0]],
                    paths  = [[0, 1, 2, 3]]
                );
            }
		}
	}
}

module perforation(perforation_percentage){
	perforation_radius = (radius*perforation_percentage)/100;
    cylinder(
        $height,
        perforation_radius,
        perforation_radius,
        center=true,
        $fn=200
    );
}

module perforation_text(bgColor) {
    if(use_text=="yes"){
        color("blue"){
            linear_extrude(wall*0.75){
                text(
                    display_text,
                    text_size,
                    valign="center",
                    halign="center",
                    font=font
                );
            }
        }
        color(bgColor){
            translate([0, 0, wall/4]) cube(size=[
                diameter*perforation_percentage/100,
                text_size*1.75,
                wall/2],
            center=true);
        }
    }
}

module gap (){
	factor=2;
	slot=radius/2;
	rotate([0,0,0], center=true){
		translate([
            -(slot)/2,
            - diameter*(factor/2),
            wall+$reinforced_structure_z
        ]){
			cube([slot,diameter*factor,$height*factor]);
		}
	}
	
	rotate([0,0,60], center=true){
		translate([
            -(slot)/2,
            - diameter*(factor/2),
            wall+$reinforced_structure_z
        ]){
			cube([slot,diameter*factor,$height*factor]);
		}
	}
	rotate([0,0,120], center=true){
		translate([
            -(slot)/2,
            - diameter*(factor/2),
            wall+$reinforced_structure_z
        ]){
			cube([slot,diameter*factor,$height*factor]);
		}
	}
	
	if(minimalistic=="yes"){
		rotate([0,0,30], center=true){
			translate([
                -(slot),
                - diameter*(factor/2),
                wall+$reinforced_structure_z
            ]){
				cube([radius,diameter*factor,$height*factor]);
			}
		}
	}
}

module holder() {
	z=wall;
	difference(){
		difference(){
			// Outter holder body
            cylinder($height+0.6,radius+wall,radius+wall,center=false,$fn=sides);
			// Cut out the inside of the holder body
            translate([0,0,z]){
				cylinder($height+100,radius,radius,center=false,$fn=sides);
			}
		}
		gap();
		if(use_perforation=="yes"){
			perforation(perforation_percentage);
		}
        if(create_base=="no"){
            // Remove the base. Useful for quick wall testing.
            translate([0,0,-0.9]) cylinder(z+1, r=radius+wall+1,$fn=sides);
        }
	}
    if(create_base!="no"){
        perforation_text("Green");
    }
}

module cover(){
	// Translation allows both to fit on a 200mm bed
    translate([radius+cover_position_spacer,radius+cover_position_spacer,0]){
		if(use_cover=="yes"){
			spacer=0.1;
            difference() {
                color("red"){
                    difference(){
                        cylinder(
                            wall,
                            (radius+wall-spacer)-(wall/2),
                            (radius+wall-spacer)-(wall/2),
                            center=false,
                            $fn=sides
                        );
                        if(use_perforation=="yes"){
                            perforation(perforation_percentage);
                        }
                    }
                }
                accents(perforation_percentage);
            }
            perforation_text("DarkRed");
		}
	}
}

module cover_(){
	spacer=0.5;
    newRadius = (radius+wall)-(wall/2);
	color("red"){
		translate([0,0,$height-wall]){
            difference(){
                cylinder(wall+0.01, r=newRadius,center=false,$fn=sides);
                if (use_perforation=="yes"){
                    translate([0,0,$height-wall]){
                        cylinder($height,radius/2, radius/2, center=true);
                    }
                }
            }	
            translate([0,0,wall]){
                cylinder(1, newRadius, newRadius-1, $fn=sides);
            }
        }
	}
}

module final_holder(){
	if(!just_the_cover){
		if (use_cover=="yes") {
			difference(){
				holder();
				cover_();
                accents(perforation_percentage);
			}
		}else{
            difference() {
                holder();
                accents(perforation_percentage);
            }
		}
	}
}

module accents(perforation_percentage) {
    color("Orange") {
        if (accent=="Planets") {
            base_planet_radius = 5;
            translate([radius-base_planet_radius*2, 0, wall*1.25]) {
                cylinder(
                    wall,
                    r=base_planet_radius,
                    center=true,
                    $fn=200
                );
            }
            translate([
                radius-base_planet_radius*6.25,
                radius-base_planet_radius*5,
                wall*1.25
            ]) {
                cylinder(
                    wall,
                    r=base_planet_radius*2,
                    center=true,
                    $fn=200
                );
            }
            translate([
                -(radius-base_planet_radius*4),
                radius-base_planet_radius*7.75,
                wall*1.25
            ]) {
                cylinder(
                    wall,
                    r=base_planet_radius*1.3,
                    center=true,
                    $fn=200
                );
            }
            translate([
                -(radius-base_planet_radius*8),
                -(radius-base_planet_radius*4),
                wall*1.25
            ]) {
                cylinder(
                    wall,
                    r=base_planet_radius*1.7,
                    center=true,
                    $fn=200
                );
            }
        }
        else if (accent=="Border") {
            name_plate_radius = (radius*(100-perforation_percentage))/100;
            translate([0,0,wall*0.75]) {
                difference() {
                    // Outter ring
                    cylinder(
                        $height,
                        radius-wall,
                        radius-wall,
                        center=false,
                        $fn=sides
                    );
                    cylinder(
                        $height,
                        radius-wall*2,
                        radius-wall*2,
                        center=false,
                        $fn=sides
                    );
                }
                intersection() {
                    // Cutout for the bottom
                    translate([-radius, -radius-wall, 0]) {
                        cube([diameter, name_plate_radius, wall]);
                    }
                    cylinder($height,r=radius-wall,center=false,$fn=sides);
                    
                }
                difference() {
                    // Inner Ring
                    cylinder(
                        $height,
                        radius-wall*3,
                        radius-wall*3,
                        center=false,
                        $fn=sides
                    );
                    cylinder(
                        $height,
                        radius-wall*4,
                        radius-wall*4,
                        center=false,
                        $fn=sides
                    );
                }
            }
        }
        else if (accent=="Stars") {
            base_star_radius = 5;
            scale([-1,-1,1]) {
                translate([radius-base_star_radius*2, 0, wall*1.25]) {
                    Star(4,base_star_radius,1);
                }
                translate([
                    radius-base_star_radius*6,
                    radius-base_star_radius*5,
                   wall*1.25
                ]) {
                    Star(4,base_star_radius*.75,1.5);
                }
                translate([
                    -(radius-base_star_radius*4),
                   radius-base_star_radius*7,
                    wall*1.25
                ]) {
                    Star(4,base_star_radius*1.2,1);
                }
                translate([
                    -(radius-base_star_radius*7),
                    -(radius-base_star_radius*4),
                    wall*1.25
                ]) {
                    Star(4,base_star_radius*2,1);
                }
            }
        }
    }
}

if (part=="cover"){
    // Remove built in cover translation
    translate([
        -radius-cover_position_spacer,
        -radius-cover_position_spacer,
        0
    ]){
        cover();
    }
}else{
    if (part=="both" || part=="holder") {
        final_holder();
    }
    if (part=="both" || part=="cover") {
        cover();
    }
}
