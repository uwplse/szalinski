// SD and microSD card holder Customizer - by Robert Wallace - Oct 2019

// Generate a box (and corresponding lid) for storing SD cards
//   -- user-specified: number of card slots
//   -- user-specified: orientation of SD cards (horiz or vert)
//   -- user-specified: generate box or lid or both


// 1 - 50.  There will be one SD slot and one microSD slot per row
number_of_card_slot_rows = 7; //1:50

// Which way to cut the slots for SD card storage
SD_card_orientation = "Horizontal"; //[Horizontal,Vertical]

// make the storage box object
generate_box = "Yes"; //[Yes,No]

// Make a lid to fit the box
generate_lid = "Yes"; //[Yes,No]

module fake_news()  // encountering any module stops customizer from further customizing
{
}



// translate custimizer entries into parameters used in the code
num_sd = (number_of_card_slot_rows < 0 ||   // if out of range, give 'em 7
         number_of_card_slot_rows > 50) ? 
         7 :
         number_of_card_slot_rows;    // number of sd card slots to cut (microsd, too)

sd_horiz = (SD_card_orientation == "Horizontal") ? 1 : 0; // set to 1 for horizontal
                                                     // placement of SD cards

make_box = (generate_box == "Yes" || generate_box == "YES") ? 1 : 0;   // slotted-box
make_lid = (generate_lid == "Yes" || generate_lid == "YES") ? 1 : 0;   // lid

if(make_box == 0 && make_lid == 0)
{
linear_extrude(height = 3)
text("Please choose box and/or lid.");
}
// Here be Dragons!
//
// Note there are almost more lines of parameter set-up than object generation code

// You can change these, but even I don't remember what they all do, so...

lid_tol = .1; // a little gap between base and lid sides so lid will fit
sdtol = 1;     // -- and so the cards will fit, too

//microSD slot dimensions -- exact card dim plus tolerance
msdx = 11 + sdtol;   // msd card width + tolerance
msdy = 15;           // cards always stored vertically - no tolerance needed
msdz = .76 + .75;    // msd card thickness + tolerance
msd_in = 11.5;       // msd slot depth - no tolerance needed

// SD dimensions - slot dimensions based on horizontal or vertical orientation
sdx = (sd_horiz) ? 32 + sdtol : 24 + sdtol;  // SD slot x dim placed vert or horiz
sdy = (sd_horiz) ? 24 : 32;     // Y has no tolerance -it's the open vertical direction
sdz = 2 + sdtol/2;              // thickness of SD card slot
sd_in = (sd_horiz) ? 19 : 25;   // depth of SD slot (horizontal or vertical orientation)

// SD placement parameters  (as tuned for my preference)
// Note: gap between SD and mSD slots is determined programatically - see msd_xoff
sdgap = 5.0;    // space between cards (vertical)
sd_xoff = 3;    // space between SD cards and left side of box
sd_yoff = 5;    // space between bottom card and bottom of box

msd_xoff = 3;  // msd slots will be offset from right side of box

msdgap = sdgap;// + msdz;

// box of slots - dimensions are for the part of the box "inside" the
//                base that forms the ledge for the lid to rest upon

box_x = sdx + msdx + sd_xoff + sd_yoff + 1;  // box x based on card widths and offsets
box_y = num_sd * (sdz + sdgap) + sd_yoff;    // box y based on num_sd (card count)
box_z = sd_in + 1.5;                         // box z based on card ht and floor thk
box_r = 2.2; //1.5;                          // 4 corners roundover radius

ledge_ht = 5;  // measured down from top of box
lid_z = ledge_ht + (sdy-sd_in) + 1;  // but needs to clear inserted cards by, min, 1mm
lid_thk = 1.5;

ledge_wid = .75 + lid_tol;  // the width of the ledge the lid sits on

orientation = (sd_horiz == 1) ? "horizontally" : "vertically";
echo("Card Slots",  num_sd, "SD Stored" ,orientation, "Box dimensions", x=box_x, y=box_y, z=box_z, r=box_r);

