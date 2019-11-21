// Linear bearing, LMxUU style
//      Design by W. Bruce Moore
//


/* [Primary dimensions] */

inside_diameter = 8.0;
outside_diameter = 15.0;
overall_length = 24.0;

/* [Retainer rings */

ring_spacing = 17.5;
ring_depth = 0.7;
ring_width = 1.1;

/* [Groove parameters] to form inner bearing ribs */

groove_count = 8;           // how many ribs (and grooves)
groove_width = 2.3;         // determines thickness of ribs
groove_depth = 1.9;         // determines outer wall thickness
twist_grooves = 2.0;        // number of grooves shift over length
                            // (zero = straight grooves, no twist)


/* [Hidden] */


//
// Suggested configurations for:
//
//   /*      LM6UU   */
//   /*---------------------------*/
//   inside_diameter = 6.0;
//   outside_diameter = 12.0;
//   overall_length = 19.0;
//   ring_spacing = 13.5;
//// /* Long */
////   overall_length = 35.0;
////   ring_spacing = ??;
//// /* ---- */
//   ring_depth = 0.5;
//   ring_width = 1.1;
//   groove_count = 8;
//   groove_width = 1.9;
//   groove_depth = 1.5;
//// /*  Heavy duty: */
////   groove_count = 12;
////   groove_width = 0.8;
////   twist_grooves = 3.0;
//// /* ---- */
//
//
//
//   /*      LM8UU   */
//   /*---------------------------*/
//   inside_diameter = 8.0;
//   outside_diameter = 15.0;
//   overall_length = 24.0;         // Short=17
//   ring_spacing = 17.5;           // Short=11.5
//// /* Long */
////   overall_length = 45.0;
////   ring_spacing = 35.0;
//// /* ---- */
//   ring_depth = 0.7;
//   ring_width = 1.1;
//   groove_count = 8;
//   groove_width = 2.3;
//   groove_depth = 1.9;
//// /*  Heavy duty: */
////   groove_count = 12;
////   groove_width = 1.1;
////   twist_grooves = 3.0;
//// /* ---- */
//
//
//
//   /*      LM10UU   */
//   ---------------------------
//   inside_diameter = 10.0;
//   outside_diameter = 19.0;
//   overall_length = 29.0;
//   ring_spacing = 22.0;
//// /* Long */
////   overall_length = 55.0;
////   ring_spacing = ??;
//// /* ---- */
//   ring_depth = 1.0;
//   ring_width = 1.3;
//   groove_count = 8;
//   groove_width = 3.0;
//   groove_depth = 2.5;
//// /*  Heavy duty: */
////   groove_count = 12;
////   groove_width = 1.5;
////   twist_grooves = 3.0;
//// /* ---- */
//
//
//
//   /*      LM12UU   */
//   /*---------------------------*/
//   inside_diameter = 12.0;
//   outside_diameter = 21.0;
//   overall_length = 30.0;
//   ring_spacing = 23.0;
//// /* Long */
////   overall_length = 57.0;
////   ring_spacing = ??;
//// /* ---- */
//   ring_depth = 1.0;
//   ring_width = 1.3;
//   groove_count = 8;
//   groove_width = 3.5;
//   groove_depth = 2.7;
//// /*  Heavy duty: */
////   groove_count = 12;
////   groove_width = 1.7;
////   twist_grooves = 3.0;
//// /* ---- */
//
//
//

$fs = 1.2;
$fa = 8;

in_radius = inside_diameter / 2;
out_radius = outside_diameter / 2;
groove_angle = 360 / groove_count;
groove_extra = 1;            // extra depth to remove curved inner edge
fillet_size = 0.7;
rib_fillet = fillet_size / 4;
ring_offset = (ring_spacing - ring_width) / 2;
endcap_thickness = 1.0;
endcap_gap = 0.5;



module endcap(base_height)
    {   // create an endcap disk
    translate([0, 0, base_height])
    linear_extrude(height=endcap_thickness)
        difference()
            {
            circle(out_radius - fillet_size);
            circle(in_radius + (endcap_gap / 2));
            }
    }


union()
    {
    difference()
        {
        // outer shell
        translate([0, 0, -overall_length / 2])
        rotate_extrude()
            difference()
                { hull()
                // filleted barrel
                offset(r=fillet_size / 2)
                offset(r=-fillet_size / 2)
                translate([in_radius, 0, 0])
                square([out_radius - in_radius, overall_length]);
                // retainer rings
                translate([out_radius - ring_depth, 
                    ((overall_length - ring_width) / 2) + ring_offset, 0])
                square([ring_depth, ring_width]);
                translate([out_radius - ring_depth, 
                    ((overall_length - ring_width) / 2) - ring_offset, 0])
                square([ring_depth, ring_width]);
                }
        // inner grooves
        linear_extrude(height=overall_length, 
            twist=groove_angle * twist_grooves, center=true)
            {
            offset(r=-rib_fillet)          // round off ribs
            offset(r=rib_fillet)
            union()
                {
                circle(in_radius);         // hollow
                for (i=[1 : groove_count])
                    {                      // add groovees
                    rotate([0, 0, groove_angle * i])
                        {
                        translate([in_radius - groove_extra,
                                -groove_width / 2, 0])
                        offset(r=fillet_size / 2)
                        square([groove_depth + groove_extra - fillet_size, 
                                groove_width - fillet_size]);
                        }
                    }
                }
            }
        }
    endcap(-overall_length / 2);           // bottom endcap
    endcap((overall_length / 2) - endcap_thickness);  // top endcap
    }

