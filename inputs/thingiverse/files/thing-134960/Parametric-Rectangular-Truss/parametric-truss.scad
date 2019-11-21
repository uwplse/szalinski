//Parametric Rectangular Truss
//Created by Jon Hollander, 8/16/13

truss_width=40;
truss_height=40;
truss_thickness=5;
beam_thickness_percentage=10; //[1:100]

module truss(base_w,base_h,link_thickness, p){
	x0 = base_w/2;
	y0 = base_h/2;

	x1 =(1-p/100)*x0;
	y1 =(1-p/100)*y0;

	d=p/100*x0/sqrt(2);

	difference(){
		cube([base_w, base_h, link_thickness], center=true);
		translate([0,0,-link_thickness/2-1]){ 
			linear_extrude(height=link_thickness+2) polygon([[-x1+d,-y1],[x1-d,-y1],[0,-d]]);
			linear_extrude(height=link_thickness+2) polygon([[-x1+d,y1],[x1-d,y1],[0,d]]);
			linear_extrude(height=link_thickness+2) 	polygon([[-x1,-y1+d],[-x1,y1-d],[-d,0]]);
			linear_extrude(height=link_thickness+2) 	polygon([[x1,-y1+d],[x1,y1-d],[d,0]]);
			
		}
	}	
}

//For testing and customizer
truss(base_w=truss_width, base_h=truss_height, link_thickness=truss_thickness, p=beam_thickness_percentage);
