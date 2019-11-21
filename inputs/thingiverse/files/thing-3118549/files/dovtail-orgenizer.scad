amount=2; // how many boxes 
box_width=100;
box_height=70;
box_depth=50; 
box_floor=1.1;// Thicness of floor 
width_distance=25; // The distance between the dovetail on the x axis
height_distance=25;// The distance between the dovetail on the Y axis

module male_dovetail2d(max_width, min_width, depth,  cutout_width, cutout_depth) {
    difference(){    
        dovetail_2d(max_width,min_width,depth);
        translate([0.001,depth+0.001,0]){
            dovetail_cutout2D(cutout_width,cutout_depth);
        }
    }
}
module dovetail_cutout2D(cwidth, cdepth) {
	translate([0,-cdepth+cwidth/2,0])
		union() {
			translate([-cwidth/2,0,0])
				square([cwidth,cdepth-cwidth/2]);
			difference() {
				circle(r=cwidth/2,  $fs=0.25);
				translate([-cwidth/2-0.05,0.05]) 
                      square([cwidth+0.1,cwidth+0.1]);
			}
		}
}


module female_dovetail_negative2d(max_width, min_width, depth, clearance) {
	union() {
		translate([0,-0.001,0])
			dovetail_2d(max_width,min_width,depth);
			translate([-(max_width+clearance)/2, depth-0.002,0])
				square([max_width+clearance,clearance/2]);
	}
}

module dovetail_2d(max_width, min_width, depth) {
	angle=atan((max_width/2-min_width/2)/depth);	
	polygon(paths=[[0,1,2,3,0]], points=[[-min_width/2,0], [-max_width/2,depth], [max_width/2, depth], [min_width/2,0]]);
}





max_width=10;
min_width=6;
depth=3.5;//of dovetail
cut_width=depth+1;//3;
cut_depth=depth-1;//3;
clearance=0.35;
rim=1.5;

width_interval=width_distance;
height_interval=height_distance;
edge=depth+rim;


for(a=[0:amount-1]){
    translate([a*(box_width+edge),0,0]){
        generate();
    }    
}


startCut=(max_width/2)+2;
module bottom(){
  for(x=[startCut+depth+rim:width_interval:box_width-startCut]){
        translate([x,0,0]){  
            rotate(0){
                echo(x);
                children();
            }
        }
    }   
}

module left(){
    for(y=[startCut+depth+rim:height_interval:box_height-startCut]){    
        translate([0,y,0]){  
            rotate(270){
                children();
            }
        }
    }  
}

module right(){
    for(y=[startCut+depth+rim:height_interval:box_height-startCut]){    
        translate([box_width,y,0]){  
            rotate(270){
                children();
            }
        }
    }
}
module top(){
      
      for(x=[startCut+depth+rim:width_interval:box_width-startCut]){
        translate([x,box_height,0]){              
            rotate(0){
                children();
            }
        }
    }
}


module generate(){
    difference(){
    linear_extrude(box_depth){
        difference(){
            square([box_width,box_height]);
                          
           
            bottom(){
               female_dovetail_negative2d(max_width, min_width, depth,  clearance);
            } 
            left(){
              female_dovetail_negative2d(max_width, min_width, depth,  clearance);
            }

        }
        right(){
           male_dovetail2d(max_width, min_width, depth,  cut_width, cut_depth);
        }
        top(){
          male_dovetail2d(max_width, min_width, depth, cut_width, cut_depth);
        }
    }
     translate([edge,edge,box_floor]){
        cube([box_width-edge-rim,box_height-edge-rim,box_depth]);
     }
    }
}