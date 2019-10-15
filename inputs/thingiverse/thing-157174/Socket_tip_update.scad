
//diameter of the socket interior. (measurement A)
diameter=21; //[18:28]

//depth of the socket. (measurement B - must be less than exterior length!!)
sktdepth=26; //[0:38]

//exterior length of the socket. (measurement C)
extlen=33; //[25:40]

//desired length of the artifical finger (measurement D)
length=40;//[40:59]

//view socket/finger tip
part = "socket"; //[first:socket,second:tip]

/*[hidden]*/
$fn=18;

//take user diameter input and convert to radius
intrad=diameter/2;

//display select for customizer


print_part();

module print_part(){

	if (part== "first"){
		finger_socket();
	} else if (part== "second"){
		finger_tip();
	}
}

//pad for finger tip
module FPadSection(){
	rotate([0,90,0])rotate([0,0,-20])scale([1,2,1])cylinder(r=5,h=2,center=true);
}

//_________________________________________//
//_________________________________________//
//_________________________________________//
//_________________________________________//



//finger socket
module finger_socket(){
difference(){

union(){

difference(){

union(){

difference(){

//main cylinder
translate([0,0,extlen/2-((sktdepth-intrad)/2)+1])cylinder(r=intrad+1.5,h=extlen,center=true);

//rounding the top of the socket exterior
translate([0,0,-extlen*0.25])
difference(){
translate([0,0,(extlen/2-((sktdepth-intrad)/2)+1)+(extlen/2)])sphere(r=intrad+6);
translate([0,0,(extlen/2-((sktdepth-intrad)/2)+1)+(extlen/2)])sphere(r=intrad+2);
translate([0,0,(extlen/2-((sktdepth-intrad)/2)+1)+(extlen/8)])cube([100,100,extlen],center=true);
}

translate([0,intrad+1.9,0])cube([40,2.25,200],center=true);

//socket interior
union(){
cylinder(r=intrad,h=sktdepth-intrad,center=true);
translate([0,0,(sktdepth-intrad)/2])sphere(r=intrad);
}

}

//linkage for finger
translate([0,0,(extlen/2-((sktdepth-intrad)/2)+1)+(extlen/2)-0.25])rotate([90,0,0])
difference(){

union(){
	//cylinder and central cube
	translate([0,10.5,0])rotate([0,90,0])cylinder(r=6.25,h=5.5,center=true,$fn=30);
	translate([0,5.25,0])cube([5.5,10.5,12.5],center=true);
	//wider section
	translate([0,2,0])cube([14.5,4,10],center=true);
	
	//stopping block
	difference(){
	translate([0,3.75,5.5])cube([14.5,7.5,2.5],center=true);
	translate([0,7.5,3.75])rotate([-45,0,0])cube([16,1,4],center=true);
	}
}
//axel hole <-----------
translate([0,10.5,0])rotate([0,90,0])cylinder(r=2.4,h=7,center=true,$fn=30);

//bungee pathway
translate([0,15,3.75])rotate([90,0,0])cylinder(r=1.25,h=15,center=true,$fn=25);
translate([0,5,6])rotate([51,0,0])cylinder(r=1.25,h=9,center=true,$fn=25);
translate([0,5,6])rotate([51,0,0])cylinder(r=1.25,h=6,center=true,$fn=25);

//cable pathway
translate([0,15,-5])rotate([90,0,0])cylinder(r=1.5,h=22,center=true,$fn=25);

//angled edges for base
translate([7.25,0,5])rotate([0,-45,0])cube([3,20,10],center=true);
translate([7.25,0,-5])rotate([0,45,0])cube([3,20,10],center=true);
translate([-7.25,0,-5])rotate([0,-45,0])cube([3,20,10],center=true);
translate([-7.25,0,5])rotate([0,45,0])cube([3,20,10],center=true);

}


}

translate([0,0,(extlen/2-((sktdepth-intrad)/2)+1)+(extlen/2)+2.5])rotate([-60,0,0])cylinder(r=1,h=400,center=true);

}
translate([0,0.5,0])
difference(){
translate([0,-(intrad+2.5),-((extlen/2+((sktdepth-intrad)/2)-2)-(extlen/2))])cylinder(r=1.75,h=2,center=true);
translate([0,-(intrad+2.5),-((extlen/2+((sktdepth-intrad)/2)-2)-(extlen/2))])cylinder(r=1,h=3,center=true);
}

}

translate([0,0,extlen/2])rotate([0,90,0])cylinder(r=1,h=intrad*4,center=true);
translate([0,0,extlen/4])rotate([0,90,0])cylinder(r=1,h=intrad*4,center=true);
translate([0,0,0])rotate([0,90,0])cylinder(r=1,h=intrad*4,center=true);

translate([0,0,extlen/2])rotate([0,90,45])cylinder(r=1,h=intrad*4,center=true);
translate([0,0,extlen/4])rotate([0,90,45])cylinder(r=1,h=intrad*4,center=true);
translate([0,0,0])rotate([0,90,45])cylinder(r=1,h=intrad*4,center=true);

translate([0,0,extlen/2])rotate([0,90,-45])cylinder(r=1,h=intrad*4,center=true);
translate([0,0,extlen/4])rotate([0,90,-45])cylinder(r=1,h=intrad*4,center=true);
translate([0,0,0])rotate([0,90,-45])cylinder(r=1,h=intrad*4,center=true);


}

}


