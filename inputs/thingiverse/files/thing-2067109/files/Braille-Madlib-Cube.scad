//Word Cube Generator
//Inspired by Word Cubes by MrKindergarten
//http://www.thingiverse.com/thing:1554507


/*[Sentance Pattern]*/
//f = doesn't spin, l = spins, must start and end with f
pattern = ["ff","l","f","ll","f"];
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
      translate([0,size/2,size/2])
        sphere(3);
    makeCubes();
  }
}
module makeCubes(step = 0)
{
  if(step < len(pattern)-1){
    for(i=[0:len(pattern[step])-1]){
      translate([size*2/3,0,0]*i)
        makeCube(hollow=len(search("l",pattern[step])));
    }
    translate([size*2/3*len(pattern[step])+gap,0,0])
      makeCubes(step = step +1);
  }
  else
    makeCube(flag = false);
}

module makeCube(hollow = false, flag = true)
{
  union(){
    difference(){
      cube([size*2/3,size,size]);
      if(hollow)
        translate([0,size/2,size/2])
          rotate([0,90,0])
            cylinder(r = size/4+2, h = size+gap*2);
    }
    if(flag)
      translate([0,size/2,size/2])
        rotate([0,90,0])
          cylinder(r = size/4, h = size*2/3+gap*2);
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
