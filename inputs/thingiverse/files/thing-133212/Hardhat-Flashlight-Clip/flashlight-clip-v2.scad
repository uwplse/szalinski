//overall width of clip, in mm, measure hardhat slot
clip_width=30; 

//Diameter of flashlight, in mm
diam=21.2;

//Thickness of clip, in mm
thickness=2;

//length of release tab, in mm
release_tab_length=5;

//Locking clip angle, in degrees; More angle = tighter/"snappier" fit
locking_clip_angle=15;

//Adjust this larger to reach deeper into hard hat slot
locking_clip_reach=13;

//Width of barb, in mm: Wider barb = more secure locking action
locking_clip_barb_size=2;




module insertion_tabs() //tabs at mouth of clip (draws a big wide triangle
{
polygon(points=[[0,0],[50,50*sqrt(3)],[50,-50*sqrt(3)]],path=[[0,1,2]]);
}

module insertion_tabs_trim() //trims off big triangle leaving the two tabs
{
translate([(thickness/2)*sqrt(3),0])
{
polygon(points=[[0,0],[50,50*sqrt(3)],[50,-50*sqrt(3)]],path=[[0,1,2]]);
}
difference()
{
circle(r=100);
circle(r=(diam/2)+thickness+release_tab_length);
}
}

module brace() //adds a little fillet between circle and tab
{
translate([-(diam/2)-thickness,-0.38*diam,0])
{
rotate(-55,[0,0,1])
{
square([2,7]);
}
}
}

module clip_segment1() //draws first half of tongue
{
translate([-(diam/2)-(thickness-1),-7.5,0])
{
square([2,20], center=true);
}
}


module clip_segment2() //draws second(bent) half of tongue
{
translate([-(diam/2)-(thickness-1)-(0.5*locking_clip_reach*sin(locking_clip_angle)),-(17+(0.5*locking_clip_reach*cos(locking_clip_angle))),0])
{
rotate(-locking_clip_angle,[0,0,1])
{
square([2,locking_clip_reach], center=true);
polygon(points=[[-1,-(locking_clip_reach/2)],[-1,-(locking_clip_reach/2)+5],[-1-locking_clip_barb_size,-(locking_clip_reach/2)+5]],paths=[[0,1,2]]);
}
}
}

//main body
linear_extrude(height=clip_width)
{
union()
{
difference()
{
	union()
	{
		circle(r=(diam/2)+thickness);
		insertion_tabs();
		brace();	
}	
circle(r=(diam/2));
insertion_tabs_trim();
}
clip_segment1();
clip_segment2();

}
}