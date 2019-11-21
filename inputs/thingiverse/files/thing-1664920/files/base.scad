//Base Generator for Miniature Wargamers

//Measurements in milimeters or inches?
units=1; // [0:millimeters, 1:inches]
//how wide in mm should the base be?
base_width = 1;
//how deep should the base be? must be equal to or greater than width
base_depth = 2;
//how tall should the base be?
base_height = .125;
//What angle should the sides be? 70 is a good value; use 90 for straight sides
angle= 70;
//what shape?
shape=4; // [4:rectangle, 6:octangle, 80:lozenge]
/* [Base Slot] */
//What kind of slot?
slot_type=0; // [0:none, 1:end to end, 2:corner to corner, 3:end-to-end double]
//How long is the slot?
slot_length = .5;
//How wide is the slot?
slot_width = .09;
//For offset slots, how deep is the offset? (required for double slots)
slot_offset = 0;
/* [Base Indent] */
//% to indent the top surface? (0 for no indent)
base_indent=0;
//% of top surface to indent?
base_indent_area=95;
/* [Central Hole] */
//what shape?
hole_shape=0; // [0:none, 4:diamond, 6:hexagon, 80:round]
//hole diameter?
hole_radius=.35;
/* [Nameplate] */
//What kind of nameplate?
nameplate_type=0; // [0:none, 1:nameplate lengthwise]
//How long is the nameplate?
nameplate_length = 1.5;
//How wide is the nameplate?
nameplate_width = .3;
//Offset how far from the center?
nameplate_offset = .3;
/* [Number of Bases] */
// Number of rows of bases
rows = 1; // [1:10]
// Number of columns of bases
columns = 1; // [1:10]



module base(width, depth, height, side_angle, sides, bslot, slength, swidth, sback, bindent, biarea, hshape, hradius, ntype, nlength, nwidth, noffset)
{

/* [Hidden] */
  $fa=0.5; // default minimum facet angle
  $fs=0.5; // default minimum facet size
  convf = 25.4; // inches to mm

// conversions to metric (if needed)

  bh = units ? height * convf : height;
  bw = units ? width * convf : width;
  bd = units ? depth * convf : depth;
  sl = units ? slength * convf : slength;
  sw = units ? swidth * convf : swidth;   
  sb = units ? sback * convf : sback;   
  hr = units ? hradius * convf : hradius;
  nl = units ? nlength * convf : nlength;
  nw = units ? nwidth * convf : nwidth;   
  npo = units ? noffset * convf : noffset;     
  
// if rectangle, rotate from diamond to rectangle    
    
  rangle = sides == 4 ? 45 : 0;
    
  inset = bh/tan(angle);
  radius1 = sides == 4 ? sqrt(2) * bw / 2 : bw/2;
  radius2 = radius1 - inset * 2;
  diff = sides == 6 ? bd - (sqrt(3) * radius1) : bd - bw;
  offset1 = sides == 4 ? sqrt((diff * diff)/2): 0;
  offset2 = sides == 4 ? sqrt((diff * diff)/2): diff;
  
  
  // slot variables
   
  sangle = (bslot == 2) ? atan(bw/bd) : 0; // angle of slot
  slot_offset = (sb) ? (sides == 4) ? sqrt((sb * sb)/2) : sb : 0;
  
  
  doff = (sides == 6) ? bd/2 - (sqrt(3) * radius1)/2 : bd/2 - bw/2;
  
 
  soffset_x = sqrt(((doff - slot_offset) * (doff - slot_offset))/2);
  soffset_y = sqrt(((doff + slot_offset) * (doff + slot_offset))/2);
  
  np_offset = sqrt(((npo) * (npo))/2);
  
  rotate(rangle)
  {
      difference()
      {
        hull()
        {
        cylinder(r1=radius1, r2=radius2, h=bh, $fn=sides);
        translate([offset1,offset2,0])
          cylinder(r1=radius1, r2=radius2, h=bh, $fn=sides);      
        }

        if (bslot) // if base slot
        {
          if (sides==4)
          {
          translate([soffset_x,soffset_y,bh / 2])        
            color([0,0,1])
              rotate(sangle - 45)
                cube([sw,sl, bh + 4], center=true);
          }
          else
          {
             translate([0 - slot_offset,doff,bh / 2])        
               color([0,0,1])
                 rotate(sangle)
                   cube([sw,sl, bh + 4], center=true);              
          }
        }
        if (bslot == 3) // if double slot
          {
            if (sides == 4)
              translate([soffset_y,soffset_x,bh / 2])
                color([0,0,1])
                  rotate(sangle - 45)
                    cube([sw,sl, bh + 4], center=true);        
            else
              translate([slot_offset, doff, bh / 2])
                color([0,0,1])
                  cube([sw,sl, bh + 4], center=true);              
          }
        if (bindent) // if indented top
          {
            if (sides == 4)
            {
              translate([0,0,bh * (100 - bindent)/100])
                color([0,0,1])
                    hull()
                    {
                      cylinder(r1=radius2 * (biarea)/100, r2=radius2 * (biarea)/100, h=bh, $fn=sides);
                      translate([offset1,offset2,0])
                        cylinder(r1=radius2 * (biarea)/100, r2=radius2 * (biarea)/100, h=bh, $fn=sides);  
                    }
            }    
            else
              translate([0, 0, bh * (100 - bindent)/100])
                color([0,0,1])
                  hull()
                  {
                    cylinder(r1=radius2 * (biarea)/100, r2=radius2 * (biarea)/100, h=bh, $fn=sides);
                    translate([offset1,offset2,0])
                      cylinder(r1=radius2 * (biarea)/100, r2=radius2 * (biarea)/100, h=bh, $fn=sides);              }
          }    
          if (hshape) // if central hole
          {
            if (sides == 4)
            {
              translate([soffset_x,soffset_y,-2])
                rotate(45)
                  color([0,0,1])
                    cylinder(r=hr, h=bh+4, $fn=hshape);
            }    
            else
            {
              translate([0, doff, -2])
                color([0,0,1])
                 cylinder(r=hr, h=bh+4, $fn=hshape);
            }
          }       
      }
      if (nameplate_type)
          if (sides == 4)
            translate([soffset_x - np_offset,soffset_y + np_offset,4])
              rotate(45)
                color([0,0,1])
                  cube([nl,nw, bh], center=true);
          else
              translate([npo,(sides == 6) ? bd/2 - (sqrt(3) * radius1)/2 : bd/2 - bw/2,4])
                rotate(90)
                  color([0,0,1])
                    cube([nl,nw, bh], center=true);

   }
}


module make_x_by_y (x,y)
{
    
/* [Hidden] */
  convf = 25.4; // inches to mm    
    
// conversions to metric (if needed)

  xspace = units ? base_width * convf + 2 : base_width + 2;
  yspace = units ? base_depth * convf + 2 : base_depth + 2;
    
	for (j = [0:y])
    {
		for (i = [0:x])
        {
			translate([i*xspace,j*yspace,0]) children(0);
		}
	}
}

make_x_by_y(rows - 1,columns - 1)
{
	base(base_width, base_depth, base_height, angle, shape, slot_type, slot_length, slot_width, slot_offset, base_indent, base_indent_area, hole_shape, hole_radius, nameplate_type, nameplate_length, nameplate_width, nameplate_offset);
}

// Written in 2016 by Bill Armintrout <http://theminiaturespage.com>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
