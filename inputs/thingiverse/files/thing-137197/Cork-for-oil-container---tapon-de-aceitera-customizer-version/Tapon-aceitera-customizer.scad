$fn=100*1;

//larger width radius (half the diameter)
radius1=14.5; 

//shorter width radius (half the diameter)
radius2=12.25; 

// height
height=21.4; 

//angle for the air hole
angle=atan((radius1-radius2)/height);

difference(){
	cylinder(h=height,r1=radius1, r2=radius2, center=true);
		translate([0,(radius1+radius2)/2-3,0])rotate([angle,0,0])cylinder(h=height+10,r=1, center=true);

}