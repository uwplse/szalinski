

/*[what to render]*/

//render face plate
rfp=1;	//[1:true,0:false]
//render front dial
rfd=1;	//[1:true,0:false]
//render rear dial
rrd=1;	//[1:true,0:false]
//render cosine dial
rcd=1;	//[1:true,0:false]
//render hexagon center rod
rhr=1;	//[1:true,0:false
//render sine/cosine dial
rsd=2;	//[0:1:2]
// render linear guide
rlg=4;	//[0:1:4]

/*[parameters]*/

//bearing diameter
bd=51.7;	
//bearing thickness
bt=15;	
//center hex rod size
chrs=6.4;	
//center hex hole size
chhs=6.4;	
//extruder size
ES=0.4;		
//inside compensation;	
ic=0.2;

/*[hidden]*/

//face size
fs=25;		
//face thickness
ft=1.2;		
//face overlap
fo=1;
//face angle
fa=4;
//face inner radius
fir=bd/2-bd/20;	
//front dial length
fdl=fir+fs*2/3;		


if(rfp)
{
	faceplate();
	rod_support();
	bearing_support();
	stand();
}

if(rfd)
	translate([0,fir+2*fs+fdl/5,0])
		front_dial();

if(rrd)
	translate([0,fir+2*fs+fdl/5+fdl/3,0])
		rear_dial();

if(rhr)
	translate([-3*chrs,fir+2*fs+fdl/5,0])
		hexagon_rod();

translate([0,fir+2*fs+fdl/5+fdl/3+fs*2/3-(fir+fs*8/5-fs*2/3-10*ft)*5/3,0])
	for(i=[1:1:rsd])
		translate([0,(i*fir+fs*8/5-fs*2/3-10*ft)*5/3,0])
			sine_dial();

translate([0,fir+2*fs+fdl/5+fdl/3+fs*2/3+(fir+fs*8/5-fs*2/3-10*ft)*5/3,0])
	for(i=[1:1:rlg])
		translate([0,i*8*ft,0])
			linear_guide();

module cross_helper()
{	
	difference()
	{
		for(i=[0,1])
			rotate([0,90,i*90])
				translate([i*ft,0,0])
				cylinder(r=fs*2/6+ft, h=((fir+fs*4/3+fs*1/3)-fs*2/6-fdl*16/14+2*ft)*2,center=true);
	
		for(i=[0,1])
			rotate([0,0,i*90])
		{		
			translate ([0,0,-(fs*2/6+2*ft)/2-ft*4])
			cube([((fir+fs*4/3+fs*1/3)-fs*2/6-fdl*16/14+3*ft)*2, 2*(fs*2/6+2*ft), fs*2/6+2*ft],center=true);
		translate ([0,0,(fs*2/6+2*ft)/2+ft*2-0*ft])
			cube([((fir+fs*4/3+fs*1/3)-fs*2/6-fdl*16/14+3*ft)*2, 2*(fs*2/6+2*ft), fs*2/6+2*ft],center=true);
		

		translate([0,0,i*-ft])
			{
		cube([((fir+fs*4/3+fs*1/3)-fs*2/6-fdl*16/14+2*ft)*2+ft,fs*2/3+2*ic,ft*3/2], center=true);
		translate([0,0,ft*3/2])
		cube([fir*2+fs*11/3+11/2*ft-fo,fs*2/3-ft,ft*4], center=true);
			}
		
		}	
		cylinder(r=fdl/20+ft,h=10*ft,$fn=20,center=true);
	}
}

module linear_guide()
{
	cube([(fir+fs*8/5+5*ft)*2, 5*ft-ic, ft],center=true);
}

module center_hex_hole_test()
{
	difference()
	{
		cylinder(r=max(chrs/2+2*ft,fdl/10),h=ft,center=true);
		cylinder(r=chrs/(2*cos(180/6)),h=ft*2,center=true,$fn=6);
	}
}
module hexagon_rod()
{
	translate([0,0,(bt+6*ft)/2-ft*1/2])
		cylinder(r=(chrs-ic)/(2*cos(180/6)),h=bt+6*ft,center=true,$fn=6);
}

module sine_dial()
{
	
