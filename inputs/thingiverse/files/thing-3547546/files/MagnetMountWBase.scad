// Which part would you like to see?
part="3"; // [1:Base Only,2:Mount Only,3:Base & Mount]
Screw_hole="yes";// [yes,no]
Screw_diameter=3;// [1:.5:5]
Screw_head_diameter=8;// [4:.5:10]
Slotted_screw_hole="yes";// [yes,no]
Slot_width=1;// [1,2,3]
// Distance between the screw head and bottom of base
Mount_plate_thickness=2;// [1:.5:5]
Magnet_position_indicator="yes";// [yes,no]
Magnet_length=15;// [3:.5:20]
Magnet_width=6.5;// [2:.5:15]
Magnet_height=3;// [2,3,4]

/*[hidden]*/
/***************************************
  
             Magnet mount

       Author: Lee J Brumfield

****************************************/



/***************************************
  
          Magnet mount base

       Author: Lee J Brumfield

****************************************/

SD=Screw_diameter/2;
SHD=Screw_head_diameter/2;
SW=Slot_width;
ML=Magnet_length;
MW=Magnet_width;
MH=Magnet_height;
MPT=Mount_plate_thickness-(ML+6)/2;
MPT2=Mount_plate_thickness-(MH+3)/2;
MPT3=Mount_plate_thickness;

print_part();

module print_part() 
{
if (part == "1")
{
Base();
} 
else if (part == "2") 
{
Mount();
} 
else if (part == "3") 
{
Both();
} 
}

module Both() 
{
Base();
Mount();	
}

$fn=200;

module Base()
{
color ("blue")
{
translate([-(ML+MH+SW+8)/2-3,0,ML/2])
difference() 
{
union()
{
minkowski()
{
cube([ML+MH+SW+4,MW+3,ML],center=true);
cylinder(h=6,r=2,center=true);
}
}
minkowski()
{
translate([-(ML+MH+SW+8)/2+3+MH/2,0,-1.25])
cube ([MH,MW,ML],center=true);
cylinder(h=3.51,r=.25,center=true);
}
translate([-(ML+MH+SW+8)/2,0,0])
if (Magnet_position_indicator == "yes")
cube ([.8,.4,ML],center=true);
translate([(ML+MH+SW+8)/2,0,(ML+MH)])
rotate([0,35,0])
cube ([(ML+MH+SW+8)*1.5,(MW+7)*2,(ML+MH)*2],center=true);
if (Screw_hole == "yes")
{
if (Slotted_screw_hole == "yes")
{
hull()
{
translate([MH/1.5,0,0])
cylinder(h=ML+6.1,r=SD,center=true);
translate([MH/1.5+SW,0,0])
cylinder(h=ML+6.1,r=SD,center=true);
}
hull()
{
translate([MH/1.5,0,MPT+ML])
cylinder(h=ML*2,r=SHD,center=true);
translate([MH/1.5+SW,0,MPT+ML])
cylinder(h=ML*2,r=SHD,center=true);
}
}
else
{
translate([SW,0,0])
cylinder(h=ML+6.1,r=SD,center=true);
translate([SW,0,MPT+ML])
cylinder(h=ML*2,r=SHD,center=true);
}
}
}
}
}

module Mount()
{
color ("green")
{
translate([(ML+7)/2+3,0,0])
{
difference() 
{
union()
{
if (Screw_hole == "yes")
minkowski()
{
translate([0,0,-(MH+3)/2+MPT3/2])
cube([ML+3,MW+SHD*4+3,MPT3/2],center=true);
cylinder(h=MPT3/2,r=2,center=true);
}
minkowski()
{
cube([ML+3,MW+3,3],center=true);
cylinder(h=MH,r=2,center=true);
}
}
minkowski()
{
translate([0,0,-(MH+3)/2+MH/2+.25])
cube ([ML,MW,MH],center=true);
cylinder(h=.51,r=.5,center=true);
}
if (Magnet_position_indicator == "yes")
translate([0,0,(MH+3)/2])
cube ([ML,.4,.8],center=true);
if (Screw_hole == "yes")
{
if (Slotted_screw_hole == "yes")
{
translate([(ML+6)/4,0,0])
{
hull()
{
translate([-SW/2,MW/2+SHD+3.5,0])
cylinder(h=ML+6.1,r=SD,center=true);
translate([SW/2,MW/2+SHD+3.5,0])
cylinder(h=ML+6.1,r=SD,center=true);
}
hull()
{
translate([-SW/2,MW/2+SHD+3.5,MPT2+ML])
cylinder(h=ML*2,r=SHD,center=true);
translate([SW/2,MW/2+SHD+3.5,MPT2+ML])
cylinder(h=ML*2,r=SHD,center=true);
}
}
translate([-(ML+6)/4,0,0])
{
hull()
{
translate([-SW/2,-MW/2-SHD-3.5,0])
cylinder(h=ML+6.1,r=SD,center=true);
translate([SW/2,-MW/2-SHD-3.5,0])
cylinder(h=ML+6.1,r=SD,center=true);
}
hull()
{
translate([-SW/2,-MW/2-SHD-3.5,MPT2+ML])
cylinder(h=ML*2,r=SHD,center=true);
translate([SW/2,-MW/2-SHD-3.5,MPT2+ML])
cylinder(h=ML*2,r=SHD,center=true);
}
}
}
else
{
translate([0,MW/2+SHD+3.5,0])
cylinder(h=ML+6.1,r=SD,center=true);
translate([0,MW/2+SHD+3.5,MPT2+ML])
cylinder(h=ML*2,r=SHD,center=true);
}
}
}
}
}
}