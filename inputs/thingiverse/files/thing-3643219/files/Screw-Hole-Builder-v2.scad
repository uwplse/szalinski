// Alexey D. Filimonov <alexey@filimonic.net>
// 2019

/* ChangeLog
    2019-05-23 Added ability to customize diameters
    2019-05-20 First Release
    

*/
/* [Common] */
// Use pre-defined screw cap sizes
use_pre_defined = 0; //[0:No, 1:Yes]

/* [Quality] */
// Quality of the model
quality_fn = 25; // [5:50]
/* [Parameters if you use pre-defined cap sizing] */
// Screw body diameter, mm
screw_body_diameter1 = 3.0;
// Screw cap type (chooose)
screw_hat_type = 1 ;// [1:Machine Countersink, 2:Machine Countersink raised, 3:Machine Panhead, 4:Machine Cheesehead, 5:Hex socket Cap, 6:Hex socket Countersink, 7:Hex bolt]
/* [Parameters if you not use pre-defined cap sizing] */
screw_body_diameter2 = 4.0;
screw_hat_diameter = 10.0;
screw_hat_height = 4.0;


/* [Tolerance] */
// Tolerance when printed, mm
tolerance = 0.5; //[0:0.1:2]
/* [Floor Thickness] */
// Floor thickness, mm, for easy cut
floor_thickness = 1.2; //[0:0.05:2]


/* [Hidden] */

$fn = quality_fn;
// Hat diameter:
hat_diameter_multiplier = [ 
  1.75, // Machine Countersink
  1.75, // Machine Countersink raised
  2.00, // Machine Panhead
  1.60, // Machine Chesshead
  1.50, // Hex socket Cap
  2.00, // Hex socket Countersink
  2.00, // Hex bolt
];

hat_height_multiplier = [ 
  0.50, // Machine Countersink
  0.75, // Machine Countersink raised
  0.60, // Machine Panhead
  0.60, // Machine Chesshead
  1.25, // Hex socket Cap
  0.60, // Hex socket Countersink
  0.70, // Hex bolt
];

function get_hat_diameter(d_body, h_type) = hat_diameter_multiplier[h_type-1] * d_body;
function get_hat_height(d_body, h_type) = hat_height_multiplier[h_type-1] * d_body;
function get_screw_max_slide(d_hat, d_body) = d_hat -(d_hat/2)*(1- cos(asin(d_body/d_hat)));

_bd = (use_pre_defined == 0) ? screw_body_diameter2 + tolerance : screw_body_diameter1 + tolerance ;
_bh = floor_thickness;
_hd = (use_pre_defined == 0) ? screw_hat_diameter + tolerance : get_hat_diameter(_bd, screw_hat_type) + tolerance;
_hh = (use_pre_defined == 0) ? screw_hat_height + tolerance : get_hat_height(_bd, screw_hat_type) + tolerance;
_md = get_screw_max_slide(_hd, _bd) + tolerance;



echo("_bd",_bd);
hull() {
    cylinder (h=_bh, d=_bd);
    translate ([_md,0,0]) cylinder (h=_bh, d=_bd);
}
cylinder(h = _hh + _bh, d = _hd);
hull() {
    translate([0, 0,_bh])  cylinder(h = _hh, d = _hd);
    translate([_md,0,_bh]) cylinder(h = _hh, d = _hd);
}
hull() {
    translate([_md,0,_bh+_hh]) cylinder(h=_hd/2, d1= _hd, d2 = 0);
    translate([0 ,0, _bh+_hh]) cylinder(h=_hd/2, d1= _hd, d2 = 0);
}


