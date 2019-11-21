inch=25.4; // *1

view = "vect"; //[view: show the bot, vect: make a file to cut]
//the thickness of the material being used
bot_skin_thick = 0.075*inch; 
//gap to make the creases to bend the body
crease = .1;
//increase in radius to let wheel and support spin 
slip = 0.035*inch; 

//twice the distance from the motor mount to the center of the motor shaft
motor_body_height = .6*inch; 
//clearance diameter of the motor shaft.
motor_shaft_diameter = .3*inch; 

//width of the robots body
bot_body_width = 80; 
//height of the robots body (width of the sides)
bot_body_height = 40; 
//length of the robots body
bot_body_length = 4*inch; 

//increases the wheel size beyond the height of the side.
bot_wheel_size = 0;
//diameter of the axle where the wheels mount
bot_wheel_axel_diameter = 0.25*inch; 
//how far to move the wheel back from center.
bot_wheel_setback = 15; 
//distance from side of the body to the wheel hub
bot_wheel_clearance = 1.2; 

//Height of each slot
slot_height = 2;
//Width of each slot
slot_width = 1;
//Moves the slots between the inner and outer diameter of the wheel
slot_bias = 1; //[0:0.01:1]
//Degrees rotation between slots.  Should be a clean divisor of 360.
slot_rotate_by = 15; //[1:360]

/* [Hidden] */
$fs=.1; // *1
current_rotation = 0;

bot_wheel_shaft_r = bot_wheel_axel_diameter/2; 
bot_wheel_clear = bot_skin_thick + bot_wheel_clearance;
bot_wheel_r = bot_body_height/2+bot_wheel_size;
bot_wheel_hub_r = bot_wheel_shaft_r*1.2 + bot_wheel_r*0.2;
bot_wheel_c = bot_wheel_r+motor_body_height/2+motor_shaft_diameter/2;

slot_rotate_steps = 360 / slot_rotate_by;
slot_offset = bot_wheel_shaft_r*1.1*slot_bias + bot_wheel_r*(0.9*(1-slot_bias));

/* [Hidden] */


folded = lookup($t, [
	[0,1],
	[.3,0],
	[.6,0],
	[.8,1]
	]);


if (view == "vect") {
	projection() 
		cardbot(0);
	} 
else { cardbot(folded); }


