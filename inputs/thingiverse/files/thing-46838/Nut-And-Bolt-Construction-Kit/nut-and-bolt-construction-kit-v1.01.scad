/*
Nut and Bolt Construction Kit, library and customiser code
By the DoomMeister
v1.0

>>>Parts to be implimented
Rectangle Plate n x n, v1.0
Circular Plate, v1.0
L_beam, v1.0
angle beam, v1.0 (scruffy a<90)
Free Shape Plate -- to follow
Wheel, v1.0
Pully, v1.0
Gears -- to follow
>>>tweakable Parameter
Hole Size
Hole ratio
Clearance
Pulley Cord diameter
>>>>Changes
v1.01, hole size now free entry
*/

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Customiser Code
//For Library use comment this and the section bellow out
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
///*
							//shape of part	
							shape = "plate";	// [plate,L_plate,angle_plate,round_plate,wheel,pully]
							//holes across, also used to determine size of round plate and gear
							x_holes=3;				//	
							//holes in the up down direction
							y_holes= 2;				//
							//holes on L plate side
							z_holes = 2;			//
							//of angle beam, or between holes on circle
							angle = 120;				// 
							//thickness of part
							thickness = 2;			//
							//size of screws and rod used
							screw_diameter = 3;	//
							//tweak,distance between holes in diameters
							hole_ratio = 1;		//
							//cord diameter for pullys
							cord_diameter = 1.5;  //
							//tweak, clearance on holes
							clearance = 0.5;		//[0.1:1]
							//tweak, round or square corners
							round_corners = "yes";	//[yes,no]
							//tweak, corner quality, nuber of facets
							quality = 20;  		//[10,25,50,100]
							
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Test Section, draws the part. 
//For Library use follow this structure in your own code
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
construction_set_part(		_shape = shape, 
							nx = x_holes, 
							ny = y_holes, 
							nz = z_holes,
							ang = angle,
							hd = screw_diameter,
							hr = hole_ratio,
							thk = thickness, 
							clr = clearance,
							corners = round_corners,
							qul = quality,
							crdd = cord_diameter);

