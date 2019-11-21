
$fn=25; //[10:Small, 25:Medium, 40:Large]

level1_b_diameter1=40; //[0:100]
level1_b_diameter2=35;	//[0:100]
level1_b_thickness=2; //[0:10]
level1_m_diameter1=0;		//[0:100]
level1_m_diameter2=0;		//[0:100]
level1_m_hight=30;	//[0:100]
level1_t_diameter1=35;	//[0:100]
level1_t_diameter2=25;	//[0:100]
level1_t_hight=10;	//[0:10]
level1_column_number=12;		//[0:20]
level1_column_diameter=4;	//[0:20]
level2_b_diameter=10; //[0:50]
level2_b_hight=20;	//[0:100]
level2_t_diameter=1;	//[0:50]
level2_t_hight=10;	//[0:50]

//first level
	//first level bottom
		translate([0,0,level1_b_thickness/2])
		cylinder(h=level1_b_thickness, r1=level1_b_diameter1/2, r2=level1_b_diameter2/2, center=true);
	
	//first level middle
		translate([0,0,level1_b_thickness+level1_m_hight/2])
		cylinder(h=level1_m_hight, r1=level1_m_diameter1/2, r2=level1_m_diameter2/2, center=true);
	
	//first level top
	difference(){
		translate([0,0,level1_b_thickness+level1_m_hight+level1_t_hight/2])
		cylinder(h=level1_t_hight, r1=level1_t_diameter1/2, r2=level1_t_diameter2/2, center=true);
		translate([0,0,level1_b_thickness+level1_m_hight+level1_t_hight/2])
		cylinder(h=level1_t_hight+0.1, r1=(level1_t_diameter1-level1_column_diameter*2)/2, r2=(level1_t_diameter2-level1_column_diameter*2)/2, center=true);
		
		}

	
	//first level columns
		for ( i = [ 0 : level1_column_number ] )
			{
			translate([(cos(i*360/level1_column_number))*((level1_b_diameter2-level1_column_diameter)/2),sin(i*360/level1_column_number)*((level1_b_diameter2-level1_column_diameter)/2),(level1_b_thickness+level1_m_hight/2)])
				cylinder(h=level1_m_hight, r=level1_column_diameter/2, center=true);
				
			}


		level2_c_diameter=level1_t_diameter2;
		translate([0,0,level1_b_thickness+level1_m_hight+level1_t_hight])
			{
				difference()
					{
						semi_sphere();
						translate([0,0,-level2_c_diameter/2])
						cube(level2_c_diameter, true);
					}
			}


module semi_sphere() {
difference()
								{
								union(){
								sphere(r=level2_c_diameter/2);
								translate([0,0,level2_c_diameter/2-level1_column_diameter/2])
								cylinder(h=level2_b_hight, r=level2_b_diameter/2, center=true);
								translate([0,0,((level2_c_diameter/2)-(level1_column_diameter/2)+(level2_b_hight/2)+(level2_t_hight/2))])
								cylinder(h=level2_t_hight, r1=level2_b_diameter/2, r2=level2_t_diameter/2, center=true);
								}
								sphere(r=(level2_c_diameter-2*level1_column_diameter)/2);
								}
							}