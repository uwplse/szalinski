// generall mold for trapezee leather cases - for these particular dimensions
// it's made for Leatherman skeletool

// selection ->
// =1 to generate top
// =2 to generate bottom
// =3 to generate both
selection=3;

// build variables - feel free to modify for different results
$fn=100;
case_width_bottom=33;
case_witdh_top=35;
case_width_dd=case_witdh_top-case_width_bottom;
case_height_offset=3;
case_height=90+case_height_offset;
case_depth=15.5;
rounded=3;
leather_d=3.2;
cube_d=5;

// -> modules for generator

// base
module poly_build(mold_offset) {
    mo=mold_offset;
    polygon( points=[
                [0,0]-[mo,mo],
                [case_width_bottom,0]+[mo,-mo],
                [case_width_bottom + case_width_dd/2, case_height]+[mo,mo],
                [-case_width_dd/2, case_height]+[-mo,mo],
            ]
    );
}

module model(model_offset, model_add_h=0) {
    ld=model_offset;
    difference() {
        minkowski() {
            sphere(rounded);
            linear_extrude(case_depth-rounded+ld+model_add_h)
                poly_build(-rounded+ld);
        }
        // cut off bottom made with minkowski
        translate([-rounded, -rounded, -rounded] - [2,2,2])
            cube( [ case_witdh_top+rounded*2+ld,
                    case_height+rounded*2+ld,
                    rounded]+[2,2,2]);
    }
}

module top_cutoff() {
    translate([-leather_d-case_width_dd/2,case_height-3,0]-[0.1,0.1,0.1])
        cube([case_witdh_top+2*leather_d,
              case_height_offset+leather_d,
              case_depth+leather_d
              ] + [0.2,0.2,0.2]);
}

// // this is how leather will fill in mold, we don't really need it, but it's a nice preview
// difference() {
// model(leather_d);
// translate([0,0,-0.1])
// model(0);
// top_cutoff();
// }

module outer_cube() {
    translate(  [-leather_d-case_width_dd/2,
                 -leather_d,
                 0
                ]-[0.1,0.1,0.0]+[-cube_d,-cube_d,0])
    cube( [case_witdh_top+2*leather_d,
            case_height,
            case_depth+leather_d]+[0.2,0,0.2]+[2*cube_d,cube_d,cube_d]);
}

module stand_cube() {
    translate(  [-leather_d-case_width_dd/2,
                 -leather_d,
                 -cube_d
                ]-[0.1,0.1,0.0]+[-cube_d,-cube_d,0])
    cube( [case_witdh_top+2*leather_d,
            case_height,
            cube_d]+[0.2,0,0.2]+[2*cube_d,cube_d,0]);
}

/// -> actual model build

// top_cover
if(selection ==1 || selection ==3) {
    difference() {
        outer_cube();
    // inside
        difference() {
            translate([0,0,-0.1])
            model(leather_d);
            top_cutoff();
        }
    }
}

// bottom/inside
if(selection ==2 || selection ==3) {
    union() {
        translate([0,0,-leather_d]) {
            stand_cube();
            difference() {
                model(0,leather_d);
                top_cutoff();
            }
        }
    }
}
