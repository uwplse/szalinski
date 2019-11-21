

//Choose the size of plug you want.
gauge=10;//[3,3.97,4,4.67,5,6,6.35,7,7.94,8,9,9.53,10,11,11.1,12,12.7,13,14,14.3,15,15.9,16,17,18,19,19.1,20,21,22,22.2,23,24,25,25.4,26,27,28,29,29.37,30,30.07,31,31.75,32,33,33.34,34,34.93,35,36,36.5,37,38,38.1,39,39.7,40,41,41.3,42,43,44,44.5,45,46,47,47.6,48,49,50,50.8]

//Choose how thick your ear is 1-10.
depth=10;//[1:10]

//Choose hole size: 10=no hole, 1=thin walls.
thickness=1;//[1:27]

module ear_gauge();
{
	difference()
	{
		union()
		{
			cylinder(depth,gauge/2,gauge/2);
			cylinder(depth/2,(gauge/2)+2,(gauge/3));
			translate([0,0,(depth/2)])cylinder(depth/2,(gauge/3),(gauge/2)+2);
		}
		union()
		{
			cylinder(depth,(gauge/2)-thickness,(gauge/2)-thickness);
			cylinder((depth/2)+1,((gauge/2)+2)-thickness,1);
			translate([0,0,depth/2])cylinder((depth/2),1,((gauge/2)+2)-thickness);
		}
	}
}