	difference()
	{
		translate([((fir+fs*2-fo)-(fir+fs*8/5+7/2*ft)+ft*2)/2,0,0])
			cube([(fir+fs*8/5+7/2*ft)+(fir+fs*2-fo)+ft*2,fs*2/3,ft], center=true);
		cube([fdl*16/7, fdl/10+ic,2*ft], center=true);
	}
	for(i=[-1:2:1])
	{
		translate([i*(fir+fs*8/5),0,ft*5/4])
			difference()
			{
				cube([7*ft,fir+fs*8/5-fs*2/3-10*ft,ft*7/2],center=true);
				cube([5*ft,fir+fs*8/5-fs*2/3-8*ft,ft*3/2],center=true);
				translate([0,0,ft*4/3])
					cube([4*ft,fir+fs*8/5-fs*2/3-8*ft,ft*3/2],center=true);
				translate([0,0,3/2*ft])
					cube([fir*2+fs*11/3+11/2*ft-fo,fs*2/3,5*ft], center=true);
			}
	}
	translate([(fir*2+fs*11/3+11/2*ft-fo)/2+(fs*1/3-fo-ft*3/2)/2-1/2*ft,0,(bt+9*ft)/2])
	rotate([0,-90,0])
	difference()
	{
		cube([bt+9*ft,fs*2/3,ft],center=true);
			translate([(bt+9*ft)/2,0,-bt+9/2*ft/4])
				for(i=[45,-135])
				rotate([0,0,i])
					cube([fdl/2,fdl/2,fdl/2]);
	}
}

module front_dial()
{
	difference()
	{	
		union()
		{
			translate([fir+fs*2/7,0,0])
				cylinder(r=fdl/20,h=fdl/5);
			cylinder(r=max(chrs/2+2*ft,fdl/10),h=ft,center=true);
			translate([fdl/2,0,0])
				cube([fdl,fdl/5,ft],center=true);
		}
		translate([fdl,0,-fdl/4])
			for(i=[45,-135])
				rotate([0,0,i])
					cube([fdl/2,fdl/2,fdl/2]);
		cylinder(r=chhs/(2*cos(180/6)),h=ft*2,center=true,$fn=6);
			
	}
}

module rear_dial()
{
	difference()
	{
		union()
		{
			cylinder(r=max(chrs/2+2*ft,fdl/10),h=ft,center=true);
				translate([fdl/2,0,0])
					cube([fdl,fdl/5,ft],center=true);
		}		
				cylinder(r=chhs/(2*cos(180/6)),h=ft*2,center=true,$fn=6);
		translate([fdl,0,-fdl/4])
			for(i=[45,-135])
			rotate([0,0,i])
				cube([fdl/2,fdl/2,fdl/2]);
	}
	translate([fdl,0,-ft/2])
		cylinder(r=fdl/20,h=7*ft,$fn=20);
}


module faceplate()
{
	difference()
	{
		union()
		{
			difference()
			{
				cylinder(r=fir+fs, h=ft,center=true,$fa=4);
				cylinder(r=fir, h=ft*2,center=true,$fa=4);	
			}

			for (i=[0:90:359])
			{
				rotate([0,0,i])
					translate([0,fs/2+fir+fs-fo,0])
							cube([2*(fir)+4*fs-2*fo,fs,ft],center=true);
			}
		}
		markings();
	}
}

module markings ()
{	
	rotate ([180,0,0]){
	
	for (i=[0:-90:-179])
		rotate([0,0,i])
			{
				for(i=[-fdl:fdl/10:fdl])
					translate([i,(fir+2*fs-fo-fs/4),ft/4])
						cube([1,fs/4,ft],center=true);
				for(i=[-fdl:fdl/2:fdl])
					translate([i,(fir+2*fs-fo-fs/4),ft/4])
						cube([1,fs/3,ft],center=true);
			}
	list1=["-1","-.5","0",".5","1"];	
	list2=[for (a=[-fdl:fdl/2:fdl])a];

	{
	for(i=[0:4])
		translate([list2[i],(fir+2*fs-fo-fs*5/7),ft/4])
			linear_extrude(height=ft,center=true)
				text(text = str(list1[i]), size = fs/3, valign = "center",halign ="center");
	for(i=[0:4])
	translate([(fir+2*fs-fo-fs*5/7),list2[i],ft/2])
		linear_extrude(height=ft,center=true)
			text(text = str(list1[i]), size = fs/3, valign = "center",halign ="center");
	}
	list3=["0","π/2","π","3π/2"];
	
	for(i=[0:45:359])
	
		rotate([0,0,i])
			translate([fir+3/4*fs,0,ft/4])
				cube([fs/3,1,ft],center=true);
	
	for(i=[0:3])
		translate([cos(i*90)*(fir+fs*3/8),sin(i*90)*(fir+fs*3/8),ft/4])
			linear_extrude(height=ft,center=true)
				text(text = str(list3[i]), size = fs/3, valign = "center",halign ="center");
	
	for(i=[0:10:359])
	rotate([0,0,i])
		translate([fir+3/4*fs,0,ft/2])
			cube([fs/4,1,ft],center=true);
	
}
}

