// exposed-infill IKEA Rallen charger base
// jan.1/2019, Gary Marsh (gmarsh23 @ Thingiverse)

// Provided under a Creative Commons BY-SA license
// Which means if I see these on Etsy without credit, I'll bitch and complain ;)


// makes previews look good
nudge = 0.001;

// main body dimensions
x = 76;
y = 150;
z = 17;

// corner radius, and top/bottom chamfers
body_corner_radius = 10;
body_bottom_chamfer = 0.5;
body_top_chamfer = 0.5;

// number of segments on corners
body_corner_fn = 60;

// moves charger pad towards cord outlet (positive)
// or other end (negative) by this many mm
rallen_y_offset = 0;

// rallen cutout dimensions, I wouldn't mess with these
rallen_top_d = 71;
rallen_top_h = 2.5;
rallen_top_chamfer = 0.25;
rallen_center_d = 64;
rallen_fn = 90;

// foot cutout dimensions, provides a solid place for a stick on foot
foot_inset = body_corner_radius;
foot_dia = 8;
foot_h = 2;
foot_cutout_w = 0.1;


difference() {
    body();
    
    rallen_cutout();
    cord_cutout();
    foot_cutouts();
}


module foot_cutouts() {
    
    dx = x/2 - foot_inset;
    dy = y/2 - foot_inset;
    
    // 4 feet
    corner_coords = [[-dx,-dy],[dx,-dy],[dx,dy],[-dx,dy]];
    // 3 feet (rocks less, or more)
    //corner_coords = [[0,-dy],[dx,dy],[-dx,dy]];
    
    cutout_fn = 8;
    
    translate([0,0,-nudge])
    linear_extrude(height=foot_h+nudge)
    
    for(c=corner_coords) {
        translate(c)
        for(a=[0:45:359]) {
            rotate([0,0,a])
            hull() {
                translate([0,1]) circle(d=foot_cutout_w,$fn=cutout_fn);
                translate([0,foot_dia/2]) circle(d=foot_cutout_w,$fn=cutout_fn);
            }
        }
    }    
}


module cord_cutout() {
    
    cord_cutout_d = 3.75;
    cord_cutout_z = 2.5;
    cord_cutout_fn = 24;
    cord_cutout_w = 2.75;
    cord_cutout_bottom_chamfer = 0.5;
    
    cord_end_chamfer = 1;
    
    // center cord tunnel
    translate([0,rallen_y_offset,cord_cutout_z])
    rotate([-90,0,0]) cylinder(d=cord_cutout_d,h=y,$fn=cord_cutout_fn);
    
    // square "squeeze the cord through" part
    translate([-cord_cutout_w/2,rallen_y_offset,-nudge])
        cube([cord_cutout_w,y,cord_cutout_z+nudge]);
    
    // bottom chamfer
    hull() {
        translate([0,rallen_y_offset,-nudge])
            cylinder(d1=cord_cutout_w+2*cord_cutout_bottom_chamfer,d2=cord_cutout_w,h=cord_cutout_bottom_chamfer+nudge,$fn=16);
        translate([0,y,-nudge])
            cylinder(d1=cord_cutout_w+2*cord_cutout_bottom_chamfer,d2=cord_cutout_w,h=cord_cutout_bottom_chamfer+nudge,$fn=16);
        }
    
    // end (cord outlet) chamfer
    translate([0,y/2+nudge,cord_cutout_z]) rotate([90,0,0])
        cylinder(d1=cord_cutout_d+2*cord_end_chamfer,d2=cord_cutout_d,h=cord_end_chamfer+nudge,$fn=cord_cutout_fn);
    

    // inner chamfer
    translate([0,rallen_y_offset,0])
    hull() {
        translate([0,rallen_center_d/2+2,cord_cutout_z]) rotate([90,0,0])
            cylinder(d1=cord_cutout_d,d2=cord_cutout_d+8,h=4,$fn=cord_cutout_fn);
        translate([0,rallen_center_d/2+2,0]) rotate([90,0,0])
            cylinder(d1=cord_cutout_d,d2=cord_cutout_d+8,h=4,$fn=cord_cutout_fn);
    }    
}



module rallen_cutout() {
    
    // inner/bottom cutout
    translate([0,rallen_y_offset,0])
        chamfered_cylinder(d=rallen_center_d,h=z-rallen_top_h,c1=-body_bottom_chamfer,c2=-1,$fn=rallen_fn,nudge=nudge);
    
    // outer/top cutout
    translate([0,rallen_y_offset,z-rallen_top_h])
        chamfered_cylinder(d=rallen_top_d,h=rallen_top_h,c1=0,c2=-rallen_top_chamfer,$fn=rallen_fn,nudge=nudge);
    
    
    // center connector - "attaches" the inner and outer cutouts. 
    center_connector_depth = 1;
    center_connector_w = 0.5;
    
    translate([0,rallen_y_offset,z-rallen_top_h-center_connector_depth])
    linear_extrude(h=center_connector_depth+nudge)
    intersection() {
        circle(d=rallen_top_d-nudge,$fn=rallen_fn);
        for(a=[0:18:179]) rotate([0,0,a]) square([center_connector_w,100],center=true);
    }
}
    

module body() {
    
    dx = x/2 - body_corner_radius;
    dy = y/2 - body_corner_radius;
    d = body_corner_radius * 2;
    h = z;
    c1 = body_bottom_chamfer;
    c2 = body_top_chamfer;
    fn = body_corner_fn;
    
    corner_coords = [[-dx,-dy],[dx,-dy],[dx,dy],[-dx,dy]];
    
    hull() {
        for(c=corner_coords) translate(c)
            chamfered_cylinder(d=d,h=h,c1=c1,c2=c2,$fn=fn);
    }    
}    
    
    
    
    






module chamfered_cylinder(d=10,h=10,c1=0,c2=0,c1a=45,c2a=45,$fn=$fn,nudge=0) {
    c1h = abs(c1) * tan(c1a);
    c2h = abs(c2) * tan(c2a);
    
    translate([0,0,-nudge]) cylinder(d1=(d-2*c1),d2=d,h=c1h+(2*nudge),$fn=$fn);
    translate([0,0,c1h-nudge]) cylinder(d=d,h=h-c1h-c2h+(2*nudge),$fn=$fn);
    translate([0,0,h-c2h-nudge])
        cylinder(d2=(d-2*c2),d1=d,h=c2h+(2*nudge),$fn=$fn);
}
