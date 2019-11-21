$fn=120*1;

thickness = 4 * 1;

// Hand spread
cellphoneWidth = 90; // [50:1:200]

// Hand depth
cellphoneThickness = 18; // [8:1:50]

// Foot depth
cellphoneThicknessFeet = 15; // [8:1:50]

bodyWidth = 20 * 1;
spread = 1.5*2;
difference(){
union(){
difference()
{
union(){
	cube([80,bodyWidth,thickness]); //body
	
	translate([80,        0,0]) cylinder(h=thickness, r=(bodyWidth/2)+spread); //left pelvis
	translate([80,bodyWidth,0]) cylinder(h=thickness, r=(bodyWidth/2)+spread); //right pelvis
	
	translate([80,-10-spread,0]) cube([40,15,thickness]); //left leg
	translate([80,15+spread,0]) cube([40,15,thickness]); //right leg

	translate([bodyWidth, 10,0]) rotate(a=[0,0,205.1]) cube([15,200,thickness]); //left arm
	translate([6.5,bodyWidth,0]) rotate(a=[0,0,334.8]) cube([15,200,thickness]); //right arm

	translate([-(bodyWidth/2),(bodyWidth/2),0]) cylinder(h=thickness, r=bodyWidth); //head

}
# translate([85+spread/2,10,-1]) cylinder(h=thickness+2,r=5+spread); //trouser-clearer 1
# translate([85,5-spread,-1]) cube([10+spread*2,10+spread*2,thickness+2]); //trouser-clearer 2

translate([0,-400-(cellphoneWidth/2)+(bodyWidth/2),-1]) cube([400,400,thickness+2]); //arm-clearer 1

translate([0,(bodyWidth/2)+(cellphoneWidth/2),-1]) cube([400,400,thickness+2]); //arm-clearer 2

translate([-(bodyWidth/2)-5,(bodyWidth/2)-7,-1]) cylinder(h=thickness+2, r=5);//left eye
translate([-(bodyWidth/2)-5,(bodyWidth/2)+7,-1]) cylinder(h=thickness+2, r=5);//right eye

translate([-(bodyWidth/2),(bodyWidth/2),-1]) difference() //mouth
{
	cylinder(h=thickness+2,r=15);
	translate([-4,0,0]) cylinder(h=thickness+2,r=15);
}
}
translate([21-((75-cellphoneWidth)/4),-(cellphoneWidth/2)+(bodyWidth/2)-5,0]) hand(); //left hand
translate([21+15-((75-cellphoneWidth)/4),5+(cellphoneWidth/2)+(bodyWidth/2),0]) rotate(a=[0,0,180]) hand(); //right hand

translate([5+80+40-1,-10-spread,0]) rotate(a=[0,0,90]) foot();
translate([5+80+40-1,15+spread,0]) rotate(a=[0,0,90]) foot();
}
	translate([40,bodyWidth/2,3]) cylinder(h=thickness+2,r=2.75);
	translate([40+20,bodyWidth/2,3]) cylinder(h=thickness+2,r=2.75);
	translate([40,bodyWidth/2,-1]) cylinder(h=thickness+2,r=1.75);
	translate([40+20,bodyWidth/2,-1]) cylinder(h=thickness+2,r=1.75);
}

module hand()
{
	difference()
	{
		union()
		{
			cube([16.5,5,thickness+cellphoneThickness]);
			translate([0,0,thickness+cellphoneThickness]) cube([16.5,11.2,6.5]);
		}
		translate([-1,10,thickness+cellphoneThickness-5]) rotate(a=[45,0,0]) cube([16.5+2,10,5+2]);
	}
}

module foot()
{
	difference()
	{
		union()
		{
			cube([15,5,thickness+cellphoneThicknessFeet]);
			translate([0,0,thickness+cellphoneThicknessFeet]) cube([15,11.2,6.5]);
			translate([0,thickness+3,thickness-0.1]) rotate(a=[135,0,0]) cube([15,4,4]);
		}
		translate([-1,10,thickness+cellphoneThicknessFeet-5]) rotate(a=[45,0,0]) cube([15+2,10,5+2]);
	}
}