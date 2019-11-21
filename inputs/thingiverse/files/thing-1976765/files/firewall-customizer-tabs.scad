// Firewall Customizer
// with optional mounting tabs
// written by Dave Halderman
// 2017-10-08

// Total width (mm)
width = 31;

//Total height (mm)
height = 25;

//Thickness (mm)
thickness = 4; //[2:0.5:6]

//Diameter of center hole (mm)
center_hole_dia = 8; //[0:0.5:16]

//Diameter of bolt holes
bolt_hole_dia = 3.3; //[2.2:M2, 3.3:M3, 4.4:M4]

//Spacing of left/right holes (mm - center to center)
horiz_hole_spacing = 19; //[12:1:19]

//Spacing of top-bottom holes (mm - center to center)
vert_hole_spacing = 16; //[12:1:19]

//Motor wire notch width (mm)
notch_width = 6; //[0:0.5:12]

//Motor wire notch height (mm)
notch_height = 4; //[0:0.5:8]

//Mounting tab length (mm) - set to 0 for no tabs
tab_length = 10; //[0:1:25]

//Mounting tab height (mm)
tab_height = 4; //[0:1:25]

//Mounting tab thickness (mm)
tab_thickness = 1.5; //[1:0.5:3]

//Mounting tab position (mm from bottom of firewall)
tab_pos = 5; //[0:1:20]

//Foam thickness (mm) - used to offset tabs from edge of firewall
foam_thickness = 5; //[0:0.5:10]

/* [Hidden] */
$fn=100;

difference() {
    union() {
        firewall();
        tabs();
    }
    notch_bevel();
    hole_bevel();
}

module firewall() {
    linear_extrude(thickness) {
        difference() {
            square([width,height],center=true);
            circle(d=center_hole_dia);
            translate([horiz_hole_spacing/2,0,0]) circle(d=bolt_hole_dia);
            translate([-horiz_hole_spacing/2,0,0]) circle(d=bolt_hole_dia);
            translate([0,vert_hole_spacing/2,0]) circle(d=bolt_hole_dia);
            translate([0,-vert_hole_spacing/2,0]) circle(d=bolt_hole_dia);
            translate([((2/3)*width)-(width/2),(height/2)-notch_height,0]) square([notch_width,notch_height+1]);
        }
    }
}

module notch_bevel() {
    translate([((2/3)*width)-(width/2)+(notch_width/2),(height/2)-(notch_height/2)+0.25,thickness*0.5])
        union() {
            translate([0,0,thickness*0.2])
                linear_extrude(2,scale=1.75)
                    square([notch_width-1,notch_height], center=true);
            rotate([0,180,0])
                translate([0,0,thickness*0.2])
                    linear_extrude(2,scale=1.75)
                        square([notch_width-1,notch_height], center=true);
        }
}

module hole_bevel() {
    translate([0,0,thickness*0.5])
    union() {
        translate([0,0,(thickness*0.3)*1.5])
            cylinder(d1=center_hole_dia-1, d2=center_hole_dia*1.25, h=thickness*0.2, center=true);
        rotate([0,180,0])
            translate([0,0,(thickness*0.3)*1.5])
                cylinder(d1=center_hole_dia-1, d2=center_hole_dia*1.25, h=thickness*0.2, center=true);
    }
}

module tabs() {
    translate([(width/2)-tab_thickness-foam_thickness,tab_pos-(height/2),thickness]) cube([tab_thickness,tab_height,tab_length]);
    translate([foam_thickness-(width/2),tab_pos-(height/2),thickness]) cube([tab_thickness,tab_height,tab_length]);
    translate([foam_thickness-(width/2)+tab_thickness,tab_pos+(tab_height/2)+(tab_thickness/2)-(height/2),thickness]) rotate([90,0,0]) linear_extrude(tab_thickness) polygon([[0,0],[min(tab_height/2,5),0],[0,tab_length]]);
translate([-foam_thickness+(width/2)-tab_thickness,tab_pos+(tab_height/2)+(tab_thickness/2)-(height/2),thickness])rotate([90,0,0]) linear_extrude(tab_thickness) polygon([[0,0],[max(-tab_height/2,-5),0],[0,tab_length]]);
}