//Word Cube Generator
//Inspired by Word Cubes by MrKindergarten
//http://www.thingiverse.com/thing:1554507


/*[Word 1]*/
W1_L1 = "b";
W1_L2 = "o";
W1_L3 = "x";
/*[Word 2]*/
W2_L1 = "z";
W2_L2 = "i";
W2_L3 = "p";
/*[Word 3]*/
W3_L1 = "t";
W3_L2 = "e";
W3_L3 = "n";
/*[Word 4]*/
W4_L1 = "h";
W4_L2 = "u";
W4_L3 = "t";
/*[Cube Features]*/
size = 25.4;
gap = 2;
topBump = true;//[true,false]
/*[Braille Text Size]*/
//percentage of cube
fontSize = .75;//[.05:.05:1]

rotate([0,90,0]){
  union(){
    if(topBump)
      translate([-size-gap,0,0])
        sphere(3);
    difference(){
      cube([size*2+gap*2,size,size], center = true);
      translate([-size/3-gap/2,0,0])
        cube([gap,size+1,size+1], center = true);
      translate([size/3+gap/2,0,0])
        cube([gap,size+1,size+1], center = true);
      rotate([0,90,0])
          cylinder(r = size/4+1, h = size+gap*2, center = true);
    }
    rotate([0,90,0])
      translate([0,0,-size/2-gap])
        cylinder(r = size/4, h = size+gap*2);
    //Word 1
    rotate([0,0,0])
    {
      translate([-size*2/3-gap,0,size/2])
        scale(size*fontSize/8)
          brailConversion(W1_L1);
      translate([0,0,size/2])
        scale(size*fontSize/8)
          brailConversion(W1_L2);
      translate([size*2/3+gap,0,size/2])
        scale(size*fontSize/8)
          brailConversion(W1_L3);
    }
    //Word 2
    rotate([90,0,0])
    {
      translate([-size*2/3-gap,0,size/2])
        scale(size*fontSize/8)
          brailConversion(W2_L1);
      translate([0,0,size/2])
        scale(size*fontSize/8)
          brailConversion(W2_L2);
      translate([size*2/3+gap,0,size/2])
        scale(size*fontSize/8)
          brailConversion(W2_L3);
    }
    //Word 3
    rotate([180,0,0])
    {
      translate([-size*2/3-gap,0,size/2])
        scale(size*fontSize/8)
          brailConversion(W3_L1);
      translate([0,0,size/2])
        scale(size*fontSize/8)
          brailConversion(W3_L2);
      translate([size*2/3+gap,0,size/2])
        scale(size*fontSize/8)
          brailConversion(W3_L3);
    }
    //Word 4
    rotate([270,0,0])
    {
      translate([-size*2/3-gap,0,size/2])
        scale(size*fontSize/8)
          brailConversion(W4_L1);
      translate([0,0,size/2])
        scale(size*fontSize/8)
          brailConversion(W4_L2);
      translate([size*2/3+gap,0,size/2])
        scale(size*fontSize/8)
          brailConversion(W4_L3);
    }
  }



}
//All the braille text logic below...


braille_conversion_db =[
["CAPS",  [6]          ],
["a",   [1]            ],
["b",   [1, 2]         ],
["c",   [1, 4]         ],
["d",   [1, 4, 5]      ],
["e",   [1, 5]         ],
["f",   [1, 2, 4]      ],
["g",   [1, 2, 4, 5]   ],
["h",   [1, 2, 5]      ],
["i",   [2, 4]         ],
["j",   [2, 4, 5]      ],
["k",   [1, 3]         ],
["l",   [1, 2, 3]      ],
["m",   [1, 3, 4]      ],
["n",   [1, 3, 4, 5]   ],
["o",   [1, 3, 5,]     ],
["p",   [1, 2, 3, 4]   ],
["q",   [1, 2, 3, 4, 5]],
["r",   [1, 2, 3, 5]   ],
["s",   [2, 3, 4,]     ],
["t",   [2, 3, 4, 5]   ],
["u",   [1, 3, 6,]     ],
["v",   [1, 2, 3, 6]   ],
["w",   [2, 4, 5, 6]   ],
["x",   [1, 3, 4, 6]   ],
["y",   [1, 3, 4, 5, 6]],
["z",   [1, 3, 5, 6]   ],
["!",   [2, 3, 5,]     ],
[",",   [2]            ],
["-",   [3, 6]         ],
[".",   [2, 5, 6]      ],
["?",   [2, 3, 6]      ],
["#",   [3, 4, 5, 6]   ],
["0",   [2, 4, 5]      ],
["1",   [1]            ],
["2",   [1, 2]         ],
["3",   [1, 4]         ],
["4",   [1, 4, 5]      ],
["5",   [1, 5]         ],
["6",   [1, 2, 4]      ],
["7",   [1, 2, 4, 5]   ],
["8",   [1, 2, 5]      ],
["9",   [2, 4]         ]
]; 
$fn = 10;
module drawDot(pos = 0)
{
  if(pos == 1)
    translate([-1.5,3,0])
      sphere(center = true);
  else if(pos == 2)
    translate([-1.5,0,0])
      sphere(center = true);
  else if(pos == 3)
    translate([-1.5,-3,0])
      sphere(center = true);
  else if(pos == 4)
    translate([1.5,3,0])
      sphere(center = true);
  else if(pos == 5)
    translate([1.5,0,0])
      sphere(center = true);
  else if(pos == 6)
    translate([1.5,-3,0])
      sphere(center = true);
}
module brailConversion(char = " "){
  temp = search(char, braille_conversion_db)[0];
  for(dot = braille_conversion_db[temp][1]){
    drawDot(dot);
  }
}