// export each separately
// box_lid(_h,_w,_d);
// box_lower(_h,_w,_d, _hasCutout);

// define card size
// Ex: MTG with sleeves 93, 67, 44
// height in mm
_h = 93;  
// width in mm
_w = 67;   
// depth/how thick is the pile of cards in mm
_d = 44 ;
// should the bottom have a cutout?
_hasCutout = 1;  // [1:yes,0:no] 
// should this thing render the top/lid of the box
_include_top = 1;  // [1:yes,0:no]
// should this thing render the bottom of the box
_include_bottom = 1;  // [1:yes,0:no]
// when rendering both top and bottom, include spacing between objects (in mm).
_object_spacing = 4;  


// cut out will save on printing material and time

//     _________________
//    /                /|
//   /                d |
//  /                /  |
// ------------------   |
// |                |   |
// |                |   |
// |                |   |
// |                h   |
// |                |   |
// |                |   |
// |                |  /
// |                | /
// |                |/
// ---------w--------




module inner_dim(h,w,d)
{
	translate([.6,0,0]) cube([h + 0.1,w,d],center=true);
	
}

module outer_dim(h,w,d)
{
	cube([h + 1.2,w + 2.4,d + 2.4],center=true);

}
module outer_lid(h,w,d)
{
	h_mod = h;
	w_mod = w + 0.5;
	d_mod = d + 0.5;
	cube([h_mod + 2.4, w_mod + 4.8,d_mod + 4.8],center=true);
	
}


module cutout(h,w,d)
{
	scale([(h/2),(w/2),1]) rotate([0,0,45]) cube([1,1,5], center=true);

}

module box_lower(h,w,d,hasCutout)
{
	difference()
	{
		outer_dim(h,w,d);
		inner_dim(h,w,d);
		translate([h/2,0,0]) 
			rotate([90,0,0]) 
				cylinder(w+40, d=d/1.5, center=true);
		
		if(hasCutout)
		{
			translate([0,0,d/2]) cutout(h,w,d);
			translate([0,0,-d/2]) cutout(h,w,d);
		}
	}

}

module box_lid(h,w,d)
{
	difference()
	{
		outer_lid(h,w,d);
		translate([.6,0,0]) outer_dim(h + .1,w+.5,d + .5);
		translate([h/2,0,0]) 
			rotate([90,0,0]) 
				cylinder(w+40, d=d/1.5, center=true);
	}
	
}

// control output for customizer
module output_top()
{
    rotate([0,-90,0]) box_lid(_h,_w,_d);
}

module output_bottom()
{
    translate([0,0,-(1.2/2)]) rotate([0,-90,0]) box_lower(_h,_w,_d, _hasCutout);
}

if(_include_top == 1 && _include_bottom == 1)
{
    translate([-(_d/2) - 2 - _object_spacing,0,0]) output_top();
    translate([(_d/2) + 2 + _object_spacing,0,0]) output_bottom();
}
else if(_include_top == 1)
{
    output_top();
}
else
{
    output_bottom(); 
}


//output_top();

//translate([30,0,0]) rotate([0,-90,0]) box_lid(_h,_w,_d);
//translate([-30,0,0])  rotate([0,-90,0]) box_lower(_h,_w,_d, _hasCutout);










