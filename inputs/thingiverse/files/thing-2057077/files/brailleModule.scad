/*[Begin Variables]*/
word = "Example";
$fn = 6;

/*[hidden*/
braille_conversion_db =[
["CAPS",  [6]          ],
//Capital Letters
//todo still, make them put the cap before hand
["A",   [1]            ],
["B",   [1, 2]         ],
["C",   [1, 4]         ],
["D",   [1, 4, 5]      ],
["E",   [1, 5]         ],
["F",   [1, 2, 4]      ],
["G",   [1, 2, 4, 5]   ],
["H",   [1, 2, 5]      ],
["I",   [2, 4]         ],
["J",   [2, 4, 5]      ],
["K",   [1, 3]         ],
["L",   [1, 2, 3]      ],
["M",   [1, 3, 4]      ],
["N",   [1, 3, 4, 5]   ],
["O",   [1, 3, 5,]     ],
["P",   [1, 2, 3, 4]   ],
["Q",   [1, 2, 3, 4, 5]],
["R",   [1, 2, 3, 5]   ],
["S",   [2, 3, 4,]     ],
["T",   [2, 3, 4, 5]   ],
["U",   [1, 3, 6,]     ],
["V",   [1, 2, 3, 6]   ],
["W",   [2, 4, 5, 6]   ],
["X",   [1, 3, 4, 6]   ],
["Y",   [1, 3, 4, 5, 6]],
["Z",   [1, 3, 5, 6]   ],
//lowercase letters
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
//Numbers
["0",   [2, 4, 5]      ],
["1",   [1]            ],
["2",   [1, 2]         ],
["3",   [1, 4]         ],
["4",   [1, 4, 5]      ],
["5",   [1, 5]         ],
["6",   [1, 2, 4]      ],
["7",   [1, 2, 4, 5]   ],
["8",   [1, 2, 5]      ],
["9",   [2, 4]         ],
//other symbols
["!",   [2, 3, 5,]     ],
[",",   [2]            ],
["-",   [3, 6]         ],
[".",   [2, 5, 6]      ],
["?",   [2, 3, 6]      ],
["#",   [3, 4, 5, 6]   ],
[" ",   []             ]
];

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
module brailConversion(word = " "){
  temp = search(str(word), braille_conversion_db);
  echo(temp);
  for(num = [0:len(temp)]){
    translate([6*num,0,0])
    {
      for(dot = braille_conversion_db[temp[num]][1]){
        drawDot(dot);
      }
    }
  }
}

brailConversion(word);