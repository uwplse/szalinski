// preview[view:south, tilt:top]
// Number of periods in the pattern per rotation?
whole_periods =4;//[0:10]
// How many times should the pattern wrap around?
turns = 2;//[1:10]
// How tall (in mm)?
height = 30;//[5:200]
// Thickness of the band?
width = 12;//[3:200]
// Inside diameter of the thing?
inner_diameter = 90;//[1:200]
// Diameter of the rail?
rail_diameter = 3; //[2:10]

mirror_reinforced = "yes";//[yes,no]
top_and_bottom_reinforced = "yes";//[yes,no]
inside_and_outside_reinforced = "no";//[yes,no]
// How dense to pack shapes? (100-200 very coarse) (200-500 rough) (500-1000 smooth)
segments_per_turn = 600;//[50:1500]
fragments_per_segment = 25;//[3:40]

ring();

periods = 1/turns+whole_periods;

module ring() {
	union(){
		for ( i = [0 : 1/segments_per_turn : turns] )
		{
			translate([(inner_diameter/2+width/2+rail_diameter/2)*sin(360*i) + width/2*sin(360*i*periods)*sin(i*360), 
						  (inner_diameter/2+width/2+rail_diameter/2)*cos(360*i) + width/2*sin(360*i*periods)*cos(i*360), 
						  height/2*cos(360*i*periods)])
			sphere(r = rail_diameter,$fn = fragments_per_segment,center = true);
		}
		if (mirror_reinforced == "yes")
		{
			for ( i = [0 : 1/segments_per_turn : turns] )
			{
				translate([(inner_diameter/2+width/2+rail_diameter/2)*sin(360*i) + width/2*sin(360*i*periods)*sin(i*360), 
							  (inner_diameter/2+width/2+rail_diameter/2)*cos(360*i) + width/2*sin(360*i*periods)*cos(i*360), 
							  -height/2*cos(360*i*periods)])
				sphere(r = rail_diameter,$fn = fragments_per_segment,center = true);
			}
		}
		if (top_and_bottom_reinforced == "yes")
		{
			for ( i = [0 : 1/segments_per_turn : turns] )
			{
				translate([(inner_diameter/2+width/2+rail_diameter/2)*sin(360*i), 
							  (inner_diameter/2+width/2+rail_diameter/2)*cos(360*i), 
							  height/2])
				sphere(r = rail_diameter,$fn = fragments_per_segment,center = true);
			}
			for ( i = [0 : 1/segments_per_turn : turns] )
			{
				translate([(inner_diameter/2+width/2+rail_diameter/2)*sin(360*i), 
							  (inner_diameter/2+width/2+rail_diameter/2)*cos(360*i), 
							  -height/2])
				sphere(r = rail_diameter,$fn = fragments_per_segment,center = true);
			}
		}
		if (inside_and_outside_reinforced == "yes")
		{
			for ( i = [0 : 1/segments_per_turn : turns] )
			{
				translate([(inner_diameter/2+width+rail_diameter/2)*sin(360*i), 
							  (inner_diameter/2+width+rail_diameter/2)*cos(360*i), 
							  0])
				sphere(r = rail_diameter,$fn = fragments_per_segment,center = true);
			}
			for ( i = [0 : 1/segments_per_turn : turns] )
			{
				translate([(inner_diameter/2+rail_diameter/2)*sin(360*i), 
							  (inner_diameter/2+rail_diameter/2)*cos(360*i), 
							  0])
				sphere(r = rail_diameter,$fn = fragments_per_segment,center = true);
			}
		}
	}
}



