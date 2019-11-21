// MMDVM Hotspot Case Raspberry Pi Zero W
// Remixed from R.J.Tidey 17th May 2016 https://www.thingiverse.com/thing:1549028
// Remixed by Chris Andrist, KC7WSU
// https://www.thingiverse.com/thing:3586123

/* [Global] */

// Build Options
build = 3; // [1:Base Only,2:Lid Only,3:Base and Lid]
// Text Line 1
text_line_1 = "KC7WSU";
// Text Line 2
text_line_2 = "HOTSPOT";
// Text Size
text_size = 10; // [8:12]
// Vent Type
vent_type = "logo"; // [logo:DMR-UTAH Logo, horizontal;Horizontal Vent Holes, vertical:Vertical Vent Holes
// Vertical Vent Height
v_vent_height = 10; // [5:15]
// Number of Vertical Vent Holes
v_vent_num = 20; // [0:20]
// Antenna Hole
antenna_hole = "no"; // [yes:Antenna Hole, no:No Antenna Hole]
//Antenna Hole Radius
antenna_radius = 7; //[4:7]

// Antenna Connector Location
// For MMDVM_HS v1.6
// Edge = 6, Top = 16, Depth = 6
antenna_edge = 6;
antenna_top = 16;
antenna_depth = 6;

// General parameters
wall = 2.0;
corner = 3.0;
tol = 0.3;
$fn=30;

//Base parameters
//inner dimensions
base_width = 30;
//65 for original pizero with no camera connector
//67 for pizero with camera connector
base_length = 67.0;
hole2hole_l = 58;
hole2hole_w = 23;

support_offset = 3.5;
support_height = 1.5;
support_radius = 1.4;
support_size = 7.0;
usbpower_offset = 54.0;
usbusb_offset = 41.4;
usb_length = 9.25;
hdmi_offset = 12.4;
hdmi_length = 13.75;
cutout_height_offset = 1.0;
sd_offset = 16.7;
sd_width = 13.0;

//Lid parameters
lid_height = 1.5;
lid_height_extra = 12; // 11 Pi Spacing + 1.5 Board - 0.5 Lip
board_thick = 1.35;
connector_thick = 3.2;
screw_depth = 8.0;
screw_radius = 1.0; 
gpio_centre_x = 32.5;
gpio_centre_y = 3.5;
gpio_length = 51.5;
gpio_width = 6;
gpio_recess_h = 1.2;
corner_size = 2.4;

//calculate required base_height
base_height = support_height + board_thick + connector_thick + tol;
echo("base_height = ",base_height);
echo("base_length = ",base_length);
echo("lid_height = ",lid_height+lid_height_extra);

/**
 * Stripped down version of "bezier_v2.scad".
 * For full version, see: https://www.thingiverse.com/thing:2170645
 */

function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function bezier_2D_point(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]
];

function bezier_coordinates(points, steps) = [
	for (c = points)
		for (step = [0:steps])
			bezier_2D_point(c[0], c[1], c[2],c[3], step/steps)
];

module bezier_polygon(points) {
	steps = $fn <= 0 ? 30 : $fn;
	polygon(bezier_coordinates(points, steps));
}

