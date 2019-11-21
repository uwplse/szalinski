// Custom Screen to fill a hole (c) 2013 David Smith
// licensed under the Creative Commons - GNU GPL license.
// http://www.thingiverse.com/thing:112117

/* [Hole] */

// Hole Shape 
shape= 16; // [ 3:Triangle, 4:Square, 5:Pentagon, 6:Hexagon, 8:Octagon, 16:Rough Circle, 128:Smooth Circle ]

// Diameter of a circle connecting all the points definiting your hole's shape (mm). 
diameter = 100; 

// Hole depth (mm)
depth = 10 ; 

// Width of the screen's frame (mm).
frame_thickness = 1.2;

// Size of the border (mm). Only 'flush' screens have borders. 
border_size = 2.4;

//Include nubs for tight fitting on circles
nubs = 0; //[0:1]

/* [Screen] */

// Spacing between mesh threads (mm). 
mesh_space=3;

//How thick to draw the mesh in terms of the extrusion width
mesh_thick=1; //[1:10]

// Thickness of the screen (mm). It should be a multiple of your slicer's layer height for best results.
mesh_height=2.2; 

// Screen is flush to the surface or recessed.
indention = 0; // [0:Recessed, 1:Flush]

/* [Slicer] */

// The thickness of your slices (mm). Screen threads are a multiple of this for their height.
printer_layer_height = 0.20;  

// The shell or skin size of your slicer (mm) .
printer_skin_size =    0.4;

// The width of your extruded filament (mm). Screen threads are a multiple of this for their width. 
printer_extrusion_width = 0.4;

/* [Hidden] */
 
smooth = shape;

custom_shape_screen();

module custom_shape_screen() {
union() {
	difference() {   
		union() {
			cylinder(h=depth+1, r=diameter/2, $fn=smooth);		

			if (indention == 1)  
				// Brim if screen is flush and at the bottom 
				cylinder(h=frame_thickness, r=(border_size + diameter/2), $fn=smooth);
			else
			{
				// OR add a small brim on the bottom side (that prints on top)
				translate([0,0,depth-printer_extrusion_width*3])
				{
					union()
					{
					cylinder(h=printer_skin_size*5, r=(printer_extrusion_width + diameter/2), $fn=smooth);
		translate([0,0,-printer_skin_size*9.5])
									cylinder(h=printer_skin_size*10,
									r2=((printer_extrusion_width + diameter + 8* printer_extrusion_width)/2),
									r1=((printer_extrusion_width + diameter)/2),
									center=false,
								   $fn=smooth);
					}
					difference()
					{
						cylinder(h=printer_skin_size*8, 
								r=((printer_extrusion_width + diameter + 8* printer_extrusion_width)/2), 
								$fn=smooth);
						union()
						{
							cylinder(h=printer_skin_size*10, 
								r=((5*printer_extrusion_width + diameter)/2), 
								$fn=smooth);
						}
					}
				}
			}
		}

		translate([0,0,-1])
		cylinder(h=depth+3, r=(diameter/2)-frame_thickness, $fn=smooth);
	}

	meshscreen_shape(h=mesh_height,
				mesh_w=printer_extrusion_width*mesh_thick,
				mesh_space=mesh_space,
				width=diameter,
				layer_h=printer_layer_height);

	// Make little nubs on the sides to tighten the fit a little (but only for circles).
	if (smooth > 8 && nubs > 0)
	for (i = [0:3]) {
		rotate(90*i,[0,0,1])
		translate([(diameter/2),0,depth/2])
		cube(size=[1,1,depth],center=true);
	}
}
}

module meshscreen_shape(h=2,mesh_w=1,mesh_space=2,width=60,layer_h){
	intersection(){
		cylinder(r=width/2,h,$fn=smooth);
		mesh_raw(h=h,mesh_w=mesh_w,mesh_space=mesh_space,width=width,layer_height=layer_h);
	}
	difference(){
		cylinder(r=width/2,h, $fn=smooth);
		translate([0,0,-h*0.05]) cylinder(r=width/2-0,h=h*1.1, $fn=smooth);
	}
}

module mesh_raw(h=2,mesh_w=1,mesh_space=2,width=50,layer_height){
	for ( j = [0 :(mesh_w+mesh_space): width] )
	{
	   	translate([0,0,0.01])translate([-width/2+j, 0, h/4])cube([mesh_w,width,h/2-layer_height/10],center=true);
		translate([0,0,0.01])translate([0, -width/2+j, h/4])cube([width,mesh_w,h/2],center=true);
	}
}
