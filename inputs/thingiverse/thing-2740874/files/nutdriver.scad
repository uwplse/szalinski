// Simple nutdriver example -- Al Williams

// Type of shaft
$fn=50;  // [6:hex, 128:round]
// Size of nut (a little larger than the nut is good)
nutsize=6.2;
// Size of hex driver side -- should be tight
hexsize=2;
// Size of wall around nut
wall=1;
// Socket height
sock_height=4;
// Drive height
drive_height=4;
// Gap between drive and socket
gap=3;

// Scale up holes by factor if your printer/slicer makes holes small
holescale=1;
// Add a bit to holes if your printer/slicer makes holes small (make negative if they come out big)
holeoffset=0.5;

nut_size=nutsize*holescale+holeoffset;
hex_size=hexsize*holescale+holeoffset;

difference()
{
   translate([0,0,-(drive_height+gap/2)]) cylinder(d=nut_size+2*wall,h=sock_height+drive_height+gap,center=false);
   translate([0,0,gap/2]) cylinder(d=nut_size,$fn=6,h=sock_height+2,center=false);
   translate([0,0,-(drive_height+gap/2+2)])
      cylinder(d=hex_size,$fn=6,h=drive_height+2,center=false);
}