// adopted from http://www.thingiverse.com/thing:43756

/* [Extrusion] */
extrusion_width=20; // width of the exstrusion
slot_width=6; // width od the slot in the rail
slot_thickness=1; // material thickness
t_width=6; //  width of the slot
t_depth=1;             
trap_bot_width=10; // width of the bottom of the slot
trap_top_width=5; // width of the top of the slot
trap_depth=4; // depth of the slot

/* [End Cap] */
cover_thickness=2; // desired thickness of the endstop
corner_rounding=2; // radius of the corner on endstop

hole_size=0; // set hole size > 0, i.e. = 5 if you want a hole in the center of the end-stop

tab_height=5; // height/depth of the tabs

undersize=0; //this may need be adjusted for a good fit

/* [Spool Rest] */
spool_rest_length=80; // length of the top glide area for the filament spool
corner_mount_clearance=21; // add clearing for any corner hardware
spool_endstop_height=8; // height of the endstop (including the hight of the spool glide area)
adjust_spool_rest_radius=1.7; // change the radious of the spool rest, to match the width of the end-stop

difference() {
    union() {
        union() {
            for (a=[0:3])
                rotate([0,0,90*a])
                    translate([0,-extrusion_width/2,0])
                        if (a==3)
                            t_slot(spool_rest_length - corner_mount_clearance);
                        else
                            t_slot(tab_height);
            translate([-extrusion_width/2+corner_rounding-spool_endstop_height-adjust_spool_rest_radius, -extrusion_width/2+corner_rounding,0])
                minkowski() {
                    cube([extrusion_width-corner_rounding*2+spool_endstop_height+adjust_spool_rest_radius,extrusion_width-corner_rounding*2,cover_thickness-1]);
                    cylinder(r=corner_rounding, h=1, $fn=16);
                }
        }
        
        linear_extrude(height=spool_rest_length+cover_thickness) {
            // calculate the center offset
            radius=extrusion_width/2;
            translate([-spool_endstop_height/2,0,0]) {
                difference() {
                    circle(radius+adjust_spool_rest_radius, $fa=4);
                    translate([-radius+spool_endstop_height/2,-radius*5,0])
                        square(size=[radius*10,radius*10], center=false);
                }
            }
        }
    }
    
    // uncomment line below to add a center hole in the end cap
    if (hole_size>0)
        cylinder(r=hole_size/2, h=cover_thickness*4, center=true);
}

module t_slot(zheight=tab_height) {
	translate([-slot_width/2+undersize/2,0,0])
		cube([slot_width-undersize, slot_thickness+t_depth,zheight]);
	translate([-t_width/2+undersize/2,slot_thickness,0])
		cube([t_width-undersize,t_depth-undersize+0.01,zheight]);
	translate([0,slot_thickness+t_depth-undersize,0])
		linear_extrude(height=zheight)
			trapezoid(bottom=trap_bot_width-undersize, top=trap_top_width-undersize, height=trap_depth-undersize);
}

module trapezoid(bottom=10, top=5, height=2)
{
	polygon(points=[[-bottom/2,0],[bottom/2,0],[top/2,height],[-top/2,height]]);
}

module topCylinder() {
  //  intersection() {
  //      circle(r=(spool_hole_diameter - spool_rest_diameter_undersize)/2);
        translate(-(extrusion_width/2),extrusion_width/2,0);
            square(size=[extrusion_width,extrusion_width/2], center=false);
  //  }
}