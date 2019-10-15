//Algorithms learned from the excellent explanations at http://weblog.jamisbuck.org/2011/2/7/maze-generation-algorithm-recap.html

//preview[view:south, tilt:top]

//See instructions if increasing this doesn't work (this shouldn't be a problem below 25)
maze_width=10;//[4:50]


//See instructions if increasing this doesn't work
maze_height=10;//[4:50]


//See instructions for information on maze types
maze_type = "Sidewinder";//[Sidewinder,Binary Tree,Unicursal Sidewinder,Unicursal Binary Tree]

//Lower numbers cause more vertical paths. Higher numbers cause more horizontal paths.
direction_bias = 5;//[1:9]

//How wide should each path be, in mm
width_of_paths=10;//[1:50]


//Height, in mm, of the walls
wall_height=10;//[5:50]


//Thickness of inside walls, in mm
inside_wall_thickness=3;//[1:10]


//Thickness of outside wall, in mm
outside_wall_thickness=5;//[1:20]

//Allows entry into the maze from the side
include_an_entrance=1;//[0:No,1:Yes]

//Thickness of base below maze, in mm
base_thickness=2;//[1:10]


//See instructions for information on this, otherwise, leave at 0
random_seed = 0;

/* [Hidden] */
bias = (direction_bias < 5)? 5/direction_bias : .2*(10-direction_bias);

seed = (random_seed == 0)?rands(0,1000000,1)[0]:random_seed;
width=unicursalchecker()?(maze_width%2==0)?maze_width/2:(maze_width+1)/2:maze_width;
height=unicursalchecker()?(maze_height%2==0)?maze_height/2:(maze_height+1)/2:maze_height;
path_width=unicursalchecker()?(width_of_paths*2)+inside_wall_thickness:width_of_paths;

    
    difference(){
      mazeBase();//Correctly sized cube
      if(include_an_entrance == 1)  
        mazeEntrance();//More cubes
   if(maze_type == "Sidewinder" || maze_type == "Unicursal Sidewinder")      
        SideWinder();
   if(maze_type == "Binary Tree"||maze_type == "Unicursal Binary Tree")
       BinaryTree();
     }
    if(maze_type == "Unicursal Sidewinder") SideWinder(unicursal = true);//Adds mid-paths for unicursal mazes
    if(maze_type == "Unicursal Binary Tree") BinaryTree(unicursal = true);
function unicursalchecker()=(maze_type == "Unicursal Sidewinder" || maze_type == "Unicursal Binary Tree");
    
module mazeEntrance(){
    
        translate([(path_width*(width-1))+(inside_wall_thickness*(width-1)),(path_width*height)+(inside_wall_thickness*(height-1))-.1,0])cube([path_width,outside_wall_thickness+.2,wall_height+.1]);//Top right entrance
    if(!unicursalchecker()){//Other entrance
        nums = (width%2==0)?(width%4==0)?width/2:(width+2)/2:((width-1)%4==0)?(width+1)/2:(width-1)/2;
        pos=floor(rands(((width-nums)/2),width-((width-nums)/2),1,seed)[0]);
        translate([(path_width*pos)+(inside_wall_thickness*pos),-(outside_wall_thickness+.1),0])cube([path_width,outside_wall_thickness+.2,wall_height+.1]);
    }
}  
    
module mazeBase(){
    
    translate([-outside_wall_thickness,-outside_wall_thickness,-base_thickness])cube([(2*outside_wall_thickness)+(width*path_width)+((width-1)*inside_wall_thickness),(2*outside_wall_thickness)+(height*path_width)+((height-1)*inside_wall_thickness),base_thickness+wall_height-.01]);    
    }
    
module BinaryTree(unicursal=false){
rndtmp=biasfixer(rndtmpgenbias());//generates array of rands

rndflr = rndflrer(rndtmp);//makes array 0 or 1
    
rndrow = rndrower(rndflr);//creates correctly size row
    
mazetopremoved = remove_top_row(rndrow);
//Required for binary tree    
mazeinfo = remove_right_row(mazetopremoved);

    //Generates parts
for(h=[0:height-1])for(w=[0:width-1])
    translate([(path_width+inside_wall_thickness)*w,(path_width+inside_wall_thickness)*h,0])BinaryTreeblock(mazeinfo[h][w]);

function rndtmpgen()= rands(0,2,(width*height),(seed));

function rndtmpgenbias() = rands(0,(1/bias)+1,(width*height),(seed));

function biasfixer(matrix)=[for(i=matrix)(i>1)?1:i];
    
function rndflrer(rndtmp)=[for(i=rndtmp)floor(i)];
    
function rndrower(rndflr)=[for(h=[0:height-1])[for(w=[0:width-1]) rndflr[h * width + w]]];
    
function remove_top_row(mazeinfo)=[for (h=[0:height-1])(h==height-1)?[for (w=[0:width-1])1]:mazeinfo[h]];
    
function remove_right_row(mazeinfo)=[for(h=[0:height-1])[for (w = [0:width-1]) (w==width-1)?(h==height-1)?2:0:mazeinfo[h][w]]];
    
