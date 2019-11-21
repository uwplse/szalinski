/*[top dimensions]*/
//Show assembled
assembled=1; //[1:yes, 0:no]
stem_height=40;
stem_dia=7.5;
stem_dia_tol=.75;
stem_facets=8;
stem_hole_dia=2.5;
stem_hole_offset=stem_height/2;

base_height=30;
base_dia=50;
base_facets=10;
base_chamfer=10;
base_ring_dia=50;
base_ring_height=10;

/*[handle dimensions]*/
handle_length=100;
handle_thick=stem_dia*2;
handle_width=20;
hole_edge=10;
shaft_tol=1;


top();
if(assembled==0)
translate([0,handle_width+base_dia/2+base_ring_dia/2,0])
handle();
if(assembled==1)
translate([-handle_length/2,0,stem_height/2])
	rotate([90,0,0])
		handle();


module top(){
	if (assembled==1){
		union(){
			rotate([180,0,0])
				base();
			translate([0,0,stem_height])
				rotate([180,0,0])
					stem();
		}
	}
	if(assembled==0){
		base();
		translate([base_ring_dia/2+base_dia/2+stem_dia,0,0])
			stem();

	}

}

module handle(){
	difference(){
		union(){
			cube([handle_length,handle_width,handle_thick],center=true);
			translate([handle_length/2,0,0])
				cylinder(r=stem_height/2,h=handle_thick,$fn=50,center=true);
		}
		translate([handle_length/2,0,0])
			cylinder(r=stem_height/2-hole_edge,h=handle_thick*1.1,$fn=50,center=true);
		translate([handle_length/2,0,0])
			rotate([90,0,0])
				cylinder(r=stem_dia/2+shaft_tol,h=stem_height*1.1,center=true,$fn=50);
		//for(i=[-handle_length/2
	}
}

module base(){
	difference(){
		union(){
			intersection(){
				cylinder(r1=base_dia/2,r2=0,h=base_height,$fn=base_facets);
				cylinder(r=base_dia/2-base_chamfer,h=base_height,$fn=base_facets);
			}
			cylinder(r=base_ring_dia/2,h=base_ring_height,$fn=base_facets);
		}
		cylinder(r=stem_dia/2+stem_dia_tol/2,h=base_height/2,$fn=stem_facets);
	}
	
}

module stem(){
	difference(){
		cylinder(r=stem_dia/2,h=stem_height+base_height/2,$fn=stem_facets);
		translate([0,0,stem_hole_offset])
			rotate([90,-20,0])
				cylinder(r=stem_hole_dia/2,h=stem_dia*1.5,$fn=5,center=true);
	}


}
