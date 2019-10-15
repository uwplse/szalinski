bookx=150;//Book Width
booky=20; //Book Thickness
bookz=200;// Book Height
angle=15; //Desired Angle
size=30; //Preferred Cylinder Diameter, will resize if book thickness requires it
$fn=200;


//Calculated Variables
calsize=max(size,2*booky*sin(angle)/(2/3));
zsize=calsize;
standz=bookz*cos(angle);// 250;
standy=(3/4)*(bookz*sin(angle)+booky*cos(angle));//60;
standx=(2/3)*bookx;//150;
standlen=sqrt(pow(standy,2)+pow(standx/2,2));
standangle=atan(standx/(2*standy));

difference()
{
	union()
	{
		cylinder(d=zsize, h=standz);
		
		rotate([-90,0,-standangle])
		cylinder(d=calsize, h=standlen);

		rotate([-90,0,standangle])
		cylinder(d=calsize, h=standlen);

		translate([standlen*sin(standangle),standlen*cos(standangle),0])
		sphere(d=calsize);

		translate([-standlen*sin(standangle),standlen*cos(standangle),0])
		sphere(d=calsize);

	}
	//Remove slot, trim back to angle
	translate([0,standlen*cos(standangle)-booky*cos(angle),calsize/8])
	rotate([angle,0,0])
	translate([-bookx/2,0,0])
	union()
	{
		cube([bookx,booky,bookz]);
		translate([0,0,30])
		cube([bookx,booky*10,bookz-30]);
	}
	// Remove bottom half of cylinders
	translate([-standlen*2,-standlen*2,-100])
	cube([standlen*4,standlen*4,100]);
}
	//Renders Book to help guide
	*translate([0,standlen*cos(standangle)-booky*cos(angle),calsize/8])
	rotate([angle,0,0])
	translate([-bookx/2,0,0])
	union()
	{
		cube([bookx,booky,bookz]);
		translate([0,0,30])
		cube([bookx,booky,bookz-30]);
	}