//#
//#  thing1379622_roomnumber-keychain-customizable.scad
//#  http://www.thingiverse.com/thing:1379622
//#
//#  2016-02-29  V0.1 prototype
//#  2016-02-29  V0.2 dynamic scale, inner font

//###  parameter  ###

room_text = "Room";
room_number = "101";
keychain_height = 6; // [2:3:18]
keychain_size = 1.0; // [0.5:Small,1.0:Medium,1.5:Large]
font_style = "outer"; // [outer,inner]

//###  parts  ###

scale(keychain_size) print_part();

module print_part() {
  text_scale = 4/len(room_text);
  number_scale = 3/len(room_number);
  if (font_style == "inner") {
      difference() {
          scale([2,1,1]) 
            translate([10/2,10/2,0])
            cylinder(keychain_height,10,10);
          union () {
              color("red") 
                translate([4.0,-0.7,keychain_height/3*2])
                scale([1.1*number_scale,1.0,keychain_height/3*1]) 
                lib_drawtext(room_number);
              color("red") 
                translate([4.0,8,keychain_height/3*2])
                scale([0.7*text_scale,0.5,keychain_height/3*1]) 
                lib_drawtext(room_text);
              color("green") 
                translate([-3/2,5,0])
                cylinder(keychain_height,3,3);
          }
      }
  } else {
      difference() {
          union () {
              scale([2,1,1]) 
                translate([10/2,10/2,0])
                cylinder(keychain_height/3*2,10,10);
              color("red") 
                translate([4.0,-0.7,keychain_height/3*2])
                scale([1.1*number_scale,1.0,keychain_height/3*1]) 
                lib_drawtext(room_number);
              color("red") 
                translate([4.0,8,keychain_height/3*2])
                scale([0.7*text_scale,0.5,keychain_height/3*1]) 
                lib_drawtext(room_text);
          }  
          color("green") 
            translate([-3/2,5,0])
            cylinder(keychain_height/3*2,3,3);
      }
  }
}

//###  libraries  ###

module lib_drawtext(text) {

  // 
  //  OpenSCAD 3D Text Generator
  //  http://www.thingiverse.com/thing:59817
  // 
  //  Copyright (c) by pgreenland, published  Mar 10, 2013
  //  Licensed under the Creative Commons - Attribution - Share Alike license. 
  // 

