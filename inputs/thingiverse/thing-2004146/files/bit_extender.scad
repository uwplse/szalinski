
/* [Adapter Type] */
type=2; // [1:pin+hole,2:hole+hole]
/* [Adapter shape] */
//exterior of the adapter
form=1; // [1:cylinder,2:hexagon]
/* [Bit size] */
// size of the bit in mm
size=6.2;
// Deep of the hole for the bit in mm
deep=10;
/* [Joint parameters] */
//how much to add to bit size for external diameter of extender (teoretically affect the hardeness, of course the print setting also important)
diameter=3; // [1:1mm,2:2mm,3:3mm,4:4mm,5:5mm, 6:6mm]
// distance (in mm.) between two bit's holes inside the adapter. May be used to get long adapter. Full adapter height=deep*2+distance
distance=3;
/* [Material properties] */
// Shrinkage is differ for materials. Size of holes will be increased forthis value. Try  the default, correct if too tight.
shrinkage=0.1;

if (distance<2) {
    distance=2;
    };

radius=(diameter+size)/2;
    
if (type==2){
difference(){
difference(){
if (form==1){
cylinder(deep*2+distance,r=radius+shrinkage,center=false);
}else{
    Hexagone(radius*2,deep*2+distance);
};
Hexagone(size+shrinkage,deep);
    };
translate([0,0,deep+distance]) {Hexagone(size+shrinkage,deep);
    };
};
} else {
difference(){
if (form==1) {
    cylinder(deep+distance,r=radius+shrinkage,center=false);
} else {
    Hexagone(radius*2,deep+distance);
};
Hexagone(size+shrinkage,deep);
};
translate([0,0,deep+distance]) {Hexagone(size-shrinkage,deep);
    };
};
function cot(x)=1/tan(x);
module Hexagone(size,height)
{
	angle = 60;		
	width = size * cot(angle);

    translate([0,0,height/2]){

	union()
	{
		rotate([0,0,0])
			cube([size,width,height],center=true);
		rotate([0,0,angle])
			cube([size,width,height],center=true);
		rotate([0,0,2*angle])
			cube([size,width,height],center=true);
	}
};
}
