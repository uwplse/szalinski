//Inner diameter of smaller tube
id1 = 13.5;
//Outer diameter of smaller tube (must be larger than id1
od1 = 17;
//Inner diameter of larger tube (must be larger than od1
id2 = 19;
//Outer diameter of larger tube (must be larger than id2)
od2 = 23;
//Height of smaller tube interface
h1 = 25; 
//Height of larger tube interface
h2 = 30;
//Angle of legs
ang = 40;
//Thickness of outer walls of part
thickness = 2;


ir1 = id1/2;
or1 = od1/2;
ir2 = id2/2;
or2 = od2/2;

rotate(180,[1,0,0])translate([0,0,-h2]){
	rotate(ang, [1,0,0])translate([0,0,-h1/2])cylinder(r=ir1, h=h1,center=true);
	rotate(120)rotate(ang, [1,0,0])translate([0,0,-h1/2])cylinder(r=ir1, h=h1,center=true);
	rotate(240)rotate(ang, [1,0,0])translate([0,0,-h1/2])cylinder(r=ir1, h=h1,center=true);
	translate([0,0,thickness/2])cylinder(r=or2, h=thickness,center=true);
	translate([0,0,h2/2]){
		cylinder(r=ir2, h=h2,center=true);	
	   difference(){
			cylinder(r=or2+thickness, h=h2,center=true);
			cylinder(r=or2, h=h2+1,center=true);		
		}
	}
}

module endcap(){

	translate([0,0,thickness/2])cylinder(r=or1, h=thickness,center=true);
	translate([0,0,h1/2]){
		cylinder(r=ir1, h=h1,center=true);
   		difference(){
			cylinder(r=or1+thickness, h=h1,center=true);
			cylinder(r=or1, h=h1+1,center=true);
		
		}
	}

}
translate([or2+or1+thickness*2+5,0,0])endcap();
translate([or2+or1+thickness*2+5,or1*2+thickness*2+5,0])endcap();
translate([or2+or1+thickness*2+5,-or1*2-thickness*2-5,0])endcap();


translate([-or2*2-thickness*2-5,0,0]){
difference(){
	union(){
		translate([0,0,thickness/2])cylinder(r=or2, h=thickness,center=true);
		translate([0,0,h2/2]){
			cylinder(r=ir2, h=h2,center=true);
   			difference(){
				cylinder(r=or2+thickness, h=h2,center=true);
				cylinder(r=or2, h=h2+1,center=true);	
			}
		}
	}
	translate([0,0,h2/2])cylinder(r=or1, h=h2+1,center=true);
	}
}

