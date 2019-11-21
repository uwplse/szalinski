// Ultra Grip Pick 0.1 - a parametric symmetrical plectrum designed to be ultra-grippy, Antti Suomela August 2017
// CC-BY-SA-NC - Creative Commons Attribution-NonCommercial-ShareAlike 3.0

/* Set thickness, length, and other parameters as you like. */ 
thickness = 0.7;        // plectrum thickness, as expected, default: 0.7 
length = 30;            // from base to tip (hint: keep the plectrum longer than it is wide for best results) default: 30
width = 26;             // speaks for itself, default: 26
taper = 1;              // default: 1mm taper distance from the thick bit to the very edge

/* Not commonly changed, but nevertheless changeable variables. Chunk and funk change the shape of the plectrum in a certain way. Experiment! :-) */
chunk = 0.327;         // practical range 0 to 0.345 to avoid going beyond set length and width parameters, experiment! :-) (default: 0.327)
funk = 0.2;            // practical range 0 to 0.3 without going beyond set length and width parameters (default: 0.2)

/* The following are the grip hole parameters. Adjust to your liking. */
hole_size = 5;          // diameter in millimetres, default: 5
hole_separation = 6;


i = 0;

module main_part(t) {               // this establishes the shape and size of the plectrum, the t parameter is the thickness
    linear_extrude(height = t, convexity = 10, center = true)
    resize(newsize=[length, width, thickness])
    hull() {
            circle(width / 2, $fn = 50);
            translate([funk * -length, chunk * width, 0])
                circle(4, $fn = 30);              // base corner #1
            translate([funk * -length, chunk * -width, 0])
                circle(4, $fn = 30);              // base corner #2
            translate([length - width / 2 - 1.5, 0, 0])
                circle(1.5, $fn = 50);                              // tip
    }

}
module taper() {                    // this does the tapering at the edge of the plectrum
    hull() {
            resize(newsize=[length - taper, width - taper, thickness])      
            main_part(thickness);
            main_part(0.01);        
    }
}


module hole_tool(size) {                // this creates the tool used to cut the holes later in create_holes
    circle(d = size, $fn = 20);
}
    


module create_holes() {
    difference() {   
        taper();     
        translate([0,0,0])
        for (i = [0:5]) {      
            rotate([0,0,60+i*60])
            for(i = [0:10]) {
                    if (i*hole_separation+hole_size < width / 2) {
                        linear_extrude(height = thickness + 1, center = true)
                        translate([i*hole_separation,0,0])
                        if (i == 0) { hole_tool(hole_size); }
                        else { hole_tool(hole_size/2+(i*i)/2); }
                        
                    }
                
            }
        }
    }
}

create_holes();