    module BinaryTreeblock(type){
        if(unicursal == false){
        if(type == 0)
            cube([path_width,path_width+inside_wall_thickness+.1,wall_height+.1]);
        if(type == 1)
            cube([path_width+inside_wall_thickness+.1,path_width,wall_height+.1]);
        if(type == 2)
            cube([path_width,path_width,wall_height+.1]);
    }
        if(unicursal == true){//midpaths
            if(type == 1)
                translate([width_of_paths,width_of_paths,0])cube([path_width+inside_wall_thickness,inside_wall_thickness,wall_height+.1]);
            if(type == 0)
                translate([width_of_paths,width_of_paths,0])cube([inside_wall_thickness,path_width+inside_wall_thickness,wall_height + .1]);
            if(type == 2)
                translate([width_of_paths,width_of_paths,0])cube([inside_wall_thickness,width_of_paths+inside_wall_thickness+outside_wall_thickness,wall_height + .1]);
            }
}}
module SideWinder(unicursal=false){
    
rndtmp=biasfixer(rndtmpgenbias());//rnd values

rndflr = rndflrer(rndtmp);//makes values an int[][]
    
rndrow = rndrower(rndflr);//creates rows

rndrowfixed=rndmazefixer(rndrow);//Pre-processing for algorithm

rndsums=rndsummer(rndrowfixed);//How many 0's are in a row

runranded=runrander(rndsums);//Where should it carve up

upcarves = upcarvesgen(runranded);//Puts upcarves where they are needed

mazeinfo_almost = upcarves+rndrowfixed;//combines group and upcarves data
    
mazeinfo=remove_top_row(mazeinfo_almost);//top row must be removed


    
    for(h=[0:height-1])for(w=[0:width-1])
    translate([(path_width+inside_wall_thickness)*w,(path_width+inside_wall_thickness)*h,0])SideWinderblock(mazeinfo[h][w]);//generates blocks

function runrander(rndsums)=[for(h=[0:height-1]) [for(w=[0:width-1])(rndsums[h][w]==0)?0:floor(rands(0,rndsums[h][w],1,rndtmpgen()[h*width + w])[0]+1)]];
    
function remove_top_row(mazeinfo)=[for (h=[0:height-1])(h==height-1)?[for (w=[0:width-1])(w==width-1)?4:0]:mazeinfo[h]];

function upcarvesgen(runranded)=[for(h=[0:height-1])[for(w=[0:width-1])upcarveshelper(runranded[h],w,1)]];
    
function upcarveshelper(runranded,w,iter)=(runranded[w]==0)?upcarveshelper(runranded,w+1,iter+1):(runranded[w] == iter)?2:0;

function rndmazefixer(rndrow)=[for(h=[0:height-1])rndrowfixer(rndrow[h])];
    
function rndrowfixer(row)=[for (w = [0:width-1]) (w==width-1)?1:row[w]];

function rndtmpgen()= rands(0,2,(width*height),(seed));

function rndtmpgenbias() = rands(0,bias+1,(width*height),(seed));

function biasfixer(matrix)=[for(i=matrix)(i>1)?1:i];

function rndflrer(rndtmp)=[for(i=rndtmp)floor(i)];
    
function rndrower(rndflr)=[for(h=[0:height-1])[for(w=[0:width-1]) rndflr[h * width + w]]];
    
function rndsummer(rndrow)=[for(h=rndrow)rndsumrow(h)];
    
function rndsumrow(h,i=0,wi=0)=(i==0)?
        [for (w=[0:len(h)-1]) (h[w]==0)?
            0:
            rndsumrow(h,i=1,wi=w)]:
                (wi == 0)?
                    i:
                    (h[wi-1]==0)?   rndsumrow(h,i=i+1,wi=wi-1):
        i;
        
 module SideWinderblock(type){
            if(unicursal == false){//generate blocks
    if(type == 0){
        cube([path_width+inside_wall_thickness+.1,path_width,wall_height + .1]);       
    }
    if(type == 1||type == 4){
        cube([path_width,path_width,wall_height + .1]);
    }
    if(type == 2){
        SideWinderblock(0);
        SideWinderblock(3);
    }
    if(type == 3){
        
        cube([path_width,path_width+inside_wall_thickness+.1,wall_height + .1]);
    }}
    if(unicursal == true){//generate paths in the middle
        if(type == 0)translate([width_of_paths,width_of_paths,0])cube([path_width+inside_wall_thickness,inside_wall_thickness,wall_height+.1]);
            
        if(type == 1)
            translate([width_of_paths,width_of_paths,0])cube([inside_wall_thickness,inside_wall_thickness,wall_height+.1]);
        
        if(type == 2){
            SideWinderblock(0);
            SideWinderblock(3);
        }
        if(type == 3)
            translate([width_of_paths,width_of_paths,0])cube([inside_wall_thickness,path_width+inside_wall_thickness,wall_height+.1]);
        if(type == 4)
            translate([width_of_paths,width_of_paths,0])cube([inside_wall_thickness,width_of_paths+inside_wall_thickness+outside_wall_thickness,wall_height+.1]);
    }
    
}

}
       
