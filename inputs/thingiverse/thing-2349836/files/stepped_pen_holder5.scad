//CUSTOMIZER VARIABLES
//Hole Size
hole_size = 15; //[5:20]
//Start Height
start_height = 75; //[30:80]
//Step height
step_height = 15; //[5:20]
//Number of slots
size = 4; //[3:10]

wall_width = 3; //[2:5]
//CUSTOMIZER VARIABLES END


difference(){
    for (y=[0:size-1]){
        for (x=[0:size-1]){
            translate([(hole_size-(wall_width/2))*x,(hole_size-(wall_width/2))*y,0]){
                if (x==0 && y==0){
                    column(0);
                }
                for (p=[1:size]){
                    if (x==p || y==p){
                        column(step_height*p);
                    } 
                }            
            }
        }
    }
    for (z=[0:1]){
        for (x=[0:size-1]){
            translate([((hole_size-wall_width/2)*x)+7,20,(14*z)+10]){
                rotate([90,0,0]){
                    
                        Hexagone(8,300);
                }
            }
            rotate([0,0,90]){
                translate([((hole_size-wall_width/2)*x)+7,20,(14*z)+10]){
                    rotate([90,0,0]){
                        
                            Hexagone(8,300);
                    }
                }
            }
        }
    }
    
}

module column(diff){
    difference(){
        cube([hole_size,hole_size,start_height+diff]);
        translate([wall_width/2,wall_width/2,1]){
            cube([hole_size-wall_width,hole_size-wall_width,start_height+diff]);
        }
    }
}

module Hexagone(cle,h)
{
	angle = 360/6;		// 6 pans
	cote = cle * cot(angle);
	echo(angle, cot(angle), cote);
	echo(acos(.6));

	union()
	{
		rotate([0,0,0])
			cube([cle,cote,h],center=true);
		rotate([0,0,angle])
			cube([cle,cote,h],center=true);
		rotate([0,0,2*angle])
			cube([cle,cote,h],center=true);
	}


}

function cot(x)=1/tan(x);
