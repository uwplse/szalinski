$fn=36;

use<PCB.scad>;
use<Resistor.scad>;
use<IC_TO220.scad>;
use<INA_3221_I2C.scad>;
use<Arduino nano.scad>;
use<LCD_1602_I2C.scad>;
use<Pin_header.scad>;
use<Solder.scad>;

difference()
  {
  union()
    {
//PCB(PCB_size_X,PCB_size_Y,PCB_size_Z,PCB_pitch,PCB_style);

    translate([0,0,0])
      PCB(2.54*35,2.54*27,1,2.54,2);

//----------------------------------------------------------------------------------------------------------

//Arduino_nano(Connection_pins_enabled,Connection_pins_up,6_pins_enabled,6_pins_up);

    translate([2.54*9,-2.54*8,0])
      rotate([0,0,90])
        Arduino_nano(1,0,0,0);


//----------------------------------------------------------------------------------------------------------

//LCD_1602_Serial(Pins_enabled,Pins_up,Version,Text1,Text2);
  translate([-2.54*11,-2.54,10])
      rotate([0,0,90])
        LCD_1602_I2C(1);


//Top Side solder track

//5V track
    translate([2.54*5,-2.54*6,0])
      rotate([0,0,90])
        Solder(2,0);
translate([-2.54*14,-2.54*13,0])
      rotate([0,0,90])
        Solder(8,0);
translate([-2.54*15,-2.54*4,0])
      rotate([0,0,0])
        Solder(19,0);

//GND track
    translate([2.54*3,-2.54*5,0])
      rotate([0,0,90])
        Solder(2,0,0);
translate([-2.54*15,-2.54*13,0])
      rotate([0,0,90])
        Solder(10,0);
translate([-2.54*14,-2.54*6,0])
      rotate([0,0,0])
        Solder(20,0);

      }

//Chopping off lower part of legs
translate([0,0,-51.5])
cube([200,200,100],center=true);
    }

//Lower side components
//Needs to be a different thread to cut the legs of the components
difference()
  {
  union()
    {

//Bottom side solder tracks
    translate([-2.54*13,-2.54*4,0])
      rotate([0,180,90])
        Solder(10,0);
translate([2.54*9,-2.54*4,0])
      rotate([0,180,90])
        Solder(2,0);
translate([2.54*9,-2.54*4,0])
      rotate([0,180,0])
        Solder(23,0);

    translate([-2.54*12,-2.54*6,0])
      rotate([0,180,90])
        Solder(8,2);
translate([2.54*8,-2.54*5,0])
      rotate([0,180,90])
        Solder(2,2);
translate([2.54*8,-2.54*6,0])
      rotate([0,180,0])
        Solder(21,2);
    }

//Chopping off lower part of legs
translate([0,0,51.5])
cube([200,200,100],center=true);
  }