module dmrutah_logo() {
	bezier_polygon([[[-0.00103455, -9.667024651999998], [-0.00103455, -9.667024651999998], [14.102815224, -3.5223587569999975], [14.102815224, -3.5223587569999975]], [[14.102815224, -3.5223587569999975], [14.102815224, -3.5223587569999975], [17.619556694099998, -5.187751343599997], [17.619556694099998, -5.187751343599997]], [[17.619556694099998, -5.187751343599997], [17.619556694099998, -5.187751343599997], [25.225799867099997, -2.6782687321999976], [25.225799867099997, -2.6782687321999976]], [[25.225799867099997, -2.6782687321999976], [25.225799867099997, -2.6782687321999976], [27.1505985732, -3.151929997999998], [27.1505985732, -3.151929997999998]], [[27.1505985732, -3.151929997999998], [27.1505985732, -3.151929997999998], [33.3424292172, 8.770000192726002e-08], [33.3424292172, 8.770000192726002e-08]], [[33.3424292172, 8.770000192726002e-08], [33.3424292172, 8.770000192726002e-08], [43.6190450892, -6.5044957463], [43.6190450892, -6.5044957463]], [[43.6190450892, -6.5044957463], [43.6190450892, -6.5044957463], [47.0186695983, -5.6941629632], [47.0186695983, -5.6941629632]], [[47.0186695983, -5.6941629632], [47.0186695983, -5.6941629632], [59.9995743933, -10.3488467426], [59.9995743933, -10.3488467426]], [[59.9995743933, -10.3488467426], [59.9995743933, -10.3488467426], [47.9465962893, -8.056004012], [47.9465962893, -8.056004012]], [[47.9465962893, -8.056004012], [47.9465962893, -8.056004012], [41.0690219913, -9.1198605695], [41.0690219913, -9.1198605695]], [[41.0690219913, -9.1198605695], [41.0690219913, -9.1198605695], [43.0050554466, -7.354150151600001], [43.0050554466, -7.354150151600001]], [[43.0050554466, -7.354150151600001], [43.0050554466, -7.354150151600001], [37.8240872601, -5.949011590100001], [37.8240872601, -5.949011590100001]], [[37.8240872601, -5.949011590100001], [37.8240872601, -5.949011590100001], [35.7379215195, -3.5314737421999993], [35.7379215195, -3.5314737421999993]], [[35.7379215195, -3.5314737421999993], [35.7379215195, -3.5314737421999993], [32.5703581743, -1.3365111143000021], [32.5703581743, -1.3365111143000021]], [[32.5703581743, -1.3365111143000021], [32.5703581743, -1.3365111143000021], [26.4659677953, -5.811438906500001], [26.4659677953, -5.811438906500001]], [[26.4659677953, -5.811438906500001], [26.4659677953, -5.811438906500001], [24.3792191196, -4.511122674800003], [24.3792191196, -4.511122674800003]], [[24.3792191196, -4.511122674800003], [24.3792191196, -4.511122674800003], [19.125384045599997, -6.462577413200004], [19.125384045599997, -6.462577413200004]], [[19.125384045599997, -6.462577413200004], [19.125384045599997, -6.462577413200004], [22.834282122299996, -9.068721263000002], [22.834282122299996, -9.068721263000002]], [[22.834282122299996, -9.068721263000002], [22.834282122299996, -9.068721263000002], [14.003875239299996, -5.426807728700002], [14.003875239299996, -5.426807728700002]], [[14.003875239299996, -5.426807728700002], [14.003875239299996, -5.426807728700002], [0.00018431429999527676, -9.667395610700002], [0.00018431429999527676, -9.667395610700002]], [[0.00018431429999527676, -9.667395610700002], [0.00018431429999527676, -9.667395610700002], [-0.00103455, -9.667024651999998], [-0.00103455, -9.667024651999998]]]);
}

module round_cube(start,length,width,height,z_offset,cor) {
    hull() {
        translate([start,start,z_offset])
            cylinder(height,r=cor);
        translate([start+length,start,z_offset])
            cylinder(height,r=cor);
        translate([start+length,start+width,z_offset])
            cylinder(height,r=cor);
        translate([start,start+width,z_offset])
            cylinder(height,r=cor);
    }
}

module screwhole() {
    cylinder(wall+support_height+tol,r=support_radius);
    cylinder(wall*0.75,2*support_radius,support_radius);
}

module corner_support() {
    difference() {
        union() {
            round_cube(corner-2*tol,corner_size,corner_size,lid_height+wall,0,corner);
            translate([support_offset,support_offset,wall-0.1])
                cylinder(lid_height+connector_thick+0.1,4,3);
        }
        translate([support_offset,support_offset,wall+lid_height+connector_thick-screw_depth])
            cylinder(screw_depth+1,r=screw_radius);
    }
}

