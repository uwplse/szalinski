//Parametric adaptor bracket generator for the Aus3D IR Z Probe

//-------------------Edit these values---------------------//

//the Z offset, amount to lower the probe by
z_height = 30.0;      

//hole spacing that the bracket is mounting to. 24mm = 30mm fan, 32mm = 40mm fan, 40mm = 50mm fan.
hole_spacing = 32;  

//thickness of the bracket
thickness = 5;      

//-----Probably don't edit these (unless you want to)-----//

//Inner hole diameter (Ignore)
hole_size = 3.5;

//Outer diameter around screw holes (Ignore)
hole_od = 7;

//Distance between screw holes on probe (Ignore)
probe_hole_spacing = 24;


module screwHole(x,y) {
    translate([x,y,0]) {
        difference() {
            cylinder(thickness,hole_od,hole_od,true);
            cylinder(thickness+1,hole_size,hole_size,true);
        }
    }
}

module hole(x,y) {
    translate([x,y,0]) {
        cylinder(thickness+1,hole_size,hole_size,true);
    }
}
    
difference() {
    
    union() {
    
        screwHole(hole_spacing/2,-z_height/2);
        screwHole(-hole_spacing/2,-z_height/2);
        screwHole(probe_hole_spacing/2,z_height/2);
        screwHole(-probe_hole_spacing/2,z_height/2);
        
        linear_extrude(height = thickness, center = true, convexity = 10, slices = 20, scale = 1.0) {
            
            polygon(points = [ 
            [-hole_spacing/2-hole_od, -z_height/2], 
            [-hole_spacing/2, -z_height/2-hole_od], 
            [hole_spacing/2, -z_height/2-hole_od],
            [hole_spacing/2+hole_od, -z_height/2],
            [probe_hole_spacing/2+hole_od, z_height/2],
            [probe_hole_spacing/2, z_height/2+hole_od],
            [-probe_hole_spacing/2, z_height/2+hole_od],
            [-probe_hole_spacing/2-hole_od, z_height/2],
            ], 
            convexity = N);

        }
    }

    hole(hole_spacing/2,-z_height/2);
    hole(-hole_spacing/2,-z_height/2);
    hole(probe_hole_spacing/2,z_height/2);
    hole(-probe_hole_spacing/2,z_height/2);
}
        

