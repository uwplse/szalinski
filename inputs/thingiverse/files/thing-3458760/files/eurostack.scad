// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A set of cylindrical holes to store one set of euro coins.
//
// (c) 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

// ... to preview. You will get all parts when you click "Create Thing".
part = "stack"; // [stack: coin stacker, lid: lid]



// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]

// How many one cent coins
one_cents = 1;  // [0:50]

// How many two cent coins
two_cents = 1;  // [0:50]

// How many five cent coins
five_cents = 1;  // [0:50]

// How many ten cent coins
ten_cents = 1;  // [0:50]

// How many twenty cent coins
twenty_cents = 1;  // [0:50]

// How many fifty cent coins
fifty_cents = 1;  // [0:50]

// How many one euro coins
one_euros = 1;  // [0:50]

// How many two euro coins
two_euros = 1;  // [0:50]


/* [Hidden] */

// Heights or thicknesses of the coins

h_001 = 1.67;
h_002 = h_001;
h_005 = h_001;
h_01 = 1.93;
h_02 = 2.14;
h_05 = 2.38;
h_1 = 2.33;
h_2 = 2.2;

// Diameters of the coins

d_001 = 16.25;
d_002 = 18.75;
d_005 = 21.2;  // !
d_01 = 19.75;  // Smaller than the 5 cent. Things are swapped below
d_02 = 22.25;
d_05 = 24.25;  // !
d_1 = 23.25;  // Smaller than the 50 cent. Swapped, too.
d_2 = 25.75;




// *******************************************************



w = 0.8;  // Wall width
p = 0.6;  // Bottom, top plate height
c = 1;  // Clearance
ch = 0.2; //


// Some of these are from a template and not used in this design. Working out which exactly i could delete is too much work

angle = 55; // Overhangs much below 60 degrees are a problem for me

// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong. tau = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around



some_distance = 50;
ms = 0.01;  // Muggeseggele.

// fn for differently sized objects and fs, fa; all for preview or rendering.
pna = 40;
pnb = 15;
pa = 5;
ps = 1;
rna = 180;
rnb = 30;
ra = 1;
rs = 0.1;
function na() = (preview) ? pna : rna;
function nb() = (preview) ? pnb : rnb;
$fs = (preview) ? ps : rs;
$fa = (preview) ? pa : ra;



// calculate some more values

function c_h_n(n) = (n > 0) ? ch : 0;

// How high the whole thing


h_t = p + one_cents * h_001 + c_h_n(one_cents) + two_cents * h_002 + c_h_n(two_cents) + ten_cents * h_01 + c_h_n(ten_cents) + five_cents * h_005 + c_h_n(five_cents) + twenty_cents * h_02 + c_h_n(twenty_cents) + one_euros *  h_1 + c_h_n(one_euros)  + fifty_cents * h_05 + c_h_n(fifty_cents) + two_euros * h_2  + p;

;

// N.B.: 10 cent pieces have a smaller diameter than 5 cent pieces, as does the 1
// euro coin and 50 cent coin. Below they are swapped. You should later
// stack them that way, too.

// To make the whole no coin of this size situation easier, we just do the
// c_h for coins that are not there. I'll call this a kludge. Whatever.

o_001 = p;
o_002 = o_001 + one_cents * h_001 + c_h_n(one_cents);
o_01 = o_002 + two_cents * h_002 + c_h_n(two_cents);
o_005 = o_01 + ten_cents * h_01 + c_h_n(ten_cents);
o_02 = o_005 + five_cents * h_005 + c_h_n(five_cents);
o_1 = o_02 + twenty_cents * h_02 + c_h_n(twenty_cents);
o_05 = o_1 + one_euros * h_1 + c_h_n(one_euros);
o_2 = o_05 + fifty_cents * h_05 + c_h_n(fifty_cents);

d_ex = 2*c+2*w;

