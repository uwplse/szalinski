Render = "entire"; // [body:Case,lid:Lid,entire:Entire]

screw_cones = true; // [true:Yes,false:No]
wall_thickness=1.5;
pillar_thickness_factor=4;
lid_thickness=3;
floor_thickness=8;
wall_height=70;
wall_width=90;
wall_length=160;
button_diameter=28; // [28:M28,24:M24]
buttons_per_row=4;
button_rows=2;

buttonSpace=wall_length/buttons_per_row;

module case() {
    translate([0,0,0])
        cube([wall_width,wall_thickness,wall_height]);
        cube([wall_thickness,wall_length,wall_height]);
        cube([wall_width,wall_length,floor_thickness]); // floor

    translate([0,wall_length,0])
        cube([wall_width,wall_thickness,wall_height]);

    translate([wall_width,0,0])
        cube([wall_thickness,wall_length+wall_thickness,wall_height]);

    // Pillars
        translate([wall_thickness,wall_thickness,0])
            cube([wall_thickness*pillar_thickness_factor,wall_thickness*pillar_thickness_factor,wall_height]);
        translate([wall_width-pillar_thickness_factor-wall_thickness,wall_thickness,0])
            cube([wall_thickness*pillar_thickness_factor,wall_thickness*pillar_thickness_factor,wall_height]);
        translate([wall_thickness,wall_length/2-pillar_thickness_factor/2,0])
            cube([wall_thickness*pillar_thickness_factor,wall_thickness*pillar_thickness_factor,wall_height]);
        translate([wall_width-pillar_thickness_factor-wall_thickness,wall_length/2-pillar_thickness_factor/2,0])
            cube([wall_thickness*pillar_thickness_factor,wall_thickness*pillar_thickness_factor,wall_height]);
        translate([wall_thickness,wall_length-pillar_thickness_factor-wall_thickness,0])
            cube([wall_thickness*pillar_thickness_factor,wall_thickness*pillar_thickness_factor,wall_height]);
        translate([wall_width-pillar_thickness_factor-wall_thickness,wall_length-pillar_thickness_factor-wall_thickness,0])
            cube([wall_thickness*pillar_thickness_factor,wall_thickness*pillar_thickness_factor,wall_height]);


};

module lid() {
    difference() {
        translate([0,0,wall_height]) cube([wall_width+wall_thickness,wall_length+wall_thickness,lid_thickness]); // lid
        for ( r = [1:2:3] ) {        
            for ( h = [0:buttons_per_row-1] ) {
               translate ([wall_width/4*r+wall_thickness/2,buttonSpace*h+wall_thickness/2+buttonSpace/2,wall_height]) cylinder(lid_thickness*2, button_diameter/2,button_diameter/2);
            };
        };
        // Screw cones
        if (screw_cones) {
            translate([wall_thickness+pillar_thickness_factor/2,wall_thickness+pillar_thickness_factor/2,wall_height])
                cylinder($fn=20,pillar_thickness_factor,pillar_thickness_factor/6,lid_thickness);
            translate([wall_width-pillar_thickness_factor+pillar_thickness_factor/2,wall_thickness+pillar_thickness_factor/2,wall_height])
                cylinder($fn=20,pillar_thickness_factor,pillar_thickness_factor/6,lid_thickness);
            translate([wall_thickness+pillar_thickness_factor/2,wall_length/2,wall_height])
                cylinder($fn=20,pillar_thickness_factor,pillar_thickness_factor/6,lid_thickness);
            translate([wall_width-pillar_thickness_factor/2,wall_length/2+wall_thickness,wall_height])
                cylinder($fn=20,pillar_thickness_factor,pillar_thickness_factor/6,lid_thickness);
            translate([wall_thickness+pillar_thickness_factor/2,wall_length-pillar_thickness_factor/2,wall_height])
                cylinder($fn=20,pillar_thickness_factor,pillar_thickness_factor/6,lid_thickness);
            translate([wall_width-pillar_thickness_factor/2,wall_length-pillar_thickness_factor/2,wall_height])
                cylinder($fn=20,pillar_thickness_factor,pillar_thickness_factor/6,lid_thickness);
        };
    };
};
 
if ((Render=="body") || (Render=="entire"))  case();
if ((Render=="lid") || (Render=="entire")) lid();
