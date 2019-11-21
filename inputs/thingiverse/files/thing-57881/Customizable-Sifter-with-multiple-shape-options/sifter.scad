
//Choose which mode to work in. Unfortunately the preview cannot handle the large number of holes needed for the sifter inserts.  In Design mode only a few holes will be created. In Design 2 mode all holes will be shown in "debug mode" which means they appear as translucent grey objects. Switch to Final mode when you are ready to output an STL file.  The preview will likely not show everything correctly, but the STL will be fine.
mode="Design";//[Design,Design 2,Final]


//What to include in STL
include="Both";//[Cup,Inserts,Both]

//Overall shape of sifter
cup_shape=6;//[3:Triangle,4:Square,5:Pentagon,6:Hexagon,60:Circle]

//Units for below inputs (mm or inches)
units=1;//[1:mm,25.4:inches]

//Height of the Cup
cup_height=50;

//Width of cup at base
cup_base_width=50;

//Width of cup at top (this must be equal to or greater than the base)
cup_top_width=70;

//Thickness of the cup walls
cup_thickness=3;

//Width of the lip on the bottom inside of cup to hold inserts
lip_width=3;

//Thichness of the shifter inserts
insert_thickness=4;

//Stack multiple inserts
stack="No";//[No,Yes]

//If stacking, how much space in mm to leave between inserts for removable support material
stack_spacing=1;

//Shape of holes in inserts
holes_shape=60;//[3:Triangle,4:Square,6:Hexagon,60:Circle]

//Number of inserts to generate
number_of_inserts=8;

//Spacing of holes
hole_spacing=1;

//Width of holes in first (or only) insert
width_of_holes=3;

//If generating more than one insert, enter how much bigger the holes are in each additional insert (in the units specified above).
growth_of_holes=0.5; 

//Internal Variables
base = cup_base_width * units;
holeR = width_of_holes * units * 0.5;
space = hole_spacing*units;
max_width= max(cup_base_width,cup_top_width);

module triangle_holes(ends, n)
{
	assign(holeR=holeR+n*growth_of_holes*units*.5)
	{
		for ( i = [-ends : holeR*2+space : ends], j= [ -ends : (holeR*4/3+space*4/3)*0.866 : ends] )
		{
			translate([i,j,0])
	
			if (  round((j+ends)/((holeR*4/3+space*4/3)*0.866 ))%2  )
			{
				rotate(180)
				translate([0,0,-1])
				cylinder(h=insert_thickness*units+2,r=holeR*4/3,$fn=holes_shape);
			}else{
				translate([-holeR*0.5*4/3,0,-1])
				cylinder(h=insert_thickness*units+2,r=holeR*4/3,$fn=holes_shape);
			}
		}
	}
}

module square_holes(ends, n)
{
	assign(holeR=holeR+n*growth_of_holes*units*.5){
		//for ( i = [-ends : holeR+(space-2*(holeR-holeR/sqrt(2))) : ends], j= [ -ends : holeR+(space-2*(holeR-holeR/sqrt(2))) : ends] )
		for ( i = [-ends : 2*holeR+space : ends], j= [ -ends : 2*holeR+space : ends] )
		{
			translate([i,j,-1])
			rotate(45)
			cylinder(h=insert_thickness*units+2,r=holeR*sqrt(2),$fn=holes_shape);

		}
	}
}




module hexagon_holes(ends, n)
{
	assign(holeR=holeR+n*growth_of_holes*units*.5){
		for ( i = [-ends : 3*holeR/sqrt(3)+space : ends], j= [ -ends : 2*holeR+space : ends] )
		{
			translate([i,j,-1])
			
			if (  round((i+ends)/(3*holeR/sqrt(3)+space))%2  )
			{
				translate([0,holeR+space/sqrt(3),0])
				cylinder(h=insert_thickness*units+2,r=holeR*2/sqrt(3),$fn=holes_shape);
			}else{	
				cylinder(h=insert_thickness*units+2,r=holeR*2/sqrt(3),$fn=holes_shape);
			}
		}
	}
}


module round_holes(ends, n)
{

	assign(holeR=holeR+n*growth_of_holes*units*.5){
		for ( i = [-ends : 3*holeR/sqrt(3)+space : ends], j= [ -ends : 2*holeR+space : ends] )
		{
			translate([i,j,-1])
			
			if (  round((i+ends)/(3*holeR/sqrt(3)+space))%2  )
			{
				translate([0,holeR+space/sqrt(3),0])
				cylinder(h=insert_thickness*units+2,r=holeR,$fn=holes_shape);
			}else{	
				cylinder(h=insert_thickness*units+2,r=holeR,$fn=holes_shape);
			}
		}
	}
}