//*/ 
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Outer Module, does the selection work
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
module construction_set_part(_shape = "rectangle", nx = 4, ny = 2,nz= 0, ang = 90, hd = 3,hr = 2,thk = 2,clr = 0.5, corners = "yes", crdd, qul = 10)
{
	echo(_shape,nx,ny,nz);
	if	(_shape=="plate")
		{
			color("red")
			plate_rectangle(_nx = nx, _ny = ny,_nz = 0, _hd = hd, _hr = hr,_thk = thk,_clr = clr, _corners=corners, _qul = qul);
		}
	if	(_shape=="L_plate")
		{
			color("green")
			plate_rectangle(_nx = nx, _ny = ny,_nz = nz,_ang=90, _hd = hd, _hr = hr,_thk = thk,_clr = clr, _corners=corners, _qul = qul);
		}
	if	(_shape=="angle_plate")
		{
			plate_angle(_nx = nx, _ny = ny,_nz = nz,_ang=ang, _hd = hd, _hr = hr,_thk = thk,_clr = clr, _corners=corners, _qul = qul);
		}
	if	(_shape=="round_plate")
		{
			color("blue")
			plate_round(_nx = nx, _ny = ny,_nz = nz,_ang = ang, _hd = hd, _hr = hr,_thk = thk,_clr = clr, _corners=corners, _qul = qul);
		}
	if	(_shape=="wheel")
		{
			color("purple")
			wheel(_nx = nx, _ny = ny,_nz = nz,_ang = ang, _hd = hd, _hr = hr,_thk = thk,_clr = clr, _corners=corners,_pully = false, _crrd=0, _qul = qul);
		}
	if	(_shape=="pully")
		{
			color("pink")
			wheel(_nx = nx, _ny = ny,_nz = nz,_ang = ang, _hd = hd, _hr = hr,_thk = thk,_clr = clr, _corners=corners,_pully = true, 				_crdd=crdd, _qul = qul);
		}
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Inner Modules, draws the parts
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

module plate_rectangle(_nx = 4, _ny = 1,_nz=0,_ang=90, _hd = 3, _hr = 2,_thk = 2,_clr = 0.5, _corners="yes", _qul = 10)
{
//module to draw flat plates and L beams.
_wi = _hd * (_hr+1);
_w = _wi * _nx;
_h = _wi * _ny;
_z = (_wi * _nz)+(_thk*(_nz/_nz));
echo("build area required(x\y\z)",_w,_h,_z);

union()
	{
		_plate_rectangle(__nx = _nx, __ny = _ny, __hd = _hd, __hr = _hr,__thk = _thk,__clr = _clr, __corners=_corners, __qul = _qul);
		if(_nz>0)
			{
				translate([0,0,_thk])
				rotate([90,0,0])
					_plate_rectangle(__nx = _nx, __ny = _nz, __hd = _hd, __hr = _hr,__thk = _thk,__clr = _clr, __corners=_corners, __qul = _qul);
				translate([0,-_thk,0])
					cube([_w,_thk,_thk]);
				translate([0,-_thk,0])
					cube([_thk,_thk+_hd/2,_thk]);
				translate([0,-_thk,0])
					cube([_thk,_thk,_thk+_hd/2]);
				translate([_w-_thk,-_thk,0])
					cube([_thk,_thk+_hd/2,_thk]);
				translate([_w-_thk,-_thk,0])
					cube([_thk,_thk,_thk+_hd/2]);
			}

	}

}

module plate_angle(_nx = 4, _ny = 1,_nz=0,_ang=90, _hd = 3, _hr = 2,_thk = 2,_clr = 0.5, _corners="yes", _qul = 10)
{
//module to draw flat plates and L beams.
_wi = _hd * (_hr+1);
_w = _wi * _nz;
_h = _wi * _ny;
_z = (_wi * _nz)+(_thk*(_nz/_nz));
_xl = _thk*tan(90-_ang/2);
_xm = (_thk*sin(_ang/2));
_xn = _thk*cos(_ang/2);
echo("build area required(x\y\z)",_w,_h,_z,_xl);

union()
	{
		
		rotate([0,270,-_ang/2])
		translate([0,0,-_thk])
			_plate_rectangle(__nx = _nz, __ny = _nx, __hd = _hd, __hr = _hr,__thk = _thk,__clr = _clr, __corners=_corners, __qul = _qul);
		translate([0,0,0])
		rotate([0,270,_ang/2])
			_plate_rectangle(__nx = _nz, __ny = _ny, __hd = _hd, __hr = _hr,__thk = _thk,__clr = _clr, __corners=_corners, __qul = _qul);
	if(_ang>90)
		{
		rotate([0,270,-_ang/2])
		translate([0,-_xl,-_thk])
			cube([_w,_hd/2+_xl,_thk]);
		rotate([0,270,_ang/2])
		translate([0,-_xl,0])
			cube([_w,_hd/2+_xl,_thk]);
		}

