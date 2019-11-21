//Number of spinners
spinners=11;			// [3:1:20]

// Rotation preview
rotatePreview=8;		//[8,-45]

/* Hidden */
startDist=20;			//initial distance for spinner. Minimum of (ballWidth+connectorWidth)/2
distStep=5;				//increment in distance for each spinner
ballWidth=14;			//width of balls on each spinner
ballHeight=6;			//height of balls on each spinner
connectorWidth=17;		//width of connector in middle of spinner
indent=3.5;				//depth of indentation in connector
extrude=3;				//depth of extrusion from connector
margin=1;				//extra height between balls

module spinner(dist){
	//central holder for dowel
	difference(){
		//main section
		union(){
			//cylinder
			translate([0,0,-(ballHeight+margin)/2]) cylinder(h=ballHeight+margin, r=connectorWidth/2, $fn=50);
			//bar
			cube(size=[dist*2,4,3], center=true);
			//balls on ends
			translate([dist,0,0]) scale([1,1,ballHeight/ballWidth]) sphere(r=ballWidth/2, $fn=50);
			translate([-dist,0,0]) scale([1,1,ballHeight/ballWidth]) sphere(r=ballWidth/2, $fn=50);
			//male connector
			translate([0,0,-(ballHeight+margin)/2-extrude]) 
			intersection(){
				cylinder(h=ballHeight, r=connectorWidth/2-2, $fn=50);
				cube(size=[20,8,10], center=true);
			}
		}
		//indented space on top
		//first group allows for 8 degree twist one way
		translate([0,0,ballHeight/2-indent+margin/2]) 
		intersection(){
			cylinder(h=ballHeight+1, r=connectorWidth/2-1, $fn=50);
			rotate([0,0,-8]) cube(size=[20,8,10], center=true);
		}
		//second group allows 40 degree twist other way
		translate([0,0,ballHeight/2-indent+margin/2]) 
		intersection(){
			cylinder(h=ballHeight+1, r=connectorWidth/2-1, $fn=50);
			rotate([0,0,40]) cube(size=[20,8,10], center=true);
		}
		//cylinder to cut out middle for dowel
		translate([0,0,-25]) cylinder(h=50, r=3.2, $fn=50);
	}
}

//top cap
difference(){
	union(){	
		//main section
		translate([0,0,(ballHeight+margin+extrude+3)-(ballHeight+1)/2]) cylinder(h=ballHeight+margin, r=connectorWidth/2, $fn=50);
		//male connector
		translate([0,0,(ballHeight+margin+extrude+3)-(ballHeight+margin)/2-extrude]) 
		intersection(){
			cylinder(h=ballHeight, r=connectorWidth/2-2, $fn=50);
			cube(size=[20,8,ballHeight], center=true);
		}
	}
	translate([0,0,-100]) cylinder(h=200, r=3.2,  $fn=50);
}

//spinners
for (i = [0:spinners-1]) {
	translate([0,0,-i*(ballHeight+margin+extrude+3)])rotate([0,0,rotatePreview*i]) spinner(i*distStep+startDist);
}

//bottom cap
translate([0,0,-(ballHeight+margin+extrude+3)*spinners-3])
	difference(){
		//main section
		translate([0,0,-(ballHeight/2+1)/2]) cylinder(h=ballHeight+margin, r=connectorWidth/2,  $fn=50);
		//indented space on top
		//first group allows for 8 degree twist one way
		translate([0,0,ballHeight/2-indent+margin/2]) 
		intersection(){
			cylinder(h=ballHeight+1, r=connectorWidth/2-1,  $fn=50);
			rotate([0,0,-8]) cube(size=[20,8,10], center=true);
		}
		//second group allows 45 degree twist other way
		translate([0,0,ballHeight/2-indent+margin/2]) 
		intersection(){
			cylinder(h=ballHeight+1, r=connectorWidth/2-1,  $fn=50);
			rotate([0,0,40]) cube(size=[20,8,10], center=true);
		}
		//dowel cutout
		translate([0,0,-180]) cylinder(h=200, r=3.2,  $fn=50);
	}
	