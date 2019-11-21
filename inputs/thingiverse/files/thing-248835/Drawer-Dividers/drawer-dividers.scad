
height=12.7;				//divider height
width=50.8;			//container width
depth=50.8;			//container depth
row_dividers=4;		//# row dividers
column_dividers=4;	//# column dividers
fillet_diam=1.5;	   //fillet diameter 
wall_thickness=0.5;		//wall thickness

ff=0.001*1;				//fudge factor to create a closed manifold



union()
{

//// Dividers

	for(j = [0:row_dividers - 1])
	{
		translate([0,(depth/(row_dividers+1))+j*(depth/(row_dividers+1)),0]) cube([width,wall_thickness,height]);
	}

	for(k = [0:column_dividers - 1])
	{
		rotate([0,0,90]) translate([0,-(width/(column_dividers+1))-k*(width/(column_dividers+1)),0]) cube([depth,wall_thickness,height]);
	}

//// Fillets

	for(m = [0:column_dividers - 1])
	{
		for(n = [0:row_dividers - 1])
		{
			//// Upper right fillet
			translate([(width/(column_dividers+1))+m*(width/(column_dividers+1))-ff,(depth/(row_dividers+1))+n*(depth/(row_dividers+1))+wall_thickness-ff,0]) fillet();

			//// Upper left fillet
			translate([(width/(column_dividers+1))+m*(width/(column_dividers+1))-wall_thickness+ff,(depth/(row_dividers+1))+n*(depth/(row_dividers+1))+wall_thickness-ff,0]) rotate([0,0,90]) fillet();

			//// Lower left fillet
			translate([(width/(column_dividers+1))+m*(width/(column_dividers+1))-wall_thickness+ff,(depth/(row_dividers+1))+n*(depth/(row_dividers+1))+ff,0]) rotate([0,0,180]) fillet();

			//// Lower right fillet
			translate([(width/(column_dividers+1))+m*(width/(column_dividers+1))-ff,(depth/(row_dividers+1))+n*(depth/(row_dividers+1))+ff,0]) rotate([0,0,270]) fillet();

		}
	}

};



//////////// module definitions ///////////////////////

module fillet() 
{
	difference()
	{
		cube([fillet_diam/2,fillet_diam/2,height]);
		translate([fillet_diam/2,fillet_diam/2,0]) cylinder(h=(height+1)*2,r=fillet_diam/2,center=true,$fn=20);
	}
};