module rod_support()
{
//	for (i=[0:90:359])
//		rotate([0,0,i])
//	{
//		translate([fir+fs*8/5,fir+fs*8/5,0])
//			cube([10*ft,10*ft,ft],center=true);
//		translate([fir+fs*8/5,0,0])
//			cube([ft+0.4,(fir+fs*8/5)*2,ft],center=true);
//	}
	for (i=[-1,1])
		for (j=[-1,1])
			translate([i*(fir+fs*8/5),j*(fir+fs*8/5),bt+6*ft])
				{
					
				difference()
				{
					for(i=[0,1])
					translate([0,0,ft*3/2*i])
						rotate([0,0,i*90])
							hull()
							{
								cube([8*ft,8*ft,ft*7/2],center=true);
								translate([0,0,-ft*7/4-fs*1/12])
								cube([ft*2,8*ft,5*ft],center=true);	
							}
					for(i=[0,1])
						translate([0,0,ft*3/2*i])
						rotate([0,0,i*90])
						{
							cube([5*ft,9*ft,ft*3/2],center=true);
							translate([0,0,ft*4/3])
							cube([4*ft,9*ft,ft*4],center=true);
						}
				}for(i=[0,1])
					rotate([0,0,i*90])
								translate([0,0,-bt/2-ft*4])
						cube([ft*2,8*ft,bt+4*ft],center=true);
				}
	
				
	}

module bearing_support ()
{
	translate([0,0,(bt+ft*2)/2])
		intersection()
		{
			difference()
				{
				inside_hole(bd/2+ft,bt+ft*2,ES);
				inside_hole(bd/2,bt*2,ES);
				}
			for (i=[0:90:179])
				rotate([0,0,i])
					cube([bd*2,bt,bt*2],center=true);
		}
	for(i=[0:90:359])
		rotate([0,0,i])
		translate([bd/2,0,bt+ft*3/2])
		cube([3/2*ft,2*ft,ft],center=true);
}

module stand ()
{
	a=fir+2*fs-fo-ft;
	for (i=[-1:2:1])
	translate([i*a,0,0])
	polyhedron
    (points = [
			[ft,fir+fs-fo,0], [-ft,fir+fs-fo,0],[ft,fir+fs-fo,bt], [-ft,fir+fs-fo,bt],
			[ft, (fir+2*fs-fo)*(1-sin(fa))+(bd/2+ft)*sin(fa),bd/2],
			[-ft, (fir+2*fs-fo)*(1-sin(fa))+(bd/2+ft)*sin(fa),bd/2],
			[ft, fir+2*fs-fo,0], [-ft, fir+2*fs-fo,0]],
 
     faces = 	[[0,2,1],[1,2,3],[2,4,3],[3,4,5],[4,6,5],[5,6,7],[0,1,6],[1,7,6],
				[1,3,7],[3,5,7],[0,6,2],[2,6,4]]	  
     );
}



module inside_hole (r, h, t, compensate=true, center=true) //t=extruder size
{
    n = max(round(4*r),3);
	if(compensate)
	{
			r=(t+sqrt(pow(t,2)+4*pow(r,2)))/2;
			cylinder(h=h, r=r/cos(180/n),center=center,$fn=n);
	}
		else
		{
			cylinder(h=h, r=r/cos(180/n),center=center,$fn=n);
		}
}