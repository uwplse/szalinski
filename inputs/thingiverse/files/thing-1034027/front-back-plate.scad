/* [Global] */

// Do you want holes for Arduino/Ramps1.4?
arduino_ramp_hole = "YES"; // [NO:No,YES:Yes]

// Do you want holes for d-sub?
dsub = 0; // [0:No,25:9pin,33.3:15pin,47.17:25pin,63.5:37pin]
dsub_x = 50; // [60]
dsub_y = 50; // [90]

// preview[view:south, tilt:top]

module screw_hole(){
    cylinder($depth+2,1.8,1.8,$fn=30);
    translate([0,0,2.4])cylinder(1.4,1.8,3.1,$fn=30);
    translate([0,0,3.6])cylinder(1.3,3.1,3.1,$fn=30);
}

module arduino_ramp_hole(){
	translate([7,49.5,-1])cube([12,12,10]);
	translate([20,9.5,-1])cube([10,60,10]);
	translate([20,9.5,-1])cube([18,22,10]);
}


module dsub_hole($size){
    $height=12;
   
    translate([-$size/2,0,0]){
        translate([0,0,0])cylinder($height-2,1.42,1.42,$fn=30);
        
        difference(){
            translate([4.04,-4.18,0])cube([$size/2-8.08/2+0.1,8.36,$height-2]);
            translate([3.04+0.5,-4.18-1,-1])rotate([0,0,10])cube([2,10,$height]);
            translate([5.6,2.76,0])difference(){
                translate([-2.42,-0.2,-1])cube([2.42,2.42,$height]);
                cylinder($height,1.42,1.42,$fn=30);
            }
            translate([6.565,-2.76,0])difference(){
                translate([-1.42,-1.44,-1])cube([1.42,1.42,$height]);
                cylinder($height,1.42,1.42,$fn=30);
            }
        }
    }
    mirror()translate([-$size/2,0,0]){
        translate([0,0,0])cylinder($height-2,1.42,1.42,$fn=30);
        
        difference(){
            translate([4.04,-4.18,0])cube([$size/2-8.08/2+0.1,8.36,$height-2]);
            translate([3.04+0.5,-4.18-1,-1])rotate([0,0,10])cube([2,10,$height]);
            translate([5.6,2.76,0])difference(){
                translate([-2.42,-0.2,-1])cube([2.42,2.42,$height]);
                cylinder($height,1.42,1.42,$fn=30);
            }
            translate([6.565,-2.76,0])difference(){
                translate([-1.42,-1.44,-1])cube([1.42,1.42,$height]);
                cylinder($height,1.42,1.42,$fn=30);
            }
        }
    }
}

module plate(){
    $depth=2.8;
    $plate_width=90;
    $plate_length=60;
    
	difference() {
		cube([$plate_length,$plate_width,$depth],0);
		translate([3.5,3.5,-1])screw_hole();
		translate([53.7,3.5,-1])screw_hole();
		translate([53.7,86.5,-1])screw_hole();
		translate([3.5,86.5,-1])screw_hole();
		if(arduino_ramp_hole=="YES"){arduino_ramp_hole();}
        if(dsub>0){translate([dsub_x,dsub_y,-1])rotate(270)dsub_hole(dsub);}
	}
}

rotate(90)plate();

//QA
//rotate([0,90,0]) translate([-2.5,2.5,-2.5]){
//    import("/home/feiming/Downloads/Front_side_Size2_corrected.stl", convexity=3);
//}
