/**********************************
RPI case cylinder generator
(http://www.thingiverse.com/thing:2480069)

Author: Philippe Petitjean, 08/2017
License : GNU - GPL

v3 better customizer, less supports for cap, view much faster, front grid choice.
v2 add top grid option + customizer makerbot variables
v1 initial version

**********************************/

/**********************************
 Select output here!
**********************************/
/*[Select Output]*/
draw_rpi_middle_case=1;// [0:off,1:on]
draw_rpi_top_case=1;// [0:off,1:on]
draw_bottom=1;// [0:off,1:on]
draw_mount_rpi=1;// [0:off,1:on]
draw_pad=1;// [0:off,1:on]


// Global resolution
$fs = 0.1*1;  // Don't generate smaller facets than 0.1 mm
$fa = 5*1;    // Don't generate larger angles than 5 degrees

$vpt = [37.5, -36.02, 68.48];
$vpr=[64.10,0.0,41.80];
$vpd=679.97;


/*[Space Fit Parameter]*/
//Space to fit
clearance=1;


//rpi case dimension
/*[Case Parameter]*/
rpi_case_diameter=120;//[80:200]
rpi_case_thickness=2;
rpi_case_hight=120;//[80:200]


//********************
//rpi top case
//********************
/*[Top Case Parameter]*/
rpi_top_hight=35; //[10:200]
rpi_top_thickness=2;

//remove support structure for cap
rpi_top_polygon=rpi_case_diameter-(rpi_case_diameter-rpi_case_thickness*2);
rpi_top_transpoly=rpi_case_diameter/2-rpi_top_polygon;


/**********************************
 Options cap grid
**********************************/
rpi_top_circle_grid=1;// [0:off,1:on]

circlegrid_diameter=100;//[50:200]
circlegrid_hight=120*1;
circlegrid_thickness=4;
circlegrid_nb_space=6;//[0:20]
circlegrid_space=10;//[0:40]
circlegrid_circle_nb=3;//[0:20]
circlegrid_circle_space=15;//[0:40]

//*********************************



//********************
// opening bottom 
//********************
/*[Bottom Case Parameter]*/
bottom_opening_d=80;//[0:200]
//bottom_opening_h=100;//[0:200]
bottom_opening_facettes=12;//[3:100]

/**********************************
// Fixations
// rpi Board Dimensions
**********************************/
/*[Mount Board Parameter]*/
boardWidth=56;
boardLength=85;

gap_hole_lenght=58;
gap_hole_width=49;

mount_hole_diameter=2.75;
mount_hole_side_offset=3.5;
mount_hole_mid_offset=boardLength-mount_hole_side_offset-gap_hole_lenght;

mount_riser_height=10;//[5:40]
mount_riser_scale=2*1;

px1 = boardWidth/2-mount_hole_side_offset;
py1 = -boardLength/2+mount_hole_side_offset;

px2 = -boardWidth/2+mount_hole_side_offset;
py2 = -boardLength/2+mount_hole_side_offset;

px3 = px1;
py3 = py1+gap_hole_lenght;

px4 = px2;
py4 = py1+gap_hole_lenght;

board_mount_offset_x=0*1;
board_mount_offset_y=0*1;
board_mount_offset_z=15;//[10:40]

//********************
//rail support inside
//********************
/*[Mount Rail Parameter]*/
rail_dimension=10;//[10:20]
p=sqrt(pow(rail_dimension/2,2)*2);
rail_lenght=10;//[10:40]
rail_thickness=5;//[2:20]
rail_face=2;//[2:10]

//********************
// front grid
//********************
/*[Front Grid Parameter type 1]*/
grid_type=2;//[1,2]
grid_number_hight=6;//[1:20]
grid_number_width=6;//[1:20]
grid_hole_diameter=8;//[1:20]
grid_add_space=4;//[1:20]
cell_heigth=rpi_case_diameter;
grid_tx=0*1;
grid_ty=0*1;
tz=rpi_case_hight/2;
grid_rx=90;//[1:200]
grid_ry=0*1;
grid_rz=0*1;
grid_angle_max=80;//[40:180]

//type 2
/*[Front Grid Parameter type 2]*/
g_f_c_diameter = 100; //[50:200]
g_f_c_hight = 120; //[50:200]
g_f_c_thickness = 4;//[1:20]
g_f_c_nb_space = 6;//[1:20]
g_f_c_space=10;//[1:20]
g_f_c_number = 5;//[1:20]
g_f_c_circle_space = 15;//[1:40]


//********************
// Pad bottom support 
//********************
/*[Bottom Pad Parameter]*/
pad_diam_s=30;//[10:60]
pad_diam_e=20;//[10:60]
pad_nb=6;//[3:12]
pad_hight=30;//[10:100]
pad_angle=25;//[0:180]
pad_notch=10;//[5:60]
pad_hole_diam=2.5;
pad_circle_hight=5;//[1:20]

