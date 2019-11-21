// twist-off-cap generator or as we say in german:
// Nockendrehverschlussgenerator

// inner diameter of the lid
diameter = 41; // [10.0:100.0]
// inner height of the lid
height = 8; // [1:20]

simple_lid = false;
wall_thickness = 4;

//  number of lugs
n = 4; // [3,4,6]
// lug width
lug_width = 1; 
// lug thickness (height)
lug_thickness = 1; 
// height of the chamfer (0 = off)
chamfer_size = 0.5; 

// enables coin slot generation (e.g. for creating a savings box)
coin_slot = false;
coin_slot_length = 28;
coin_slot_width = 3.2;

// generate hole pattern (e.g. for a salt dispender)
hole_pattern = false;
// diameter of each hole of the pattern
hole_pattern_diameter = 1.5;
// number of concentric rings with holes to generate
hole_pattern_rings = 5;


// hidden
$fn = 1 * 64; // number of fragments
overlap = 1 * 0.5; // oversizing lug ring to get a manifold mesh (otherwise openScad will crash)

// cam polygon parameter
di = diameter - 2 * lug_width; // inner diameter
dp = di * tan(180/n) / sin(180/n); // outer polygon diameter
dc = diameter * tan(180/n) / sin(180/n); // chamfering polygon diameter

// scaling of imported stl mesh
sxy = diameter / 20; // (20mm diameter)
sz = height / 3; // (3mm height)
        
union() {
    // lug construction
    translate([0, 0, height-lug_thickness-chamfer_size-overlap])
    color([0.8, 0, 0])
    render() difference(){
        cylinder(d=diameter+overlap, h=lug_thickness+chamfer_size); // cylinder
        translate ([0, 0, chamfer_size]) cylinder(d=dp, h =lug_thickness, $fn=n); // n-sided polygon
        cylinder(d1=dc, d2=dp, h=chamfer_size, $fn=n); // chamfering
    }
    
    difference() {
        if (simple_lid) {
            // simple lid            
            color([0.0, 0.6, 0.8])
            render() difference() {
                translate([0, 0, -wall_thickness])
                cylinder(d=diameter+wall_thickness, h=height+wall_thickness);
                cylinder(d=diameter, h=height);
            }
        } else {
            // load prefab jar lid model  
            scale([sxy, sxy, sz])
            color([0.0, 0.6, 0.8])
            import("jar-lid_blank.stl", convexity=3);
        }
        // coin slot
        if (coin_slot) {
            translate([0, 0, -0.5*sz*wall_thickness]) 
            cube([coin_slot_length, coin_slot_width, sz*wall_thickness], center=true);
        }
        
        // hole pattern
        if (hole_pattern) {
            for (ring = [1:hole_pattern_rings]) {
                n = ring*ring + 1;
                r = 2* (ring-1) * hole_pattern_diameter;
                
                for (i = [1:n]) {
                    x = r * cos(i*360/n);
                    y = r * sin(i*360/n);
                    
                    translate([x, y, -sz*wall_thickness])            
                    cylinder(d=hole_pattern_diameter, h=sz*wall_thickness);
                }
            }
        }
    }
}
    

