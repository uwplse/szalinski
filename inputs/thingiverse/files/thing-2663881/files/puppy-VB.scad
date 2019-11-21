type="9_random_dogs"; //[configurable_dog,random_dog, 9_random_dogs,16_random_dogs]

//should we have a base?
PrintBase=1; //[1,0]

//radius head
r_head=8;

//length head
l_head=10;

//lift of the head -> r_head*.7;
lift_head=5.6;

//neck length
up_neck=15;

//radius body
r_body=7;

//length body
l_body=18;

//leg radius at bottom
r_leg_low=5;

//length legs
l_leg=18;

//legs to the outside -> l_leg/3
out_leg=6;

//length feet -> 
l_feet=4.5;

//radius tail
r_tail=3;

//length tail
l_tail=20;

//position of the eye
pos_eye=.15;

//radius of the eye
r_eye=r_head/2;

//thickness of the ears
thick_ear=3;

//radius of ears -> r_head*.7;
r_ear=5.6;

/* [Hidden] */
//-------------------------------------------------------------------------------
/*
Configurable dog pack
Version B, December 2017
Written by MC Geisler (mcgenki at gmail dot com)

You need configurable dogs? You have configurable dogs. Either one or nine, you decide.
Use it to create mini or big dog sculptures!

Have fun!

License: Attribution 4.0 International (CC BY 4.0)

You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
    for any purpose, even commercially.
*/


basex=60;
basey=40;
basethick=5;
    
module dog(r_head,l_head,lift_head,up_neck,r_body,l_body,r_leg_low,l_leg,out_leg,l_feet,r_tail,l_tail,pos_eye,r_eye,thick_ear,r_ear)
{
	r_neck=r_head*.7;
	forward_neck=5;
	straight_neck=.3;
	leg_mid_percent=.3;
	Cutoffleg_percent=.5;
	r_mid_tail_percent=1.3;
	tail_mid_percent=.35;
	tail_low_percent=.21;
	
	dummy_max_body_extent=l_head+forward_neck+l_body+out_leg+l_tail+r_head+r_tail;
	
	module body(pos)
	{
		translate([pos*l_body/2,0,0])
			sphere(r=r_body,center=true);
	}
	module front_body()
	{
		body(1);
	}
	module back_body()
	{
		body(-1);
	}
	module mid_neck(shift)
	{
		translate([l_body/2+forward_neck*shift,0,up_neck*shift])
			sphere(r=r_neck,center=true);
	}
	module head(pos)
	{
		translate([l_body/2+forward_neck+pos*l_head,0,up_neck+lift_head*pos])
			sphere(r=r_head,center=true);
	}
	module back_head()
	{
		head(0);
	}
	module front_head()
	{
		head(1);
	}
	module eye(pos)
	{
		translate([l_body/2+forward_neck+pos_eye*l_head,pos*r_eye*.7,up_neck+r_head*1.1+lift_head*pos_eye])
			sphere(r=r_eye,center=true);
	}
	module earpart(pos)
	{
		translate([l_body/2+forward_neck-.5*l_head,pos*r_head/2,up_neck+r_head-lift_head*.5])
			rotate([45,35,-20*pos])
				cube(r_ear,center=true);
	}
	module ear(pos)
	{
		length=sqrt(l_head*l_head+lift_head*lift_head);
		$fn=25;	

		difference()
		{
			earpart(pos);
			translate([thick_ear*l_head/length,0,lift_head*thick_ear/length])
				earpart(pos);
		}
	}
	module leg(out_percent,dirx,diry)
	{
		translate([(l_body/2+out_leg*out_percent)*dirx,((r_body-r_leg_low)+out_leg*out_percent)*diry,-l_leg*out_percent])
			sphere(r=r_leg_low,center=true);
	}
	module tail(pos,radiusfactor)
	{
		translate([-l_body/2-l_tail*pos/2,0,l_tail*pos])
			sphere(r=r_tail*radiusfactor,center=true);
	}
	
	//---------------------------------
	
	module specific_dog()
	{
		//body
		hull()
		{	
			back_body();
			front_body();
		}
		
		//head
		hull()
		{	
			back_head();
			front_head();
		}
		
		//lower neck
		hull()
		{	
			front_body();
			mid_neck(.5-straight_neck/2);
		}
		//middle neck
		hull()
		{	
			mid_neck(.5-straight_neck/2);
			mid_neck(.5+straight_neck/2);
		}
		//upper neck
		hull()
		{	
			mid_neck(.5+straight_neck/2);
			back_head();
		}
		
