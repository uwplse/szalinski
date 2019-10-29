socket_width = 122.8 + 1;   // add 1mm 
socket_depth = 19.8 + 0.5;  // add 0.5mm
socket_height = 18;
socket_gauge = 3.5;

plate_gauge = 2.8;
plate_height = 120;
plate_width = socket_width+2*socket_gauge;


$fn=50;

// ===================================================


module panel()
{
    corner_r = 4;

    translate([0,+socket_height+socket_gauge,0])
    
    difference()
    {
        // plate with round corners
        hull()
        {
                cube([
                    plate_width,
                    plate_height-corner_r,
                    plate_gauge
                ]);
                
                // round corners
                translate([corner_r,plate_height-corner_r,0])
                    cylinder(r=corner_r, h=plate_gauge, center=false);
            
                translate([
                    socket_width+2*socket_gauge-corner_r,
                    plate_height-corner_r,
                    0])
                    cylinder(r=corner_r, h=plate_gauge, center=false);        
        } 
        
        // 4 vertical cut outs       
        hole_width = plate_width/9;
        for (i=[0:4])
            translate([i*2*hole_width+hole_width,25,0])
                cube([hole_width,plate_height-40,plate_gauge]);

        // break outline for reduced warping
        translate([0,7,0])
            cube([hole_width/2,5,plate_gauge]);

        translate([plate_width-hole_width/2,7,0])
            cube([hole_width/2,5,plate_gauge]);   
   
        translate([4*hole_width,7,0])
           cube([hole_width,5,plate_gauge]);      
        
    } 

    

}

module socket()
{
    difference()
    {
        union()
        {
        
            // base cube
            cube([
                socket_width+2*socket_gauge,
                socket_height+socket_gauge,
                socket_depth+2*socket_gauge
            ]);

            // nose, front restraint for iPad
            translate([
                0,
                socket_height+socket_gauge,
                socket_depth+socket_gauge
            ])
                cube([
                    socket_width+2*socket_gauge,
                    4,
                    socket_gauge
                ]);
            
            // midlle restraint, half cylinder
            translate([
                0,
                socket_height+socket_gauge,
                socket_depth/2+socket_gauge
            ])
                rotate([0,90,0])
                    cylinder(
                        r=2, 
                        h=socket_width+2*socket_gauge, 
                        center=false
                    );
        
        }
        
        // subtract the Concept-2 Display encasing from base cube
        translate([socket_gauge, 0, socket_gauge])
        cube([
            socket_width,
            socket_height,
            socket_depth
        ]);
        
        
    }
}

panel();
socket();