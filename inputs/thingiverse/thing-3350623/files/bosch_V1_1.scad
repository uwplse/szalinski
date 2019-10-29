// 1.1: Slightly improved mounting
union () {
    breiteOben = 220;
    breiteUnten = breiteOben-10;
    dicke = 5;

	difference () {
		union(){
		   translate([-5,9,0]) cube([5,201,4],0);  
			
		   cube([65,breiteOben,4],0);
			
		   translate([65+4.5+1,58.5,2]) rotate([90,0,0]) cylinder(r=4.5, h=16, center=true, $fn=50); 
		   translate([64,50.5,0]) cube([3.2,16,4],0);

		   translate([65+4.5+1,159.5,2]) rotate([90,0,0]) cylinder(r=4.5, h=16, center=true, $fn=50); 
		   translate([64,151.5,0]) cube([3.2,16,4],0);

		 }

		difference() {
			union() {

				translate([0,-10,-1]) rotate([0,0,1]) cube([65+10,10,dicke+3],0);  
				translate([0,breiteOben,-1]) rotate([0,0,-2]) cube([65+10,10,dicke+3],0);

				translate([-11,58,-1]) cube([38+1+10,15-8,dicke+3],0);   
				translate([-11,154+4,-1]) cube([38+1+10,15-8,dicke+3],0);      

				  translate([0,14,-1])  cube([18,14,dicke+3],0);
				  translate([0,31,-1])  cube([18,18,dicke+3],0);

				  translate([22,11,-1])  cube([18,18,dicke+3],0);
				  translate([22,31,-1])  cube([18,18,dicke+3],0);

				for (i=[0:9]) translate([44,11 + (i * 20),-1])  cube([18,18,dicke+3],0);
				for (i=[0:4]) translate([0,68 + (i * 18),-1])  cube([18,13,dicke+3],0);
				for (i=[0:3]) translate([22,73 + (i * 20),-1])  cube([18,18,dicke+3],0);	   

				  translate([0,171,-1])  cube([18,18,dicke+3],0);
				  translate([0,191,-1])  cube([18,14,dicke+3],0);

				  translate([22,171,-1])  cube([18,18,dicke+3],0);
				  translate([22,191,-1])  cube([18,18,dicke+3],0);

				   translate([65+4.5+1,58,2]) rotate([90,0,0]) cylinder(r=2.25, h=20, center=true, $fn=50); 
				   translate([65+3.3,50.1,1.5]) cube([10,5+1,6],0);  
				   translate([65+3.3,61.8,1.5]) cube([10,5+1,5],0);  
				   translate([65+3.3,56,-3.5]) cube([10,5+1,6],0);  

				   translate([65+1+4.5,158,2]) rotate([90,0,0]) cylinder(r=2.25, h=20, center=true, $fn=50); 
				   translate([65+3.3,151.1,1.5]) cube([10,5+1,6],0);  
				   translate([65+3.3,162.8,1.5]) cube([10,5+1,5],0);  
				   translate([65+3.3,157,-3.5]) cube([10,5+1,6],0);   

				   translate([-1,-4,-2]) cube([7.5,13,7],0);   
				   translate([-1,210,-2]) cube([7.5,11.5,7],0);   
			}
		}
	}
	union(){
		translate([6.5,-4,0]) cube([7,8,4],0);   
		translate([6.5,215,0]) cube([7,8,4],0);  
		
		translate([-6.5,35,0]) cube([3,8,4],0);  
		translate([-6.5,80,0]) cube([3,8,4],0); 
		translate([-6.5,135,0]) cube([3,8,4],0); 
		translate([-6.5,180,0]) cube([3,8,4],0); 

	}
}
