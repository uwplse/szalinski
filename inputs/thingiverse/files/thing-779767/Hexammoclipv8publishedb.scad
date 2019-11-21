//Published under the creative commons license, share and share alike.
//My thanks to all who have contributed to the versions of openscad and modules/addins for it. Without you this would not have been possible.

//Nerf Gun Bullet Holder
//parameters

Max_bullets = 7;
clip_interval = 1;
name1 ="SIMON";
name2 ="BELT";
name3 ="AMMO";
unit_width =22.0;
unit_height =25;
total_length=unit_width*Max_bullets;
face_length=unit_width-2*unit_width/4;
echo ("face length =", face_length);
echo ("total length =",total_length);
echo ("hex size =",2*(unit_width/2-cordface_diff));
letterheight = (Max_bullets <3) ? 5:5;
clip_gap = 2.5;
cordface_diff =unit_width/2-sqrt((pow(face_length,2))-(pow(unit_width/4,2))); 
echo ("cordface difference =",cordface_diff);
hex_gap = 18; //distance between the hexes
joint_thickness = 6; //thickness of the joint material
cylinder_oheight = 4; //height of outer cylinder, over the top
cylinder_iheight = 3.2;//height of the inside of the cylinder
clearance = 1; //clearance between parts of the joint
overlap = 2; //overlap between the hex and the joint
kd=unit_width/2+hex_gap/2-overlap;
angle = 40;
if  (Max_bullets % 2 == 0){echo ("even length");} else { echo ("odd length");}

//libraries

use <Write.scad>


SmartElongate ();
		
module First () {
union() {
		translate ([0,0,0])clip ();
		translate([unit_width/2-overlap+hex_gap/2,0,0]) left ();
		translate([0,cordface_diff-unit_width/2-0.5,unit_height/2])rotate ([-90,90,180])write (name1,t=1.3, h=letterheight, font = "orbitron.dxf", center=true);
		
		difference(){
			translate ([0,0,0])cylinder (h=unit_height,r=unit_width/2,$fn=6);
			translate ([0,0,0])cylinder (h= unit_height, r=7,  $fn =100);
				}
		
		translate ([0,0,unit_height/2])
			 for (i=[0:11]){
				rotate(i*360/12,[0,0,1])translate ([7,0,0]) sphere (r=1);
					}
					}
					}

module Last() {
	translate ([0,kd,0])
	rotate ([0,0,90])
union() {
		translate ([0,0,0])clip ();
		translate([-unit_width/2+overlap-hex_gap/2,0,0]) right ();
		translate([0,cordface_diff-unit_width/2-0.5,unit_height/2])rotate ([-90,90,180])write (name2,t=1.3, h=letterheight, font = "orbitron.dxf", center=true);
		difference(){
			translate ([0,0,0])cylinder (h=unit_height,r=unit_width/2,$fn=6);
			translate ([0,0,0])cylinder (h= unit_height, r=7,  $fn =100);
				}
		
		translate ([0,0,unit_height/2])
			 for (i=[0:11]){
				rotate(i*360/12,[0,0,1])translate ([7,0,0]) sphere (r=1);
					}
					}
					}


module Bulletsubunit(){
	translate ([0,kd,0])
	rotate ([0,0,90])
	union() {
		translate ([0,0,0])clip ();
		translate([unit_width/2-overlap+hex_gap/2,0,0]) left ();
		translate([-unit_width/2+overlap-hex_gap/2,0,0]) right ();
		translate([0,cordface_diff-unit_width/2-0.5,unit_height/2])rotate ([-90,90,180])write (name3,t=1.3, h=letterheight, font = "orbitron.dxf", center=true);
		difference(){
			translate ([0,0,0])cylinder (h=unit_height,r=unit_width/2,$fn=6);
			translate ([0,0,0])cylinder (h= unit_height, r=7,  $fn =100);
				}
		translate ([0,0,unit_height/2])
			 for (i=[0:11]){
				rotate(i*360/12,[0,0,1])translate ([7,0,0]) sphere (r=1);
					}
					}
					}
				

module clip (){
	union() {			
	translate ([-face_length/2,unit_width/2-cordface_diff+clip_gap+1,0]) cube(size=[face_length,2,25], center = false);//the back piece
	translate ([-face_length/2,unit_width/2-cordface_diff,23]) cube(size=[face_length,clip_gap+3,2], center = false);// the top piece
	translate ([-face_length/2,unit_width/2+clip_gap-cordface_diff,0]) cube(size=[face_length,1.5,2], center = false);//the bottom piece

			}
}
module joint (angle=55) {
	
		union () {
			rotate ([0,0,angle]) translate ([0,0,0]) right ();
			left ();
}}
module right (){
	difference () {
		union () {
			translate ([0,-joint_thickness/2,(cylinder_oheight+clearance)])cube (size = [hex_gap/2,joint_thickness,unit_height-2*cylinder_oheight-2*clearance], center = false);
			translate ([0,0,cylinder_oheight+clearance]) cylinder (r=5,h=unit_height-2*cylinder_oheight-2*clearance, $fn=50);}
		   translate ([0,0,cylinder_oheight+clearance])cylinder (r=3.9,h=unit_height-2*cylinder_oheight-2*clearance, $fn=50);
}}

module left (){
		union (){
		translate ([0,0,0]) cylinder (r=3.4, h=(unit_height), $fn=50);
		translate ([-hex_gap/4,0,cylinder_oheight/2])cube (size = [hex_gap/2,joint_thickness,cylinder_oheight], center = true);
		translate ([-hex_gap/4,0,unit_height-cylinder_oheight/2])cube (size = [hex_gap/2,joint_thickness,cylinder_oheight], center = true);
}}
function Getangle (a) = lookup (a,[[1,0],[2,45],[3,80.2644],[4,110.264],[5,136.829],[6,160.924],[7,183.132],[8,203.837],[9,223.308],[10,241.743],[11,259.291],[12,276.07],[13,292.172],[14,307.673]]);


function sumv(v,i,s=0) = (i==s ? v[i] : v[i] + sumv(v,i-1,s));

vec= [0, asin(1/sqrt(2)),asin(1/sqrt(3)),asin(1/sqrt(4)),asin(1/sqrt(5)),asin(1/sqrt(6)),asin(1/sqrt(7)),asin(1/sqrt(8)),asin(1/sqrt(9)),asin(1/sqrt(10)),asin(1/sqrt(11) )];

module SmartElongate () {
			translate ([2*kd,-kd,0])rotate([0,0,90])First ();
			for (i=[0:Max_bullets-3]){ 
									echo (sumv(vec,i,0));
									rotate ([0,0,sumv(vec,i,0)])translate ([sqrt(i+1)*2*kd,0,0])Bulletsubunit();}
			rotate ([0,0,sumv(vec,Max_bullets-2,0)])translate ([sqrt(Max_bullets-1)*2*kd,0,0])Last ();}