//********************
// Cable side opening
//********************
/*[Window side Parameter]*/
cable_px=0*1;
cable_py=30;//[0:100]
cable_pz=board_mount_offset_z+10;
cable_rx=0*1;
cable_ry=0*1;
cable_rz=0*1;
cable_slot_hight=20;//[0:200]
cable_slot_h=boardLength-cable_slot_hight;
cable_slot_w=5;//[1:20]
cable_round=5;//[1:20]

//********************
//   Fixation hole 
//********************
/*[Fixation Hole Parameter]*/
fixation_nb=3;//[0:10]
fixation_r_offset=0*1;

fixe_cube_size=10;
fixe_cube_size_h=6;
fixe_cube_screw_d=3;
fixe_cube_screw_h=22;
fixe_cube_boulon_d=6;
fixe_cube_boulon_h=2.5;


//********************
// Fixation 
//********************
module ngt_fixe_cube(){
    union() {
            cylinder(d=fixe_cube_screw_d,h=fixe_cube_screw_h,center=true);
            translate([0,0,-fixe_cube_size_h/2+fixe_cube_boulon_h/2])cylinder(h=fixe_cube_boulon_h,d=fixe_cube_boulon_d,center=true,$fn=8);
    }
}

module fixe_cube(){
    difference (){
        cube([fixe_cube_size,fixe_cube_size,fixe_cube_size_h],center=true);
        ngt_fixe_cube();
    }
}


module fixation(fixe_r=0,fixe_offset=0){
  rotate([0,0,fixe_r]) {  translate([0,-rpi_case_diameter/2+rpi_case_thickness+fixe_cube_size_h/2+clearance/2,fixe_offset]) rotate([0,90,-90])fixe_cube(); }   
}

module ngt_fixation(fixe_r=0,fixe_offset=0){
  rotate([0,0,fixe_r]) {  translate([0,-rpi_case_diameter/2+rpi_case_thickness+fixe_cube_size_h/2+clearance/2,fixe_offset]) rotate([0,90,-90])ngt_fixe_cube(); }   
}

//********************
// mount hole module
//********************
module mount_hole() {
    difference() {
    cylinder(h=mount_riser_height, d=mount_hole_diameter*mount_riser_scale);
    translate([0, 0, mount_riser_height/2]) cylinder(h=10, d=mount_hole_diameter);
    } 
}

//*******************************
// rpi 2/3 mounting plate module
//*******************************
module A(){
   
    //mounting rail
    rotate(180) translate([0,(rail_lenght+rail_dimension/2)/2,0]) {
        
    union(){
        rotate(45) cube([rail_dimension/2,rail_dimension/2,boardLength],center=true);
        translate([0,rail_lenght/2,0]) cube([rail_dimension/4,rail_lenght,boardLength],center=true);
    }
    
        //plaque
        translate([0,rail_lenght,0]) cube([boardWidth,rail_face,boardLength],center=true);
        
        //p1 
        translate([px1,rail_lenght,py1]) rotate([-90,0,0]) mount_hole();
        
        //p2 
        translate([px2,rail_lenght,py2]) rotate([-90,0,0]) mount_hole();
        
        //p3 
        translate([px3,rail_lenght,py3]) rotate([-90,0,0]) mount_hole();
        
        //p4 
        translate([px4,rail_lenght,py4]) rotate([-90,0,0]) mount_hole();
    }
}

module B() {
    union(){
        rotate(45) cube([rail_dimension/2+clearance,rail_dimension/2+clearance,boardLength],center=true);
        translate([0,rail_lenght/2,0]) cube([rail_dimension/4+clearance,rail_lenght,boardLength],center=true);
    }
}

module C() {
    rotate(180) translate([0,(rail_lenght+rail_dimension/2)/2,0])
    difference(){
        translate([0,0,-rail_thickness/2]) cube([rail_dimension,rail_lenght+rail_dimension/2,boardLength+rail_thickness],center=true);
        B();
    }
}


//********************
//mounting plate rpi
//********************
if (draw_mount_rpi) {
    translate([0,rpi_case_diameter/2,rpi_case_hight/2]) A();
}
   
//***********************
// mounting rail module
// + cut to size 
//***********************
module rail_int(){
        difference (){
            translate([0,rpi_case_diameter/2,rpi_case_hight/2]) C();
            difference () {
                cylinder(r=rpi_case_diameter*2, h=rpi_case_hight, center=false);
                cylinder(r=rpi_case_diameter/2, h=rpi_case_hight, center=false);
            }
        }
    }


