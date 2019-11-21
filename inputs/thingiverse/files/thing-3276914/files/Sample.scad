$fn=36;

use<PCB.scad>;
use<Resistor.scad>;
use<IC_TO220.scad>;
use<INA_3221_I2C.scad>;
use<Arduino nano.scad>;
use<LCD_1602_Serial.scad>;
use<Pin header.scad>;

difference()
  {
  union()
    {
//PCB(PCB_size_X,PCB_size_Y,PCB_size_Z,PCB_pitch,PCB_style);
    translate([0,0,0])
      PCB(2.54*35,2.54*27,1,2.54,2);

//Arduino_nano(Connection_pins_enabled,Connection_pins_up,6_pins_enabled,6_pins_up);
    translate([2.54*9,-2.54*8,0])
      rotate([0,0,90])
        Arduino_nano(1,0,0,0);

//Resistor(Text,Color1,Color2,Color3,Color4,Orientation,Type,Solder);
    translate([2.54*13,-2.54*3,0])
      rotate([0,0,90])
        Resistor("","Brown","Black","Orange","Gold",1,0,1);

    translate([2.54*12,-2.54*3,0])
      rotate([0,0,90])
        Resistor("","Brown","Black","Orange","Gold",1,0,1);

    translate([2.54*11,-2.54*3,0])
      rotate([0,0,90])
        Resistor("","Brown","Black","Orange","Gold",1,0,1);

    translate([2.54*10,-2.54*3,0])
      rotate([0,0,90])
        Resistor("","Brown","Black","Orange","Gold",1,0,1);

    translate([2.54*7,-2.54*3,0])
      rotate([0,0,90])
        Resistor("","Brown","Black","Orange","Gold",1,0,1);

    translate([2.54*11,-2.54*13,0])
      rotate([0,0,-90])
        Resistor("","Brown","Black","Orange","Gold",1,0,1);

    translate([2.54*12,-2.54*13,0])
      rotate([0,0,-90])
        Resistor("","Brown","Black","Orange","Gold",1,0,1);

    translate([2.54*13,-2.54*13,0])
      rotate([0,0,-90])
        Resistor("","Brown","Black","Orange","Gold",1,0,1);

    translate([2.54*14,-2.54*13,0])
      rotate([0,0,-90])
        Resistor("","Brown","Black","Orange","Gold",1,0,1);

    translate([2.54*15,-2.54*13,0])
      rotate([0,0,-90])
        Resistor("","Brown","Black","Orange","Gold",1,0,1);

    translate([2.54*16,-2.54*13,0])
      rotate([0,0,-90])
        Resistor("","Brown","Black","Orange","Gold",1,0,1);

//INA_3221(Data_pins_enabled,Data_pins_up,Power_pins_enabled,Power_pins_up,Load_pins_enabled,Load_pins_up);
    translate([2.54*11,2.54*6,0])
      rotate([0,0,180])
        INA_3221(1,0,1,0,1,0);
    
    translate([2.54*4,-2.54*1,0])
      rotate([0,0,180])
        TO220("IRF","520",1,1);
    translate([2.54*4,2.54*3,0])
      rotate([0,0,180])
        TO220("IRF","520",1,1);
    translate([2.54*4,2.54*7,0])
      rotate([0,0,180])
        TO220("IRF","520",1,1);
    translate([2.54*4,2.54*11,0])
      rotate([0,0,180])
        TO220("IRF","520",1,1);

//LCD_1602_Serial(Pins_enabled,Pins_up,Version,Text1,Text2);
  translate([-2.54*11,-2.54,0])
      rotate([0,0,90])
        LCD_1602_Serial(1,0,0,"1234567890123456","1234567890123456");

//Pin_header(Pins_number,Pins_up,Type);
  translate([-2.54,-2.54*8,0])
      rotate([0,0,90])
        Pin_header(10,1,1);

      }


translate([0,0,-51])
cube([200,200,100],center=true);
    }
