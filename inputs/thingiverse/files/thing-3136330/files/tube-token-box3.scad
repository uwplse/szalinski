/*
Made by
 Daniel K. Schneider, TECFA, University of Geneva,
 Elsa C.L. Schneider, Haute Ecole d'Art et de Design (HEAD), Geneva
 Kalli Benetos, TECFA, University of Geneva
 Jan 2017.

Use the rewarder module to create reward tubes. The typical use case is the following: You need some extrinsic motivation to get tasks done. For each hour spent or each task done, award yourself with a token. Once the tube to the left is full you can give yourself a reward, e.g buy something that you would not buy otherwise, a weekend in some nice place, etc. The larger box serves as a token pool.

The devices includes a "tube" that you can fill with coins or tokens of various thickness and color. Coins can be cashed in directly, tokens allow for more differentiated strategies. See file tube-tokens-2.scad. It is up to the user to decide what tokens represent. We suggest creating these tokens with a laser cutter. Otherwise you can print them.

Motivational design parameters you can decide upon: Coin type, amount of coins, lettering in three places, instructions to the user (or s/he decide by themselves). Other parameters define wall size, floor size (and indirectly the pool size), multiple columns, front/back gap, corner radius, etc.

For the calibration of width and height we use coins as "standard" since people got a good feel for them. For example, if you define the height as 50 x 2EUR you we will 100 Euros once it is full,but you can decide on anything else.

Below are examples that you could uncomment.

Credits for code that we reused:

fit_outside_tube: by Winder, published Dec 22, 2013 
http://blog.willwinder.com/2013/12/openscad-linear-extrude-that.html
https://www.thingiverse.com/thing:209964/#files

License: http://www.gnu.org/licenses/gpl-2.0.html

Rounded square: By felipesanches 
https://github.com/Metamaquina/Metamaquina2Beta/blob/master/rounded_square.scad

Coin dimensions according to Wikipedia
- https://en.wikipedia.org/wiki/Swiss_franc
- https://en.wikipedia.org/wiki/Euro_coins
- https://en.wikipedia.org/wiki/Coins_of_the_United_States_dollar

Tip for customizer users:
- only use ascii characters in the file
- https://customizer.makerbot.com/docs
- Probably, the thing must be published
*/

/* [Resolution, fragments per circle] */
$fn=20;

/* [Tube Size] */
Coin_Diameter = 27.40; // [31.45:CHF_5, 27.40:CHF_2, 25.75:EUR_2, 23.25:EUR_1, 24.257:US_quarter]
Coin_Thickness = 2.15; // [2.35:CHF_5, 2.15:CHF_2, 2.20:EUR_2, 2.33:EUR_1, 1.75:US_quarter]
// N coins defining the height of the tube(s)
N_coins=30;
// extra space added to each coins; will eat into wall thickness
Extra=0.6; 
// Size of floor with respect to tube
Floor_Size_Multiplier=2; // [1:5]
// One or more tubes
Multiple=1; // [1:5]
// height of pool with respect to tube
Pool_Height=0.7; //

/* [Walls and gaps] */
// Wall thickness
Wall_Thickness=5;
// Rounding of tube corners
Corner_Radius=4;
// height of base platform
Floor_Height=4;
// gap width in tubes
Gap=6;
// gap width in pool
Gap_Pool=6;

/* [Text decorations] */
Side_R_Text="TOKENS";
Side_R_Text_Height=1;
Side_Text_R_Font_Size=5;
Side_Text="FEED ME";
Side_Text_Height=2;
Side_Text_Font_Size=6;
Text="REWARD";
Text2="BOX";
Text_Font_Size=5;


/* [Hidden] */
coin_selected = [Coin_Diameter, Coin_Thickness];

// Constants you can use in function calls
// largest swiss coin, used a lot
CHF_5  = [31.45, 2.35];
// large swiss coin
CHF_2  = [27.40, 2.15];
// popular, but a bit small
US_quarter = [24.257, 1.75];
// limited use
US_05 = [30.60,2.15];
// limited use
US_1  = [26.50, 2.0];
// old large US$, still legal but obsolete
US_1o = [38.1,2.58]; 
// largest € coin, used a lot
EUR_2  = [25.75, 2.20];
// most popular € coin, but a bit small
EUR_1  = [23.25, 2.33];

// ----------------- Examples of use. 

// rewarder ();

