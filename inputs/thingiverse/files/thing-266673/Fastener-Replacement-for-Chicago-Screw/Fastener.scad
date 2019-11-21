$fn=20;
HeadHeight=1; // [1,1.5,2,2.5,3]
HeadDiameter=10; //[7:15]
SleeveLength=10; //[1:100]
SleeveOutterDiameter=5.08;//[5.00,5.08,6,7,8,9,10]
Play=0.1;// [0.0,0.1,0.2,0.3,0.4,0.5]

HeadRadius=HeadDiameter/2;
SleeveOutterRadius=SleeveOutterDiameter/2;
SleeveInnerRadius=(SleeveOutterRadius/2)-Play;

O1=HeadDiameter/2;
O2=HeadDiameter+10;
O3=(HeadDiameter*2)+15;
O4=(HeadDiameter*3)+20;

translate([O1,0,0]) core();
translate([O2,0,0]) core();
translate([O3,0,0]) outter();
translate([O4,0,0]) outter();

module core() {
	difference() {
		union() {
			rotate([-90,0,0]) cylinder(r=SleeveInnerRadius,h=SleeveLength+(HeadHeight*2));
			rotate([-90,0,0]) cylinder(r=HeadRadius,h=HeadHeight);
		}
		translate([-HeadRadius,0,-HeadRadius]) cube([HeadDiameter+1,SleeveLength+(HeadHeight*2)+1,HeadRadius]);
	}
}

module outter() {
	difference() {
		union() {
			rotate([-90,0,0]) cylinder(r=SleeveOutterRadius,h=SleeveLength+HeadHeight);
			rotate([-90,0,0]) cylinder(r=HeadRadius,h=HeadHeight);
		}
		rotate([-90,0,0]) cylinder(r=SleeveInnerRadius+Play,h=SleeveLength+HeadHeight);
		translate([-HeadRadius,0,-HeadRadius]) cube([HeadDiameter+1,SleeveLength+HeadHeight+1,HeadRadius]);
	}
}
