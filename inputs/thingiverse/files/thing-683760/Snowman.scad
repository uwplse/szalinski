//Overall height of the snowman
total_height=10;
resolution=25;//[8:Low,25:Medium,50:High,100:Ultra]
//Want a Nose?
Nose=1;//[1:Yes,0:No]

//Ratio
Top_Ball=3;//[1:10]
//Ratio
Middle_Ball=4;//[0:10]
//Ratio
Bottom_Ball=5;//[1:10]
//Ratio
Cylinder=2;//[0:10]

/* [Hidden] */
snowman();

module snowman()
{
	sum=Bottom_Ball+Middle_Ball+Top_Ball+Cylinder;
	d1=total_height*Bottom_Ball/sum;
	r1=d1/2;
	d2=total_height*Middle_Ball/sum;
	r2=d2/2;
	d3=total_height*Top_Ball/sum;
	r3=d3/2;
	hz=total_height*Cylinder/sum;
	difference()
	{
	union()
	{
		//Bottom Ball
		sphere(r=r1,$fn=resolution);
		//Middle Ball
		translate([0,0,0.9*(d1+d2)/2])
		{
			sphere(r=r2,$fn=resolution);
		}

		translate([0,0,0.9*(d2+(d1+d3)/2)])
		{
			//Top Ball
			sphere(r=r3,$fn=resolution);
			//Nose
			translate([0.9*d3/2,0,0])
			{
				rotate([0,90,0])
				{
					cylinder(h=Nose*d3/4,r1=Nose*d3/16,r2=0,$fn=resolution/2);
				}
			}
		}
		//Hat
		translate([0,0,0.9*(d1/2+d2+d3)])
		{
			cylinder(h=hz*0.2,r=hz/2,$fn=resolution);
			cylinder(h=hz,r=0.75*hz/2,$fn=resolution);
		}
	}
	}
}