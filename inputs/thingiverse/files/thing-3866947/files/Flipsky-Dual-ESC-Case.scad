// Written by Eitan Tsur (eitan.tsur@gmail.com)

/* [Optional Features] */
// Which model to generate: Lid or Base
Model = "Lid"; //[Lid, Base]
// Add receiver cutout?
ReceiverCutout = true;
// Add hall connector cutouts?
HallCutout = true;

/* [VESC Dimensions] */
// VESC Width
VescX = 78;
// VESC Length
VescY = 79;
// VESC cable slot depth
VescCableZ = 9;
// VESC cable diameter
VescCableD = 7;
// Add this to "bottom" thickness to get supports holding VESC heatsink in place
VescZOffset = 5;
// VESC phase leads slot width
VescPhaseWidth = 60;
// VESC power leads slot width
VescPowerWidth = 26;
// Power switch diameter
SwitchD = 16;

/* [General Enclosure Parameters] */
// Wall thickness (best if divisible by printing nozzle diameter)
WT = 4.8;
// Z top and bottom layer thickness
ZT = 2;
// Height of bottom half of case
BaseZ = 23;
// Height of top half of case - (This is for clearance due to the filter caps I added to the receiver and the caps on the VESC)
LidZ = 22;
// Side compartment(s) width
SideX = 20;
// Side compartment(s) length
SideY = 40;
// Bottom compartment depth (keep in mind wall thickness; this is just for cabling to reduce the chance of noise)
BottomY = 6.8;
BottomX = VescX+(SideX*2)+(WT*2);
// Depth the alignment "teeth" should descend into the base without interfering with the VESC mounting studs
LidToothDepth = 2.5;

/* [Mounting hole spacing parameters] */
// Skateboard truck bolt spacing width
TruckWidth = 41.275;
// Skateboard truck bolt spacing length (old school)
TruckLength1 = 53.975;
// Skateboard truck bolt spacing length (new school)
TruckLength2 = 63.5;
// Skateboard truck bolt diameter
TruckBoltD = 5;

VentSpacing = TruckWidth-TruckBoltD-WT*2;

/* [Receiver cutout] */
// Receiver cutout width for lid
ReceiverX = 60;
// Receiver cutout length for lid
ReceiverY = 30;

/* [Hall connector cutout] */
// Hall sensor connector length
HallX = 4.75;
// Hall sensor connector width
HallY = 10.7;
// Hall sensor connector depth
HallZ = 3.7;

/* [Quality settings] */
// Minimum segment size (smaller is better but more time-consuming to render)
$fs=0.1; // [0.01:0.01:10]
// Minimum angle size (smaller is better but more time-consuming to render)
$fa=5.0; // [0.1:0.1:365]


/* TODO:
   - Try snap-closed clasp
   - Sealing gasket?
   - Antenna holes for lid?
*/
/* -------------------------------------------------------------------------- */

module screwhole(diameter=2, height=2, zoffset=0) {
  translate( [0,0,zoffset+height/2] ) cylinder(d=diameter, h=height, center=true);
}