d_o_2 = d_2 + d_ex;
d_o_05 = max(d_05+d_ex, d_o_2 - (fifty_cents*h_05+c_h_n(fifty_cents))*xy_factor);
d_o_1 = max(d_1+d_ex, d_o_05 - (one_euros*h_1+c_h_n(one_euros))*xy_factor);
d_o_02 = max(d_02+d_ex, d_o_1 - (twenty_cents*h_02+c_h_n(twenty_cents))*xy_factor);
d_o_005 = max(d_005+d_ex, d_o_02 - (five_cents*h_005+c_h_n(five_cents))*xy_factor);
d_o_01 = max(d_01+d_ex, d_o_005 - (ten_cents*h_01+c_h_n(ten_cents))*xy_factor);
d_o_002 = max(d_002+d_ex, d_o_01 - (two_cents*h_002+c_h_n(two_cents))*xy_factor);
d_o_001 = max(d_001+d_ex, d_o_002 - (one_cents*h_001+p+c_h_n(one_cents))*xy_factor);

// *******************************************************
// End setup

// Calculate some values

// *******************************************************
// Generate the parts

print_part();
// preview_parts();
// stack_parts();



module print_part()
{
   if ("stack" == part)
   {
      stack();
   }
   if ("lid" == part)
   {
      lid();
   }
}

module preview_parts()
{
   stack();
   translate([some_distance, 0, 0])
   {
      lid();
   }
}

module stack_parts()
{
   // intersection()
   {
      color("yellow")
      {
         stack();
      }
      translate([0,0,h_t-p])
      {
         color("red")
         {
            lid();
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves


module stack()
{
   difference()
   {
      union()
      {
         cylinder(d1=d_o_001, d2=d_o_002, h=one_cents*h_001+p+c_h_n(one_cents)+ms);
         translate([0,0,o_002])
         {
            cylinder(d1=d_o_002, d2=d_o_01, h=two_cents*h_002+c_h_n(two_cents)+ms);
         }
         // First 10 cent
         translate([0,0,o_01])
         {
            cylinder(d1=d_o_01, d2=d_o_005, h=ten_cents*h_01+c_h_n(ten_cents)+ms);
         }
         // Only then the bigger 5 cent
         translate([0,0,o_005])
         {
            cylinder(d1=d_o_005, d2=d_o_02, h=five_cents*h_005+c_h_n(five_cents)+ms);
         }
         translate([0,0,o_02])
         {
            cylinder(d1=d_o_02, d2=d_o_1, h=twenty_cents*h_02+c_h_n(twenty_cents)+ms);
         }
         translate([0,0,o_1])
         {
            cylinder(d1=d_o_1, d2=d_o_05, h=one_euros*h_1+c_h_n(one_euros)+ms);
         }
         translate([0,0,o_05])
         {
            cylinder(d1=d_o_05, d2=d_o_2, h=fifty_cents*h_05+c_h_n(fifty_cents)+ms);
         }
         translate([0,0,o_2])
         {
            cylinder(d=d_o_2, h=two_euros*h_2+c_h_n(two_euros)+p+ms);
         }
      }
      union()  // To make debuging (%) easier
      {
         translate([0,0,o_001])
         {
            cylinder(d=d_001+2*c, h=h_t);
         }
         translate([0,0,o_002])
         {
            cylinder(d=d_002+2*c, h=h_t);
         }
         // First 10 cent
         translate([0,0,o_01])
         {
            cylinder(d=d_01+2*c, h=h_t);
         }
         // Only then the bigger 5 cent
         translate([0,0,o_005])
         {
            cylinder(d=d_005+2*c, h=h_t);
         }
         translate([0,0,o_02])
         {
            cylinder(d=d_02+2*c, h=h_t);
         }
         translate([0,0,o_05])
         {
            cylinder(d=d_05+2*c, h=h_t);
         }
         translate([0,0,o_1])
         {
            cylinder(d=d_1+2*c, h=h_t);
         }
         translate([0,0,o_2])
         {
            cylinder(d=d_2+2*c, h=h_t);
         }
      }
   }
}

module lid()
{
   cylinder(d=d_2, h=p);
}
