$fn = $preview ? 32 : 128;

/* [Defaults] */
Default_Arm_Gap = 5; // [0:0.1:10]
Default_Arm_Height = 15; // [0:0.1:50]
Default_Arm_Wall = 5; // [1:0.1:20]
Default_Arm_Bore = 4; // [1:0.1:40]
Default_Arm_Pipe = 22; // [1:0.1:50]

/* [Customizer] */
From = [-100,30];
To = [100, -40];
Pipe1 = 28.3;
Pipe2 = 15.3;

module stephull()
{
	for (i=[0:1:$children-2])
		hull() { children(i); children(i+1); }
}

module arm_mask(
	to,
	h=Default_Arm_Height, 
	gap=Default_Arm_Gap, 
	pipe=Default_Arm_Pipe, 
	wall=Default_Arm_Wall, 
	bore=Default_Arm_Bore)
{
	h = h + 1;
	x = to[0]; y = to[1];	
	da = abs(y) > abs(x) ? 90 : 0;
	pc = abs(y) > abs(x) 
		? [0, y-sign(y) * abs(x), 0] 
		: [x-sign(x) * abs(y), 0, 0];

	stephull() {
		translate(pc/2) cylinder(h=h, d=gap,center=true);
		translate(pc) cylinder(h=h, d=gap,center=true);
		translate(to) cylinder(h=h, d=gap,center=true);
	}
	translate(to) cylinder(h=h, d=pipe, center=true);

	translate(pc * 0.75) 
	rotate([0,0,da])
	rotate([90,0,0])
	cylinder(h=pipe+2*wall, d=bore,center=true);
	
	translate(pc + (to-pc) * 0.4)
	rotate([0,0,sign(x)*sign(y)*45]) 
	rotate([90,0,0])
	cylinder(h=pipe + 2*wall, d=bore, center=true);
}

module arm_unmask(
	to,
	h=Default_Arm_Height,
	gap=Default_Arm_Gap,
	pipe=Default_Arm_Pipe, 
	wall=Default_Arm_Wall, 
	bore=Default_Arm_Bore)
{
	d = gap + 2 * wall;
	x = to[0]; y = to[1];	
	pc = abs(y) > abs(x) 
		? [0, y-sign(y) * abs(x), 0] 
		: [x-sign(x) * abs(y), 0, 0];
	
	stephull() 
	{
		cylinder(h=h, d=d, center=true);
		translate(pc) cylinder(h=h, d=d, center=true);
		translate(to) cylinder(h=h, d=d, center=true);
	}
			
	translate(to) cylinder(h=h, d=pipe + 2 * wall,center=true);
}	

module arm(
	to,
	h=Default_Arm_Height,
	gap=Default_Arm_Gap,
	pipe=Default_Arm_Pipe, 
	wall=Default_Arm_Wall, 
	bore=Default_Arm_Bore,
	unmask = true,
	masked = true)
{
	if (!unmask) arm_mask(to,h,gap,pipe,wall,bore);
	else difference() {
		arm_unmask(to, h, gap, pipe, wall, bore);
		if (masked) arm_mask(to, h, gap, pipe, wall, bore);
	}
}

module triarm_part(mask)
{
	to_src1=[80,-30];
	to_src2=[-80,-30];
	to_dst1=[70,-20];
	to_dst2=[-70,-20];
	
	a=64;
	
	translate(to_dst1) rotate([0,0,-a]) translate(-to_src1)
	{
		arm(to=to_src1, masked=mask, unmask=!mask);
		arm(to=to_src2, masked=mask, unmask=!mask);
	}
	
	translate(to_dst2) rotate([0,0,a]) translate(-to_src2)
	{
		arm(to=to_src2, masked=mask, unmask=!mask);
		arm(to=to_src1, masked=mask, unmask=!mask);
	}
}

module triarm()
{
	difference() {
		triarm_part(false);
		triarm_part(true);
	}
}
//triarm();

arm(To, pipe=Pipe1);
arm(From, pipe=Pipe2);