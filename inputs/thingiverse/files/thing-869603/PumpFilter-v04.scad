// Parametric Pump Filter (c) 2015 David Smith
// licensed under the Creative Commons - Attribution - Non Commercial
// http://www.thingiverse.com/thing:869603

/* [Filter] */

// (mm). 
filter_diameter = 25; 

// (mm)
connector_diameter = 10; 

// (mm)
connector_length =14;

// (mm).
wall_thickness = 1.2;

/* [Filter] */

// Spacing between filter threads (mm). 
mesh_space=1.5;

// Thickness of the filter screen (mm). It should be a multiple of your slicer's layer height for best results.
mesh_height=2.0; 

/* [Slicer] */

// The thickness of your slices (mm). Filter threads are a multiple of this for their height.
printer_layer_height = 0.25;  

// The shell or skin size of your slicer (mm) .
printer_skin_size =    0.6;

// The width of your extruded filament (mm). Filter threads are a multiple of this for their width. 
printer_extrusion_width = 0.55;

/* [Hidden] */
 
// Hole Shape 
shape= 128; // [ 3:Triangle, 4:Square, 5:Pentagon, 6:Hexagon, 8:Octagon, 16:Rough Circle, 128:Smooth Circle ]
 
smooth = shape;

funnel_length = max( connector_diameter - filter_diameter,
                     filter_diameter - connector_diameter );
custom_filter();
  
module custom_filter() {
     
union() {
	difference() {   
		union() {
            // Filter
			cylinder(   h=mesh_height, 
                        r=(filter_diameter/2)+wall_thickness, $fn=smooth);		

            // Funnel
			translate([0,0,mesh_height])
			cylinder(  h=funnel_length, 
                        r1=(filter_diameter/2)+wall_thickness, 
                        r2=(connector_diameter/2)+wall_thickness,
                        $fn=smooth);
            
            // Connector
            translate([0,0,mesh_height+funnel_length])
            cylinder(  h=connector_length, 
                        r=(connector_diameter/2)+wall_thickness, 
                        $fn=smooth);
	}

        union() {
            translate([0,0,-1])
            // The hole for the screen
            cylinder(   h=mesh_height+1, 
                        r=(filter_diameter/2), 
                        $fn=smooth);
            
            // The hole for the funnel
            translate([0,0,mesh_height])
            cylinder(   h=funnel_length, 
                        r2=(connector_diameter/2),
                        r1=(filter_diameter/2), 
                        $fn=smooth);
            
            // The hole for the connector
            translate([0,0,mesh_height+funnel_length])
            cylinder(  h=connector_length, 
                        r=(connector_diameter/2), 
                        $fn=smooth);
        }
	}

	meshscreen_shape(h=mesh_height,
				mesh_w=printer_extrusion_width,
				mesh_space=mesh_space,
				width=filter_diameter,
				layer_h=printer_layer_height);
    
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

		translate([0,0,h/2+.02])translate([0,-width/2+j, h/4])cube([width,mesh_w,h/2],center=true);
	}
}