if ( Model == "Lid" )
{
  // Let's start building the lid, shall we?
  difference()
  {
    union()
    {
      // Base:
      linear_extrude(height = ZT)
        offset(2) offset(-2)
        difference()
        {
          union()
          {
            translate([0, 0, 0]) square([VescX+WT*2, VescY+WT*2]);
            translate([-SideX-WT, -BottomY, 0]) square([SideX+WT*2, SideY+WT*2]);
            translate([VescX+WT, -BottomY, 0]) square([SideX+WT*2, SideY+WT*2]);
            translate([-SideX-WT, -BottomY-WT, 0]) square([BottomX+WT*2, BottomY+WT*2]);
          }
          // Receiver cutout:
          if ( ReceiverCutout ) translate( [VescX/2+WT-ReceiverX/2, WT, 0] ) square([ReceiverX, ReceiverY]);
        }

      // Walls:
      translate([0, 0, ZT])
        linear_extrude(height = LidZ-ZT)
        offset(2) offset(-2)
        union()
        {
          difference()
          {
            union()
            {
              translate([0, 0, 0]) square([VescX+WT*2, VescY+WT*2]);
              translate([-SideX-WT, -BottomY, 0]) square([SideX+WT*2, SideY+WT*2]);
              translate([VescX+WT, -BottomY, 0]) square([SideX+WT*2, SideY+WT*2]);
              translate([-SideX-WT, -BottomY-WT, 0]) square([BottomX+WT*2, BottomY+WT*2]);
            }
            union()
            {
              translate([WT, WT, 0]) square([VescX, VescY]);
              translate([-SideX, -BottomY, 0]) square([SideX, SideY+WT]);
              translate([VescX+WT*2, -BottomY, 0]) square([SideX, SideY+WT]);
              translate([-SideX, -BottomY, 0]) square([BottomX, BottomY]);
              translate([0,-BottomY+WT*1.5,0]) square([VescX+WT*2, SideY-WT/2]);
            }
          }
        }
      // Alignment tabs:
      linear_extrude(height = LidZ+LidToothDepth)
      union()
      {
        translate([WT, WT, 0]) square([WT, WT]);
        translate([VescX, WT, 0]) square([WT, WT]);
        translate([VescX, VescY, 0]) square([WT, WT]);
        translate([WT, VescY, 0]) square([WT, WT]);
        translate([WT+VescX+SideX, SideY-BottomY, 0]) square([WT, WT]);
        translate([-SideX, SideY-BottomY, 0]) square([WT, WT]);
      }
      linear_extrude(height = LidZ)
      union()
      {
        translate([WT, -BottomY, 0]) square([WT, BottomY+WT]);
        translate([VescX, -BottomY, 0]) square([WT, BottomY+WT]);
      }
      // Locking "buttons"
      translate( [WT*1.5, WT+LidToothDepth/4, LidZ+LidToothDepth/2] ) sphere(d=LidToothDepth);
      translate( [VescX+WT/2, WT+LidToothDepth/4, LidZ+LidToothDepth/2] ) sphere(d=LidToothDepth);
      translate( [WT+VescX-LidToothDepth/4, VescY+WT/2, LidZ+LidToothDepth/2] ) sphere(d=LidToothDepth);
      translate( [WT+LidToothDepth/4, VescY+WT/2, LidZ+LidToothDepth/2] ) sphere(d=LidToothDepth);
      translate( [WT*2+VescX+SideX-LidToothDepth/4, SideY-BottomY+WT/2, LidZ+LidToothDepth/2] ) sphere(d=LidToothDepth);
      translate( [-SideX+LidToothDepth/4, SideY-BottomY+WT/2, LidZ+LidToothDepth/2] ) sphere(d=LidToothDepth);
      
    }
    // TODO: Add closure feature(s) here.
  }
}

