/* [Global] */

// How deep should the hexagonal hole for the wheel shaft be?
shaft_pocket_len = 13; // [ 1:30 ]

// How long past the end of the shaft should the hub extend?
extension = 10; // [ 3: 40 ]

// How wide should the shaft be between flats?  ( this will require tweaking for material and printer properties )
hex_shaft_across_flats_mm = 8.17; // [ 4:80 ]

// inner hub diameter ( make it bigger than hex_shaft_across_flats_mm + 3 )
inner_hub_diameter_mm = 15; // [ 7:80 ]

// paddle hub diameter ( make it bigger than inner_hub_diameter_mm + 10 )
paddle_hub_diameter_mm = 30; // [ 13:80 ]

// paddle hub thickness ( make it bigger than hex_shaft_across_flats_mm + 10 )
paddle_hub_thickness_mm = 8; // [ 5:80 ]


// paddle slot thickness ( tweak for material + printer  )
paddle_slot_thickness_mm = 1; // [ 0.1:4 ]

// How many paddles? 
numpaddles = 4; // [ 0:24 ]


/*  [Hidden] */
screw_hole_height = 3;
tallness = shaft_pocket_len + extension;

 module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}

difference () {
    union() {
        cylinder (d=paddle_hub_diameter_mm, h=paddle_hub_thickness_mm);
        cylinder (d=inner_hub_diameter_mm, h=tallness);
    }
    translate ([0, 0, tallness - shaft_pocket_len + 0.01]) {
        cylinder_outer (height = shaft_pocket_len, radius = hex_shaft_across_flats_mm/2, fn=6); 
    }
    translate ([0, 0, -0.01])cylinder (d =hex_shaft_across_flats_mm, h = tallness -shaft_pocket_len - screw_hole_height);
    translate ([0, 0, tallness - shaft_pocket_len - screw_hole_height * 0.66])
        cylinder_outer (radius =3/2, height = screw_hole_height );
    translate ([0,0,-0.1]) difference () {
        union () {
            for (rot= [0:360/numpaddles:359]) { 
                rotate([0,0,rot]) cube([paddle_hub_diameter_mm + 0.01, paddle_slot_thickness_mm,tallness]);
            }
        }
        cylinder (d=15, h=tallness);
    }
}