//***********************
// Pad module
//***********************
module pad(){
    //cercle bas
	difference(){
		union () {
			cylinder(r=rpi_case_diameter/2+pad_diam_e/2, h=pad_circle_hight, center=center);
			for (i = [1:pad_nb]) rotate([0,0,(360/pad_nb*i)+pad_angle]) {
				translate([0,rpi_case_diameter/2,0])  cylinder(h=pad_hight,r1=pad_diam_s/2,r2=pad_diam_e/2); 
			}
		}
		translate([0,0,pad_notch]) cylinder(r=rpi_case_diameter/2+clearance/2, h=rpi_case_hight, center=center);
		translate([0,0,-0.01]) cylinder(r=rpi_case_diameter/2-rpi_case_thickness, h=rpi_case_hight, center=center);
		translate([0,0,pad_notch/2+pad_hight/2]) pad_hole();
	}
}


module pad_hole(){
    for (i = [1:pad_nb]) rotate([0,0,(360/pad_nb*i)+pad_angle]){ { 
        translate([0,rpi_case_diameter/2+pad_diam_e/2,0]) { rotate([90,0,0]) cylinder(h=50,d=pad_hole_diam); } } }
}


//**************************
// Pad
//**************************
if (draw_pad){
    //translate([0,0,-rpi_top_hight-pad_notch]) pad();
	translate([0,0,-rpi_top_hight-pad_notch]) pad();
}

//***************************
// module rpi middle case
//***************************
module rpi_cylinder(){
    difference() {        
        cylinder(d=rpi_case_diameter, h=rpi_case_hight, center=false);
        translate([0,0,-0.01]) cylinder(d=rpi_case_diameter-rpi_case_thickness*2, h=rpi_case_hight+0.02, center=false);
    }
}


//***************************
// module rpi top case
//***************************
module rpi_top() {
    translate([0,0,0]){
        //translate([0,0,rpi_top_hight/2]) cube([1,1,1],center=true);
        difference () {
			union(){
				//cap + edge
				difference(){
					cylinder(d=rpi_case_diameter, h=rpi_top_hight, center=true);
					translate([0,0,-rpi_top_thickness+0.02]) { cylinder(d=rpi_case_diameter-rpi_case_thickness*2, h=rpi_top_hight+0.01, center=true); }
				}

				//joint
				translate([0,0,-rpi_top_hight/2-2]){  
				   difference(){
						cylinder(d=(rpi_case_diameter-rpi_case_thickness*2)-clearance, h=4, center=true);
						cylinder(d=(rpi_case_diameter-rpi_case_thickness*2*2), h=4+0.01, center=true);
					}
				}
				
				translate([0,0,-rpi_top_hight/2]) rotate_extrude(convexity = 10) translate([rpi_top_transpoly,0,0]) polygon(points=[[0,0],[rpi_top_polygon,0],[rpi_top_polygon,rpi_top_polygon]]);
			}
    
			//bracket, hole
			
			for(i=[1:fixation_nb]) {
				ngt_fixation(fixe_r=i*(360/fixation_nb)+fixation_r_offset,fixe_offset=-fixe_cube_size/2-rpi_top_hight/2);
			} 
			
    
		}
        
        //bracket
        for(i=[1:fixation_nb]) {
            fixation(fixe_r=i*(360/fixation_nb)+fixation_r_offset,fixe_offset=-fixe_cube_size/2-rpi_top_hight/2);
        }
        
    }
}

if (draw_rpi_top_case) {
	render(convexity = 2){
		if (rpi_top_circle_grid){
			difference() {
				translate([0,0,rpi_case_hight+rpi_top_hight/2])  rpi_top();
				translate([0,0,rpi_case_hight+rpi_top_hight/2]) circle_grid(circlegrid_diameter=circlegrid_diameter,circlegrid_hight=circlegrid_hight,circlegrid_thickness=circlegrid_thickness,circlegrid_nb_space=circlegrid_nb_space,circlegrid_space=circlegrid_space,circlegrid_circle_nb=circlegrid_circle_nb,circlegrid_circle_space=circlegrid_circle_space);
			}
		} else {
			translate([0,0,rpi_case_hight+rpi_top_hight/2]) rpi_top();
		}
	
	}	
}



module nb_ngt_fixation(){
            for(i=[1:fixation_nb]) {
            ngt_fixation(fixe_r=i*(360/fixation_nb)+fixation_r_offset,,fixe_offset=fixe_cube_size/2);
        } 
}