	if(_ang<90)
		{
			translate([-_xn,-_xm,0])
				cube([(_xn)*2,_xm,_w]);
			
			cylinder(r=(_wi-_hd)/3, h=_w, $fn=_qul);
		}

	}

}


module plate_round(_nx = 4, _ny = 1,_nz=0,_ang = 90, _hd = 3, _hr = 2,_thk = 2,_clr = 0.5, _corners="yes", _qul = 10)
{
//module to make round plate with n holes at specified angle
_wi = _hd * (_hr+1);
_w = _wi * _nx;
_h = _wi * _ny;
_eff_d = _w-(_hd*2);
_c = 3.142 *_eff_d;
_nh = 360 / _ang;
_ha = 360/_nh;

echo("Build area (xyz)", _w,_w,_eff_d,_nh,_c);

difference()
	{
	cylinder(r=_w/2, h=_thk, $fn=_qul);
	for(nh = [0:_nh-1])
		{
			for( ri = [0:round(_nx/2)])
			{
			rotate([0,0,nh*_ha])
			translate([ri*_wi,0,-1])
				cylinder(r=(_hd+_clr)/2, h = _thk+2, $fn=_qul);
			}

		}
			/*translate([0,0,-1])
				cylinder(r=(_hd+_clr)/2, h = _thk+2, $fn=_qul);*/
	}
}


module wheel(_nx = 4, _ny = 1,_nz=0,_ang = 90, _hd = 3, _hr = 2,_thk = 2,_clr = 0.5, _corners="yes",_pully=false,_crdd=1, _qul = 10)
{
//module to make wheels and pulleys
_wi = _hd * (_hr+1);
_w = _wi * _nx;
_cr = _thk*1;


echo("Build area (xyz)", _w+(2*_cr),_w+(2*_cr),2*_cr);

difference()
	{
		union()
		{
			translate([0,0,-_cr])
			cylinder(r=_w/2, h=_thk, $fn=_qul);
			translate([0,0,-_cr])
			cylinder(r=(_hd+_clr), h = _thk +_cr, $fn=_qul);
			rotate_extrude(convexity = 10)
			translate([_w/2,0,_cr])
			//rotate([90,0,0])
				circle(r = _cr, $fn=_qul);

		}
			if(_pully)
				{
					rotate_extrude(convexity = 10)
					translate([(_w+_cr)/2,0,_cr])
						circle(r = (_crdd)/2, $fn=_qul);
					rotate_extrude(convexity = 10)
					translate([(_w+_cr)/2,-_crdd/2,0])
						square([_crdd+_cr,_crdd]);
				}

			translate([0,0,-_cr-1])
				cylinder(r=(_hd+_clr)/2, h = _thk+2+_cr, $fn=_qul);
	}
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Support Modules, draws bits of the parts
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
module hole(_id = 3, _od = 6,__thk = 2,__qul = 10)
{
_ir = _id/2;
_or = _od/2;

	difference()
	{
		cylinder(r = _or, h=__thk, $fn = __qul);
		translate([0,0,-1])
			cylinder(r = _ir, h=__thk+2, $fn = __qul);
	}
}

module _plate_rectangle(__nx = 4, __ny = 1, __hd = 3, __hr = 2,__thk = 2,__clr = 0.5, __corners="yes", __qul = 10)
{
//module to draw flat plates and L beams.
__wi = __hd * (__hr+1);
__w = __wi * __nx;
__h = __wi * __ny;

	difference()
	{	
		if (__corners=="yes")
		{
			union()
			{
				minkowski()
				{
					cube([__w-__hd,__h-__hd,__thk/2]);
					translate([__hd/2,__hd/2,0])
						cylinder(r = __hd/2, h = __thk/2, $fn = __qul);
				}}



		}
		if (__corners=="no")
		{
			union()
			{
				cube([__w,__h,__thk]);

			}
		}
		for
			( y = [0:__ny-1])
			{
			for( x = [0:__nx-1])
			{
				#translate([__wi/2+(x*__wi),__wi/2+(y*__wi),-1])
					cylinder(r = (__hd + __clr)/2, h = __thk + 2, $fn = __qul);
			}}
	}

}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Dev Modules, not working yet
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
module plate_free(_nx = 4, _ny = 1,_nz=0, _hd = 3, _hr = 2,_thk = 2,_clr = 0.5, _corners="yes", _qul = 10)
{
//atempt to build a plate of any rows
_wi = _hd * (_hr+1);
_w = _wi * _nx;
_h = _wi * _ny;
_z = (_wi * _nz)+(_thk*(_nz/_nz));
echo("build area required(x\y\z)");

		union(){
		for(yi= [0:4-1])
		{
			for(xi = [1,3,4,2,3,4,2])
			{
			for(i= [	[_wi*xi,_wi*yi],
					
					])
			{
				translate(i)
						hole(_id=_hd+_clr, _od=_wi, __thk = _thk, __qul = _qul);
			}}}
		}
}