module cut_outs(height) {
    translate([tol+hdmi_offset-0.5*hdmi_length,-wall-0.1,height])
        cube([hdmi_length, wall+ 1.0,base_height]);
    translate([tol+usbusb_offset-0.5*usb_length,-wall-0.1,height])
        cube([usb_length, wall+ 1.0,base_height]);
    translate([tol+usbpower_offset-0.5*usb_length,-wall-0.1,height])
        cube([usb_length, wall+ 1.0,base_height]);
    translate([-wall-0.1,tol+sd_offset-0.5*sd_width,height])
        cube([wall+ 1.0,sd_width,base_height]);
}

module logo_vent_holes() {
    translate([5, 10]) {
        linear_extrude(2) 
            rotate([180,0,0])
                dmrutah_logo();
    }
}

module h_vent_holes() {
       translate([(base_length/2)-5,(base_width/2)-5,0])
            cylinder(h=3,r=1); 
        linear_extrude(3)
            translate([base_length/2,(base_width/2)-5,0])
                square([10,2],true);
        translate([(base_length/2)+5,(base_width/2)-5,0])
            cylinder(h=3,r=1); 
        
        translate([(base_length/2)-10,(base_width/2),0])
            cylinder(h=3,r=1); 
        linear_extrude(3)
            translate([base_length/2,(base_width/2),0])
                square([20,2],true);
        translate([(base_length/2)+10,(base_width/2),0])
            cylinder(h=3,r=1);         
 
         translate([(base_length/2)-5,(base_width/2)+5,0])
            cylinder(h=3,r=1);        
        linear_extrude(3)
            translate([(base_length/2),(base_width/2)+5,0])
                square([10,2],true);
        translate([(base_length/2)+5,(base_width/2)+5,0])
            cylinder(h=3,r=1);
}

module vertical_vent() {
    union() {
        translate([0,v_vent_height/2,0]) {
            cylinder(h=2,r=1); 
        }
        translate([0,0,1]) {
            cube([2,v_vent_height,2],true);
        }
        translate([0,-(v_vent_height/2),0]) {
            cylinder(h=2,r=1); 
        }
    }
}

module v_vent_holes(num) {
    for (i = [1 : num])
        translate([ (base_length/(num+1))*i, 15]) vertical_vent();
}

module h_vent_holes() {
       translate([(base_length/2)-5,(base_width/2)-5,0])
            cylinder(h=3,r=1); 
        linear_extrude(3)
            translate([base_length/2,(base_width/2)-5,0])
                square([10,2],true);
        translate([(base_length/2)+5,(base_width/2)-5,0])
            cylinder(h=3,r=1); 
        
        translate([(base_length/2)-10,(base_width/2),0])
            cylinder(h=3,r=1); 
        linear_extrude(3)
            translate([base_length/2,(base_width/2),0])
                square([20,2],true);
        translate([(base_length/2)+10,(base_width/2),0])
            cylinder(h=3,r=1);         
 
         translate([(base_length/2)-5,(base_width/2)+5,0])
            cylinder(h=3,r=1);        
        linear_extrude(3)
            translate([(base_length/2),(base_width/2)+5,0])
                square([10,2],true);
        translate([(base_length/2)+5,(base_width/2)+5,0])
            cylinder(h=3,r=1);
}

