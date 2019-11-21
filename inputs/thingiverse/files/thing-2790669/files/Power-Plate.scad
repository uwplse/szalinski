
bottom_length = 245;  //total length
bottom_width = 100;  //base width (twist will result in wider overall dimensions)
top_length = 245;
top_width = 130;
edge_rad = 4;    //edge radius of top and bottom surfaces
height = 30;        //minimum height (cant and/or lift will result in taller overall height) - NOTE: ht must be >= 2*edge_rad
twist = 9;     //degrees of twist
cant = 6;       //degrees of cant - this simple demo only supports positive (leftward) cant
lift = 0;       //degrees of lift - this simple demo only supports positive (heel) lift
screw_size = 6.25; //screw hole size
lightening_hole_spacing = 5;  // spacing between lightening holes
steps = 20;     //smoothness factor - more steps = smoother sides
screw_hole_spacing = 20; //spacing for screw holes - should not be changed


//this adjusts the total height, to take into account height added due to the edge radius - shouldn't be changed by user
adj_ht = height - 2*edge_rad;
min_width = min(bottom_width, top_width);
min_length = min(bottom_length, top_length);

//difference to punch holes
difference() {
    //call the plate module to initiate the render
    translate([0,0,edge_rad]) //move to z=0
        plate();
    
	$fa = 1;
    //center lightening hole
	center_lhr = screw_hole_spacing*1.414 - (screw_size / 2) - lightening_hole_spacing;
    cylinder(h=100,r=center_lhr);
    
    //screw holes
    for (i=[0,90,180,270]) rotate(i) screw_holes();
        
    //lightening holes        
    for (i=[0,180]) rotate(i) lightening_holes();
    //lightening_holes();
}

module screw_holes() {
    $fn = 20;
    translate([screw_hole_spacing,screw_hole_spacing,0]) 
        cylinder(h=100,r=screw_size / 2);
}

module lightening_holes() {
	
	s = screw_hole_spacing;
	w = (min_width / 2) - edge_rad;
	q = screw_size /2;
    lhs = lightening_hole_spacing / 2;

	side_lhy = (s + w) / 2;
	side_lhr = (w - s - lightening_hole_spacing) / 2;	
	
    $fa = 0.5;
    translate([0,side_lhy,0])
        cylinder(h=100,r=side_lhr);
	
	tan_twist_2 = tan(twist/2);
    ta = s+q;
	incenter_hole(ta, ta*tan_twist_2, w/tan_twist_2, w, ta, w);
    incenter_hole(ta, ta*tan_twist_2, w/tan_twist_2, w, ta, ta*tan(twist/2) - w);

    rotate([0,0,twist/2-5])
        translate([min_length/2 - w*.7,0,0])
            cylinder(h=100,r=w/2 - lhs);
}

module incenter_hole(Ax, Ay, Bx, By, Cx, Cy) {
   	aL = sqrt(pow(Cx-Bx,2) + pow(Cy-By,2)); // length of BC
	bL = sqrt(pow(Cx-Ax,2) + pow(Cy-Ay,2)); // length of AC
	cL = sqrt(pow(Bx-Ax,2) + pow(By-Ay,2)); // length of AB
	pL = aL + bL + cL;
	
	//calculate incenter of triangle
	Ox = (aL*Ax + bL*Bx + cL*Cx) / pL;
	Oy = (aL*Ay + bL*By + cL*Cy) / pL;

    //calculate distance from center to AB to ger hole radius
    t_area = abs((Ax-Cx)*(By-Ay) - (Ax-Bx)*(Cy-Ay));
    rad = t_area / pL;	

    $fn = 50;
	translate([Ox,Oy,0])
		cylinder(h=100,r=rad - lightening_hole_spacing/2);
}

module plate() {
	$fa = 1;
	for (s = [0:1:steps-1]) {
	    translate([0, 0,  adj_ht/steps * s]) //move up according to step
        rotate([cant/steps * s, -lift/steps * s, 0]) //cant and lift
	    rotate([0, 0, twist/steps * s])  //twist along Z
        component_plate(bottom_width+(top_width-bottom_width)*s/steps, bottom_length+(top_length-bottom_length)*s/steps);
	}
}

module component_plate(width, length) {
	$fa = 1;
    minkowski() {	
        hull() {
            translate([-length/2 + width/2, 0, 0])
                cylinder(r=width/2 - edge_rad, h=.001);
            translate([length/2 - width/2, 0, 0])
                cylinder(r=width/2 - edge_rad, h=.001);
        }
        sphere(r=edge_rad, $fn=20);
    }
}
