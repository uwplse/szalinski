// Customizable Funnel
// by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// under Creative Commons License, Attribution (BY)

funnel_diameter = 50;    // [1:120]
mid_diameter    =  9;    // [0.5:0.1:30]
pipe_diameter   =  6;    // [0.5:0.1:30]
pipe_length     = 30;    // [10:100]
thickness       =  1.6;  // [0.25:0.05:2.00]
brim            =  4;    // [0:0.1:25]
cone_angle      = 60;    // [45:120]

CustomizableFunnel(funnel_diameter,
                   pipe_length,
		   mid_diameter,
		   pipe_diameter,
		   thickness,
		   brim,
		   cone_angle
                  );
		  
module CustomizableFunnel(funnel_diam,
                          pipe_length,
                       	  pipe_diam1,
                     	  pipe_diam2,
                     	  thickness,
                     	  brim,
                     	  angle,
                     	  min_wall=0.41) {
  // main cone
  top = funnel_diam * 0.5/tan(angle/2);    // top of main cone
  pipe_attachment = top * (1 - pipe_diam1/funnel_diam); // this is where the pipe attaches
  height = pipe_attachment + pipe_length; // height of whole part
                       
  // pipe
  // this is how wide the pipe would be if it extended to the base
  pipe_delta = (pipe_diam1 - pipe_diam2)/pipe_length;
  pipe_diam0 = pipe_diam1 + pipe_delta*pipe_attachment;
  // extra diameter of pipe with given thickness and slope
  extra_pipe_diam = 2*thickness*sqrt(1+pipe_delta*pipe_delta);
                       
  difference() {
    union() {
      // main cone of funnel
      outside_top = top + thickness/sin(angle/2);        // this high with given thickness
      outside_diam = funnel_diam * outside_top/top;   // this wide with given thickness
      cylinder(d1=outside_diam, d2=0, h=outside_top, $fn=90);
      
      // pipe
      cylinder(d1=pipe_diam0+extra_pipe_diam, 
               d2=pipe_diam2+extra_pipe_diam, 
               h=height, $fn=90);
      
      // brim
      cylinder(d=funnel_diam+2*brim, h=thickness, $fn=90);
    }
    
    // inside of main cone  
    cylinder(d1=funnel_diam, d2=0, h=top, $fn=90);

  
    // inside of pipe
    translate([0, 0, pipe_attachment])
      cylinder(d1=pipe_diam1, d2=pipe_diam2, h=pipe_length, $fn=90);
    
    // sharp end of pipe
    epsilon = 0.001; // err on the safe side (cut away too much)
    h = 4*thickness;
    d2 = pipe_diam2 + extra_pipe_diam + pipe_delta*h;
    translate([0, 0, height - h])
      difference() {
        cylinder(d=d2, h=h+epsilon, $fn=90);
        cylinder(d1=d2, d2=pipe_diam2+2*min_wall, h=h, $fn=90);
      }
  }
}
