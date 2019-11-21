// Size of the creature.  NOTE: Small is the same as medium because small creatures control the same area as a medium creature.  Source: 5e SRD pg 92
size = "medium"; //[tiny,small,medium,large,huge,gargantuan]

// Add lip around edge? (slow)
lip = "yes"; //[yes,no]

// Do you want to have numbered tiles in an array?
indexed_array = "no"; //[yes,no]

// How rough the lip should be.  Try 4 and 8 for interesting options other than a smooth curve.
lip_roughness = 100; //[4:2:100]

// Resolution (higher is *much* slower)
$fn = 100;

// Base radius we scale from.  Adjust if your map is not 25.4mm squares
radius = 12.5;

// Number of columns when indexing
columns = 3;

// Number of rows when indexing
rows = 4;

// Height of base
base_height = 3; //[2:0.1:5]

// Size of gap
gap_size = 0.6; //[0.1:0.1:3]

// How much material should be left at the bottom of the gap.  Zero to have the gap all the way through.
gap_base = 0.5; //[0:0.1:1.0]

// Number of degrees for gap to cover.  45 works well at all sizes.
gap_degrees = 45; //[30:5:90]

// Depth for font pocket
font_depth = 0.5; //[0.1:0.1:1]

// Space between bases when using an indexing array
array_gap = 5; //[1:10]

// No assignment inside if statements, so we get this abomination
base_radius = str(size) == str("tiny") ? radius/2 : (str(size) == str("large") ? radius*2 : (str(size) == str("huge") ? radius*3 : (str(size) == str("gargantuan") ? radius*4 : radius)));

// Font size for indexed bases
font_size = base_radius/2;

// This determines the offset for the arc.  The arc has a radius of twice base_radius, so it needs to be moved by that much to have the edge centered.  Additionally, we calculate the distance from the midpoint of the secant line to the edge and add half of that to center the arc on the base.
gap_center_offset = -base_radius*2 + base_radius*(1-cos(gap_degrees/2));

/*
 * Arc Module for OpenSCAD
 * by chickenchuck040
 * https://www.thingiverse.com/thing:1092611
 * Licenced under Creative Commons Attribution
*/
module arc(radius, thick, angle){
	intersection(){
		union(){
			rights = floor(angle/90);
			remain = angle-rights*90;
			if(angle > 90){
				for(i = [0:rights-1]){
					rotate(i*90-(rights-1)*90/2){
						polygon([[0, 0], [radius+thick, (radius+thick)*tan(90/2)], [radius+thick, -(radius+thick)*tan(90/2)]]);
					}
				}
				rotate(-(rights)*90/2)
					polygon([[0, 0], [radius+thick, 0], [radius+thick, -(radius+thick)*tan(remain/2)]]);
				rotate((rights)*90/2)
					polygon([[0, 0], [radius+thick, (radius+thick)*tan(remain/2)], [radius+thick, 0]]);
			}else{
				polygon([[0, 0], [radius+thick, (radius+thick)*tan(angle/2)], [radius+thick, -(radius+thick)*tan(angle/2)]]);
			}
		}
		difference(){
			circle(radius+thick);
			circle(radius);
		}
	}
}

module minifig_base()
{
    difference() {
        // Base cylinder
        cylinder(h=base_height,r=base_radius);
        
        // Gap for figure
        translate([gap_center_offset,0,gap_base]) linear_extrude(height=base_height) arc(thick=gap_size,radius=base_radius*2,angle=gap_degrees);
        
        // Bevelled lip
        if (str(lip) == str("yes"))
        {
            rotate_extrude() translate([base_radius,base_height,0]) circle(r=base_height/3, $fn=lip_roughness);
        }
    }
}

if (indexed_array == "yes")
{
    for (i=[0:columns-1])
    {
        for (j=[0:rows-1])
        {
            index = i*(rows)+j+1;
            font_offset = index >=10 ? font_size*2/3 : font_size/3;
            translate([i*base_radius*2+array_gap*i, j*base_radius*2+array_gap*j, 0])
            difference()
            {
                minifig_base();
                translate([-font_size-base_radius*(1-cos(gap_degrees/2)),font_offset,base_height-font_depth])
                rotate([0,0,-90])
                linear_extrude(height=font_depth)
                text(str(index), size=font_size, font="FreeSerif");
            }
        }
    }
}
else
{
    minifig_base();
}