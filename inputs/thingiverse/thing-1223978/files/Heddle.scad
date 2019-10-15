//How many warp threads
warp_count = 20;

//How wide is each thread
warp_diameter = .5;

//How high is the Heddle
heddle_height = 10; 

//2D to make DXF files, 3D for STL
2Dv3D = "3D"; // [2D, 3D]


/* [Hidden] */
warp_dia = warp_diameter; 
weft_dia = warp_dia; 
shaft_width = warp_dia + weft_dia ;
heddle_frame_width = 5*warp_dia;
heddle_frame = heddle_frame_width * 2;
heddle_width = shaft_width  * warp_count;
tt = 0.1;

if (2Dv3D=="2D") {
    projection() heddle();
    }
  else {
    heddle();
    }


module heddle() {
    difference () {  
        cube([heddle_height + heddle_frame, heddle_width + heddle_frame, shaft_width]);
        translate ([heddle_frame_width , heddle_frame_width, -tt/2 ]) 
            cube([heddle_height, heddle_width, shaft_width+tt ]);
        }
    for (I = [ heddle_frame_width + shaft_width : shaft_width *2: heddle_width+heddle_frame - shaft_width  ]) {  
        translate ([0, I, 0]) 
            difference () {
                cube ([heddle_height + heddle_frame, shaft_width, shaft_width] );
                translate ( [(heddle_height + heddle_frame) / 2, shaft_width/2, -tt/2] ) 
                    cylinder ( h=shaft_width+tt, r=warp_dia/2);
                }
            }
        }