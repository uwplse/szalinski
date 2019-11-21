//overall width of clip, in mm, measure hardhat slot, 25mm minimum
clip_width=30; 

//Diameter of flashlight, in mm, 21.2 for Sipik SK-68 cloen
diam=21.2;

//Thickness of clip, in mm
thickness=2;

//length of release tab, in mm
release_tab_length=5;

//size of nut trap, 6mm max
nut_trap_size=5.3;

//size of screw holes
screw_hole_size=4.6;

module insertion_tabs() //tabs at mouth of clip (draws a big wide triangle
{
polygon([[0,0],[50,50*sqrt(3)],[50,-50*sqrt(3)]],[[0,1,2]]);
}

module insertion_tabs_trim() //trims off big triangle leaving the two tabs
{
translate([(thickness/2)*sqrt(3),0])
{
polygon([[0,0],[50,50*sqrt(3)],[50,-50*sqrt(3)]],[[0,1,2]]);
}
difference()
{
circle(r=100);
circle(r=(diam/2)+thickness+release_tab_length);
}
}




module clamp() //draws clamp section
translate([-(diam/2)-thickness,-2.5,0])
{
difference()
{
square([22,17],center=true);
translate([-3,2.5,0])
{
square([6,12],center=true);
}
}
}


module nut_trap()
{
union()
{
translate([-(diam/2)-thickness-6-3.3,0,7])
{
rotate(90,[0,1,0])
{
linear_extrude(height=3.4)
{
circle(r=nut_trap_size,$fn=6);
}
}
}

translate([-(diam/2)-thickness-6-3.3,0,clip_width-7])
{
rotate(90,[0,1,0])
{
linear_extrude(height=3.4)
{
circle(r=nut_trap_size,$fn=6);
}
}
}
}
}


module clamp_holes()
{
union()
{
translate([-(diam/2)-thickness-6-6,0,7])
{
rotate(90,[0,1,0])
{
linear_extrude(height=6)
{
#circle(r=screw_hole_size/2);
}
}
}

translate([-(diam/2)-thickness-6-6,0,clip_width-7])
{
rotate(90,[0,1,0])
{
linear_extrude(height=6)
{
#circle(r=screw_hole_size/2);
}
}
}
}
}



//main body
difference()
{
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
			
		}	
		insertion_tabs_trim();
		circle(r=(diam/2));
	}
difference()
{
clamp();
circle(r=(diam/2));
}
}
}
nut_trap();
clamp_holes();
}

