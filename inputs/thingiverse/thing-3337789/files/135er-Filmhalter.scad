// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Holder to scan 135 film strips with a Reflecta ProScan 10T
//
// Copyright 2018 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0


/* [Global] */


// ... to preview. You will get both parts when you click "Create Thing".
part = "halter"; // [halter: film holder, einsatz: film holder clamp]

// Set this to "render" and click on "Create Thing" when done with the setup.
preview = 1; // [0:render, 1:preview]

/* [Holder] */

// Width of the holder. This one and the next one are the two values you do need to set up for your scanner. Preset is for a Reflecta proScan. Maybe subtract half a millimtre for a better fit.
holder_width = 58.4;  // [20:0.1:150]

// Height or thickness of the holder. See above. You know they were too high when you need a mallet to go from one image to the next...
holder_thickness = 5.6;  // [3:0.1:10]

// How many exposures on the longest strips you want to fit into this. Make sure the resulting holder still fits onto your print bed.
images_per_strip = 4;  // [1:1:8]

/* [Magnets] */

// Diameter of the magnet hole. Add clearance by hand here. Set to 0 for no magnet holes.
magnet_diameter = 3.8;  // [0:0.1:15]
// Height or thickness of the magnet. Make sure to use magnets flat enough to fit.
magnet_height = 1;  // [0.5:0.1:3]

/* [Hidden] */

// Das ganze Filmgroessen-Geraffel wieder verstecken: ein thing pro
// Film. Teil der Automatik (mit/ohne Stege, Lang-oder Kurzkerbe) sind so
// halbwegs inaktiv.


// Width of the film
film_width = 35;  // [8:0.1:70]
// Length from the left edge of an exposure to its right edge
image_width = 36; // [8:0.1:100]
// Length from one point (e.g. left edge) of one exposure to the same point of the next exposure. This minus the image width is used for the vertical ridges, if it's positive.
image_pitch = 8*4.75;  // 8 perf
// Size of an exposure from bottom to top.
image_height = 24; // [7:0.1:68]


bildabstand = max(image_pitch, image_width);
l_filmsteg = max(0, bildabstand-image_width);
r_r = 1.0;  // Rundungsradius

// Auch wichtig:
l_zk = 4;  // Laenge Zentrierkerbe
b_zk = 4;  // Breite Zentrierkerbe
h_zk = 1.2;  // Tiefe der Zentrierkerbe
w_zk = 1;  // Wand bzw Abstand der Zentrierkerbe vom Rand



l_griff = 30;
o_griff = 30;
w_griff = 3;
magnet_y_off = 0;  // Abstand Magnet vom Einsatz

kurzsteg_grenze = 1;  // Weniger als 1 mm pro Seite: Kurzstege

mit_langsteg = ( ((film_width-image_height)/2) >= kurzsteg_grenze);


w_steg = 2;  // Breite fuer Stuecke, die den Film zentrieren.
l_kurzsteg = 0.4*bildabstand;  // Laenge fuer Stuecke, die den Film zentrieren,
// wenn wier keine Fensterstege machen



w_schraeg = 1;  // Breite der Abschraegung rund um die Filmfenster




// *******************************************************
// Extra parameters. These can be changed reasonably safely.


w = 1.8;  // Wall width
p = 1.2;  // Bottom, top plate height
c = 0.6;  // Clearance
c_z = 0.3;  // Clearance in z direction. Mostly for the magnet hole and centering ridge
angle = 60; // Overhangs much below 60 degrees are a problem for me


// Halbwegs wichtig
h_steg = 1.6;  // Hoehe fuer Stuecke, die den Film zentrieren.
h_nut = h_steg + c_z;  // Tiefe fuer Stuecke, auf denen der Film nicht aufliegt



// *******************************************************
// Some shortcuts. These shouldn't be changed

tau = 2 * PI;  // pi is still wrong. tau = circumference / r

xy_factor = 1/tan(angle);
// To get from a height to a horizontal width inclined correctly
z_factor = tan(angle);  // The other way around

some_distance = 1.2 * holder_width;
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

l_fenster = bildabstand * images_per_strip;
l_rand = 2 * w_steg + w_schraeg + 2;
w_rand = w_schraeg + 8;
l_ue_a =  l_fenster + 2*l_rand;
w_einsatz = image_height + 2 * w_rand;
h_bd = holder_thickness/2;  // Hoehe Boden oder Deckel

to_griff = l_ue_a/2 - o_griff - l_griff/2;



// *******************************************************
// End setup




// *******************************************************
// Generate the parts


print_part();
// filmhalter();
// einsatz();
// preview_parts();
// stack_parts();



module print_part()
{
   if ("halter" == part)
   {
      filmhalter();
   }
   if ("einsatz" == part)
   {
      einsatz();
   }
}

module preview_parts()
{
   filmhalter();
   translate([0, some_distance, 0])
   {
      einsatz();
   }
}

module stack_parts()
{
   // intersection()
   {
       // color("yellow")
      {
         filmhalter();
      }
      translate([0,0,holder_thickness + ms])
      {
         rotate([0,180,0])
         {
            // color("red")
            {
               einsatz();
            }
         }
      }
   }
}

// *******************************************************
// Code for the parts themselves


module filmhalter()
{
   difference()
   {
      basis_filmhalter();
      fenster();
      magnetausschnitte();
      kerben();
   }
   fensterstege();
   bodenstege();
}

module einsatz()
{
   difference()
   {
      union()
      {
         difference()
         {
            basis_einsatz();
            fenster();
         }
         fensterstege();
      }
      einsatzausschnitte();
      // magnetausschnitte(magnet_diameter/2);
      magnetausschnitte();
   }

}


module basis_filmhalter()
{
   translate([0,0,h_bd])
   {
      difference()
      {
         massiver_halter();
         einsatz_ausschnitt(c);
      }
   }
}