//***************************
// module bottom case
//***************************
if (draw_bottom){
	render(convexity = 2){
		difference(){
				difference(){
					translate([0,0,-rpi_top_hight/2]) rotate([0,180,0])  rpi_top();
					translate([0,0,0-rpi_top_hight+rpi_top_thickness+(pad_hight/2-pad_notch/2)-2]) pad_hole();
				}

			//grid
			//translate([0,0,-rpi_top_hight-rpi_top_thickness]) rotate([0,-180,0]) difference(){
				translate([0,0,-rpi_top_hight+rpi_top_thickness+0.01]) rotate([0,-180,0]) difference(){
				cylinder(d=bottom_opening_d,h=rpi_top_thickness*2,$fn=bottom_opening_facettes,centrer=true);
				
				union(){
					for (i=[1:6]){
						rotate([0,0,i*360/6])cube([5,bottom_opening_d,bottom_opening_d*2],center=true);
					}   
				}
			}

		}
	}
}

//********************
// grid module
//********************
module grid(){
	translate ([grid_tx,grid_ty,tz]) rotate([grid_rx,grid_ry,grid_rz]) {
		for (j=[0:grid_number_hight]){
			for (i=[0:grid_number_width]){
				translate ([0,j*(grid_hole_diameter+grid_add_space)-(grid_number_hight*(grid_hole_diameter+grid_add_space)/2),0]) rotate([0,(grid_angle_max/grid_number_width*i)-grid_angle_max/2,0]) { rotate ([0,0,90])cylinder(h=cell_heigth,d=grid_hole_diameter, center = false,$fn=6) ;}
			}
		}
	}
}

module grid2(){
	translate ([grid_tx,grid_ty,tz]) rotate([grid_rx,grid_ry,grid_rz]) {
		for (j=[0:grid_number_hight]){
			for (i=[0:grid_number_width]){
				translate ([0,j*(grid_hole_diameter+grid_add_space)-(grid_number_hight*(grid_hole_diameter+grid_add_space)/2),0]) rotate([0,(grid_angle_max/grid_number_width*i)-grid_angle_max/2,0]) { rotate ([0,0,90])cylinder(h=cell_heigth,d=grid_hole_diameter, center = false,$fn=6) ;}
			}
		}
	}
}

//********************
//side opening for cable 
//********************
module slot_cable() {
    minkowski()
    {
        translate ([cable_px,cable_py,cable_pz]) rotate([grid_rx,grid_ry,grid_rz]) cube([rpi_case_diameter,cable_slot_h,cable_slot_w],center=false);
        sphere(r=cable_round);
    }
}

//********************
// rpi middle case
//********************
if (draw_rpi_middle_case) {
	render(convexity = 2){
		difference (){
			rpi_cylinder();
			
			if (grid_type==1){
				grid();
				}
			if (grid_type==2){
				translate([0,-rpi_case_diameter/2,rpi_case_hight/2])  rotate([90,0,0]) circle_grid(circlegrid_diameter=g_f_c_diameter,circlegrid_hight=g_f_c_hight,circlegrid_thickness=g_f_c_thickness,circlegrid_nb_space=g_f_c_nb_space,circlegrid_space=g_f_c_space,circlegrid_circle_nb=g_f_c_number,circlegrid_circle_space=g_f_c_circle_space);
				}
			slot_cable(round=5,slot=5);
			  
			for(i=[1:fixation_nb]) {
				ngt_fixation(fixe_r=i*(360/fixation_nb)+fixation_r_offset,fixe_offset=fixe_cube_size/2);
				ngt_fixation(fixe_r=i*(360/fixation_nb)+fixation_r_offset,fixe_offset=rpi_case_hight-fixe_cube_size/2);
			} 
		}
		rail_int();
		//translate([0,-rpi_case_diameter/2,rpi_case_hight/2])  rotate([90,0,0])  circle_grid(circlegrid_circle_nb=1);
	}
}


//********************
// circle grid module
//********************
module circle_grid (circlegrid_diameter=100,circlegrid_hight=120,circlegrid_thickness=4,circlegrid_nb_space=6,circlegrid_space=10,circlegrid_circle_nb=3,circlegrid_circle_space=15) {
		
		//make f5 much faster
		render(convexity = 2)
		{
			ciclegrid_angle=(360/circlegrid_nb_space/2);
			for (c=[0:circlegrid_circle_nb-1]){
				dcs=c*circlegrid_circle_space;
				dca=c*ciclegrid_angle;
				rotate(dca) difference(){
					cylinder(d=circlegrid_diameter-dcs, h=circlegrid_hight, center=true);
					cylinder(d=circlegrid_diameter-circlegrid_thickness*2-dcs, h=circlegrid_hight+2, center=true);
					union(){
					for (i=[1:circlegrid_nb_space]){
						rotate(i*360/circlegrid_nb_space) translate([-circlegrid_space/2,0,-circlegrid_hight/2]) cube([circlegrid_space,circlegrid_diameter,circlegrid_hight+2]);
					}
					}
				}

			}
		}
}

