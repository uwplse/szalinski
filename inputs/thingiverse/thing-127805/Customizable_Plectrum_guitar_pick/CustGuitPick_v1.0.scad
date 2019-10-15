// customizable plectrum

tip_radius=2.7;
hip_radius=4.9;
width=25;
length=30;
bevel=.95;
tip_height=1;
hole="yes"; //[yes,no]
hole_radius=2.7;
resolution=64;

height=7;
// actual height of final object is determined by tip height and bevel angle.  
// if height variable is too low, there will be flats at the thick parts, 
// and the final object will not sit flat on the build platform.

$fn=resolution;

//place flat at origin
rotate ([bevel, 0, 0])
translate ([0, 0, tip_height/2-height/2])

difference(){
hull (){
cylinder (r=tip_radius, h=height);
translate ([-width/2+hip_radius, length-hip_radius-tip_radius, 0])
 cylinder (r=hip_radius, h=height);
translate ([width/2-hip_radius, length-hip_radius-tip_radius,0])
 cylinder (r=hip_radius, h=height);
 }

//cut top and bottom faces
rotate ([bevel, 0, 0])
 translate ([-width/2-1, -tip_radius-1, height/2+tip_height/2])
  cube ([width+2, length+2, height/2]);
rotate ([-bevel, 0, 0])
 translate ([-width/2-1, -tip_radius-1, -tip_height/2])
  cube ([width+2, length+2, height/2]);

//optional hole
if (hole=="yes"){
translate ([width/2-hip_radius, length-hip_radius-tip_radius, 0])
 cylinder (r=hole_radius, h=height);}
}