  //Characters
  chars = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}";

  //Chracter table defining 5x7 characters
  //Adapted from: http://www.geocities.com/dinceraydin/djlcdsim/chartable.js
  char_table = [ [ 0, 0, 0, 0, 0, 0, 0],
                 [ 4, 0, 4, 4, 4, 4, 4],
                 [ 0, 0, 0, 0,10,10,10],
                 [10,10,31,10,31,10,10],
                 [ 4,30, 5,14,20,15, 4],
                 [ 3,19, 8, 4, 2,25,24],
                 [13,18,21, 8,20,18,12],
                 [ 0, 0, 0, 0, 8, 4,12],
                 [ 2, 4, 8, 8, 8, 4, 2],
                 [ 8, 4, 2, 2, 2, 4, 8],
                 [ 0, 4,21,14,21, 4, 0],
                 [ 0, 4, 4,31, 4, 4, 0],
                 [ 8, 4,12, 0, 0, 0, 0],
                 [ 0, 0, 0,31, 0, 0, 0],
                 [12,12, 0, 0, 0, 0, 0],
                 [ 0,16, 8, 4, 2, 1, 0],
                 [14,17,25,21,19,17,14],
                 [14, 4, 4, 4, 4,12, 4],
                 [31, 8, 4, 2, 1,17,14],
                 [14,17, 1, 2, 4, 2,31],
                 [ 2, 2,31,18,10, 6, 2],
                 [14,17, 1, 1,30,16,31],
                 [14,17,17,30,16, 8, 6],
                 [ 8, 8, 8, 4, 2, 1,31],
                 [14,17,17,14,17,17,14],
                 [12, 2, 1,15,17,17,14],
                 [ 0,12,12, 0,12,12, 0],
                 [ 8, 4,12, 0,12,12, 0],
                 [ 2, 4, 8,16, 8, 4, 2],
                 [ 0, 0,31, 0,31, 0, 0],
                 [16, 8, 4, 2, 4, 8,16],
                 [ 4, 0, 4, 2, 1,17,14],
                 [14,21,21,13, 1,17,14],
                 [17,17,31,17,17,17,14],
                 [30,17,17,30,17,17,30],
                 [14,17,16,16,16,17,14],
                 [30,17,17,17,17,17,30],
                 [31,16,16,30,16,16,31],
                 [16,16,16,30,16,16,31],
                 [15,17,17,23,16,17,14],
                 [17,17,17,31,17,17,17],
                 [14, 4, 4, 4, 4, 4,14],
                 [12,18, 2, 2, 2, 2, 7],
                 [17,18,20,24,20,18,17],
                 [31,16,16,16,16,16,16],
                 [17,17,17,21,21,27,17],
                 [17,17,19,21,25,17,17],
                 [14,17,17,17,17,17,14],
                 [16,16,16,30,17,17,30],
                 [13,18,21,17,17,17,14],
                 [17,18,20,30,17,17,30],
                 [30, 1, 1,14,16,16,15],
                 [ 4, 4, 4, 4, 4, 4,31],
                 [14,17,17,17,17,17,17],
                 [ 4,10,17,17,17,17,17],
                 [10,21,21,21,17,17,17],
                 [17,17,10, 4,10,17,17],
                 [ 4, 4, 4,10,17,17,17],
                 [31,16, 8, 4, 2, 1,31],
                 [14, 8, 8, 8, 8, 8,14],
                 [ 0, 1, 2, 4, 8,16, 0],
                 [14, 2, 2, 2, 2, 2,14],
                 [ 0, 0, 0, 0,17,10, 4],
                 [31, 0, 0, 0, 0, 0, 0],
                 [ 0, 0, 0, 0, 2, 4, 8],
                 [15,17,15, 1,14, 0, 0],
                 [30,17,17,25,22,16,16],
                 [14,17,16,16,14, 0, 0],
                 [15,17,17,19,13, 1, 1],
                 [14,16,31,17,14, 0, 0],
                 [ 8, 8, 8,28, 8, 9, 6],
                 [14, 1,15,17,15, 0, 0],
                 [17,17,17,25,22,16,16],
                 [14, 4, 4, 4,12, 0, 4],
                 [12,18, 2, 2, 2, 6, 2],
                 [18,20,24,20,18,16,16],
                 [14, 4, 4, 4, 4, 4,12],
                 [17,17,21,21,26, 0, 0],
                 [17,17,17,25,22, 0, 0],
                 [14,17,17,17,14, 0, 0],
                 [16,16,30,17,30, 0, 0],
                 [ 1, 1,15,19,13, 0, 0],
                 [16,16,16,25,22, 0, 0],
                 [30, 1,14,16,15, 0, 0],
                 [ 6, 9, 8, 8,28, 8, 8],
                 [13,19,17,17,17, 0, 0],
                 [ 4,10,17,17,17, 0, 0],
                 [10,21,21,17,17, 0, 0],
                 [17,10, 4,10,17, 0, 0],
                 [14, 1,15,17,17, 0, 0],
                 [31, 8, 4, 2,31, 0, 0],
                 [ 2, 4, 4, 8, 4, 4, 2],
                 [ 4, 4, 4, 4, 4, 4, 4],
                 [ 8, 4, 4, 2, 4, 4, 8] ];

  //Binary decode table
  dec_table = [ "00000", "00001", "00010", "00011", "00100", "00101",
                "00110", "00111", "01000", "01001", "01010", "01011",
                "01100", "01101", "01110", "01111", "10000", "10001",
                "10010", "10011", "10100", "10101", "10110", "10111",
                "11000", "11001", "11010", "11011", "11100", "11101",
                "11110", "11111" ];

  //Process string one character at a time
  for(itext = [0:len(text)-1]) {
    //Convert character to index
    ichar = search(text[itext],chars,1)[0];

    //Decode character - rows
    for(irow = [0:6]) {
      //Select value to draw from table
      val = dec_table[char_table[ichar][irow]];

      //Decode character - cols
      for(icol = [0:4]) {
        // Retrieve bit to draw
        bit = search(val[icol],"01",1)[0];

        if(bit) {
            //Output cube
            translate([icol + (6*itext), irow, 0])
                cube([1.0001,1.0001,1]);
        }
      }
    }
  }
}