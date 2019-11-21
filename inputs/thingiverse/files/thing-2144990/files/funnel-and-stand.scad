// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Parametric funnel with stand
//
// Copyright 2017 -- 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
//

// ... to preview. You will get both parts, if you select a stand
part = "funnel"; // [funnel: funnel, stand: stand or nothing]

// in cm. The neck is the thin bottom part
outer_neck_diameter = 2.8;  // [0.3:0.1:8]

// in cm. This is the top part
inner_rim_diameter = 7;  // [3:0.1:15]

// in cm. The sharped tip is added to this length
neck_length = 2; // [0.3:0.1:8]

// Slope of the main conical part, in degrees. Beware of printing problems with low angles
funnel_angle = 60;  // [30:75]

// Cut off angle to give the funnel a sharpened tip. 0 means flat bottom.
neck_tip_angle = 22.5;  // [0:0.5:60]

// Create just the funnel, or a stand to go with it, with one or three supports
stand_style = 0;  // [0:Just funnel, 1:Funnel and simple stand, 3:Funnel and tripod stand]

// Height added  to the stand, in cm. The height of the top of the funnel will be the length of your pencil plus this.
extra_height = 1; // [1:15]

// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Hidden] */

// Some of the values below can be carefully tweaked, changing others is a
// bad idea. Try, and undo if it didn't work.


// w = 1.6;
w = 1.8;  // To get four perimeters in slic3r, we have to add a bit here. WTF?
// Wall thickness.  When you measure the conical part along the surfaces it
// will appear thinner.

es_h = 20; // Extra support/stabilizer height
es_w = 0.8;
// Extra support/stabilizer width. Need not be as stable as a normal
// wall

function strake_r() = (stand_style) ? 0 : 0.8;
handle_br = 0.8;  // Hanle border radius


r_n = (outer_neck_diameter * 5) - w -strake_r();  // inner neck radius in mm
r_r = inner_rim_diameter * 5;  // inner rim radius in mm
l_n = neck_length * 10;  // neck_length in mm
heh = extra_height * 5; // Half the extra height, in mm
ond = outer_neck_diameter * 10;
ncl = ond / cos(neck_tip_angle) * 1.05;
nth = ond * tan(neck_tip_angle);

ms = 0.01; // Muggeseggele

fua = funnel_angle;
fua_b = 90 - fua;





wiggle_room_factor = 1.1;

// The small radius of the support pencil, from center to center of face
r_p_s = 3.4 * wiggle_room_factor;
// The flat-to-flat diameter of a standard pencil is 6.8 mm. Do quite a
// bit more.
// The max. radius (center to edge).  Also the
// width of one pencil face.
r_p_l = r_p_s * 2 / 3 * sqrt(3);


// Handle sizes:

handle_w = 40;  // Wide eonugh for index and middle finger
handle_l = 30;  // Long enough for the distal segments
handle_cr = 2;  // Corner radius
// Border radius: see below
handle_handle_ch_ratio = 0.5;
// Used to calculate how heigh the lug that holds the handle is

// Tip angle
tip_a = 21;  // degrees. Apparently standard in Germany

// tip_a = 19;  // degrees. There is a German "Long Point"" pencil sharpnener
// like this.  There are also rumors that American pencils are pointier than
// German ones.
// tip_a = 24  // Special color pencil sharpener.

// The tip angle is apparently from one side to the other side, not from
// one side to the center line.


// Size of the "big pencil" connector. Twice the area, half of it hollow.
r_bp_s = sqrt(2) * r_p_s;
r_bp_l = r_bp_s * 2 / 3 * sqrt(3);

sp_h = 8 * r_p_s;  // Height of the sharpend pencil cylindrical connector bit
usp_h = 10 * r_p_s;  // Height of the unsharpend pencil connector bit


bp_s_h = r_bp_s / tan(tip_a/2);

// Height of the sleeve at the bottom (as printed) of the "big pencil"
// connector. The length of a pencil tip. (The angle of the outer wall
// should come out slightly below tip_a, as the walls get thinner. We
// (try to) maintain cross section area, not wall strength.)
// Here we need the angle from one side to the center line.


some_distance = 2 * (r_r + w) + 13 * w;

// fn for differently sized objects, for preview or rendering.
pfa = 40;
pfb = 15;
pfc = 15;
rfa = 180;
rfb = 60;
rfc = 20;
function fa() = (preview) ? pfa : rfa;
function fb() = (preview) ? pfb : rfb;
function fc() = (preview) ? pfc : rfc;