module cup()
{
	difference(){
		cylinder(h=cup_height*units,r1=base*0.5, r2=cup_top_width*units*0.5,$fn=cup_shape);
		translate([0,0,cup_thickness*units])
			cylinder(h=cup_height*units,r1=(base*0.5)-(cup_thickness*units), r2=cup_top_width*units*0.5-cup_thickness*units,$fn=cup_shape);
		translate([0,0,-1])
			cylinder(h=cup_height*units+2,r1=(base*0.5)-(cup_thickness*units)-(lip_width*units), r2=(cup_top_width*units*0.5)-(cup_thickness*units)-(lip_width*units),$fn=cup_shape);
	}

}

module sifter(n=0)
{

	difference(){
		cylinder(h=cup_height*units,r1=cup_base_width*units*0.5, r2=cup_top_width*units*0.5,$fn=cup_shape);

		translate([0,0,0-cup_thickness])
			cup();

		translate([0,0,insert_thickness])
			cylinder(h=cup_height*units+1,r1=cup_top_width*units*0.5+1, r2=cup_top_width*units*0.5+1,$fn=cup_shape);

		if (mode=="Design 2")
		{
			% intersection()
			{
				drill_holes(base*0.5, n);
				translate([0,0,-1])
				cylinder(h=cup_height*units+2,r1=cup_base_width*units*0.5-(lip_width+cup_thickness), r2=cup_top_width*units*0.5-(lip_width+cup_thickness),$fn=cup_shape);
			}
		}else{
			intersection(){
				if (mode=="Final"){
					drill_holes(base*0.5, n);
				}else{
					drill_holes(holeR+n*growth_of_holes*units*.5+space, n);
				}
				
				translate([0,0,-1])
				cylinder(h=cup_height*units+2,r1=cup_base_width*units*0.5-(lip_width+cup_thickness), r2=cup_base_width*units*0.5-(lip_width+cup_thickness),$fn=cup_shape);
			}
		}



		translate([0,0,-(cup_thickness+1)])
		scale(1.1,1.1,0)
			cup();

	}


}
if(include=="Cup")
{
	cup();
}
if(include=="Both")
{
	if(stack=="Yes")
	{
		for(i=[1:number_of_inserts])
		{
			translate([0,0,(insert_thickness*units+stack_spacing)*(i-1)])
			rotate(45)
			sifter(i);
		}
		translate([(max_width*units),0,0])
		rotate(45)
		cup();
	}else{
		assign(width=ceil(sqrt(number_of_inserts+1)))
		{
			for(grid_i = [1:width], grid_j = [1:width])
			{
				if(grid_j+((grid_i-1)*width) < number_of_inserts+1)
				{
					translate([(max_width*units)*(grid_i-1),(max_width*units)*(grid_j-1),0])
					rotate(45)
					rotate(180,[1,1,0])
					translate([0,0,-insert_thickness])
					sifter(grid_j+((grid_i-1)*width)-1);
				}
				if(grid_j+((grid_i-1)*width) == number_of_inserts+1)
				{
					translate([(max_width*units)*(grid_i-1),(max_width*units)*(grid_j-1),0])
					rotate(45)
					cup();
				}
			}
		}
	}
}

module drill_holes(ends, n)
{
	if(holes_shape==3)
	{
		triangle_holes(ends, n);
	}else if(holes_shape==4)
	{
		rotate(45)
		square_holes(ends, n);
	}else if(holes_shape==6)
	{

		hexagon_holes(ends, n);
	}else if(holes_shape==60)
	{
		round_holes(ends, n);
	}

}


if (include=="Inserts")
{
	if(stack=="Yes")
	{
		for(i=[1:number_of_inserts])
		{
			translate([0,0,(insert_thickness*units+stack_spacing)*(i-1)])
			rotate(45)
			sifter(i);
		}
	}else{
		assign(width=ceil(sqrt(number_of_inserts)))
		{
			for(grid_i = [1:width], grid_j = [1:width])
			{
				if(grid_j+((grid_i-1)*width) < number_of_inserts+1)
				{
					translate([(max_width*units)*(grid_i-1),(max_width*units)*(grid_j-1),0])
					rotate(45)
					rotate(180,[1,1,0])
					translate([0,0,-insert_thickness])
					sifter(grid_j+((grid_i-1)*width)-1);
				}
			}
		}
	}
}



