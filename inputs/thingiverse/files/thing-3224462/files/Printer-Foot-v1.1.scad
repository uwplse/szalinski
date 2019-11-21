/* == Customizer Settings ================================================ */
/*[Basics]*/

// select the basic shape
mode = "Diamond & Cross"; // [Square,Cross,Diamond,Diamond & Cross,Sphere]

// in mm, foot upper dimensions and height [x,y,z] (x/y width and height)
foot_dimensions = [40, 25, 20];

// in mm, screw hole dimensions [d_screw, d_head, d_length]
screw_dimensions = [5.5,10,7.5];

resolution = 50; // [30:Draft, 50:Normal, 80:Smooth]

// Slice details, ignored in sphere mode.
resolution_slices = 25; // [10:Draft, 25:Normal, 50:Smooth]


/*[Details]*/

// scale % of the foot tip where 0 is a sharp edge and 1 are the upper dimensions (streight form), in case of Sphere mode percentage of shere intersection (0.5 = midsection, 1 = full sphere).
foot_scale = 0.4;

// scale [x,y]% of the foot tips, y value only effective in some modes, ignored in sphere mode
foot_scale_tip = [.2, .6];

// true for a more rounded shape, false for sharp edges, ignored in sphere mode
fillets_p = "yes"; // [yes,no]

// in mm, adds an additional spheric cutout to the top of the screw hole (e.g. d_head for a cleaner opening if top surface is very narrow), set to 0 for no cutout.
cutout_diameter = 0;

// in mm, shave off foot flat at the top (added to hight)
cutout_height = 0;


// initialize constants based on parameters
$fn=resolution;
mode_diamond = mode == "Diamond" || mode == "Diamond & Cross";
mode_cross = mode == "Cross" || mode == "Diamond & Cross";
mode_sphere = mode == "Sphere";
fillets = fillets_p == "yes";
foot_dim = [foot_dimensions[0],foot_dimensions[1],
            foot_dimensions[2]+cutout_height];


/* == Draw Foot  =========================================== */
// draw foot
if (mode_sphere) {
    foot_sphere(foot_dim, foot_scale,
                screw_dim=screw_dimensions, cutout_d=cutout_diameter);
} else {
    foot_rect(foot_dim, foot_scale, screw_dimensions, mode_diamond,
              mode_cross, fillets, foot_scale_tip, cutout_diameter,
              resolution_slices);
}

/* == Foot Modlues ======================================================= */
/* Spherical foot
 * d - diameter
 */
module foot_sphere(dim, sp, screw_dim=[0,0], cutout_d=0) {
    d = dim[2] * 2;
    x = dim[0];
    h = dim[2];
    y = dim[1];
    difference() {
        resize([x,y,0]) SphereHalf(d=d, h=h, sp=sp);
        translate(-[dim[0]/2,0,0]) screw_hole(dim, screw_dim, cutout_d);
        if (cutout_height > 0) {
            translate(-[dim[0]/2,dim[1]/2,-dim[2]+cutout_height])
                cube([dim[0]+1, dim[1]+1, dim[2]]);
        }
    }
}


/* Rectangular foot
 * dim - base dimensions [x,y,h]
 * scale - 0 for a sharp edge, increase for a flat surface
 * screw_dim - screw hole dimensions [d_screw, d_head, length]
 * mode - 0 = diamond, 1 = square, 2 = narrow diamond
 * fillets - frue for a more rounded shape, false for sharp edges
 * tip_scale - fillet size factor (%), only used if fillets = true
 * cutout_d - diameter for additional cutout near screhole opening (optional, 0 for none)
 */
module foot_rect(dim, scale=0, screw_dim=[0,0], mode_diamond=false,
                 mode_cross=false, fillets=false, tip_scale=[0.25, 0.25],
                 cutout_d=0, res_slices=25) {
    difference() {
        base(dim, scale, mode_diamond, mode_cross, fillets, tip_scale,
             res_slices);
        screw_hole(dim, screw_dim, cutout_d);
        if (cutout_height > 0) {
            translate(-[0.5,dim[1]/2+0.5,-dim[2]+cutout_height])
                cube([dim[0]+1, dim[1]+1, dim[2]-cutout_height]);
        }
    }
}


