// preview[view:south, tilt:top]

// Radius of inner triangle
sign_r = 35; // [30:1:100]

// Inner thickness of sign
inner_t = 4.2; // [1:.1:10]

// Extrusion of border and symbol
extr = 1.4; // [.4:.1:5]

// Width of border
border_w = 3.0; // [1:.1:15]

// Make screw holes
use_screws = 1; // [0: False, 1:True]

// Radius of screw hole
screw_r = 1.75; // [1:.05:5]

// Radius of screw head
screw_head_r = 3.5;  // [.5:.1:5]

// Height of screw head
screw_head_h = 2; // [0:.1:5]

// Distance between screw hole and triangle corner
screw_dist = 11.5; // [1:.1:15]

// Horizontal scale of symbol
symbol_scale = 1.0; // [.5:.1:5]

// Select symbol
symbol = "rad"; // [none:None,biohaz:Biohazard, rad:Radiation, skull:Skull and bones, generic: Generic caution, custom: Heightfield bitmap (PNG)]

// Filename for custom symbol heightfield (PNG)
symbol_bitmap = ""; // [image_surface:150x150]

/* [hidden] */
border_t = inner_t+extr;
lathe = 64;
overlap = 0.1;
screw_head_ofs = 1;

// Preview colors
color_base = "gray";
color_extr = "blue";

warning_triangle();

translate([0, 0, overlap])
color(color_extr)
scale([symbol_scale, symbol_scale, 1])

if(symbol == "biohaz")
    linear_extrude(height=border_t-overlap)
    biohazard(lathe);

else if(symbol == "rad")
    linear_extrude(height=border_t-overlap)
    radiation(lathe);

else if(symbol == "skull")
    linear_extrude(height=border_t-overlap)
    skull();

else if(symbol == "generic")
    linear_extrude(height=border_t-overlap)
    generic();

else if(symbol == "custom")
    intersection() {
        difference() {
            translate([0, 0, inner_t-overlap-.01])
            scale([.25*symbol_scale, .25*symbol_scale, .01*extr])
            surface(file = symbol_bitmap, center = true);
            
            screws();
        }
        rotate(90)
        cylinder(r=sign_r, $fn=3, h=border_t+1);
    }


function triangle(r) = [
    for (i = [ 0 : 2 ]) 
        let (
            x = r * cos(120*i-30),
            y = r * sin(120*i-30)
        ) [x, y]
];

module warning_triangle() {
    corners = triangle(sign_r);

    difference() {
        color(color_extr)
        linear_extrude(height=border_t) {
            hull() {
                for(i=[0:2]) {
                    translate(corners[i])
                    circle(r=border_w, $fn=lathe);
                }
            }
        };
        
        color(color_base)
        translate([0, 0, inner_t])
        linear_extrude(height=border_t) {
            polygon(corners);
        };
        
        screws();
    }
}

module screws() {
    module screw() {
        h1=inner_t-screw_head_h-screw_head_ofs;
        h2=h1 + screw_head_h; 
        h3=border_t+50;
        
        fudge = -.001;
        rotate_extrude($fn = 32)
        polygon(points=[
            [0, fudge], 
            [screw_r, fudge],
            [screw_r, h1], 
            [screw_head_r, h2], 
            [screw_head_r, h3], 
            [0, h3]
        ]);
    }    
    
    if(use_screws) {
        screw_pos = triangle(sign_r-screw_dist);
        
        color(color_base)
        for(i=[0:2]) {
            translate(screw_pos[i])
            screw();
        }
    }
}

module radiation(fn) {
    module radiation_section() {
        difference() {            
            circle(r=46, $fn=fn);
            circle(r=14, $fn=fn);
            
            translate([-100, 0])
            square(200);
            
            rotate(90+60)
            square(100);
            
            rotate(0-60)
            square(100);
        }
    }
    
    scale(0.33) {
        for(i=[0:2])
            rotate(i*120)
            radiation_section();
        circle(9, $fn=fn);
    }
}

module skull() {
    module bone() {
        translate([0, -2])
        
        polygon(points=[
            [.5, 0],
            [7, 0],
            [7, 4],
            [-.1, 4]
        ]);
        
        translate([7, 2])
        circle(r=3, $fn=16);
        
        translate([7, -2])
        circle(r=3, $fn=16);
    }
    
    scale(.7)
    translate([0, -3]) {
        difference() {
            scale([1, .85])
            circle(15);

            // Left eye
            translate([-6, 0])
            scale([1, 1.2])
            circle(5);
            
            // Right eye
            translate([6, 0])
            scale([1, 1.2])
            circle(5);
            
            // Nose
            polygon(points=[
                [0, -4],
                [-4, -10],
                [0, -9],
                [4, -10],
            ]);
        }
        
        // Left tooth
        polygon(points=[
            [-3, -10],
            [-4.5, -18],
            [-8.5, -18],
            [-5.5, -10]
        ]);
        
        // Middle tooth
        polygon(points=[
            [1, -10],
            [2, -18],
            [-2, -18],
            [-1, -10]
        ]);
        
        // Right tooth
         polygon(points=[
            [3, -10],
            [4.5, -18],
            [8.5, -18],
            [5.5, -10]
        ]);
        
        // Bones
        rotate(35)
        translate([15, 0])
        bone();
        
        rotate(-145)
        translate([15, 0])
        bone();        
        
        mirror([1, 0, 0])
        rotate(35)
        translate([15, 0])
        bone();
        
        mirror([1, 0, 0])
        rotate(-145)
        translate([15, 0])
        bone();   
    }
}

/*
module skull() {
    text("\u2620", size=23, font="Segoe UI Symbol", 
        halign="center", valign="center");
}
*/

module generic() {
    hull() {
        translate([0, 13])
        circle(r=3.5, $fn=16);

        translate([0, -3])
        circle(r=2.5, $fn=16);
    }

    translate([0, -11])
    circle(r=2.5, $fn=16);
}

module biohazard(fn) {
    module biohazard_section(fn) {
        difference() {
            translate([0, 11])
            circle(15, $fn=fn);
            
            circle(3, $fn=fn/2);
            
            translate([0, 15])
            circle(10.5, $fn=fn);

            translate([0, 26])
            square(size=[4,4], center=true);    

            translate([0, 4])
            square(size=[1,4], center=true);

            rotate(60)
            translate([-10, -10])
            square(size=[10, 30], center=false);

            rotate(-60)
            translate([0, -10])
            square(size=[10, 30], center=false);    
        };
        
        intersection() {
            translate([0, 15])
            circle(9.5, $fn=fn);
            difference() {
                circle(13.5, $fn=fn);                
                circle(10, $fn=fn);
            }    
        } 
    }    
    
    scale(.67) {
        for(i=[0:2]) {
            rotate(i*120)
            biohazard_section(fn);
        }
    }
}