module basis_einsatz()
{
   translate([0,0,h_bd])
   {
      intersection()
      {
         massiver_halter();
         rotate([0,180,0])
         {
            einsatz_ausschnitt(0);
         }
      }
   }

}

module massiver_halter()
{
   hull()
   {
      vosp();
      mirror([0,0,1])
      {
         vosp();
      }
   }

   module vosp()
   {
      tosp();
      mirror([0,1,0])
      {
         tosp();
      }
   }
   module tosp()
   {
      osp();
      mirror([1,0,0])
      {
         osp();
      }

   }

   module osp()
   {
      translate([l_ue_a/2-r_r, holder_width/2-r_r, holder_thickness/2-r_r])
      {
         sphere(r=r_r);
      }
   }
}


module einsatz_ausschnitt(ec)
{
   translate([0, 0, holder_thickness])
   {
      cube([l_ue_a+2*ms, w_einsatz + ec, 2*holder_thickness], center=true);
      grip_cut();
      mirror()
      {
         grip_cut();
      }
   }
   module grip_cut()
   {
      translate([to_griff, 0, 0])
      {
         cube([l_griff + ec, holder_width + 2*ms, 2*holder_thickness], center=true);
         translate([0, -holder_width/2, 0])
         {
            cube([l_griff + ec, 2*w_griff+2*ec, 4*holder_thickness], center=true);
         }
      }
   }
}

module fenster()
{
   translate([0, 0, h_bd])
   {
      hull()
      {
         translate([0,0,-0.5+ms])
         {
            cube([l_fenster, image_height, 1], center=true);
         }
         translate([0,0,-h_bd-0.5-ms])
         {
            cube(
               [l_fenster+2*w_schraeg, image_height+2*w_schraeg, 1], center=true);
         }
      }

   }
}


module magnetausschnitte()
{
   if (magnet_diameter > 0 && magnet_height > 0)
   {
      magnetausschnitt(1, 1);
      magnetausschnitt(-1, 1);
      magnetausschnitt(1, -1);
      magnetausschnitt(-1, -1);
   }
}

module magnetausschnitt(xf, yf)
{
   yo_mag = w_einsatz/2 + magnet_diameter/2 +magnet_y_off;


   // Mittig in den Griffen.
   translate(
      [xf * (to_griff), yf * (yo_mag), h_bd - magnet_height-c_z + ms])
   {
      cylinder(d=magnet_diameter, h=magnet_height+c_z);  // N.B. Spiel ist schon im magnet_diameter
      // eingerechnet
   }
}

module bodenstege()
{
   translate([0, 0, -ms+h_steg/2+h_bd])
   {
      if (mit_langsteg)
      {
         langbodensteg();
         rotate(180)
         {
            langbodensteg();
         }
      }
      else
      {
         kurzbodenstege();
         rotate(180)
         {
            kurzbodenstege();
         }
      }
   }
   module langbodensteg()
   {
      translate([0,w_steg/2+film_width/2+c/2, 0])
      {
         cube([l_fenster, w_steg, h_steg], center=true);
      }
   }
   module kurzbodenstege()
   {
      for (i=[0:images_per_strip-1])
      {
         translate([-l_fenster/2 + (0.5 + i) * bildabstand, w_steg/2+film_width/2+c/2, 0])
         {
            cube([l_kurzsteg, w_steg, h_steg], center=true);
         }
      }
   }
}

module einsatzausschnitte()
{
   translate([0, 0, h_bd + ms-h_nut/2])
   {
      if (mit_langsteg)
      {
         langausschnitt();
         rotate(180)
         {
            langausschnitt();
         }
      }
      else
      {
         kurzausschnitte();
         rotate(180)
         {
            kurzausschnitte();
         }
      }
   }
   module langausschnitt()
   {
      translate([0,w_steg/2+film_width/2+c/2,0])
      {
         cube([l_fenster+6*c, w_steg+2*c, h_nut], center=true);
      }
   }
   module kurzausschnitte()
   {
      for (i=[0:images_per_strip-1])
      {
         translate([-l_fenster/2 + (0.5 + i) * bildabstand, w_steg/2+film_width/2+c/2-film_width/4 + image_height/4, 0])
         {
            cube([l_kurzsteg+2*c, w_steg+2*c+film_width/2 - image_height/2, h_nut], center=true);
         }
      }
   }
}


module fensterstege()
{
   if (l_filmsteg > 0)
   {
      for (i=[1:images_per_strip-1])
      {
         translate([-l_fenster/2 + i * bildabstand, 0, h_bd/2-ms])
         {
            cube([l_filmsteg, image_height+2*w_schraeg + 2*ms ,h_bd], center=true);
         }
      }
   }
}

module kerben()
{
   // Den Radius der Zentrierkerbe kann mensch per Pythagoras bestimmen.
   // Hypothenuse = r_zk
   // 1. Kathete = l_zk/2
   // 2. Kathete = r_zk - h_zk
   // h_zk > 0
   // r_zk * r_zk = l_zk * l_zk / 4 + r_zk * r_zk - 2 * r_zk * h_zk + h_zk * h_zk
   // 0 = l_zk * l_zk / 4 - 2 * r_zk * h_zk + h_zk * h_zk
   // 2 * r_zk * h_zk =
   r_zk = (l_zk * l_zk / 4 + h_zk * h_zk) / (2 * h_zk);
   for (i=[0:images_per_strip-1])
   {
      translate(
         [-l_fenster/2 + i * bildabstand + bildabstand/2, holder_width/2 - w_zk, h_zk-r_zk])
      {
         rotate([90,0,0])
         {
            cylinder(r=r_zk, h=b_zk);
         }
      }
   }

}