rewarder (
	  coin=coin_selected,
	  corner_radius = Corner_Radius,
	  extra = Extra,
	  floor_height = Floor_Height,
	  floor_size_multiplier = Floor_Size_Multiplier,
	  gap = Gap,
	  gap_pool = Gap_Pool,
	  multiple = Multiple,
	  n_coins = N_coins,
	  pool_height = Pool_Height,
	  side_r_text = Side_R_Text,
	  side_r_text_height = Side_R_Text_Height,
	  side_text_r_font_size = Side_Text_R_Font_Size,
	  side_text = Side_Text,
	  side_text_height = Side_Text_Height,
	  side_text_font_size = Side_Text_Font_Size,
	  text2 = Text2,
	  text = Text,
	  text_font_size = Text_Font_Size,
	  wall_thickness = Wall_Thickness
);

// rewarder (coin=CHF_5, corner_radius=4, extra=0.5, floor_height=4, floor_size_multiplier=2, gap=6, multiple=1, n_coins=35, pool_height=0.7, side_r_text="TASK ITEMS", side_r_text_height=1, side_text_r_font_size=6, side_text="FEED ME!", side_text_height=2.5, side_text_font_size=10, text2="BOX", text="REWARD", text_font_size=5, wall_thickness=4);

// rewarder (coin=EUR_2, corner_radius=4, extra=0.5, floor_height=4, floor_size_multiplier=2, gap=6, multiple=2, n_coins=45, pool_height=0.75, side_r_text="TASK TOKENS", side_r_text_height=1, side_text="TRACK WISELY", side_text_height=2, side_text_font_size=9, side_text_r_font_size=7, text="REWARD BOX", text2="I DESERVE IT", text_font_size=5, wall_thickness=4);

// rewarder (coin=CHF_5, n_coins=33);

// ---------- Main module 

module rewarder (
    coin=EUR_2, // coin size
    n_coins=30, // N coins defining the height of the tube(s)
    corner_radius=4,
    extra=0.6, // extra space added to each coins, will eat into wall thickness
    floor_height=4, // height of base platform
    floor_size_multiplier=2, // size of floor with respect to tube
    gap=6, // gap between towers
    gap_pool=6,
    multiple=1,
    pool_height=0.7,
    side_r_text="",
    side_r_text_height=1,
    side_text_r_font_size=5,
    side_text="",
    side_text_height=1,
    side_text_font_size=4,
    text="",
    text2="",
    text_font_size=5,
    wall_thickness=5) 
{
    width0 = coin[0]; 
    width = width0 + wall_thickness*2;
    h = n_coins * coin[1];
    n_coins_pool = round(n_coins*pool_height);
    h2 = n_coins_pool * coin[1];

    // a floor
    floor_size_y = width * floor_size_multiplier;
    floor_size_x = width * multiple + floor_size_y;
    fr = corner_radius;
    translate ([0,-floor_size_y/2,0]) {
	linear_extrude(height = floor_height)
	    rounded_square(
		[floor_size_x, floor_size_y],
		[fr,fr,fr,fr], true,
		center=false)   ;
	}

    // text on plate, aligned left in front of tube
    if (text) {
	translate ([0+corner_radius/2,-floor_size_y/2+2*text_font_size+corner_radius/2,floor_height]) {
	    color("blue") linear_extrude(height = 2) {
		text(text, font = "Liberation Sans", valign="center", halign="center", text_font_size, halign="left");
	    }}}
    if (text2) {
	translate ([0+corner_radius/2,-floor_size_y/2+corner_radius/2+text_font_size/2,floor_height]) {
	    color("pink") linear_extrude(height = 2) {
		text(text2, font = "Liberation Sans", valign="center", halign="center", text_font_size, halign="left");
	    }}}
    
    // create the tube(s)

    difference () {
	for ( i = [0:multiple-1] ) {
	    translate ([width/2+i*width,floor_size_y/2-width/2,floor_height]) {
		fit_outside_tube (coin=coin, n_coins=n_coins, wall_thickness=wall_thickness, gap=gap, extra=extra, corner_radius=corner_radius, side_text=side_text, side_text_font_size=side_text_font_size, side_text_height=side_text_height, side_r_text=side_r_text, side_text_r_font_size=side_text_r_font_size, side_r_text_height=side_r_text_height);
	    }
	}
	// add side text to left wall of the tube if there is
	// the text will be edged into the wall. Increase its side_text_height to create holes
	if (side_text)
	#translate ([side_text_height-1,floor_size_y/2-width/2,1+floor_height]) {
	    rotate ([0,270,0]) {
		linear_extrude(height = side_text_height)
    		text(side_text, font = "Liberation Sans:style=Bold", valign="center", side_text_font_size);
	    }
	}
    } 

    // Create the pool. It sits after the tube(s) and will take x-width and y-width (y dimension) of the floor-size multiplier. E.g. if it is 3, it will take 3xsize of the tube.
    pool_inside_width = [floor_size_y-wall_thickness*2, coin[1]];
    difference () {
	// move it to the right: N*tubes + half its size
	translate ([multiple*width+floor_size_y/2,0,floor_height]) {
	    fit_outside_tube (coin=pool_inside_width, n_coins=n_coins_pool, wall_thickness=wall_thickness, gap=gap_pool, extra=extra, corner_radius=corner_radius, side_text=side_text, side_text_font_size=side_text_font_size, side_text_height=side_text_height, side_r_text=side_r_text, side_text_r_font_size=side_text_r_font_size, side_r_text_height=side_r_text_height, marks=false);
	}

    // add side text to right wall if there is
    if (side_r_text)
    # translate ([multiple*width+floor_size_y-0.9,0,h2+floor_height-3]) {
	rotate ([0,90,0]) {
	    linear_extrude(height = side_r_text_height)
    	    text(side_r_text, font = "Liberation Sans:style=Bold", valign="center", side_text_r_font_size);
	}
    }
    }
} 


