/* [General] */
// type of top part
top_type = "teeth"; // [teeth:Split Teeth,round:Round Base,hex:Hex Nut]
// type of bottom part
bottom_type = "hex"; // [teeth:Split Teeth,round:Round Base,hex:Hex Nut]
// clearance between adjoining parts, mm
cll = .2; 

/* [Cutouts for locking] */
// diameter of locking rod (0 for none, mm)
i_lock_rod_diam = 1.2;
// width of split slice on top, mm (0 if none)
i_split_hole_width_top = 1;
// width of split slice on bottom, mm (0 if none)
i_split_hole_width_bottom = 1;

/* [Supports] */
// height of support ring on top, mm
support_height_top = 1; 
// height of support ring on bottom, mm
support_height_bottom = 1; 
// diameter of support ring on top, mm
support_diam_top = 5;
// diameter of support ring on bottom, mm
support_diam_bottom = 10;

/* [Split Teeth] */
// diameter of pcb hole, mm
i_pcb_hole_diam = 2.7; 
// pcb thickness (mm)
i_pcb_thickness = 1.8; 
// max bend angle (pla: 15%) overriding calculated value
bend_max = 12;

/* [Hex Nut] */
// hex hole major diameter, mm (0 if none)
i_hex_inside = 8;
// hex fill major diameter, mm
i_hex_outside = 10;
// height of hex piece, mm
i_hex_height = 2;

/* [Round] */
// hole major diameter, mm (0 if none)
i_round_inside = 2;
// fill major diameter, mm
i_round_outside = 4;
// height of the round piece, mm
i_round_height = 2;

// joiner piece height (mm) (only for joiner)
//joiner_height_total_in = 1.2;

include<MCAD/units.scad>
include<MCAD/regular_shapes.scad>

/* [Hidden] */
big = 10;

//Thing
do_part(top_type, support_height_top, support_diam_top, i_split_hole_width_top);
mirror([0,0,1])
  do_part(bottom_type, support_height_bottom, support_diam_bottom, i_split_hole_width_bottom);

module do_part( type, support_height, support_diam, i_split_hole_width) {
  difference() {
    union() { // always include a base
      cylinder( r = support_diam/2 , h = support_height, $fn=100);
      translate( [0,0, support_height] )
      if (type == "teeth") {
        acr_standoff_teeth(i_pcb_hole_diam-cll, i_pcb_thickness+cll,  i_split_hole_width+cll );
      } else if (type == "round") {
        acr_standoff_round( i_round_height, i_round_inside+cll, i_round_outside );
      } else if (type == "hex") {
        acr_standoff_hex( i_hex_height, i_hex_inside+cll, i_hex_outside);
      }
    }
    cutouts( i_split_hole_width+cll, i_lock_rod_diam+cll, support_height);
  }
}

module cutouts( split_hole_width, lock_rod_diam, support_height) {
  cylinder( r = lock_rod_diam/2, h = big*2, center=true, $fn=100);
  translate([-big/2,-split_hole_width/2, support_height])
    cube( size=[ big, split_hole_width, big]);
}

module acr_standoff_round( h, diam_in, diam_out)
{
  difference() {
    cylinder( r = diam_out/2 , h = h, $fn=100);
    cylinder( r = diam_in/2 , h = h, $fn=100);
  }
// tbd round with hex holes and vice versa
}


module acr_standoff_hex( h, diam_in, diam_out )
{
  difference() {
echo("in", diam_in, "out", diam_out);
    hexagon_prism( h, diam_out/2 );
    hexagon_prism( h, diam_in/2 );
  }
}


module acr_standoff_teeth( pcb_hole_diam, pcb_thickness, split_hole_width )
{
// move it so the base is at 0 height
  translate([0,0,pcb_thickness])
    teeth( s=split_hole_width/2, w=pcb_hole_diam/2, h=pcb_thickness);
}

module teeth ( s, w, h) {
// s is size of split
// w is the size of pcb hole
// h is pcb thickness
// t (what we tweak) is the height of tooth
  t = 2;
  a = (h+t);
  b = (w-s);
  R = sqrt( a*a + b*b);
  psi=atan2( b, a);
  alphapluspsi = asin( s / R);
echo(" s ", s, " w ", w, " h ", h, " t ", t);
  alpha = min(alphapluspsi + psi, bend_max);
echo(" alpha is ", alpha);
  x = (h*sin(-alpha) + s - w) / cos(alpha);
  xx = -x + s;
echo("x is ", x, " xx is ", xx, " alpha ", alpha);
// left tooth
  tooth_cut( s, w, h, xx, t, alpha);
// right tooth
  mirror( [0, 1, 0])
    tooth_cut( s, w, h, xx, t, alpha);

}

module tooth_cut( s, w, h, base_width, tooth_height, alpha) {
  tooth_base = [ s, 0, h ]; 
  difference() {
    tooth(s, w, h, base_width, tooth_height);
    translate(-tooth_base)
      rotate( alpha, [1,0,0])
        translate( tooth_base)
          mirror( [0, 1, 0])
            tooth(s, w+1, h+1, base_width+1, tooth_height+1);
  }
}

module tooth( s, w, h, base_width, tooth_height )  {
  difference() {
    union() {
      cylinder(r1 = base_width, r2 = w, h = tooth_height, $fn=100);
      mirror( [0,0,1])
        cylinder( r = w, h = h, $fn=100);
    }

// this is to only paint half of tooth
    translate( [-big/2, 0, -h]) 
       cube( [big, big, tooth_height+h]);
// hole for the split 
   translate([-big/2,-s, -h])
     cube( size=[ big, s, big]);
  }
}
