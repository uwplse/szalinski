//Pill diameter
pd=9.6;//

//Pill hight1 
pt=4.2;//

//Pill hight2
pt2=2.6;//

//Parts sellect
part="top";//[pill,top,bottom]  

pc=(pt-pt2)/2;//Convex value
sp=pd/(tan(2*atan(2*pc/pd))*2)+pd;// convex diameter

//Base hight
bh=pt/2+1;

//echo(sp);// convex diameter

module pill()
{
rotate([0,0,0])intersection(){
cylinder(h=10,r=pd/2+0.5,center=true,$fn=48);
translate([0,0,-sp+(pt2-0.5)])sphere(r=sp+0.5,center=true,$fn=96);
translate([0,0,sp-(pt2-0.5)])sphere(r=sp+0.5,center=true,$fn=96);
								}
}

module post()
{
translate([21,21,bh/2])cube(size=[5,5,bh*2], center=true);
translate([-21,21,bh/2])cube(size=[5,5,bh*2], center=true);
translate([-21,-21,bh/2])cube(size=[5,5,bh*2], center=true);
translate([21,-21,bh/2])cube(size=[5,5,bh*2], center=true);
}

union(){
if(part=="pill") {
		translate([0,0,0])pill();
				 }
		else if (part=="bottom"){
union(){
difference(){
cube(size=[46,46,bh], center=true);
translate([0,0,pt/2])pill();
translate([-0.4,-20.5,-1])cube(size=[0.8,41,20], center=false);
translate([-20.5,-0.4,-1])cube(size=[41,0.8,20], center=false);
			}
post();
		}
					}
				else if (part=="top"){
translate([0,0,0]){
difference(){
		cube(size=[44,44,bh], center=true);
		translate([0,0,pt/2])pill();
		translate([-0.4,-20.5,-10])cube(size=[0.8,41,20], center=false);
		translate([-20.5,-0.4,-10])cube(size=[41,0.8,20], center=false);
		translate([0,0,-4])rotate([0,45,0])cube(size=[5,41,5], center=true);
		translate([0,0,-4])rotate([45,0,0])cube(size=[41,5,5], center=true);
		translate([0,0,-pt])scale([0.95,0.95,2])post();

			}
		}
					}
					}

