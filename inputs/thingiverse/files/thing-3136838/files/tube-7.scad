/*
Made by Elsa (HEAD) and Daniel K. Schneider (TECFA, University of Geneva) Jan 2017.

Use the rewarder module to create reward tubes. The typical use case is the following: You are supposed to spend X hours on a task. For each hour spent, award yourself with a coin. You are allowed to freely spend the collected on anything you like once the tube is full.

Motivational parameters you can decide upon: Coin type, amount of coins. It is easy to add other coins. All you need to do is to look up or measure its width and thickness and add a line of code.

Other parameters fix wall size, floor size, front/back gap, corner radius, text on side and floor, etc.

There are examples that you could uncomment.

Credits for code that reused:

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
*/

coin=[23.25, 2.33];
n_coins=50;
wall=6;
gap=6;
extra=0.5;
corner_radius=4;
floor_height=4;
floor_size_multiplier=2;
text="REWARD TUBE";
font_size=5;
side_text="FEED ME";
font_size_side=5;
side_text_height=1;
side_r_text="ACHIEVE";
font_size_side_r=5;
side_r_text_height=1;

/* [Hidden] */

CHF_5  = [31.45, 2.35];
CHF_2  = [27.40, 2.15];
CHF_1  = [23.20, 1.55];
CHF_05 = [18.20, 1.25];
CHF_02 = [21.05, 1.65];

US_quarter = [24.257,1.75];

EUR_2  = [25.75, 2.20];
EUR_1  = [23.25, 2.33];
EUR_05 = [24.25, 2.38];
EUR_02 = [22.25, 2.14];

$fn=30;

module rewarder (coin=EUR_1, n_coins=50, wall=6, gap=6, extra=0.5, corner_radius=4, floor_height=4, floor_size_multiplier=2, text="", font_size=5, side_text="", font_size_side=5, side_text_height=1, side_r_text="", font_size_side_r=5, side_r_text_height=1) {

    // a floor
    floor_size = (coin[0]+wall) * floor_size_multiplier;
    fr = corner_radius;
    translate ([0,0,0]) {
	linear_extrude(height = floor_height)
	    rounded_square(
			   [floor_size, floor_size],
			   [fr,fr,fr,fr], true);
    }
    // create the tube, a bit to the back
    //     translate ([0,floor_size_multiplier/4*(coin[0]-wall),floor_height])
    translate ([0,0,floor_height])
	fit_outside_tube (coin=coin, n_coins=n_coins, wall=wall, gap=gap, extra=extra, corner_radius=corner_radius, side_text=side_text, font_size_side=font_size_side, side_text_height=side_text_height, side_r_text=side_r_text, font_size_side_r=font_size_side_r, side_r_text_height=side_r_text_height);
    // add text. It is etched inside the wall. If large enough it will make a hole=, but this would require support structure.
    if (text)
    translate ([0,-floor_size/2.1+font_size/2,floor_height]) {
	linear_extrude(height = 2) {
	    text(text, font = "Liberation Sans", valign="center", halign="center", font_size);
	}
    }
}


// ------------ For use with customizer

rewarder (
     coin=coin,
     n_coins=n_coins,
     wall=wall,
     gap=gap,
     extra=extra,
     corner_radius=corner_radius,
     floor_height=floor_height,
     floor_size_multiplier=floor_size_multiplier,
     text=text,
     font_size=font_size,
     side_text=side_text,
     font_size_side=font_size_side,
     side_text_height=side_text_height,
     side_r_text=side_r_text,
     font_size_side_r=font_size_side_r,
     side_r_text_height=side_r_text_height
     );

// ----------------- Other examples of use. 

// rewarder ();
// rewarder (coin=CHF_05, n_coins=30);
// rewarder (coin=CHF_1, n_coins=75);

// rewarder (coin=CHF_05, n_coins=75, wall=6, gap=6, extra=0.3, corner_radius=4, floor_height=4, floor_size_multiplier=2, text="", font_size=12);

// rewarder (coin=CHF_1, n_coins=45, wall=6, gap=6, extra=0.4, corner_radius=4, floor_height=4, floor_size_multiplier=1.7, text="REWARDBOX", font_size=5, side_text="PROGRESS", font_size_side=8, side_text_height=1);

// rewarder (coin=EUR_1, n_coins=50, wall=6, gap=6, extra=0.3, corner_radius=4, floor_height=4, floor_size_multiplier=1.7, text="50 EUR", font_size=8, side_text="REWARD BOX", font_size_side=12, side_text_height=1, side_r_text="\u2665", font_size_side_r=12, side_r_text_height=1);

// rewarder (coin=EUR_2, n_coins=60, wall=6, gap=6, extra=0.3, corner_radius=4, floor_height=4, floor_size_multiplier=1.8, text="REWARD BOX", font_size=5, side_text="1 TUTORING = 2 €", font_size_side=10.5, side_text_height=1, side_r_text="car je le mérite", font_size_side_r=12, side_r_text_height=1);

// rewarder (coin=EUR_2, n_coins=50, wall=6, gap=6, extra=0.3, corner_radius=4, floor_height=4, floor_size_multiplier=1.8, text="REWARD BOX", font_size=5, side_text="1 PAGE = 2 €", font_size_side=10.5, side_text_height=1, side_r_text="UP FOR IT", font_size_side_r=12, side_r_text_height=1);

// rewarder (coin=CHF_5, n_coins=50, wall=6, gap=6, extra=0.3, corner_radius=4, floor_height=4, floor_size_multiplier=1.7, text="1/4 K for Kalli", font_size=7.5, side_text="Housework", font_size_side=15, side_text_height=1, side_r_text="REWARD BOX", font_size_side_r=12, side_r_text_height=1);

// rewarder (coin=US_quarter, n_coins=45, wall=6, gap=6, extra=0.3, corner_radius=4, floor_height=4, floor_size_multiplier=1.7, text="REWARDBOX", font_size=5, side_text="PROGRESS", font_size_side=8, side_text_height=4);


// ---------------- Aux

// Tube creation, used by rewarder module
module fit_outside_tube (coin=EUR_1, n_coins=50, wall=6, gap=6, extra=0.5, corner_radius=4, text="", font_size=5, side_text="", font_size_side=5, side_text_height=1, side_r_text="", font_size_side_r=5, side_r_text_height=1) {
	width0 = coin[0]; 
	h = n_coins * coin[1];
	width = width0 + wall;
	
	or = corner_radius;
	ir = corner_radius-wall/2;

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
		rounded_square([width0 + extra, width0 + extra],
		    [ir,ir,ir,ir], true);
	    }
	    // add side text to left wall if there is
	    // the text will be edged into the wall. Increase its side_text_height to create holes
	    if (side_text)
	    translate ([-width/2+side_text_height-0.01,0,1]) {
		rotate ([0,270,0]) {
		    linear_extrude(height = side_text_height)
    		    text(side_text, font = "Liberation Sans:style=Bold", valign="center", font_size_side);
		}
	    }
	    // add side text to right wall if there is
	    if (side_r_text)
	    # translate ([width/2-side_r_text_height+0.01,0,h-1]) {
		rotate ([0,90,0]) {
		    linear_extrude(height = side_r_text_height)
    		    text(side_r_text, font = "Liberation Sans:style=Bold", valign="center", font_size_side_r);
		}
	    }
	    // gaps
	    // uncomment to have also a lateral gap
	    // cube (size=[width0*2,gap,h*3], center=true);
	    cube (size=[gap,width0*2,h*3], center=true);
	}

	// add the marks, 10s are left and 5s are right
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
