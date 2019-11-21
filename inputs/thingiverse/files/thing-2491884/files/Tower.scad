X=+0; Y=+1; Z=+2;

/* [General] */
// temperature of the first block
initial_temperature = 280;
// final temperature
final_temperature = 210;
// change in temperature between successively printed blocks
temperature_step = -5;
// number of blocks - used if non-zero, overrides final_temperature
number_of_blocks = 0;

/* [Detail Geometry] */
// dimensions of the base plate
base = [46, 14, 1.5];
// dimensions of the pedestal under a tower block
pedestal = [6, 6, 1];
// dimensions of the tower block
block = [8, 8, 6];
// X spacing between the towers
tower_x_distance = 16*2;
// left (X-) overhang size
overhang_l_x = 3;
// right (X+) overhang size
overhang_r_x = 5;
// top of the overhang relative to the top of the block
overhang_z_top = -2.394;
// height of the overhang
overhang_z = 3;
// gap between the bridge and the left (X-) tower
bridge_l_gap = 1;
// gap between the bridge and the right (X+) tower
bridge_r_gap = 3;
bridge_y_front = -block[Y]/2;
bridge_y = block[Y]/2;
// top of the bridge relative to the top of the block
bridge_z_top = -0.394;
// thickness of the bridge
bridge_z = 1.5;
// embossing depth of the text
text_depth = 1;
// font used for the text
text_font = "Helvetica:style=Bold";
// text ascent relative to the width of the tower block
text_ascent = 0.4;

/* Hidden */

module Tower(x, overhang, gap, temp)
    translate([x,0,0])
    scale([x<=0 ? 1 : -1, 1, 1])
{
    z1 = 0;
    translate([0,0,z1 + pedestal[Z]/2]) cube(pedestal, true);
    z2 = z1 + pedestal[Z];
    temp = temp ? str(temp) : "";
    difference() {
        translate([0,0,z2 + block[Z]/2]) cube(block, true);
        translate([0, -block[Y]/2+text_depth-0.001, z2 + block[Z]/2])
        rotate([90,0,0])
        linear_extrude(text_depth)   
        text(temp, size = block[X] * text_ascent, 
             valign = "center", halign = "center",
             font = text_font);
    }
    
    z3 = z2 + block[Z];

    overhang_pts = [[0,0],[0,-overhang_z],[overhang,0]];

    z4 = z3 + overhang_z_top;
    translate([block[X]/2, block[Y]/2, z4])
        rotate([90,0,0])
        linear_extrude(block[Y])
        polygon(points=overhang_pts);
    
    pedestal_z = abs(overhang_z_top -bridge_z_top + bridge_z);
    translate([block[X]/2 + gap, bridge_y_front, z4]) {
        cube([(overhang-gap), bridge_y, pedestal_z]);
        translate([0,0,pedestal_z])
            cube([abs(x)-block[X]/2-gap, bridge_y, bridge_z]);
    }


}

z1 = 0;
translate([0,0,z1+base[Z]/2]) cube(base, true);
z2 = z1 + base[Z];

count = number_of_blocks>0 ? number_of_blocks :
    1+(final_temperature - initial_temperature)/temperature_step;

for (i = [0 : count-1]) {
    z3 = z2 + i*(pedestal[Z] + block[Z]);
    temp = initial_temperature + i*temperature_step;
    translate([0,0,z3]) {
        Tower(-tower_x_distance/2, overhang_l_x, bridge_l_gap, temp);
        Tower(tower_x_distance/2, overhang_r_x, bridge_r_gap);
    }
}
