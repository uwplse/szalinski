//$fn = 20;

box_h = 23.5;
box_w = 26.5;
box_l = 58.5;
wall = 3;
density = 8;
seed = 7878;
useframe = true;

seed_vect = rands(1,10000,12,seed);


edge1 = rands(0,box_l, density, seed_vect[1]);
edge2 = rands(0,box_l, density, seed_vect[2]);
edge3 = rands(0,box_l, density, seed_vect[3]);
edge4 = rands(0,box_l, density, seed_vect[4]);

edge5 = rands(0,box_w, density, seed_vect[5]);
edge6 = rands(0,box_w, density, seed_vect[6]);
edge7 = rands(0,box_w, density, seed_vect[7]);
edge8 = rands(0,box_w, density, seed_vect[8]);

edge9 = rands(0,box_h, density, seed_vect[9]);
edge10 = rands(0,box_h, density, seed_vect[10]);
edge11 = rands(0,box_h, density, seed_vect[11]);
edge12 = rands(0,box_h, density, seed_vect[12]);
union()
{
union()
{
	for ( i = [1 : density] )
	{
   cyl_by_coord(edge1[i],0,0,edge2[i],0,box_h,wall);
	cyl_by_coord(edge2[i],0,box_h,edge3[i],box_w,box_h,wall);
	cyl_by_coord(edge3[i],box_w,box_h,edge4[i],box_w,0,wall);
	cyl_by_coord(edge4[i],box_w,0,edge1[i],0,0,wall);
	}
}

if (useframe)
{
	union()
	{
	cyl_by_coord(0,0,0,box_l,0,0,wall);
	cyl_by_coord(box_l,0,0,box_l,box_w,0,wall);
	cyl_by_coord(box_l,box_w,0,0,box_w,0,wall);
	cyl_by_coord(0,box_w,0,0,0,0,wall);
	cyl_by_coord(0,0,0,0,0,box_h,wall);
	cyl_by_coord(0,0,box_h,box_l,0,box_h,wall);
	cyl_by_coord(box_l,0,box_h,box_l,box_w,box_h,wall);
	cyl_by_coord(box_l,box_w,box_h,0,box_w,box_h,wall);
	cyl_by_coord(0,box_w,box_h,0,0,box_h,wall);
	cyl_by_coord(box_l,0,0,box_l,0,box_h,wall);
	cyl_by_coord(box_l,box_w,0,box_l,box_w,box_h,wall);
	cyl_by_coord(0,box_w,0,0,box_w,box_h,wall);
	}
}
}





function dist(x1, y1, z1, x2, y2, z2) = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) +(z1 - z2) * (z1 - z2) );

module cyl_by_coord(x1, y1, z1, x2, y2, z2, dia)
{
	clen = dist(x1, y1, z1, x2, y2, z2);
	dx = x2 - x1;
	dy = y2 - y1;
	dz = z2 - z1;

	angb = acos( dz / clen);
	angc = ( dx == 0) ? 
		sign( dy )* 90 : (( dx > 0) ? atan(dy/dx) : atan(dy/dx)+180 );

	translate([ x1 , y1 , z1 ])
	rotate([0 , angb , angc])
	{
		//union()
		{
		cylinder(h = clen, r = dia / 2, center = false);
 		//translate([0,0,clen])
			//sphere(dia / 1.5);
		//translate([0,0,0])
			//sphere(dia / 1.5);
		}
	}
}
