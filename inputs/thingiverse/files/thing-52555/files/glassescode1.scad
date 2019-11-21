use <write/Write.scad> 

Square_or_Circle=0; //[0:Square,1:Circle]

//If working in inches, multiply by 25.4mm to choose your size
Frame_Length=70;//[45:80]
Frame_Border_Width=12;//[1:15]

//Don't fill out the Frame Height, Depth and Rounded Size for Circle Glasses
Rounded_shape=10;//[1:45]
Frame_Height=50;//[30:80]
Frame_Depth=4;//[0.5:10]



Nose_Frame_Length=30;//[5:60]
Nose_Frame_Placement=12;//[0:25]


Ear_Frame_Length=125;//[70:200]
Ear_Frame_Height=8;//[1:15]
Ear_Frame_Distance=2;//[1:25]


right_text="Makerbot";
left_text= "Glasses";
Text_Depth=2;//[1:10]
Text_Height=5;//[1:20]
Text_Distance=18;//[1:50]

//roundcornersfunction

module createMeniscus(h,radius) // This module creates the shape that needs to be substracted from a cube to make its corners rounded.
difference(){        //This shape is basicly the difference between a quarter of cylinder and a cube
   translate([radius/2+0.1,radius/2+0.1,0]){
      cube([radius+0.2,radius+0.1,h+0.2],center=true);         // All that 0.x numbers are to avoid "ghost boundaries" when substracting
   }

   cylinder(h=h+0.2,r=radius,$fn = 25,center=true);
}


module roundCornersCube(x,y,z,r)  // Now we just substract the shape we have created in the four corners
difference(){
   cube([x,y,z], center=true);

translate([x/2-r,y/2-r]){  // We move to the first corner (x,y)
      rotate(0){  
         createMeniscus(z,r); // And substract the meniscus
      }
   }
   translate([-x/2+r,y/2-r]){ // To the second corner (-x,y)
      rotate(90){
         createMeniscus(z,r); // But this time we have to rotate the meniscus 90 deg
      }
   }
      translate([-x/2+r,-y/2+r]){ // ... 
      rotate(180){
         createMeniscus(z,r);
      }
   }
      translate([x/2-r,-y/2+r]){
      rotate(270){
         createMeniscus(z,r);
      }
   }

}


//first frame
if (Square_or_Circle==0)
{
difference()
{
rotate([90,0,0])roundCornersCube(Frame_Length,Frame_Height,Frame_Depth,Rounded_shape);
rotate([90,0,0])roundCornersCube(Frame_Length-Frame_Border_Width,Frame_Height-Frame_Border_Width, Frame_Depth, Rounded_shape);


}

//second frame
difference()
{
translate([Frame_Length+Nose_Frame_Length,0,0])rotate([90,0,0])roundCornersCube(Frame_Length,Frame_Height,Frame_Depth,Rounded_shape);

translate([Frame_Length+Nose_Frame_Length,0,0])rotate([90,0,0])roundCornersCube(Frame_Length-Frame_Border_Width,Frame_Height-Frame_Border_Width, Frame_Depth, Rounded_shape);
}
//middle
translate([Frame_Length/2-Frame_Border_Width/2,-Frame_Depth/2,Frame_Height/2-Frame_Border_Width/2-Nose_Frame_Placement])cube([Nose_Frame_Length+Frame_Border_Width,Frame_Depth,Frame_Border_Width/2]);

}
else// if (Square_or_Circle=="circle")
{
difference()
{
rotate([270,0,0])linear_extrude(height=Frame_Depth)circle(Frame_Length/2);

rotate([270,0,0])linear_extrude(height=Frame_Depth)circle(Frame_Length/2-Frame_Border_Width/2);
}
difference()
{
rotate([270,0,0])translate([Frame_Length+Nose_Frame_Length,0,0])linear_extrude(height=Frame_Depth)circle(Frame_Length/2);

rotate([270,0,0])translate([Frame_Length+Nose_Frame_Length,0,0])linear_extrude(height=Frame_Depth)circle(Frame_Length/2-Frame_Border_Width/2);}

//middle
translate([Frame_Length/2-Frame_Border_Width/2,0,Frame_Height/2-Frame_Border_Width/2-Nose_Frame_Placement])cube([Nose_Frame_Length+Frame_Border_Width,Frame_Depth,Frame_Border_Width/2]);


}



//first ear
Ear_Frame_Angle=6;

