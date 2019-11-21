
//total number of rings
rings=7;
//max thickness of each ring
max_thick=3;
//ratio of smallest thickness to max thickness
min_thick=.4;
//smallest ratio of each inner circle
inner_max=.7;
//how much each subsequent circle moves
sidestep=12;
//most each circle can move up or down
wiggle_room=20;
//min size of each ring
ring_min=15;
//max size of each ring
ring_max=50;

circle_sizes=rands(ring_min,ring_max,rings+1);
circle_smalls=rands(inner_max,.9,rings+1);
circle_rotate=rands(.1,1,rings+1);
circle_thickness=rands(min_thick,1,rings+2);
circle_shift=rands(.5,.8,6);
wiggle=rands(-1,1,rings+1);


module circle_piece (width,height,shrink,spin,shift){
difference() {
	cylinder(r=width/2, h=height, center=true, $fn=200);
	rotate([0,0, spin*360]) 
	translate([width*shift*(.9-shrink)/2, 0, 0]) 
	cylinder(r=shrink*width/2, h=height*2, center=true, $fn=200);	
}
}

for (i=[1:rings]) {
	echo (circle_thickness[i+1]);
	echo (circle_sizes[i]);
	translate([sidestep*i,wiggle[i]*wiggle_room,-((1-circle_thickness[i+1])*max_thick)/2])
	circle_piece (circle_sizes[i],max_thick*circle_thickness[i+1],circle_smalls[i],circle_rotate[i]*360,circle_shift[i]);
}