if ( Model == "Base" )
{
  // Let's start building the base, shall we?
  difference()
  {
    union()
    {
      // Base:
      linear_extrude(height = ZT)
        offset(2) offset(-2)
        union()
        {
          translate([0, 0, 0]) square([VescX+WT*2, VescY+WT*2]);
          translate([-SideX-WT, -BottomY, 0]) square([SideX+WT*2, SideY+WT*2]);
          translate([VescX+WT, -BottomY, 0]) square([SideX+WT*2, SideY+WT*2]);
          translate([-SideX-WT, -BottomY-WT, 0]) square([BottomX+WT*2, BottomY+WT*2]);
        }

      // Mount Reinforcement:
      translate([WT, WT, ZT]) linear_extrude(height = 2) square([VescX, VescY]);

      // Walls:
      translate([0, 0, ZT])
        linear_extrude(height = VescZOffset)
        offset(2) offset(-2)
        union()
        {
          // VESC Heatsink Support:
          translate([WT,WT,0])
          {
            translate([0, 0, 0]) square([VescX/2, VescY/2]);
            translate([0, 0, 0]) square([VescX, 5]);
            translate([VescX-5, 0, 0]) square([5,VescY]);
            translate([0, VescY-5, 0]) square([VescX, 5]);
          }
          difference()
          {
            union()
            {
              translate([0, 0, 0]) square([VescX+WT*2, VescY+WT*2]);
              translate([-SideX-WT, -BottomY, 0]) square([SideX+WT*2, SideY+WT*2]);
              translate([VescX+WT, -BottomY, 0]) square([SideX+WT*2, SideY+WT*2]);
              translate([-SideX-WT, -BottomY-WT, 0]) square([BottomX+WT*2, BottomY+WT*2]);
            }
            union()
            {
              translate([WT, WT, 0]) square([VescX, VescY]);
              translate([-SideX, -BottomY, 0]) square([SideX, SideY+WT]);
              translate([VescX+WT*2, -BottomY, 0]) square([SideX, SideY+WT]);
              translate([-SideX, -BottomY, 0]) square([BottomX, BottomY]);
            }
          }
        }
      // Upper Walls:
      translate([0, 0, ZT+VescZOffset])
        linear_extrude(height = BaseZ-VescZOffset-ZT)
        offset(2) offset(-2)
        difference()
        {
          union()
          {
            translate([0, 0, 0]) square([VescX+WT*2, VescY+WT*2]);
            translate([-SideX-WT, -BottomY, 0]) square([SideX+WT*2, SideY+WT*2]);
            translate([VescX+WT, -BottomY, 0]) square([SideX+WT*2, SideY+WT*2]);
            translate([-SideX-WT, -BottomY-WT, 0]) square([BottomX+WT*2, BottomY+WT*2]);
          }
          union()
          {
            translate([WT, WT, 0]) square([VescX, VescY]);
            translate([-SideX, -BottomY, 0]) square([SideX, SideY+WT]);
            translate([VescX+WT*2, -BottomY, 0]) square([SideX, SideY+WT]);
            translate([-SideX, -BottomY, 0]) square([BottomX, BottomY]);
          }
        }
      // Let's seal in the wire channel with a basic shape:
      //    translate([0, -BottomY/2-WT, ZT]) cube([VescX+WT*2, BottomY, VescZOffset+2]);
      translate([0, -BottomY, ZT]) cube([VescX+WT*2, BottomY+WT, VescZOffset+2]);
    }
    // Let's start adding features to the enclosure:

    // Switch Hole:
    translate([-SideX/2, SideY, BaseZ/2+1]) rotate([90,0,0]) cylinder(d=SwitchD, h=WT*2, center=true);

    // Phase Leads:
    translate([7+WT, VescY+WT*1.5, ZT+VescZOffset+VescCableZ+VescCableD/2])
      hull()
      {
        translate([VescCableD/2, 0, 0]) rotate([90, 0, 0]) cylinder(d=VescCableD+2, h=WT*2, center=true);
        translate([VescPhaseWidth-VescCableD/2, 0, 0]) rotate([90, 0, 0]) cylinder(d=VescCableD+2, h=WT*2, center=true);
      }

    // Power Leads:
    translate([VescX+WT*1.5, VescY+WT-7-VescPowerWidth, ZT+VescZOffset+VescCableZ+VescCableD/2])
      hull()
      {
        translate([0, VescCableD/2, 0]) rotate([0, 90, 0]) cylinder(d=VescCableD+4, h=WT*2, center=true);
        translate([0, VescPowerWidth-VescCableD/2, 0]) rotate([0, 90, 0]) cylinder(d=VescCableD+4, h=WT*2, center=true);
      }

    // Heatsink Vent:
    translate([VescX/2-VentSpacing/2+WT, (VescY/2)+(WT*1.5), 0.1])
      hull()
      {
        translate([VescZOffset+ZT, 0, 0]) rotate([90, 0, 0]) cylinder(d=(VescZOffset+ZT)*2, h=VescY*2, center=true);
        translate([VentSpacing-VescZOffset-ZT, 0, 0]) rotate([90, 0, 0]) cylinder(d=(VescZOffset+ZT)*2, h=VescY*2, center=true);
      }

    // Hall Connector Cutouts:
    if ( HallCutout )
    {
      // -Left:
      translate([-SideX-WT+(WT-HallX)/2, -BottomY, BaseZ-HallZ]) cube([HallX, HallY, HallZ]);
      translate([-SideX-WT-0.4, -BottomY+0.4, BaseZ-HallZ+0.4]) cube([HallX+0.8, HallY-0.8, HallZ-0.4]);
      // -Right:
      translate([VescX+SideX+WT*2+(WT-HallX)/2, -BottomY, BaseZ-HallZ]) cube([HallX, HallY, HallZ]);
      translate([VescX+SideX+WT*2-0.4, -BottomY+0.4, BaseZ-HallZ+0.4]) cube([HallX+0.8, HallY-0.8, HallZ-0.4]);
    }

    // Mounting Holes:
    translate([WT+VescX/2, WT+VescY/2, 0])
      union()
      {
        // -Left
        translate([-TruckWidth/2, 0, BaseZ/2-0.1]) cylinder(d=TruckBoltD, h=BaseZ, center=true);
        translate([-TruckWidth/2, 0, BaseZ/2+ZT]) cylinder(d=TruckBoltD+5, h=BaseZ, center=true);
        // -Right
        translate([TruckWidth/2, 0, BaseZ/2-0.1]) cylinder(d=TruckBoltD, h=BaseZ, center=true);
        translate([TruckWidth/2, 0, BaseZ/2+ZT]) cylinder(d=TruckBoltD+5, h=BaseZ, center=true);
        // Old School hole spacing:
        /*      translate([-TruckWidth/2, -TruckLength1, BaseZ/2-0.1]) cylinder(d=TruckBoltD, h=BaseZ, center=true);
                translate([-TruckWidth/2, -TruckLength1, BaseZ/2+ZT]) cylinder(d=TruckBoltD+5, h=BaseZ, center=true);
                translate([TruckWidth/2, -TruckLength1, BaseZ/2-0.1]) cylinder(d=TruckBoltD, h=BaseZ, center=true);
                translate([TruckWidth/2, -TruckLength1, BaseZ/2+ZT]) cylinder(d=TruckBoltD+5, h=BaseZ, center=true);
        // New School hole spacing:
        translate([-TruckWidth/2, -TruckLength2, BaseZ/2-0.1]) cylinder(d=TruckBoltD, h=BaseZ, center=true);
        translate([-TruckWidth/2, -TruckLength2, BaseZ/2+ZT]) cylinder(d=TruckBoltD+5, h=BaseZ, center=true);
        translate([TruckWidth/2, -TruckLength2, BaseZ/2-0.1]) cylinder(d=TruckBoltD, h=BaseZ, center=true);
        translate([TruckWidth/2, -TruckLength2, BaseZ/2+ZT]) cylinder(d=TruckBoltD+5, h=BaseZ, center=true);
        */
      }

    // Let's open up the vent under the heatsink a bit more:
    translate([WT+VescX/2, WT+VescY/2, 0])
      hull()
      {
        translate([0, 0, VescZOffset+ZT]) cube([VescZOffset+WT+(VescZOffset+ZT)*4, VescY, 0.1], center=true);
        translate([0, 0, 0]) cube([VescZOffset+WT+(VescZOffset+ZT)*2, VescY, 0.1], center=true);
      }
    // TODO: Add closure feature(s) here.
    translate( [WT*1.5, WT+LidToothDepth/4, BaseZ-LidToothDepth/2] ) sphere(d=LidToothDepth);
    translate( [VescX+WT/2, WT+LidToothDepth/4, BaseZ-LidToothDepth/2] ) sphere(d=LidToothDepth);
    translate( [WT+VescX-LidToothDepth/4, VescY+WT/2, BaseZ-LidToothDepth/2] ) sphere(d=LidToothDepth);
    translate( [WT+LidToothDepth/4, VescY+WT/2, BaseZ-LidToothDepth/2] ) sphere(d=LidToothDepth);
    translate( [WT*2+VescX+SideX-LidToothDepth/4, SideY-BottomY+WT/2, BaseZ-LidToothDepth/2] ) sphere(d=LidToothDepth);
    translate( [-SideX+LidToothDepth/4, SideY-BottomY+WT/2, BaseZ-LidToothDepth/2] ) sphere(d=LidToothDepth);
  }
}
