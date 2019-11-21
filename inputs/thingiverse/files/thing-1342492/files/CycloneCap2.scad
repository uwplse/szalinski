res = 40;

intake_d_ext = 60; //external diameter of intake pipe at base
intake_sh = 5;	// thickness of wall of intake pipe
intake_d_int = 39; // intake entrance internal diameter
intake_d_int_diff = 1; // intake internal diameter shrink
intake_l = 100; // Length of the intake pipe

outlet_d_ext = 80; //external diameter of intake pipe at base
outlet_sh = 5;	// thickness of wall of intake pipe
outlet_d_int = 35; // intake entrance internal diameter
outlet_d_int_diff = -1; // intake internal diameter shrink
outlet_l = 80; // Length of the intake pipe

top_d = 177.5;
top_t = 5;
top_h = 80;
shell = 3;


module cover(){
	difference(){
		union(){
			translate([0,0,top_h])rotate(a=[180,0,0])outlet_pipe_pos();
			difference(){
				union(){
					cylinder(r=top_d/2,h=top_h,$fn=res);
					translate([top_d/2-intake_d_int/2-shell,0,top_h-intake_d_ext/2])rotate(a=[90,360/res/2,0])intake_pipe_pos();
					translate([top_d/2-intake_d_int/2-shell,0,top_h-intake_d_ext/2])scale([1,1.5,1])sphere(r=intake_d_ext/2,$fn=res);
		
				}
				union(){
					cylinder(r=top_d/2-shell,h=top_h-top_t,$fn=res);
					translate([top_d/2-intake_d_int/2-shell,0,top_h-intake_d_ext/2])rotate(a=[90,0,0])intake_pipe_neg();
				}
			}
		}
		translate([0,0,top_h+0.005])rotate(a=[180,0,0])outlet_pipe_neg();
	}
}

module intake_pipe_pos(){
	cylinder(r1=intake_d_ext/2,r2=intake_d_int/2+intake_sh,h=intake_l,$fn=res);
}

module intake_pipe_neg(){
	cylinder(r1=(intake_d_int-intake_d_int_diff)/2,r2=intake_d_int/2,h=intake_l,$fn=res);
}

module outlet_pipe_pos(){
	cylinder(r1=outlet_d_ext/2,r2=outlet_d_int/2+outlet_sh,h=outlet_l,$fn=res);
}

module outlet_pipe_neg(){
	cylinder(r1=(outlet_d_int-outlet_d_int_diff)/2,r2=outlet_d_int/2,h=outlet_l+0.01,$fn=res);
}


/*
difference(){
	union(){
		cylinder(r1=60/2,r2=44/2,h=50,$fn=res);
		import("CycloneCap.stl");
	}
	cylinder(r1=35/2,r2=36/2,h=50,$fn=res);
}*/

cover();
//intake_pipe();