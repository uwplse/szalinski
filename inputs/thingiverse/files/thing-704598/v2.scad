
//thickness of the wall
thickness = 2 ;//[1:5]

//base tube radius
base_tube_radius = 8;//[5:20]
//space between base tubes
base_space = 10;//[0:100]

//water tube open end raduis
water_tube_raduis = 20;//[10:30]
//water tube height
water_tube_height = 20;//[10:50]

//vertical tube radius
tube_radius = 6;//[1:100]

//long tube height
long_tube_height = 40;//[1:100]
//short tube height
short_tube_height = 10;//[1:100]

//number of long tubes
number_long_tube_per_row = 4;//[0:20]
//number of short tubes
number_short_tube_per_row = 0;//[0:20]
//number of rows
rows = 4;//[2:20]

//space between two tubes
tube_space = 10;//[-10:100]



module tube(r,len){
	linear_extrude(height=len)
		circle(r);
}

module water_tube(or,er,h){
	hull(){
		translate([0,0,h]) linear_extrude(height=1)
			 circle(or);
		linear_extrude(height=1)
			circle(er);	
	}
}


module cap(r){
	difference(){
		sphere(r);
		translate([-1.5*r,-1.5*r,-r*3]) cube(r*3);
	}	
}

module tube_row(tr,ts,nlt,nst,lth,sth,wtr,wth,btr,is_main,btl,wtos,stos){
	
	for(i=[0:1:nlt+nst-1])
		translate([i*(tr*2+ts)+tr+stos,0,0]) 
			if(i<nst) tube(tr,sth);
			else tube(tr,lth);

	if(is_main)
		translate([btl-wtos+1,0]) 
				water_tube(wtr,tr,wth);	
	
	rotate([0,90,0]) tube(btr,btl);			
	
	rotate([0,-90,0]) cap(btr);
	translate([btl,0,0]) rotate([0,90,0]) cap(btr);
			
}

module fill(nlt,nst,str,ts,btr,bs,nr,lth,sth,wtr,wth,mbtl,btl,wtos,stos){
	translate([btl/2,0,0]) 
		rotate([-90,0,0]) 
			tube(btr,(btr*2+bs)*(nr-1));

	for(i=[0:1:nr-1])
		translate([0,i*(btr*2+ bs),0])
			if(i==0)
				tube_row(
					str,
					ts,
					nlt,
					nst,
					lth,
					sth,
					wtr,
					wth,
					btr,
					i==0,				
					mbtl,
					wtos,
					stos				
				);
			else
				tube_row(
					str,
					ts,
					nlt,
					nst,
					lth,
					sth,
					wtr,
					wth,
					btr,
					i==0,									
					btl,
					wtos,
					stos
				);
}

difference(){
	fill(
		number_long_tube_per_row,
		number_short_tube_per_row,
		tube_radius+thickness,
		tube_space,
		base_tube_radius+thickness,
		base_space,
		rows,
		long_tube_height,
		short_tube_height,
		water_tube_raduis+thickness,
		water_tube_height,
		(number_long_tube_per_row+number_short_tube_per_row)*(tube_radius*2+thickness*2+tube_space)-tube_space+water_tube_raduis*2+thickness*2,
		(number_long_tube_per_row+number_short_tube_per_row)*(tube_radius*2+thickness*2+tube_space)-tube_space,
		water_tube_raduis+thickness,
		0
	);
	translate([0,0,0]) fill(
		number_long_tube_per_row,
		number_short_tube_per_row,
		tube_radius,
		tube_space+thickness*2,
		base_tube_radius,
		base_space+thickness*2,
		rows,
		long_tube_height,
		short_tube_height,
		water_tube_raduis,
		water_tube_height,
		(number_long_tube_per_row+number_short_tube_per_row)*(tube_radius*2+thickness*2+tube_space)-tube_space+water_tube_raduis*2+thickness*2,
		(number_long_tube_per_row+number_short_tube_per_row)*(tube_radius*2+thickness*2+tube_space)-tube_space,
		water_tube_raduis+thickness,
		thickness
	);
}
