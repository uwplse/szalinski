//shell thickness
ep		=0.8;  		
//seg height
hseg		= 50;		
//seg count
nseg		=6;			
//bottom radius
rb			= 17;		
//top radius
rt			= 1.6;			
//show ready to print (0) or extended (1)
deploie=0;
//hollow segment using csg (0) or create solid shape made hollow with cura (1)
nocsg=0;

rdelta = (rb - rt) /nseg;
pente = hseg / rdelta;
zz = ep * pente ;  //friction zone


echo(str("<h2>overlap:",zz,"mm<br>size when extended: " , nseg*hseg-(nseg-1)*zz , " mm</h2><br>"));

for (n=[0:nseg-1])
	{
		translate([0,0,deploie*n*(hseg-zz)]) 
		{
			difference()
				{
				cylinder(r1=rb-n*rdelta,r2=rb-(n+1)*rdelta,h=hseg);
				translate([500*nocsg,0,-0.1]) cylinder(r1=-ep+rb-n*rdelta,r2=-ep+rb-(n+1)*rdelta,h=hseg+0.2);
				}
		}
	}