//_________________________________________//
//_________________________________________//
//_________________________________________//
//_________________________________________//

//finger tip

module finger_tip(){
translate([50,0,1.5])rotate([0,180,0])
union(){
difference(){

union(){

difference(){

difference(){

	union(){
		//female end cylinder
		difference(){
			union(){
				translate([0,10,0])rotate([0,90,0])cylinder(r=5,h=15,center=true);
				translate([5.4375,17,0])cube([4.125,10,10],center=true);
				translate([-5.4375,17,0])cube([4.125,10,10],center=true);
				
				//female end stopping block
				translate([0,9.5,3.75])cube([15,5,5.5],center=true);

				//"meat" of the finger
				translate([0,length*0.45,0.5])cube([15,length*0.55,11],center=true);

//finger pad
hull(){

translate([0,length*0.75,0.25])
rotate([-30,0,0])
cube([15,length/4,10],center=true);

translate([0,length*0.85,-5])
rotate([0,180,180])
difference(){
	hull(){
	translate([1,0,0])FPadSection();
	translate([-1,0,0])FPadSection();
	translate([5,0,0])scale([0.8,0.8,0.8])FPadSection();
	translate([-5,0,0])scale([0.8,0.8,0.8])FPadSection();
	}
	translate([0,0,-10])cube([100,100,20],center=true);
}

}

			}
			//axel hole
			translate([0,10,0])rotate([0,90,0])cylinder(r=2.25,h=16,center=true);
		}

	
		
	}
//negative space to receive male end
translate([0,10.5,0])cube([6.75,20,20],center=true);

}

//angled edges for base
translate([7.25,0,6])rotate([0,-45,0])cube([3,200,20],center=true);
translate([-7.25,0,6])rotate([0,45,0])cube([3,200,20],center=true);

//angled edges for top of tip
translate([6.25,length,5])rotate([-22.5,-22.5,10])cube([5,200,20],center=true);
translate([-6.25,length,5])rotate([-22.5,22.5,-10])cube([5,200,20],center=true);

//flattening the top
translate([0,0,8])cube([50,400,4],center=true);

//bungee pathway
translate([0,15,2.75])rotate([90,0,0])cylinder(r=1.25,h=length*0.6,center=true,$fn=25);
translate([0,15+length*0.3,4.5])cube([2.5,2.5,6],center=true);
translate([0,11+length*0.3,4.5])cube([2.5,2.5,6],center=true);

}

}

//cable pathway
translate([0,15,-2.75])rotate([90,0,0])cylinder(r=1.25,h=length*0.6,center=true,$fn=25);
translate([0,15+length*0.3,-6.5])cube([2.5,2.5,10],center=true);
translate([0,11+length*0.3,-6.5])cube([2.5,2.5,10],center=true);

//snap-pin recess
translate([7.5,10,0])cube([4.5,6,4.5],center=true);
translate([-7.5,10,0])rotate([0,90,0])cylinder(r=2.6,h=4.5,center=true);


}


}

}