		module complete_leg(dirx,diry)
		{
			//foot
			hull()
			{	
				leg(1,dirx,diry);
				translate([l_feet,0,0])
					leg(1,dirx,diry);
			}		
			//lower leg
			hull()
			{	
				leg(1,dirx,diry);
				leg(leg_mid_percent,dirx,diry);
			}
			//upper leg
			hull()
			{	
				leg(leg_mid_percent,dirx,diry);
				body(dirx);
			}
		}
		//four legs
		for (i = [-1, 1]) 
		{
			for (j = [-1, 1]) 
			{
				complete_leg(i,j);
			}
		}
		
		//upper tail
		hull()
		{	
			tail(1,1);
			tail(tail_mid_percent,1);
		}
		//mid tail
		hull()
		{	
			tail(tail_mid_percent,1);
			tail(tail_low_percent,r_mid_tail_percent);
		}
		//lower tail
		hull()
		{	
			tail(tail_low_percent,r_mid_tail_percent);
			back_body();
		}
		//ear
		ear(-1);
		ear(1);
		//eye
		eye(1);
		eye(-1);
	}
	//---------------------------------
	
	difference()
	{
		translate([0,0,l_leg+r_leg_low*Cutoffleg_percent])
			specific_dog();
		translate([0,0,-dummy_max_body_extent/2])
			cube([dummy_max_body_extent,dummy_max_body_extent,dummy_max_body_extent],center=true);
	}
   
    if(PrintBase==1)
    {
        scalingx=(basex+2*basethick)/basex;
        scalingy=(basey+2*basethick)/basey;
        translate([0,0,-basethick/2])
                scale([1,1,-1])
                    linear_extrude(height = basethick, center = true, scale=[scalingx,scalingy])
                    square([basex,basey],center=true);
        
        chamfer=1;
        goalx=(basex+2*basethick-chamfer);
        goaly=(basey+2*basethick-chamfer);
        chamferx=(basex+2*basethick)/goalx;
        chamfery=(basey+2*basethick)/goaly;
       
        translate([0,0,-basethick-chamfer/2])
                linear_extrude(height = chamfer, center = true, scale=[chamferx,chamfery])
                    square([goalx,goaly],center=true);
    }
}

module random_dog()
{
	r_head=rands(4,10,1)[0]; //8;
	l_head=rands(2,12,1)[0]; //10;
	lift_head=rands(3,12,1)[0]; //.7;
	up_neck=rands(10,30,1)[0]; //15
	r_body=rands(5,10,1)[0]; //7
	l_body=rands(7,20,1)[0]; //18
	r_leg_low=rands(8,12,1)[0]/2; //5
	l_leg=rands(8,26,1)[0]; //18
	out_leg=l_leg/6*rands(0,3,1)[0];
	l_feet=l_leg/8*rands(0,3,1)[0];
	r_tail=rands(3,7,1)[0]/2; //3
	l_tail=rands(5,30,1)[0]; //20
	pos_eye=.15;
	r_eye=r_head/2;
	thick_ear=3;
	r_ear=r_head/2;

	dog(r_head,l_head,lift_head,up_neck,r_body,l_body,r_leg_low,l_leg,out_leg,l_feet,r_tail,l_tail,r_eye,pos_eye,thick_ear,r_ear);
}

module standard_dog()
{


	dog(r_head,l_head,lift_head,up_neck,r_body,l_body,r_leg_low,l_leg,out_leg,l_feet,r_tail,l_tail,pos_eye,r_eye,thick_ear,r_ear);
}

//---------------------------------------


module randomdogs(xx,yy)
{
    for (x = [0:xx-1]) 
    {
        for (y = [0:yy-1]) 
        {
         //     $fn=rands(5,40,1)[0]; //40;
        /*
                r_head=rands(4,10,1)[0]; //8;
                l_head=rands(2,12,1)[0]; //10;
                lift_head=rands(3,12,1)[0]; //.7;
                up_neck=rands(10,30,1)[0]; //15
                r_body=rands(5,10,1)[0]; //7
                l_body=rands(7,20,1)[0]; //18
                r_leg_low=rands(8,12,1)[0]/2; //5
                l_leg=rands(8,26,1)[0]; //18
                out_leg=l_leg/6*rands(0,3,1)[0];
                l_feet=l_leg/8*rands(0,3,1)[0];
                r_tail=rands(3,7,1)[0]/2; //3
                l_tail=rands(5,30,1)[0]; //20
        */
            
                translate([x*basex,y*basey,0])
                    random_dog();
        }
    }
}

if (type=="9_random_dogs")
{
    randomdogs(3,3);
}

if (type=="16_random_dogs")
{
    randomdogs(4,4);
}

if (type=="configurable_dog")
{
    $fn=22;//40
    
    //get values from above (configuration possibility)
    standard_dog();
}

if (type=="random_dog")
{
    $fn=rands(5,40,1)[0]; //40; 
    random_dog();
}

