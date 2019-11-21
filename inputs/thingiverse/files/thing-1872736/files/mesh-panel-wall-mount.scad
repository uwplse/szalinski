// preview[view:east, tilt:top diagonal]

/*[Parameters]*/

wire_diameter = 3.8;	//[2.0:2.0mm,2.1:2.1mm,2.2:2.2mm,2.3:2.3mm,2.4:2.4mm,2.5:2.5mm,2.6:2.6mm,2.7:2.7mm,2.8:2.8mm,2.9:2.9mm,3.0:3.0mm,3.1:3.1mm,3.2:3.2mm,3.3:3.3mm,3.4:3.4mm,3.5:3.5mm,3.6:3.6mm,3.7:3.7mm,3.8:3.8mm,3.9:3.9mm,4.0:4.0mm,4.1:4.1mm,4.2:4.2mm,4.3:4.3mm,4.4:4.4mm,4.5:4.5mm,4.6:4.6mm,4.7:4.7mm,4.8:4.8mm,4.9:4.9mm,5.0:5.0mm]
clearance = 0.1;	//[0.1:0.1mm,0.2:0.2mm,0.3:0.3mm,0.4:0.4mm]
panel_offset = 6;	//[3:3mm,4:4mm,5:5mm,6:6mm,7:7mm,8:8mm,9:9mm,10:10mm]
testprint = 0;	//[0:None,1:For Test Print]
quantity = 1;	//[1:1,2:2,3:3,4:4,5:5,6:6]

/*[Hidden]*/

module mesh_panel_wall_mount(wire_diameter,clearance,panel_offset,testprint,quantity)
{
	module rounded_cube(x,y,z,r,top_chamfer,bottom_chamfer) {
		difference(){
			cube([x,y,z]);
			if ( r > 0 ) {
				for ( tr=[[[-adj,-adj,-adj],[r,r,-adj]],[[x-r,-adj,-adj],[x-r,r,-adj]],[[-adj,y-r,-adj],[r,y-r,-adj]],[[x-r,y-r,-adj],[x-r,y-r,-adj]]] ) {
					difference(){
						translate(tr[0]) cube([r+adj,r+adj,z+adj*2]);
						translate(tr[1]) cylinder(r=r,h=z+adj*2,$fn=fn);
					}
				}
			}

			if ( top_chamfer > 0 ) {
				for ( tr=[[[0,r,0],[0,0,0],y],[[r,y,0],[0,0,-90],x],[[x,y-r,0],[0,0,-180],y],[[x-r,0,0],[0,0,-270],x]] ) {
					translate(tr[0]) {
						rotate(tr[1]) {
							translate([0,-adj,z]) {
								rotate([-90,0,0]) {
									linear_extrude(height=tr[2]-r*2+adj*2,center=false,convex=10) {
										polygon(points=[[-adj,-adj],[top_chamfer+adj,-adj],[-adj,top_chamfer+adj]]);
									}
								}
							}
							translate([r,tr[2]-r*2,z]) {
								intersection() {
									rotate_extrude($fn=fn) {
										translate([-r,0,0]) {
											polygon(points=[[-adj,adj],[top_chamfer+adj,adj],[-adj,-top_chamfer-adj]]);
										}
									};
									translate([-r-adj,0,-top_chamfer-adj]) {
										cube([r+adj,r+adj,top_chamfer+adj*2]);
									}
								}
							}
						}
					}
				}
			}


			if ( bottom_chamfer > 0 ) {
				for ( tr=[[[0,r,0],[0,0,0],y],[[r,y,0],[0,0,-90],x],[[x,y-r,0],[0,0,-180],y],[[x-r,0,0],[0,0,-270],x]] ) {
					translate(tr[0]) {
						rotate(tr[1]) {
							translate([0,-adj,0]) {
								rotate([-90,0,0]) {
									linear_extrude(height=tr[2]-r*2+adj*2,center=false,convex=10) {
										polygon(points=[[-adj,adj],[bottom_chamfer+adj,adj],[-adj,-bottom_chamfer-adj]]);
									}
								}
							}
							translate([r,tr[2]-r*2,0]) {
								intersection() {
									rotate_extrude($fn=fn) {
										translate([-r,0,0]) {
											polygon(points=[[-adj,-adj],[bottom_chamfer+adj,-adj],[-adj,bottom_chamfer+adj]]);
										}
									};
									translate([-r-adj,0,-adj]) {
										cube([r+adj,r+adj,bottom_chamfer+adj*2]);
									}
								}
							}
						}
					}
				}
			}


		}
	}

	fn=36;
	width=24;
	depth=80;
	height=2.0;
	staple_thickness=0.4;
	staple_width=11;
	bezel_width=3.2;
	outer_round=4.2;
	adj=0.1;

	offset=panel_offset-height;
	dia1=wire_diameter+clearance*2;	//3.8,0.1 -> 4.0  3.8,0.2 -> 4.2
	dia2=wire_diameter-0.4+clearance*2;	//3.8,0.1 -> 3.6  3.8,0.2 -> 3.8

	l1=1.0;
	l2=6.0+wire_diameter;
	slot_chamfer=0.5;

	mount_height=offset+dia1+l1;
	mount_width=mount_height*2+l2/2;

	for ( q = [0:quantity-1] ) {
		translate([q*(width+1.0),0,0]) {
			intersection() {
				union() {
					difference(){
						rounded_cube(width,depth,height,outer_round);

						translate([
							bezel_width-(height-staple_thickness)
							,bezel_width-(height-staple_thickness)
							,staple_thickness]
						)
							rounded_cube(
								width-bezel_width*2+(height-staple_thickness)*2
								,staple_width+(height-staple_thickness)*2
								,height-staple_thickness+adj
								,outer_round-bezel_width+(height-staple_thickness)
								,0
								,(height-staple_thickness)
							);

						translate([
							bezel_width-(height-staple_thickness)
							,depth-bezel_width-staple_width-(height-staple_thickness)
							,staple_thickness
						])
							rounded_cube(
								width-bezel_width*2+(height-staple_thickness)*2
								,staple_width+(height-staple_thickness)*2
								,height-staple_thickness+adj
								,outer_round-bezel_width+(height-staple_thickness)
								,0
								,(height-staple_thickness)
							);
					}

					translate([0,depth/2,height]) {
						rotate([90,0,90]) {
							difference() {
								linear_extrude(height=width,center=false,convex=10) {
									polygon(points=[
										[-mount_width/2,-adj]
										,[-mount_width/2,0]
										,[-l2/2,mount_height]
										,[-dia2/2-slot_chamfer,mount_height]
										,[-dia2/2,mount_height-slot_chamfer]
										,[-dia2/2,mount_height-l1-dia1/2]
										,[dia2/2,mount_height-l1-dia1/2]
										,[dia2/2,mount_height-slot_chamfer]
										,[dia2/2+slot_chamfer,mount_height]
										,[l2/2,mount_height]
										,[mount_width/2,0]
										,[mount_width/2,-adj]
									]);
								}
								translate([0,offset+dia1/2,-adj]) {
									cylinder(r=dia1/2,h=width+adj*2,$fn=fn);
								}

							}
						}
					}
				}

				if ( testprint==0 ) {
					translate([-adj,-adj,-adj])
						cube([width+adj*2,depth+adj*2,height+mount_height+adj*2]);
				} else {
					translate([-adj,mount_width/2,height+adj])
						cube([width+adj*2,depth-mount_width,mount_height+adj*2]);
				}
			}
		}
	}

}

mesh_panel_wall_mount(wire_diameter,clearance,panel_offset,testprint,quantity);

