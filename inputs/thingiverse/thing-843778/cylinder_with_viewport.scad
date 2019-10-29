//Diameter of cylinder
diameter=30;
//Width of single wall layer
extrusionWidth=0.55;
//Height of cylinder
height=100;
//Height/thickness of bottom (0 for no bottom)
layerHeight=0;
//height of viewport
viewportheight=70;
//viewport width
viewportoffset=-10;
/* [hidden] */
rad=diameter/2;
$fn=50;

union() {
translate([0,0,-layerHeight]) cylinder(r=rad, h=layerHeight);
	difference () {
		cylinder(r=rad, h=height);
        union()
        {
            translate([0,0,-1])
            cylinder(r=rad-extrusionWidth, h=height+2);
            translate([-rad*2,-rad*2+viewportoffset,height/2-viewportheight/2])
            cube(size=[rad*6,rad*2,viewportheight]);
        }
	}
}