// preview[view:south east, tilt: top diagonal]

//What units are you measuring in?
units = "Inches"; //[Inches, Millimeters]

//Wall thickness for the engine brackets
wall_t = .125;

//Resolution
$fn = 30;

/* [Secondary Engines] */

//Secondary engine diameter
se_d = 1.375;
//Secondary engine mount height
se_h = 6;
//How many secondary engines are there?
se_n = 3;
//distance between the bottom of the main engine to the bottom of the second engine
se_me_diff = 1;

/* [Main Engine] */

//Main engine diameter
me_d = 1.6875;
// main engine mount height
me_h = 3;
//distance between bottom of the spacer and the bottom of the main engine
me_s_diff = .5;

/* [Spacer] */

//Spacer length
s_l = .5625;
//Spacer thickness
s_t = .25;
//Spacer height
s_h = 1.5;

/* [Hidden] */

//Makes the spacer arms overlap
overlap_amount = wall_t*2;

engine_spacer_render();

//Builds the mount to hold the secondary rocket engines
module secondary_engine_mount(){
  difference(){
    cylinder(r = se_d/2+wall_t, h = se_h);
    cylinder(r = se_d/2, h = se_h);
  }
}

//Builds the mount to hold the main engine
module main_engine_mount(){
  difference(){
    cylinder(r = me_d/2+wall_t, h = me_h);
    cylinder(r = me_d/2, h = me_h);
  }
}

//Builds the spacer that connects the secondary engines to the main engine
module spacer(){
  _r = .001;
  difference(){
    translate([me_d/2,0,0]) rotate([0,90,0]) hull(){
      for(j = [-1:2:1])
        translate([0,s_t/2*j,0])
          cylinder(r = _r, h = s_l+overlap_amount);
        translate([-s_h,0,0])
          cylinder(r = .01, h = s_l+overlap_amount);
    }
    union(){
      cylinder(r = me_d/2, h = s_h*2.5, center = true);
      translate([s_l+(me_d/2+wall_t)+(se_d/2+wall_t),0,0])
        cylinder(r = se_d/2, h = s_h*2.5, center = true);
    }
  }
}
//Connects all of the different parts together
module engine_spacer(){
  for(i = [0:360/se_n:360])
    rotate(i){
      translate([s_l+(me_d/2+wall_t)+(se_d/2+wall_t), 0, -se_me_diff])
        secondary_engine_mount();
      translate([0,0,me_s_diff])
        spacer();
    }
  main_engine_mount();
}
//converts the model to inches if units = "Inches"
module engine_spacer_render(){
  if(units == "Inches")
   scale(25.4) engine_spacer();
  else if (units == "Millimeters")
    engine_spacer();
}
