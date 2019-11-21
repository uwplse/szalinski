//Pill diameter
pd=9.6;//

//Pill hight1 
pt=4.2;//

//Pill hight2
pt2=2.6;

//Brade gap
bg=0.8;//

//Gap taper offset
gto=2.2; //

//Parts sellect
part="base";//[pill,base]  

pc=(pt-pt2)/2;//Convex value
sp=pd/(tan(2*atan(2*pc/pd))*2)+pd;// convex diameter

//Base hight
bh=pt2+(pt-pt2)/2+1;

echo(sp);// convex diameter
echo(pd+0.4);

module pill()
{
rotate([0,0,0])intersection(){
cylinder(h=20,r=pd/2+0.15,center=true,$fn=48);
translate([0,0,-sp+(pt2/2+0.2)])sphere(r=sp+0.2,center=true,$fn=48);
translate([0,0,sp-(pt2/2+0.2)])sphere(r=sp+0.2,center=true,$fn=48);
								}
}

module post2()
{
translate([0,pd*2.2,bh])cylinder(h=bh*1.5,r=pd*0.45 ,center=true,$fn=12);
translate([0,-pd*2.2,bh])cylinder(h=bh*1.5,r=pd*0.45 ,center=true,$fn=12);
translate([-pd*2.2,0,bh])cylinder(h=bh*1.5,r=pd*0.45 ,center=true,$fn=12);
translate([pd*2.2,0,bh])cylinder(h=bh*1.5,r=pd*0.45 ,center=true,$fn=12);
}

module post3()
{
translate([0,18,bh])cylinder(h=bh*2,r=pd*0.45 ,center=true,$fn=12);
translate([0,-18,bh])cylinder(h=bh*2,r=pd*0.45 ,center=true,$fn=12);
translate([-18,0,bh])cylinder(h=bh*2,r=pd*0.45 ,center=true,$fn=12);
translate([18,0,bh])cylinder(h=bh*2,r=pd*0.45 ,center=true,$fn=12);
}

if(part=="pill") {
		translate([0,0,0])pill();
				 }
else if (part=="base"){
	
	difference(){
			union(){ 
					translate([0,0,bh/2])cylinder(h=bh,r=pd*2.7 ,center=true,$fn=48);

					translate([0,0,0])post2();
					}
	translate([0,0,bh/2+1])pill();
	translate([0,0,bh])pill();
	translate([-bg/2,-21,1])cube(size=[bg,42,20], center=false);
	translate([-21,-bg/2,1])cube(size=[42,bg,20], center=false);
	translate([0,0,bh*gto])rotate([0,45,0])cube(size=[5,42,5], center=true);
	translate([0,0,bh*gto])rotate([45,0,0])cube(size=[42,5,5], center=true);
				}
						}


