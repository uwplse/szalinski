
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
    
    translate([-34,-22,0]) cube([68,length*40+38,height*20+15 ]) ;
   
    union() {
        translate([-20,10,0]) cube([40,length*40-20,height*20-5 ]) ;
		// Wall
		for( i = [1:height]) {
			for ( j = [0:length] ) {
				color( colors[rands(0, n_colors-1, 1)[0]])
                        translate([40/2+rands(-5, 5, 1)[0],j*40-(i%2)*10,i*20])
				resize([35,45,35]) stone();
                		translate([-40/2+rands(-5, 5, 1)[0],j*40-(i%2)*10,i*20])
				resize([35,45,35]) stone();
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
					translate([rands(-45, 45, 1)[0], rands(0, length*40, 1)[0],rands(0, 15, 1)[0]])
					resize([30,40,20]) stone();
				}
			}
			
			translate([-240/2,-40, -40])
			cube([240, 80+40*length+20, 40]);
		}
	}
}



//translate([-50,0,0])Wall(5, 15);
difference(){
Wall(10, 10);
translate([0,40,25])rotate ([0,90,0]) cylinder (h = 80, r=11, center = true, $fn=10);
    translate([0,40,010]) cube ( [30,21,33], center = true, $fn=10);

    
    }


  //cube([28,28,28]);

//translate([0, 10*40+50, 0])
//rotate([0,0,-30])
//Wall(5, 10);