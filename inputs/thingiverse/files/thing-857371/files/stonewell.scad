
colors = ["Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray",
"DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"];
n_colors = 5;

module stone(){ rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])resize([rands(3, 10, 1)[0],rands(3, 10, 1)[0],rands(3, 10, 1)[0]])
    //import("rock.stl", convexity=3);
    sphere(1, $fa=15, $fs=1); 
    }


module Wall( length, height)
{
    color( colors[rands(0, n_colors-1, 1)[0]])
	scale([0.2,0.2,0.20])  
     union() {
    intersection() {
    
    translate([-29,-22,0]) cube([63,length*40+44,height*20+17 ]) ;
   
    union() {
        translate([-8,10,0]) cube([20,length*40-25,height*20-5 ]) ;
		// Wall
		for( i = [1:height]) {
			for ( j = [0:length] ) {
				color( colors[rands(0, n_colors-1, 1)[0]])
                        translate([40/2+rands(-5, 5, 1)[0],j*40-(i%2)*10,i*20])
				resize([35,45,35]) stone();
                		translate([-40/2+rands(-5, 5, 1)[0],j*40-(i%2)*10,i*20])				resize([35,45,35]) stone();
			}
		}
		
		// Top stones
		for (j = [0:length]) {
				color( colors[rands(0, n_colors-1, 1)[0]])
				translate([rands(-10, 10, 1)[0],j*40+rands(-5, 5, 1)[0],(height+.5)*20])
				resize([40,40,15]) stone();
		}
        
        	// end stones
		for (j = [0:height]) {
				color("Red")
				translate([0,-5,j*20])
				resize([40,40,40]) stone();
		}
            	// end stones
		for (j = [0:height]) {
				color("Red")
				translate([0,length*40-2,j*20])
				resize([40,40,40]) stone();
		}
	}}
		// Base stones
		difference() {
			scale([1,1,1.5])
			union(){
				for( i = [0:160]) {
					color( colors[rands(0, n_colors-1, 1)[0]])
					translate([rands(0, 45, 1)[0], rands(0, length*40, 1)[0],rands(0, 15, 1)[0]])					resize([30,40,20]) stone();
				}
			}
			
			translate([-240/2,-40, -40])			cube([240, 80+40*length+20, 40]);
		}
	}
}




union(){
for( i = [0:7]) {
rotate ([0,0,45*i]) translate ([22,-8,0]) Wall(2,6);

}}