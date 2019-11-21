//CUSTOMIZER VARIABLES
//Hole Size
hole_size = 10; //[5:20]
//Start Height
start_height = 50; //[30:80]
//Step height
step_height = 10; //[5:20]
//Number of slots
size = 5; //[3:10]
//CUSTOMIZER VARIABLES END

for (y=[0:size-1]){
    for (x=[0:size-1]){
        translate([(hole_size-1)*x,(hole_size-1)*y,0]){
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

module column(diff){
    difference(){
        cube([hole_size,hole_size,start_height+diff]);
        translate([1,1,1]){
            cube([hole_size-2,hole_size-2,start_height+diff]);
        }
    }
}