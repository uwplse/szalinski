//Select Type of Print
Type=1; // [0:Straight Chain,1:Closed Loop]
//Select number of links (for Loop: more than 14!, inspect final link!)
Links=25; // [1:100]
//set thickness
thickness = 2; // [1:2]

//Dual print part to view. Bracelet, even, or odd links. On creation of STL an stl for these 3 parts will be generated.
part = "together"; // [together, even, uneven]

module HEARTS(){
	module HEARTHALF(h){
	  scale([25.4/90, -25.4/90, 1]) union()
	  {
		linear_extrude(height=h)
		  polygon([[-14.571719,-20.933442],[-11.207616,-24.148396],[-7.888872,-26.422799],[-4.654128,-27.828605],[-1.542030,-28.437764],[1.408781,-28.322229],[4.159661,-27.553951],[6.671966,-26.204883],[8.907054,-24.346975],[10.826281,-22.052181],[12.391004,-19.392452],[13.562581,-16.439740],[14.302367,-13.265996],[14.571719,-9.943174],[14.331995,-6.543223],[13.544550,-3.138097],[12.170743,0.200252],[6.765776,10.362507],[3.868395,15.114093],[0.774276,19.408022],[-2.566689,23.065825],[-6.204606,25.909031],[-10.189580,27.759167],[-12.327873,28.256063],[-14.571719,28.437764],[-14.571719,25.281037],[-12.239405,24.716464],[-9.824168,23.279968],[-7.410414,21.096956],[-5.082551,18.292834],[-2.924986,14.993006],[-1.022124,11.322880],[0.541627,7.407860],[1.681860,3.373354],[2.314169,-0.655233],[2.354147,-4.552496],[1.717387,-8.193028],[0.319482,-11.451424],[-1.923974,-14.202277],[-5.097388,-16.320181],[-9.285168,-17.679732],[-14.571719,-18.155522]]);
	  }
	}

	res1=50;
	difference(){
		union(){
			translate([4,0,0]) HEARTHALF(thickness);
			translate([-.52,0,4.17]) rotate([0,-110,0]) HEARTHALF(thickness);
		}
		translate([-20,-20,-2]) cube([40,40,2]);
		translate([-5,-10,-1]) cube([10,2.1,10]);
	}
}
module StraightChain(){
	for (i=[1:Links]){
		if (i%2==1){
			if (part == "together" || part == "uneven")
			translate([0,(10-thickness)*(i),0]) HEARTS();
		} else {
			if (part == "together" || part == "even")
			translate([1,(10-thickness)*(i),0]) mirror([1,0,0]) HEARTS();
		}
		//translate([0,20*(i-1),0]) HEARTS();
		//translate([1,10+20*(i-1),0]) mirror([1,0,0]) HEARTS();
	}
}
module LoopChain(){
	for (i=[1:Links]){
		rotate([0,0,i*Seg]) translate([Rad,0,0])
		if (i%2==1){
         if (part == "together" || part == "uneven") HEARTS();
		} else {
         if (part == "together" || part == "even")
           translate([2.3-thickness,0,0]) mirror([1,0,0]) HEARTS();
		}
	}
}

Pi=3.1415926535897;
Seg=360/Links;
Rad=(Links*(10-thickness+0.8))/(2*Pi);

if (Type==0){
	StraightChain();
} else {
	LoopChain();
}