translate([-Frame_Length/2,Frame_Depth/2,Frame_Height/2-Ear_Frame_Height-Ear_Frame_Distance])
cube([Frame_Border_Width/2,Ear_Frame_Length,Ear_Frame_Height]);

translate([-Frame_Length/2,Frame_Depth/2+Text_Distance,Frame_Height/2-Ear_Frame_Distance-Ear_Frame_Height/2])rotate([90,0,270])
write(right_text, t=Text_Depth, h=Text_Height, center=true);

hull()
{
//first box
translate([-Frame_Length/2,Frame_Depth/2+Ear_Frame_Length,Frame_Height/2-Ear_Frame_Height-Ear_Frame_Distance])cube([Frame_Border_Width/2,0.01,Ear_Frame_Height]);


//firstcircle, x=z,y=y, z=x
rotate([0,90,0])rotate([0,0,360-Ear_Frame_Angle])translate([Frame_Height/2-Ear_Frame_Height-Ear_Frame_Distance-10,Ear_Frame_Length+15,-Frame_Length/2+1])rotate([360+Ear_Frame_Angle,0,0])linear_extrude(height=Frame_Border_Width/2)circle(2.5);
}
hull()
{
//firstcircle, x=z,y=y, z=x
rotate([0,90,0])rotate([0,0,360-Ear_Frame_Angle])translate([Frame_Height/2-Ear_Frame_Height-Ear_Frame_Distance-10,Ear_Frame_Length+15,-Frame_Length/2+1])rotate([360+Ear_Frame_Angle,0,0])linear_extrude(height=Frame_Border_Width/2)circle(2.5);

//secondcircle
rotate([0,90,0])rotate([0,0,360-Ear_Frame_Angle])translate([Frame_Height/2-Ear_Frame_Height-Ear_Frame_Distance+4,Ear_Frame_Length+25,-Frame_Length/2+2])rotate([360+Ear_Frame_Angle,0,0])linear_extrude(height=Frame_Border_Width/2)circle(3);
}
//second ear

Ear_Frame_Angle=6;

translate([1.5*Frame_Length+Nose_Frame_Length-Frame_Border_Width/2,Frame_Depth/2,Frame_Height/2-Ear_Frame_Height-Ear_Frame_Distance])cube([Frame_Border_Width/2,Ear_Frame_Length,Ear_Frame_Height]);

translate([1.5*Frame_Length+Nose_Frame_Length,Frame_Depth/2+Text_Distance,Frame_Height/2-Ear_Frame_Height/2-Ear_Frame_Distance])rotate([90,0,90])
write(left_text, t=Text_Depth, h=Text_Height, center=true);

hull()
{
//first box
translate([1.5*Frame_Length+Nose_Frame_Length-Frame_Border_Width/2,Frame_Depth/2+Ear_Frame_Length,Frame_Height/2-Ear_Frame_Height-Ear_Frame_Distance])cube([Frame_Border_Width/2,0.01,Ear_Frame_Height]);


//firstcircle, x=z,y=y, z=x
rotate([0,90,0])rotate([0,0,360-Ear_Frame_Angle])translate([Frame_Height/2-Ear_Frame_Height-Ear_Frame_Distance-10,Ear_Frame_Length+15,Frame_Length*1.5+Nose_Frame_Length-Frame_Border_Width+4])rotate([360+Ear_Frame_Angle,0,0])linear_extrude(height=Frame_Border_Width/2)circle(2.5);
}
hull()
{
//firstcircle, x=z,y=y, z=x
rotate([0,90,0])rotate([0,0,360-Ear_Frame_Angle])translate([Frame_Height/2-Ear_Frame_Height-Ear_Frame_Distance-10,Ear_Frame_Length+15,Frame_Length*1.5+Nose_Frame_Length-Frame_Border_Width+4])rotate([360+Ear_Frame_Angle,0,0])linear_extrude(height=Frame_Border_Width/2)circle(2.5);

//secondcircle
rotate([0,90,0])rotate([0,0,360-Ear_Frame_Angle])translate([Frame_Height/2-Ear_Frame_Height-Ear_Frame_Distance+4,Ear_Frame_Length+25,Frame_Length*1.5+Nose_Frame_Length-Frame_Border_Width+2])rotate([360+Ear_Frame_Angle,0,0])linear_extrude(height=Frame_Border_Width/2)circle(3);
}

