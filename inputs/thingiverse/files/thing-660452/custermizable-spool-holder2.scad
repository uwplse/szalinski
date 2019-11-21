

//custermizing data

//Takuya Yamaguchi 2014/5/25
//Takuya Yamaguchi 2015/1/31

//Core Diameter
CD=22; //[15:100]

//Reel Width
RW=86; //[20:120]

difference(){
union(){
cube([20,CD+40,5],center=true); // Screw Braket
translate([0,0,0])rotate([0,0,0])
cylinder(h=5, r=CD/2+CD*0.1,$fn=48,center=true); // Base Fringe
translate([0,0,(RW+20)/2])
cylinder(h=RW+20, r=CD/2,$fn=48,center=true); //main cylinder
translate([0,0,RW+10])
cylinder(h=20, r2=CD/2,r1=CD/2+1.3,$fn=48,center=true); //taper
}
translate([0,CD/2+12,0])rotate([0,0,0])
#cylinder(h=20, r=2.8,$fn=48,center=true); //screw hole
translate([0,-(CD/2+12),0])rotate([0,0,0])
#cylinder(h=20, r=2.8,$fn=48,center=true); // screw hole
translate([0,0,(RW+20)/2+5])
cylinder(h=RW+25, r=CD/2-CD*0.05,$fn=48,center=true); //inner clinder
translate([0,0,RW*0.2+(RW+20)/2+CD/6])rotate([0,0,0])
#cube([CD/3,CD+10,RW+20],center=true); //Slit 
translate([0,0,RW*0.2+CD/6])rotate([90,0,0])
#cylinder(h=RW+1, r=CD/6,$fn=48,center=true); //Slit R
}