module screw_hole(dim, screw_dim, cutout_d) {
    translate([dim[0]/2,0]) {
        // screw head
        cylinder(d=screw_dim[0], h=dim[2]);
        // screw hole
        translate([0,0,screw_dim[2]]) cylinder(d=screw_dim[1], h=dim[2]);
        // cutout
        if (cutout_d > 0) {
            hull() {
                for (p = [[0,dim[1]/2,dim[2]], [0,-dim[1]/2,dim[2]]]) {
                   translate(p) sphere(d=cutout_d);
                }
            }
        }
    }
}

/* half base model
 * dim - base dimensions [x,y,h]
 * scale - 0 for a sharp surface edge, increase for a flat surface
 * mode_diamond - true for diamond base shape, false for square
 * fillets - use fillets?
 * tip_scale - [x,y] tip scale
 */
module base_half(dim, scale=0, mode_diamond=false, fillets=false, tip_scale=[0.25, 0.25], res_slices=25) {
    linear_extrude(height=dim[2], scale=[1,scale], slices=res_slices, twist=0) {
        if (fillets) {         
            hull() {
                if (mode_diamond) {
                    diameter = [dim[0] * tip_scale[0], dim[1] * tip_scale[1]];
                    translate([diameter[0]/2,0]) circle(d=diameter[0]);
                    translate([dim[0]/2,dim[1]/2-diameter[1]/2]) circle(d=diameter[1]);
                    translate([dim[0]/2,-dim[1]/2+diameter[1]/2]) circle(d=diameter[1]);
                } else { // symmetric square shaped (trapezium)
                    diameter = min(dim[0], dim[1]) * tip_scale[0];
                    translate([diameter/2,dim[1]/2-diameter/2]) circle(d=diameter);
                    translate([diameter/2,-dim[1]/2+diameter/2]) circle(d=diameter);
                }
            }
        } else {
            if (mode_diamond) {
                polygon(points=[[0, dim[1]*min(tip_scale[1],1)],
                                [dim[0]*(1-min(tip_scale[0],1)),dim[1]],
                                [dim[0],dim[1]],
                                [dim[0],-dim[1]],
                                [dim[0]*(1-min(tip_scale[0],1)),-dim[1]],
                                [0, -dim[1]*min(tip_scale[1],1)]]/2);
            } else {
                polygon(points=[[0,dim[1]],[dim[0],dim[1]],[dim[0],-dim[1]],[0,-dim[1]]]/2);
            }
        }
    }
}

module base(base_dim, scale=0, mode_diamond=false, mode_cross=false, fillets=false, tip_scale=[0.25, 0.25]) {
    module bhalf(bdim, xy_swap=false) {
        dim = [xy_swap ? bdim[1] : bdim[0],
               xy_swap ? bdim[0] : bdim[1],
               bdim[2]];
        tscale = [min(max(xy_swap ? tip_scale[1] : tip_scale[0], fillets ? 0.01 : 0), 1),
                  min(max(xy_swap ? tip_scale[0] : tip_scale[1], fillets ? 0.01 : 0), 1)];
        base_half(dim, scale, mode_diamond, fillets, tscale);
    }
    module bfull(dim, xy_swap=false) {
        if (mode_diamond) {
            union() {
                bhalf(dim, xy_swap);
                    translate([xy_swap ? dim[1] : dim[0],0])
                        mirror([1,0,0]) bhalf(dim, xy_swap);
            }
        } else {
            hull() {
                bhalf(dim, xy_swap);
                    translate([xy_swap ? dim[1] : dim[0],0])
                        mirror([1,0,0]) bhalf(dim, xy_swap);
            }
        }
    }
    union() {
        bfull(base_dim);
        if (mode_cross) {
            translate([base_dim[0]/2,0-base_dim[1]/2,0]) {
                rotate(90) bfull(base_dim, true);
            }
        }
    }
}


/* == Basic Modules ====================================================== */
/* top half of a sphere, optionally stretched
 * d - sphere's diameter
 * h - height (vertical stretch), optional, default: radius
 * sp - split percentage, default: 0.5 (intersection ad midpoint)
 */
module SphereHalf(d, h, sp=0.5) {
    h2 = h == undef ? d : h*2/sp/2;
    translate(-[0,0,h2/2-h2*sp]) difference() {
        resize(newsize=[0,0,h2]) sphere(d=d);
        translate(-[0,0,h2*sp]) cube([d,d,h2], center=true);
    }
}
