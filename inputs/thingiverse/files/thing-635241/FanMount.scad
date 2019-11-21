//Rod Diameter
diameter=8.1 ;
//height of everything
height=8;
// Distance of the Fan from the middel of the Rod Y-direction
leangth=117.5;
//Distance of the mounting hole to the middel of the Rod in X direction ( not adjusted for clipangel different from 0)
width=62.5;
//angle of the Frame Rods, Mendel has 60° (change this to adjust the angle of the fan if you wnat to point it on the print bed)
rodangel=60;
//angle of the Clip, maybe you want to Fnas to mount like a V
clipangel=0;
//Ratio of the FrameMount Cutout
cutoutRatio=0.7;
//Fanwidth
fanwidth=26; 
//Leagth of the Grip arms, has to be smaller than width
gripleangth=17;


//making the grib module longer when changing the angel of the rod
mountleangth=diameter*1.5+cos(rodangel)*height*2.5;


module grip()
{
translate ([0,-(mountleangth)/2,0])difference()
	{	
	translate([-diameter*3/4,-mountleangth/2,-height/2]) //block
		cube([diameter*3/2,mountleangth,height]);
	
	rotate([-90-rodangel,0,0]) cylinder(h=height*6, r=diameter/2,center=true,$fn=30); //Rod Cutout
	rotate([-90-rodangel,0,0])translate([-diameter*cutoutRatio/2,0,-20]) cube([diameter*cutoutRatio, 40,40]); //Entry Cutout
	}
}

module arm()
{
translate([0,0,-height/2])union()
	{
	translate([-height/4,0,0])cube([height/2,leangth-mountleangth/2+fanwidth/2,height]);
	translate([0,leangth-mountleangth/2-height/4+fanwidth/2,0])cube([width-gripleangth,height/2,height]);
	translate([height/6,leangth-mountleangth/2-height/6+fanwidth/2,0]) cylinder(h=height,r=height/2,$fn=30 );
	translate([width-gripleangth,leangth-mountleangth/2+fanwidth/2,0]) cylinder(h=height,r=height/2,$fn=30 );
	}
}

module clip()
{ translate([width-gripleangth,leangth-mountleangth/2+fanwidth/2,0]) rotate([0,0,clipangel])union(){
mirror([0,1,0]) halfclip();
halfclip();
}}

module halfclip()
{
	translate([0,-(fanwidth)/2,-height/2])union()
	{
	cube([height/2,(fanwidth)/2,height]);
	translate([0,-height/4,0])cube([gripleangth+5,height/4,height]);
	translate([gripleangth, 0, height/2])rotate([-90,0,0])cylinder(h=2.1,r=2,$fn=30);
	}
	

}

module whole()
{union(){
grip();
arm();
clip();
}
}

whole();
translate([-20,0,0]) mirror([1,0,0]) whole();