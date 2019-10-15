// cat toy sphere maker, by Tyler Bletsch

$fn=32*1; // << decent quality spheres

// Diameter of sphere (mm)
dia = 35; // [10:120]

// Thickness of the walls (1% for almost nonexistant, 100% for solid)
wall_thickness_percentage = 5; //[1:100]
wall_thickness = wall_thickness_percentage/100 * dia; 

// Minimum space between gaps (percentage of circumference). Smaller = more holes, bigger means fewer holes.
gap_space_percent = 2; // [1:15]
gap_space = PI*dia*gap_space_percent/100;
//gap_space =20;

// Size of gaps. 
gap_size_percent = 3; // [1:15]
gap_size = PI*dia*gap_size_percent/100;
//gap_size = 1;

// Type of cutaway
style="holes"; // [slots,holes]

// Type of hole (if cutaway style is "holes")
hole_type="round"; // [round,triangle,square,diamond,hexagon]

// hole math:
// number of holes per longitude
n_theta = ceil(PI*dia/(gap_space+gap_size));
// number of longitudes to chop holes in
n_phi = n_theta/2;

// rough heuristic to put thingies on a sphere
// thingies are fairly uniform if n_phi == n_theta/2
module at_sphere_holes(n_phi,n_theta) {
        for (j = [0:(n_phi-1)]) {
            phi = 180/(n_phi-1)*j;
            this_n_theta = floor((1-abs(phi-90)/90)*(n_theta-1))+1; // linear interpolate so we have full n_theta holes at the equator and max of 1 at the poles
            for (i = [0:(this_n_theta-1)*1]) {
                theta = 360/this_n_theta*i;
                rotate([phi,0,theta]) children();
            }
        }
}

difference() {
    sphere(d=dia,$fn=$fn*2); // initial sphere
    sphere(d=dia-wall_thickness*2);  // make hollow
    
    if (style=="slots") {
        n_gaps = floor(dia/(gap_size+gap_space)*0.95);
        gap_total_z = n_gaps*(gap_size+gap_space)-gap_space;
        for (i = [0:n_gaps-1]) {
            for (m = [0:1]) mirror([m,0,0]) 
                translate([gap_space/2,-dia/2,(gap_size+gap_space)*i-gap_total_z/2]) 
                    cube([dia,dia,gap_size]);
            translate([0,0,-dia/2]) cylinder(d=gap_size, h=dia);
        }
    } else if (style=="holes") {
        if (hole_type=="square") {
            at_sphere_holes(n_phi,n_theta) translate([-gap_size/2,-gap_size/2,0]) cube([gap_size,gap_size,dia/2+1]);
        } else {
            hole_fn = 
                hole_type=="round" ? $fn :
                hole_type=="triangle" ? 3 :
                hole_type=="diamond" ? 4 :
                hole_type=="hexagon" ? 6 :
                $fn;
            dia_adj = 
                hole_type=="round" ? 1 :
                hole_type=="triangle" ? 1.4 :
                hole_type=="diamond" ? 1.3 :
                hole_type=="hexagon" ? 1.2 :
                1;
            at_sphere_holes(n_phi,n_theta) cylinder(d=gap_size*dia_adj,h=dia/2+1, $fn=hole_fn);
        }
    }
}