if(make_box)
 {
 difference()
  {
  // main box
  union()
   {
   box(box_x, box_y, box_z, box_r);
   base(box_x, box_y, box_z, box_r, ledge_wid);
   }  // end union

  // cut out slots
  for(sdc = [0 :  1 : num_sd - 1])
   {
   translate([sd_xoff, 
              (sdc * (sdz + sdgap)) + sd_yoff,
              box_z - sd_in + .5])
    card_cutout(sdx, sdz, sd_in);
   translate([box_x - msd_xoff - msdx, 
              (sdc * (sdz + msdgap)) + sd_yoff + (sdz/2 - msdz/2), 
              box_z - msd_in + .5])
    card_cutout(msdx, msdz, msd_in);
   }  // end for(sdcount)
  }  // end difference
 }  // end if(make_box)

if(make_lid)
 {
 rotate([180,0,0]) // postions lid for printing 
  translate([(box_x + 10) * make_box,-box_y,-(lid_z+lid_thk)]) // translate to azix for rotating   
   lid(box_x, box_y, lid_z, box_r, ledge_wid, lid_thk);
 }  // end if(make_lid)

//** End of main generation

//**  Modules **//


// card_cutout() - generate a shape used to cut out the SD slots
//               -- there's also a wedge used to bevel the top leading and trailing edge
module card_cutout(ccx, ccy, ccz)
{
 // the block
cube([ccx, ccy, ccz - ccy/4]);

// the bevel
translate([0,ccy/2,ccz - (ccy) - .1])
 rotate([0,90,0])
rotate([0,0,90])
  linear_extrude(height = ccx)
   polygon([[0,0],[ccy+.35, ccy],[-ccy - .35, ccy],[0,0]]);
}


module box(x = 2,y = 3,z = 4,r = 3)
{
d=2*r;

translate([r,r,0])
hull()
 {
 translate([0, 0, 0]) cylinder(r=r, h=z-r, $fn=70);
 translate([x-d, 0, 0]) cylinder(r=r, h=z-r, $fn=70);
 translate([x-d, y-d, 0]) cylinder(r=r, h=z-r, $fn=70);
 translate([0, y-d, 0]) cylinder(r=r, h=z-r, $fn=70);

 translate([0, 0, z-r]) sphere(r=r, $fn=80);
 translate([x-d, 0, z-r]) sphere(r=r, $fn=80);
 translate([x-d, y-d, z-r]) sphere(r=r, $fn=80);
 translate([0, y-d, z-r]) sphere(r=r, $fn=80);
 }  // end hull()
}  // end module box()


module lid(x,y,z,r, edge, thk)  // currently a flat-topped lid
{
linear_extrude(height = z)
difference()
 {
 offset(r=edge)
  {
  projection()
   {
   box(x,y,z,r);
   }
  }

 offset(r=lid_tol/2)
  {
  projection()
   {
   box(x,y,z,r);
   }
  }  // end offset for lid tolerance
 } // end difference()

// stick on a lid
translate([0,0,z])
 linear_extrude(height = thk)  // parameterize the lid thickness
  offset(r=edge)
   {
   projection()
    {
    box(x,y,z,r);
    }
   }

// add inner rim to strengthen the connection between lid and walls
translate([0,0,z - 1.5])
 linear_extrude(height = 1.5)
  difference()
   {
   offset(r=edge)
    {
    projection()
     {
     box(x,y,z,r);
     }
    }

 offset(r=-1)
  {
  projection()
   {
   box(x,y,z,r);
   }
  }  // end offset for lid tolerance
 } // end difference()


}  // end module lid()


// base() -- generate base for box - a little larger than box so as to form ledge
module base(x,y,z,r, edge)
{
ledge_offset = 5;   // how far down from the top does the ledge appear

// make a projection of the box to offset for the lid and "base"
linear_extrude(height = z - ledge_offset)
 offset(r=edge)
  {
  projection()
   {
   box(x,y,z,r);
   }
  }
}