include <MCAD/triangles.scad>
include <MCAD/units.scad>

/* [Scene] */
show = "all";   // [all, outside, inside, jig]

/* [Container] */

// container wall thickness in mm
cwall_thickness = 2;

/* [Gland] */

// number of filament openings
posts = 1; // [1:1:5]
// in mm
plate_thickness = 2;
// in cm
post_separation = 3.2;
// in cm
post_extra_length = 0.75;

/* [Hidden] */

$fn = 24;

// heat-set insert dimensions
hsi_od_top = 8;
hsi_od_bot = 7.68;
hsi_length = 6.73;
hsi_hd = hsi_od_top;  // hole diameter

// insert post dimensions
// OD for the post is 13 mm
ip_mh = 5;
ip_od = hsi_od_top + ip_mh;

// plate dimensions
// calculate plate_width
plate_ip_sw = 4;
plate_width = (ip_od * posts) + (post_separation * cm * posts);
// calculate plate_height
plate_height = ip_od + (post_separation * cm);

sh_offs = 8;
shxy = [[sh_offs, sh_offs],
        [sh_offs, plate_height - sh_offs],
        [plate_width - sh_offs, sh_offs],
        [plate_width - sh_offs, plate_height - sh_offs]];

_show();


module _show() {
    show_outside = (show == "all" || show == "outside");
    show_inside = (show == "all" || show == "inside");
    show_jig = (show == "all" || show == "jig");
    
    if (show_outside) {
        outside();
    }
    
    if (show_inside) {
        translate([0, plate_height + (1 * cm)])
        inside();
    }
    
    if (show_jig) {
        translate([0, (plate_height * 2) + (2 * cm)])
        plate(chd=ip_od + 0.2);
    }
}

module _assembly() {
    outside();
    translate([0,0,-(plate_thickness + cwall_thickness)])
    inside();
}
//_assembly();

module outside() {
    // the new outside plate takes the mounting heat-set inserts
    // and has a stabilizing sheath for the post
    // this improves printability
    render()
    difference() {
        plate();
        for (i = [0.5:1:posts-0.5]) {
            translate([(ip_od * i) + post_separation * cm * i, plate_height/2])
            cylinder(d=ip_od + 0.2, h=plate_thickness);
        }
    }
    
    translate([0,0,plate_thickness]) {
        // screw posts for heat-set inserts
        for (xy=shxy) {
            translate(xy)
            screw_post();
        }
        
        // support sheaths for the filament post on the inside plate
        for (i = [0.5:1:posts-0.5]) {
            translate([(ip_od * i) + post_separation * cm * i, plate_height/2])
            render()
            difference() {
                stacked_cylinders([[ip_od + 4, 5],
                                   [ip_od + 4, ip_od + 2.75, 1]]);
                stacked_cylinders([[ip_od + 0.2, 6]]);
            }
        }
        
        // stiffness bars
        for (x=[sh_offs-1, plate_width-(sh_offs+1)]) {
            translate([x, 12])
            cube([2, 21, 2]);
        }
        for(y=[sh_offs-1, plate_height-(sh_offs+1)]) {
            translate([12, y])
            cube([plate_width - 24, 2, 2]);
        }
    }
    
}


module inside() {
    // the new inside plate is much simpler than the old
    // this improves printability
    plate();
    for (i = [0.5:1:posts-0.5]) {
        translate([(ip_od * i) + post_separation * cm * i,plate_height/2])
        insert_post();
    }
}


module plate(shd=5.2, chd=hsi_hd) {
    render()
    difference() {
        cube([plate_width, plate_height, plate_thickness]);
        
        // holes for posts
        
        //for (i=[0.5,1.5]) {
        for (i = [0.5:1:(0.5+(posts-1))]) {
            translate([(ip_od * i) + post_separation * cm * i, plate_height / 2])
            cylinder(d=chd - 0.2, h=plate_thickness);
        }
        
        // corner screw holes for M5 screws
        for (xy = shxy) {
            translate(xy)
            cylinder(d=shd, h=plate_thickness);
        }
        
    }
}


module screw_post() {
    // over the corner screw holes on the outside
    // are insets for the heat-set inserts
    oc = [[ip_od, hsi_length - 1],
          [ip_od, ip_od - 1.25, 1]];
    ic = [[hsi_hd, hsi_length]];
    
    render()
    difference() {
        stacked_cylinders(oc);
        stacked_cylinders(ic);
    }
}


module insert_post() {
    // for v2, the insert post exists entirely on the inner plate
    // to improve printability
    // also, a single length of PTFE should be inserted between the heat-set inserts.
    post_length = (plate_thickness * 2) + cwall_thickness + (post_extra_length * cm);
    _ml = post_length - (hsi_length * 2);
    ml = (_ml > 0) ? _ml : 0;
    
    outerc = [[ip_od, (hsi_length * 2) + ml - 1],
              [ip_od, ip_od - 1.25, 1]];
    
    innerc = [[hsi_hd, (hsi_length * 2) + ml]];
    
    render()
    difference() {
        stacked_cylinders(outerc);
        stacked_cylinders(innerc);
    }
    
    
    
}


module stacked_cylinders(size_vector, idx=0) {
    // from OpenSCAD manual tips, but able to make some of the cylinders tapered
    if (idx < len(size_vector)) {
        sv = size_vector[idx];
        ch = (len(sv) == 2) ? sv[1] : sv[2];
        
        if (len(sv) == 2) {
            cylinder(d=sv[0], h=ch);
        } else if (len(sv) == 3) {
            cylinder(d1=sv[0], d2=sv[1], h=ch);
        }
        
        translate([0, 0, ch]) {
            stacked_cylinders(size_vector, idx + 1);
        }
    }
}