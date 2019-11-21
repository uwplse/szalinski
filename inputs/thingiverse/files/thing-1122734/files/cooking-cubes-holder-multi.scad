cube_width=50;
cube_depth=32;
cube_height=17;
cube_padding=1;
walls=2;
nbr_of_cubes_per_bloc=10;
nbr_blocks=2;
unloading_height=20;
front_opening_width=8;

top_free=1*cube_height;
// modules
module make_cubes(width,depth,height,padding,nbr_of_cubes_per_bloc,top_free){
    cube([width+(2*padding),depth+(2*padding),height]);
    for(i = [1 : 1 : nbr_of_cubes_per_bloc-1]){
        translate([0,0,i*height-1]){
            cube([width+(2*padding),depth+(2*padding),height+1]);
            }
        }
    translate([0,0,nbr_of_cubes_per_bloc*+height]){
        cube([width+(2*padding),depth+(2*padding),height*nbr_of_cubes_per_bloc+top_free*2]);
        }       
    }


// building  
         
//cube([cube_width,cube_depth,cube_height]);  



for(bloc = [1 : 1 : nbr_blocks]){
	translate([((walls+cube_width+cube_padding*2)*(bloc-1)),0,0]){

//------------------------------  
   difference(){
       //container
       cube([cube_width+2*(walls+cube_padding),cube_depth+2*(walls+cube_padding),cube_height*nbr_of_cubes_per_bloc+walls+top_free]);
       //---------------------------------------------------------------
       // holes for screws
       translate([walls+cube_width/2,-1+walls/2,walls]){
           translate([0,0,cube_height]){
               rotate ([-90,0,0]) cylinder(h = walls+2.1, r1 = 1.5, r2 = 5, center = true);
               }
            translate([0,0,cube_height*(nbr_of_cubes_per_bloc-1)]){
               rotate ([-90,0,0]) cylinder(h = walls+2.1, r1 = 1.5, r2 = 5, center = true);
               }
           }
       // unloading opening      
       translate([-walls,walls+cube_depth/2,walls]){
            cube([cube_width+3*(walls+cube_padding),cube_depth+2*(walls+cube_padding),unloading_height]);
            }
       //front view
       translate([walls+cube_width/2-(front_opening_width/2),walls+cube_depth,walls]){
            cube([front_opening_width,+cube_depth*2,cube_height*nbr_of_cubes_per_bloc+walls]);
            }
        //cubes space
        translate([walls,walls,walls]){    
            make_cubes(cube_width,cube_depth,cube_height,cube_padding,nbr_of_cubes_per_bloc,top_free);
                }
       
       }
//------------------------------ 
// cover
	translate([0,cube_depth*2,0]){		
		cube([cube_width+2*(walls+cube_padding),cube_depth+2*(walls+cube_padding),walls]);
		translate([walls+cube_padding,walls+cube_padding,walls]){
			cube([cube_width,cube_depth,walls]);
			}
		}
	}
}   
    
    