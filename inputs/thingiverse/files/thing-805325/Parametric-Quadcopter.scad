/* [Quadcopter Size] */

//The distance between the centres of right and left front motors
Width=60;

//The distance between the centres of front and back left motors
Length=100;


//Flight Controller Width
FC_Width=30;

//Flight Controller Length
FC_Length=32;

//Width of Frame Surfaces at narrowest point
Surface_Width=3;

//The thickness of your quadcopter frame determines how strong it is, how flexible it is, how much it dampens vibration, etc.
Frame_Thickness=3;

/* [Motor Holders] */
//Actual motor diameter
Motor_Diameter= 7;// [6,7,8.5]

//Motor hole scaling.  Use this if your holes are the wrong size.  The frame is built with scaled_motor_diameter=Motor_Hole_Scaling*Motor_Diameter, so 1.0 is the no-change default.
Motor_Hole_Scaling=1.0;

//Total motor cap height (extends above the frame)
Motor_Cap=10;

//The thickness of the motor cap wall
Motor_Cap_Wall_Thickness=2;

//The size of the side opening on the motor caps
Motor_Cap_Side_Opening=1;

//This adds a slight bevel inside the motor cap so that you don't have to cut away any material to insert motors.
Motor_Cap_Inner_Bevel=0;

/* [Testing and Quality Options] */

//Which parts do you want to show
Which_Parts="frame"; // ["frame":Whole_frame, "motor":Test_motor_cap]

Resolution=100; //[20,50,100]

/* [Hidden] */

//Actual motor length;
//Motor_Length=20;//[20]



//calculated variables

FC_Band=Surface_Width;

left = -Width/2;
right = -left;
front = Length/2;
rear = -front;

RFangle=atan2(front,right);
LFangle=atan2(front,left);
RF=[right,front,RFangle];
LF=[left,front,LFangle];
RR=[right,rear,LFangle+180];
LR=[left,rear,RFangle+180];
$fn=Resolution;

scaled_motor_diameter=Motor_Hole_Scaling*Motor_Diameter;
cap_wall_thickness=Motor_Cap_Wall_Thickness;
cap_wall_opening=Motor_Cap_Side_Opening;

module motor_cap_outer(
     h=Motor_Cap,
     inside_diameter=scaled_motor_diameter,
     motor=RF,
     cap_wall_thickness=cap_wall_thickness)
{
     outer_radius=inside_diameter/2+cap_wall_thickness;
     outer_height=h+Frame_Thickness;
     translate([motor[0],motor[1]])
	  rotate(motor[2]+90) 
	       translate([0,0,outer_height/2])
	       cylinder(h=outer_height,r=outer_radius, center=true);
}

module motor_cap_inner(
     h=Motor_Cap,
     inside_diameter=scaled_motor_diameter,
     motor=RF,
     cap_wall_thickness=cap_wall_thickness,
     cap_wall_opening=cap_wall_opening)
{
     inner_radius=inside_diameter/2;
     outer_radius=inside_diameter/2+cap_wall_thickness;
     inner_height=h;
     bevel_thickness=Motor_Cap_Inner_Bevel;
     translate([motor[0],motor[1],Frame_Thickness])
	  rotate(motor[2]+90)
	  union(){ 
	  translate([0,0,inner_height/2])
	       cylinder(h=inner_height,r=inner_radius, center=true);
	  translate([0,0,bevel_thickness/2])
	       cylinder(
	  	    h=bevel_thickness,
	  	    r2=inner_radius,
	  	    r1=inner_radius+bevel_thickness,
	  	    center=true);
	  translate([0,outer_radius/2,inner_height/2]) 
	       cube([cap_wall_opening,2*outer_radius,inner_height], center=true);
     }
}

module control_centre(w=FC_Width,l=FC_Length,h=Frame_Thickness,band=FC_Band){
     d=sqrt(l*l+w*w);
     translate([0,0,h/2]) union(){
	  intersection(){
	       rotate(atan(l/w))
		    cube([d,band,h],center=true);
	       cube([w,l,h],center=true);
	  }
	  intersection(){
	       rotate(-atan(l/w))
		    cube([d,band,h],center=true);
	       cube([w,l,h],center=true);
	  }

	  difference(){
	       cube([w,l,h],center=true);
	       cube([w-2*band,l-2*band,h],center=true);

	  }
}
}

module hyperbola(a=1,b=1,v=0,h=500){
     translate([0,v,0])scale([a,b,1])
     linear_extrude(height=Frame_Thickness,convexity=10)
	  projection(cut=true)
	  translate([0,0,1])
	  rotate([-90,0,0])
	  cylinder(h=h,r1=0,r2=h);
}

module strut(x=Width/2,y=Length/2,apex=FC_Length/2-FC_Band,band=FC_Band){
     ir=scaled_motor_diameter/2+cap_wall_thickness;
     r=ir-band;
     //This hyperbola meets the motor at the outside at point (x0,y0).
     //Let the motor mount have radius r and be centered at (x,y),
     //then (y0-y)/(x0-x)= -(x/y) and (x0-x)^2+(y0-y)^2=r^2.
     //The solution for y0 and x0 are as follows:
     x0 = -y*r/sqrt(x*x+y*y)+x;
     y0 = x*r/sqrt(x*x+y*y)+y;
     aa=apex*x0/sqrt(y0*y0-apex*apex);
     
     //Here we use the same hyperbola, translated vertically by v, so
     //that the width of the struts are FC_Band where they meet the
     //motors.
     theta=atan2(y,x);
     deltaX=-band*cos(theta);
     deltaY=band*sin(theta);

     ix0 = x0+deltaX;
     iy0 = y0+deltaY;
     v=iy0-apex*sqrt(1+ix0*ix0/(aa*aa));
     intersection(){
	  difference(){
	       hyperbola(a=aa,b=apex,h=max(Width,Length)*5);	       
	       hyperbola(a=aa,b=apex,v=v,h=max(Width,Length)*5);
	  }
	  translate([0,0,Frame_Thickness/2])
	       cube([2*x+ir,
		     2*y+ir,
		     Frame_Thickness],center=true);
     }
}

if(Which_Parts=="frame"){
     difference(){
	  union(){
	       control_centre();
	       motor_cap_outer(motor=RF);
	       motor_cap_outer(motor=LF);
	       motor_cap_outer(motor=RR);
	       motor_cap_outer(motor=LR);
	       rotate(0)strut(x=Width/2,y=Length/2,apex=FC_Length/2-FC_Band,band=FC_Band);
	       rotate(90)strut(x=Length/2,y=Width/2,apex=FC_Width/2-FC_Band,band=FC_Band);
	       rotate(180)strut(x=Width/2,y=Length/2,apex=FC_Length/2-FC_Band,band=FC_Band);
	       rotate(270)strut(x=Length/2,y=Width/2,apex=FC_Width/2-FC_Band,band=FC_Band);
	  }
	  motor_cap_inner(motor=RF);
	  motor_cap_inner(motor=LF);
	  motor_cap_inner(motor=RR);
	  motor_cap_inner(motor=LR);
     }
}else{
     difference(){
	  motor_cap_outer(motor=RF);
	  motor_cap_inner(motor=RF);
     }
}