module base_shell() {
    difference() {
        round_cube(corner-wall,base_length+2*tol+2*wall-2*corner,base_width+2*tol+2*wall-2*corner,base_height+wall,0,corner);
        round_cube(corner-tol,base_length+4*tol-2*corner,base_width+4*tol-2*corner,base_height+wall,wall,corner);
         // vent hole type
        if(vent_type == "logo") {
            logo_vent_holes();
        }
        if(vent_type == "vertical") {
            v_vent_holes(v_vent_num);
        }
        if(vent_type == "horizontal") {
            h_vent_holes();
        }
    }
    difference() {
        round_cube(corner-wall+1,base_length+2*tol+2*wall-2*corner-2,base_width+2*tol+2*wall-2*corner-2,1,base_height+wall,corner);
        round_cube(corner-tol,base_length+2*tol+2*wall-2*corner-4,base_width+2*tol+2*wall-2*corner-4,1,base_height+wall,corner);
    }
    translate([-tol,-tol,0])
        cube([support_size,support_size,support_height+wall]);
    translate([hole2hole_l+tol,-tol,0])
        cube([support_size,support_size,support_height+wall]);
    translate([hole2hole_l+tol,hole2hole_w+tol,0])
        cube([support_size,support_size+2*tol,support_height+wall]);
    translate([-tol,hole2hole_w+tol,0])
        cube([support_size,support_size+2*tol,support_height+wall]);
 }

module base() {
    difference() {
        base_shell();
        translate([tol+support_offset,tol+support_offset,-0.1]) screwhole();
        translate([tol+support_offset+hole2hole_l,tol+support_offset,-0.1]) screwhole();
        translate([tol+support_offset+hole2hole_l,tol+support_offset+hole2hole_w,-0.1]) screwhole();
        translate([tol+support_offset,tol+support_offset+hole2hole_w,-0.1]) screwhole();
        cut_outs(wall+support_height+board_thick-tol); 
    }
} 

module lid_shell() {
    difference() {
        round_cube(corner-wall,base_length+2*tol+2*wall-2*corner,base_width+2*tol+2*wall-2*corner,lid_height+lid_height_extra+wall,0,corner);
        round_cube(corner-tol,base_length+4*tol-2*corner,base_width+4*tol-2*corner,lid_height+lid_height_extra+wall,wall,corner);
    }
    difference() {
        round_cube(corner-wall,base_length+2*tol+2*wall-2*corner,base_width+2*tol+2*wall-2*corner,1,lid_height+lid_height_extra+wall,corner);
        round_cube(corner-tol-1,base_length+4*tol-2*corner+2,base_width+4*tol-2*corner+2,1,lid_height+lid_height_extra+wall,corner);
    }
}

module lid() {
    difference() {
        union() {
            lid_shell();
            translate([0,0,0]) corner_support();
            translate([hole2hole_l,0,0]) corner_support();
            translate([hole2hole_l,hole2hole_w,0]) corner_support();
            translate([0,hole2hole_w,0]) corner_support();
        }
        if(antenna_hole == "yes") {
            linear_extrude(antenna_depth)
                translate([antenna_edge,antenna_top,0])
                    circle(r=antenna_radius);
            linear_extrude(wall/2)
                union() {
                    translate([(base_length/2)+antenna_radius,base_width/4,0])
                        rotate([180,0,0])
                            text(text_line_1, size = (text_size*.8), halign = "center", valign = "center");
                    translate([(base_length/2)+antenna_radius,(base_width/4)*3,0])
                        rotate([180,0,0])
                            text(text_line_2, size = (text_size*.8), halign = "center", valign = "center");
                }
        }
        else {
            linear_extrude(wall/2)
                union() {
                    translate([base_length/2,base_width/4,0])
                        rotate([0,180,0])
                            text(text_line_2, size = text_size, halign = "center", valign = "center");
                    translate([base_length/2,(base_width/4)*3,0])
                        rotate([0,180,0])
                            text(text_line_1, size = text_size, halign = "center", valign = "center");
                }
            }
    }
}

module supports() {
    for (i=[1:4])
        translate([(base_length/5)*i,0,0])
            difference() {
                cylinder(h=11, r=3); 
                cylinder(h=11, r=1.4);
    };
}

if (build == 1 || build == 3) {
    base();
}
if(build == 2){
    lid();
}
if (build == 3) {
    translate([0,base_width+4*wall,0]) lid();
    translate([0,(base_width+4*wall)*2,0]) supports();
}