// *******************************************************
// End setup



// *******************************************************
// Generate the parts

print_part();
// preview_parts();
// stack_parts();

// I used this cylinder as a modifier to set the infill to higher
// values under the central bit of the portioner sphere, to get less
// sag.
// cylinder(r=0.7*r, h=r,$fn=fa());


module print_part()
{
   if (part == "funnel")
   {
      funnel();
   }
   if (part == "stand" && stand_style)
   {
      stand();
   }
}

module preview_parts()
{
   funnel();
   translate([some_distance, 0, 0])
   {
      if (stand_style)
      {
         stand();
      }
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         stand();
      }
      rotate([0,180,0])
      {
         translate([0, 0, -3*l_n])
         {
            color("red")
            {
               funnel();
            }
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves


// And the definitions
module funnel()
{

   ch = (r_r - r_n) / tan(fua_b);
   // Max height. I sort-of designed the funnel the right way up, but
   // want it come out upside down.
   // mh = l_n + o_nl + ch;

   mh = l_n + ch;
   // just the rotationl symmetirc part
   module rot_funnel()
   {
      f_poly = [
         [r_n, mh + nth],
         [r_n+w, mh + nth],
         [r_n+w, mh - l_n],
         [r_r + w, mh-mh],
         [r_r, mh-mh],
         [r_n,  mh - l_n]
         // Mathamatically less pure, but easier to print
         ];
      rotate_extrude(convexity=4, $fn=fa())
      {
         polygon(f_poly);
      }

   }

   // The holow core of the funnel, plus a bit of tollerance. Used as
   // difference later.
   module funnel_core()
   {
      c_poly = [
         [0 ,mh + nth],
         [r_n + w/2 ,mh + nth],
         [r_n + w/2, mh - (l_n)],
         [r_r + w/2, -ms],
         [0, -ms]
         ];
      rotate_extrude(, $fn=fa())
      {
         polygon(c_poly);
      }

   }

   module funnel_neck_cutoff()
   {
      // The bit that creates the slant an the neck
      translate([-ond/2-ms, -ond/2-ms, mh])
      {
         rotate(a=neck_tip_angle, v=[1, 0, 0])
         {
            cube([ond+2*ms, ncl, ncl]);
         }
      }
   }

   module funnel_support()
   {

      // The holder lug. The Poly is bigger than needed, and we
      // subtract a bit later.
      lp_poly = [
         [r_bp_s,r_r + w - 3*w],
         [r_bp_s,r_r + w + 1.5 * r_bp_l],
         [0,r_r + w + 2*r_bp_l],
         [-r_bp_s,r_r + w + 1.5 * r_bp_l],
         [-r_bp_s,r_r + w - 3*w],
         ];
      linear_extrude(w)
      {
         // Holder plate
         polygon(lp_poly);
      }
      // Extra support
      translate([-es_w/2,r_n+w+0.5*(r_bp_l-r_p_l),0])
      {
         cube([es_w,r_r-r_n, es_h]);
      }
      bp_s_f = (r_bp_l) / r_p_l;
      translate([0,r_r+w+r_bp_l, w])
      {
         rotate(30)
         {
            difference()
            {
               cylinder(h=usp_h+heh, r=r_bp_l, $fn=6);
               // Hollow it out
               translate([0,0, heh])
               {
                  cylinder(h=usp_h+1,r=r_p_l, $fn=6);
               }
            }
         }
      }

   }
   r_h_w = handle_w - 2*handle_cr;
   e_h_l = handle_l - 2*handle_cr + r_r+w;
   e_h_l_2 = handle_l + r_r+w;

   module funnel_grip()
   {
      translate([-r_h_w/2, handle_cr, 0])
      {
         minkowski()
         {
            cube([r_h_w, e_h_l, w]);
            cylinder(r=handle_cr, h=ms, $fn=fb());
         }
      }

      rotate([0, -90, 0])
      {
         translate([0,0,-handle_br/2])
         {
            linear_extrude(handle_br)
            {
               polygon([[w,0],[ch*handle_handle_ch_ratio+w,0],[w, e_h_l_2]]);
            }
         }
      }
      translate([0,0,w])
      {
         translate([0,e_h_l_2-handle_br])
         {
            rotate([0,90,0])
            {
               cylinder(h=r_h_w, r=handle_br, center=true, $fn=fc());
            }
         }
         side_cylinder();
         mirror()
         {
            side_cylinder();
         }

      }

   }

   module side_cylinder()
   {
      translate([handle_w/2-handle_br,0,0])
      {
         rotate([-90,0,0])
         {
            cylinder(h=e_h_l+handle_cr, r=handle_br, $fn=fc());
         }
         translate([handle_br-handle_cr, e_h_l_2-handle_cr, 0])
         {
            difference()
            {
               rotate_extrude($fn=fb())
               {
                  translate([handle_cr-handle_br,0])
                  {
                     circle(r=handle_br, $fn=fc());
                  }
               }
               translate([-handle_cr,-2*handle_cr,0])
               {
                  cube([2*handle_cr,2*handle_cr, handle_br]);
               }
               translate([-2*handle_cr,-handle_cr,0])
               {
                  cube([2*handle_cr,2*handle_cr, handle_br]);
               }
            }
         }
      }

   }
   module funnel_strake()
   {

      translate([0, r_n+w, mh-l_n])
      {
         cylinder(r=strake_r(), h=l_n+nth, $fn=fc());
      }
      rotate(30)
      {
         translate([-(r_r+w), 0, 0])
         {
            rotate([0,90-funnel_angle,0])
            {
               translate([0,0,w])
               {
                  // It's possibly a rounding error, but with
                  // r=strake_r here it doesn't perfectly
                  // align with the funnel. Use a bit more.
                  cylinder(r=strake_r(), h=(r_r - r_n) / cos(funnel_angle), $fn=fc());
               }
            }
         }
      }

   }

   // The funnel proper
   difference()
   {
      rot_funnel();
      funnel_neck_cutoff();
   }

   //
   difference()
   {
      union()
      {
         if (stand_style > 0)
         {
            for (sr=[0:120:(stand_style-1)*120])
            {
               rotate(sr)
               {
                  funnel_support();
               }
            }
         }
         else
         {
            funnel_grip();
            for (i=[60, 180, 300])
            {
               rotate(i)
               {
                  funnel_strake();
               }
            }

         }
      }
      funnel_core();
      funnel_neck_cutoff();
   }
}


module stand()
{
   // hex_r = r_r + w + r_p_s;
   hex_r = r_r+ w + r_bp_l;
//   hex_r_l = hex_r_s * 2 / 3 * sqrt(3);
   difference()
   {
      union()
      {
         // Construct the stand ring symmetric to xy plane ...
         rotate(30)
         {
            rotate_extrude($fn=6)
            {
               translate([hex_r, 0, 0])
               {
                  circle(r=r_p_l, $fn=6);
               }
            }
         }
      }
      // and subtract everything below the xy plane.
      translate([0,0,-l_n])
      {
         cylinder(r=1.5*r_r, h=l_n);
      }
   }
   // Fill the base plate
   rotate(30)
   {
      cylinder(r=hex_r, h=es_w, $fn=6);
   }
   for (sr=[0:120:(stand_style-1)*120])
   {
      rotate(sr)
      {
         translate([0, hex_r, 0])
         {
            // The stand.

            rotate(30)
            {
               difference()
               {
                  union()
                  {
                     // Three segments of linear extrusion
                     // The extra
                     cylinder(h=heh, r=r_p_l,$fn=6);
                     // The sharpend bit
                     translate([0, 0 , heh])
                     {
                        cylinder(h=bp_s_h, r1=r_p_l, r2=r_bp_l,$fn=6);
                     }
                     // The shaft bit
                     translate([0, 0 , bp_s_h+heh])
                     {
                        cylinder(h=sp_h, r=r_bp_l, $fn=6);
                     }
                     // The extra plates. Should not interfere with the stand
                     // without this. Anyway.
                     rotate(-60)
                     {
                        extra_plate();
                     }
                     rotate(180)
                     {
                        extra_plate();
                     }
                  }
                  // Hollow it out
                  translate([0, 0 , heh])
                  {
                     cylinder(h=bp_s_h, r1=0, r2=r_p_l, $fn=6);
                  }
                  translate([0, 0 , bp_s_h+heh])
                  {
                     cylinder(h=sp_h+1,r=r_p_l, $fn=6);
                  }

               }
            }
         }

      }
   }

   module extra_plate()
   {
      es_s_p = [
         [0, 0],
         [es_h + r_p_l/2, 0],
         [0, es_h + r_p_l/2]
         ];
      rotate([90, 0, 0])
      {
         translate([r_p_s, 0.5*r_p_l, 0])
         {
            linear_extrude(es_w)
            {
               polygon(es_s_p);
            }
         }
      }
   }
}