// ---------------- Aux

// Tube creation, used by rewarder module
module fit_outside_tube (coin=EUR_1, n_coins=50, wall_thickness=6, gap=6, extra=0.5, corner_radius=4, text="", text2="", text_font_size=5, side_text="", side_text_font_size=5, side_text_height=1, side_r_text="", side_text_r_font_size=5, side_r_text_height=1, marks=true) {
	width0 = coin[0]; 
	h = n_coins * coin[1];
	width = width0 + wall_thickness*2;
	
	or = corner_radius;
	ir = corner_radius-wall_thickness/2;

	n_5_marks = floor(n_coins / 5);
	n_10_marks = floor(n_coins / 10);
	
	// create the tube with gaps in the walls
	difference () {
	    // Extrude the tube
	    linear_extrude(height = h)
	    difference() {
		// outer shell
		rounded_square(
		    [width, width],
		    [or,or,or,or], true);
		// inner width0 to subtract
		# rounded_square([width0 + extra, width0 + extra],
		    [ir,ir,ir,ir], true);
	    }
	    // gaps
	    // uncomment to have also a lateral gap
	    // cube (size=[width0*2,gap,h*3], center=true);
	    cube (size=[gap,width0*2,h*3], center=true);
	}

	// add the marks, 10s are left and 5s are right
	if (marks) {
	    mark_len = width0/2-gap;
	    for ( i = [1:n_5_marks] ) {
		z = i * coin[1] * 5;
		// echo ("z=",z);
		translate ([gap/2,-(width)/2,z-1]) {
		    rotate (a=[45,0,0])
		    color ("red") cube (size= [mark_len,1,1]);
		}
	    }
	    for ( i = [1:n_10_marks] ) {
		z = i * coin[1] * 10;
		echo ("z=",z);
		translate ([-mark_len-gap/2,-(width)/2,z-1]) {
		    rotate (a=[45,0,0])
		    color ("green") cube (size= [mark_len,1,1]);
		}
	    }
	}
    }

module rounded_square(dim, corners=[10,10,10,10], center=false){
  w=dim[0];
  h=dim[1];

  if (center){
    translate([-w/2, -h/2])
    rounded_square_(dim, corners=corners);
  }else{
    rounded_square_(dim, corners=corners);
  }
}

module rounded_square_(dim, corners, center=false){
  w=dim[0];
  h=dim[1];
  render(){
    difference(){
      square([w,h]);

      if (corners[0])
        square([corners[0], corners[0]]);

      if (corners[1])
        translate([w-corners[1],0])
        square([corners[1], corners[1]]);

      if (corners[2])
        translate([0,h-corners[2]])
        square([corners[2], corners[2]]);

      if (corners[3])
        translate([w-corners[3], h-corners[3]])
        square([corners[3], corners[3]]);
    }

    if (corners[0])
      translate([corners[0], corners[0]])
      intersection(){
        circle(r=corners[0]);
        translate([-corners[0], -corners[0]])
        square([corners[0], corners[0]]);
      }

    if (corners[1])
      translate([w-corners[1], corners[1]])
      intersection(){
        circle(r=corners[1]);
        translate([0, -corners[1]])
        square([corners[1], corners[1]]);
      }

    if (corners[2])
      translate([corners[2], h-corners[2]])
      intersection(){
        circle(r=corners[2]);
        translate([-corners[2], 0])
        square([corners[2], corners[2]]);
      }

    if (corners[3])
      translate([w-corners[3], h-corners[3]])
      intersection(){
        circle(r=corners[3]);
        square([corners[3], corners[3]]);
      }
  }
}