module cardbot(folded) {

if (folded > 0.7) {
  translate([bot_wheel_setback,
   -bot_body_width/2+bot_skin_thick,
   -motor_body_height/2-bot_skin_thick/2]) 
      dc_motor_small(
        body_length = 1.3*inch,
        body_diameter = .8*inch,
        body_height = motor_body_height,
        shaft_length = .4*inch,
        shaft_diameter = motor_shaft_diameter
        );
    
  translate([bot_wheel_setback,
    bot_body_width/2-bot_skin_thick,
    -motor_body_height/2-bot_skin_thick/2]) 
    rotate([180,0,0]) 
      dc_motor_small(
        body_length = 1.3*inch,
        body_diameter = .8*inch,
        body_height = motor_body_height,
        shaft_length = .4*inch,
        shaft_diameter = motor_shaft_diameter
        );

  rotate([90,0,0]) //rotate to fold
    translate([bot_wheel_setback,-bot_wheel_c,0]) //shift down when folded
      color("grey") 
      cylinder(r=bot_wheel_shaft_r, 
        h=bot_body_width+bot_wheel_clear*4 , 
        center=true);
  }

//platform
union() {
    cube([bot_body_length, bot_body_width, bot_skin_thick],center=true);
    //fill in the crease gap ever other millimeter.
    for(i  = [-bot_body_length/2+1:2:bot_body_length/2-1]) {
        translate([i,0,0])
        cube([1.6, bot_body_width+crease*2+1, bot_skin_thick],center=true);
        }
    }

//left wheel
translate([(bot_body_length/2-bot_wheel_r)*(1-folded) 
			+bot_wheel_setback*folded
			,
			-(bot_wheel_r+bot_body_width/2+bot_body_height+crease*2)*(1-folded)
			-(bot_body_width/2+crease+bot_wheel_clear)*folded
			, 
			0]) 
rotate([90*folded,0,0]) //rotate to fold
  translate([0,-bot_wheel_c*folded,0]) //shift down when folded
    difference() { //wheel, then punch out hole for axil
      cylinder(r=bot_wheel_r, h=bot_skin_thick,center=true);
      cylinder(r=bot_wheel_shaft_r+slip, h=bot_skin_thick+crease,center=true);
      for(i  = [0:1:slot_rotate_steps]) {
        rotate([0,0,slot_rotate_by*i]) {
          slot();
          }
        }
      }

//left wheel spacer
translate([(bot_body_length/2-bot_wheel_hub_r-bot_wheel_r*2-crease*2)*(1-folded) 
			+ bot_wheel_setback*folded
			,
			-(bot_wheel_hub_r+bot_body_width/2+bot_body_height+crease*2)*(1-folded)
			-(bot_body_width/2+crease+bot_wheel_clear-bot_skin_thick)*folded
			,
			0])
rotate([90*folded,0,0]) //rotate to fold
  translate([0,-bot_wheel_c*folded,0]) //shift down when folded
    difference() { //wheel, then punch out hole for axle
      cylinder(r=bot_wheel_hub_r, h=bot_skin_thick,center=true);
      cylinder(r=bot_wheel_shaft_r+slip, h=bot_skin_thick+crease,center=true);
      }

//left wheel axel stop. Glued to axle
translate([(bot_body_length/2-bot_wheel_hub_r*3-bot_wheel_r*2-crease*4)*(1-folded) 
			+ bot_wheel_setback*folded
			,
			-(bot_wheel_hub_r+bot_body_width/2+bot_body_height+crease*2)*(1-folded)
			-(bot_body_width/2+crease+bot_wheel_clear+bot_skin_thick)*folded
			,
			0])
rotate([90*folded,0,0]) //rotate to fold
  translate([0,-bot_wheel_c*folded,0]) //shift down when folded
    difference() { //wheel, then punch out hole for axle
      color("grey") cylinder(r=bot_wheel_hub_r, h=bot_skin_thick,center=true);
      cylinder(r=bot_wheel_shaft_r, h=bot_skin_thick+crease,center=true);
      }

//right wheel
translate([(bot_body_length/2-bot_wheel_r)*(1-folded) 
			+bot_wheel_setback*folded
			,
			+(bot_wheel_r+bot_body_width/2+bot_body_height+crease*2)*(1-folded)
			+(bot_body_width/2+crease+bot_wheel_clear)*folded
			,
			0])
rotate([180-90*folded,0,0]) 
  translate([0,-bot_wheel_c*folded,0])
    difference() {
      cylinder(r=bot_wheel_r, h=bot_skin_thick,center=true);
      cylinder(r=bot_wheel_shaft_r+slip, h=bot_skin_thick+crease,center=true);
      for(i  = [0:1:slot_rotate_steps]) {
        rotate([0,0,slot_rotate_by*i]) {
          slot();
          }
        }
      }

//right wheel spacer glued to wheel
translate([(bot_body_length/2-bot_wheel_hub_r-bot_wheel_r*2-crease*2)*(1-folded) 
			+bot_wheel_setback*folded
			,
			+(bot_wheel_hub_r+bot_body_width/2+bot_body_height+crease*2)*(1-folded)
			+(bot_body_width/2+crease+bot_wheel_clear-bot_skin_thick)*folded
			,
			0])
rotate([180-90*folded,0,0]) //rotate to fold
  translate([0,-bot_wheel_c*folded,0]) //shift down when folded
    difference() { //wheel, then punch out hole for axle
      cylinder(r=bot_wheel_hub_r, h=bot_skin_thick,center=true);
      cylinder(r=bot_wheel_shaft_r+slip, h=bot_skin_thick+crease,center=true);
      }

//right wheel axel stop. Glued to axle
translate([(bot_body_length/2-bot_wheel_hub_r*3-bot_wheel_r*2-crease*4)*(1-folded) 
			+bot_wheel_setback*folded
			,
			+(bot_wheel_hub_r+bot_body_width/2+bot_body_height+crease*2)*(1-folded)
			+(bot_body_width/2+crease+bot_wheel_clear+bot_skin_thick)*folded
			,
			0])
rotate([180-90*folded,0,0]) //rotate to fold
  translate([0,-bot_wheel_c*folded,0]) //shift down when folded
    difference() { //wheel, then punch out hole for axle
      color("grey") cylinder(r=bot_wheel_hub_r, h=bot_skin_thick,center=true);
      cylinder(r=bot_wheel_shaft_r, h=bot_skin_thick+crease,center=true);
      }

//left side
translate([0,-(bot_body_width/2)-crease,0])
rotate([90*folded,0,0]) 
  difference() {
    translate([0,-bot_body_height/2,0])
	  cube([bot_body_length, bot_body_height, bot_skin_thick],center=true);
	translate([bot_wheel_setback,-bot_wheel_c,0]) //punch out main axle
	  cylinder(r=bot_wheel_shaft_r+crease, h=bot_skin_thick+crease, center=true);
  //punch out for motor shaft
	translate([bot_wheel_setback,-motor_body_height/2-bot_skin_thick/2,0]) 
	  cylinder(r=motor_shaft_diameter/2+slip, h=bot_skin_thick+crease, center=true);
	}

//right side
translate([0,(bot_body_width/2)+crease,0])
rotate([180-90*folded,0,0]) 
  difference() {
    translate([0,-bot_body_height/2,0])
	  cube([bot_body_length, bot_body_height, bot_skin_thick],center=true);
	translate([bot_wheel_setback,-bot_wheel_c,0]) //punch out main axle
	  cylinder(r=bot_wheel_shaft_r+crease, h=bot_skin_thick+crease, center=true);
   //punch out for motor shaft
	translate([bot_wheel_setback,-motor_body_height/2-bot_skin_thick/2,0]) 
	  cylinder(r=motor_shaft_diameter/2+crease, h=bot_skin_thick+crease, center=true);
	}

}

    
module slot(){
  translate([bot_wheel_r - slot_height - slot_offset,-(slot_width/2),
	-bot_skin_thick/2-crease]) 
    cube([slot_height,slot_width,bot_skin_thick+crease*2]);
  }

module dc_motor_small(
	body_length = 1.3*inch,
	body_diameter = .8*inch,
	body_height = .6*inch,
	shaft_length = .4*inch,
	shaft_diameter = .2*inch)
{
	union() {
		intersection() {
			color("gray") rotate([-90,0,0]) cylinder(body_length, r=body_diameter/2);
			color("gray") cube([body_diameter, body_length*2, body_height],center=true);
			}
		translate([0,-shaft_length,0]) rotate([-90,0,0]) 
			color("silver") cylinder(shaft_length, r=shaft_diameter/2);
		}
	}

