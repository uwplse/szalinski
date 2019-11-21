$fn = 30;

//height from floor to center of lens
frame_height            = 30;

//frame lens holder dimensions
frame_rim_height        = 3.2;
frame_rim_width         = 1.2;
frame_edge_width        = 1.2;

//foot sizing - foot only gets added when rail == false
foot_height             = 2;
foot_length             = 10;

//lens sizing
lens_diameter           = 20;
lens_rim_width          = 1;
lens_center_width       = 2;

//rail connector - only added when rail == true
rail                    = false;
rail_upper_width        = 12.2;
rail_lower_width        = 4.4;
rail_opening_width      = 4.6;
rail_height             = 4.4; // trapezoid inside rail
rail_handle_height      = 1.8; // on top of trapezoid
rail_minkowski_diameter = 0.36;

//calculate derived dimensions
frame_width     = 2 * frame_rim_width + lens_center_width;
frame_diameter  = lens_diameter +2 * frame_edge_width;
pillar_height   = frame_height - frame_diameter/2;
pillar_width    = frame_width; // only when rail is false


// basic lens shape
module lens(diameter, rim_width, center_width){
    //upper half lens 
    translate([0,0,rim_width/2]){
        intersection(){
            cylinder(h = center_width/2,
                     d1 = diameter,
                     d2 = diameter);
            resize([0,0,center_width - rim_width])
                sphere(d = diameter);
        }
    }
    
    //lower half lens
    mirror([0,0,1]){
        translate([0,0,rim_width/2]){
            intersection(){
                cylinder(h = center_width/2,
                         d1 = diameter,
                         d2 = diameter);
                resize([0,0,center_width - rim_width])
                    sphere(d = diameter);
            }
        }    
    }
    //rim
    cylinder(h = rim_width,
             d1 = diameter,
             d2 = diameter,
             center = true);
}


// main frame
module frame(){
    hull(){
        //pillar
        pillar_offset = (pillar_height - frame_edge_width + frame_diameter)/2;
        translate([0,-pillar_offset,0])
            if (rail == true){
                pillar_width = rail_opening_width; // make sure pillar fits rail
                cube([pillar_width,
                      pillar_height + frame_edge_width,
                      frame_width],
                     center = true);
            } else {
                cube([pillar_width,
                      pillar_height + frame_edge_width,
                      frame_width],
                     center = true);
            }


        //lens frame
        cylinder(h = frame_width,
                 d1 = frame_diameter,
                 d2 = frame_diameter,
                 center = true
                );
    }
    
    if(rail == false) {
        //foot
        foot_offset = frame_height - foot_height/2;
        translate([0,-foot_offset,0])
            cube([frame_diameter,
                  foot_height,
                  foot_length],
                 center=true);
    }
    
    if(rail == true) {
        rail_offset = frame_height + rail_height/2 + rail_handle_height;
        translate([0,-rail_offset,0])
            rail_connector(height = rail_height,
                           length = frame_width,
                           uwidth = rail_upper_width,
                           lwidth = rail_lower_width,
                           owidth = rail_opening_width,
                           hheight = rail_handle_height,
                           md = rail_minkowski_diameter);
    }
}


// lens cutout
module lens_cutout(){
    union(){
        //opening on top for lens insertion
        translate([0,frame_diameter/4,0])
            cube([lens_diameter,
                  frame_diameter/2,
                  lens_center_width],
                  center = true);
        
        //lens cutout
        lens(lens_diameter,
             lens_rim_width,
             lens_center_width);
        
        //openings on the sides
        cylinder(h = frame_width,
                 d1 = lens_diameter - 2 * (frame_rim_height - frame_edge_width),
                 d2 = lens_diameter - 2 * (frame_rim_height - frame_edge_width),
                 center = true);
    }
}




//rail bar connector
module rail_connector(height=4.4, length=5, uwidth=12.2, lwidth=4.4, owidth=4.6, hheight=1.8, md=0.36){
    //handle
    translate([0,hheight/2 + height/2,0])
        cube([owidth, hheight, length], center=true);

    //rail shape
    linear_extrude(length, center=true){
        offset(r = md){
            offset(r = -md){
                polygon(points = [[-lwidth/2,0 -height/2],
                                  [lwidth/2,0 - height/2],
                                  [uwidth/2, height/2],
                                  [-uwidth/2, height/2]],
                                 paths  = [[0,1,2,3]]);
            }
        }
    }
}


// final object
difference(){ 
    frame();
    lens_cutout();
}

