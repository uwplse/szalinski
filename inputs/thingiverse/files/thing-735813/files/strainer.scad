// in mm
length=50;
// in mm
width=60;
// in mm
height=19.25;

//Diameter of the Incircle of the Hexagons
cell_size=7;
//Stability vs Transmissibility
wall_thickness=1.75;
solid_walls="No";//[Yes,No]

//multiple_cell=2;
//height=multiple_cell*cell_size+multiple_cell*wall_thickness+wall_thickness;

solid_wall = solid_walls=="Yes";

//honeycomb(length, width, height, cell_size, wall_thickness);
//bottom
honeycomb(length, width, wall_thickness, cell_size, wall_thickness);
if (!solid_wall)
{
//front
translate([0,wall_thickness,0])
rotate([90,0,0])
honeycomb(length, height, wall_thickness, cell_size, wall_thickness);
//back
translate([0,width,0])
rotate([90,0,0])
honeycomb(length, height, wall_thickness, cell_size, wall_thickness);
//left
rotate([90,0,90])
honeycomb(width, height, wall_thickness, cell_size, wall_thickness);
//right
translate([length-wall_thickness,0,0])
rotate([90,0,90])
honeycomb(width, height, wall_thickness, cell_size, wall_thickness);
}
//hollow cube
difference(){
	cube([length, width, height],center=false);
	{
	union(){
		translate([wall_thickness,wall_thickness,-0.5])
		cube([length-2*wall_thickness, width-2*wall_thickness, height+1],center=false);
		if (!solid_wall)
		{
			translate([-wall_thickness,wall_thickness,wall_thickness])
			cube([length+2*wall_thickness, width-2*wall_thickness, height-2*wall_thickness],center=false);
			translate([wall_thickness,-wall_thickness,wall_thickness])
			cube([length-2*wall_thickness, width+2*wall_thickness, height-2*wall_thickness],center=false);
		}
	}
	}
}

/* Thanks to Przemo Firszt for the honeycomb structure
source: http://blog.firszt.eu/index.php?post/2013/05/31/OpenSCAD-first-battle
source file:http://firszt.eu/openscad/honeycomb.scad
edited by Jan Huennemeyer: Added 'center' option
*/
module hc_hexagon(size, height) {
	box_width = size/1.75;
	for (r = [-60, 0, 60]) rotate([0,0,r]) cube([box_width, size, height],
true);
}

module hc_column(length, height, cell_size, wall_thickness) {
   no_of_cells = floor(1 + length / (cell_size + wall_thickness)) ;

        for (i = [0 : no_of_cells]) {
                translate([0,(i * (cell_size + wall_thickness)),0])
                        hc_hexagon(cell_size, height + 1);
        }
}

module honeycomb (length, width, height, cell_size, wall_thickness, center) {
   no_of_rows = floor(1.75 * length / (cell_size + wall_thickness)) ;

   tr_mod = cell_size + wall_thickness;
   tr_x = sqrt(3)/2 * tr_mod;
   tr_y = tr_mod / 2;
        off_x = -1 * wall_thickness / 2;
        off_y = wall_thickness / 2;
        difference(){
                cube([length, width, height],center=center);
					 if (center)
					 translate([-length/2, -width/2, -height/2])
                	for (i = [0 : no_of_rows]) {
                  	      translate([i * tr_x + off_x, (i % 2) * tr_y + off_y, (height) / 2])
                     	           hc_column(width, height, cell_size, wall_thickness);
	                }
					 else
						for (i = [0 : no_of_rows]) {
                     	   translate([i * tr_x + off_x, (i % 2) * tr_y + off_y, (height) / 2])
                  	              hc_column(width, height, cell_size, wall_thickness);
	                }
					 
        }
}