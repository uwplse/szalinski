//Variation from perfect cube shape. From 0 to .5
MaxIntensity = .4;
MinIntensity = .2;


//number of sub-cubes in each direction
Xcubes = 2;
Ycubes = 2;
Zcubes = 2;


xsides = Xcubes+1;
ysides = Ycubes+1;
zsides = Zcubes+1;



//Average sub-cube width in mm
scale = 30;


//added distance between sub-cubes in cube layout
seperation = 5;

/* [Holder] */

generateHolder = 0;//	[0:Don't make holder, 1:make holder]
borderTolerance = 2;
baseThickness = 4;
wallWidth = 3;
wallHeight = 10;

if(generateHolder == 1){
    translate([0,-(Ycubes*scale+borderTolerance*2+wallWidth*2)-5,0]){
        difference(){
            //large scale for base
            
        cube([Xcubes*scale+2*(wallWidth+borderTolerance),
              Ycubes*scale+2*(wallWidth+borderTolerance),
              baseThickness+wallHeight]);
            translate([wallWidth,wallWidth,baseThickness])
        cube([  Xcubes*scale+2*borderTolerance,
                Ycubes*scale+2*borderTolerance,
                wallHeight+1]);
        }
        
    }
}


list2 = [ for (a = [0:zsides-1], b = [0:ysides-1], c = [0:xsides-1])
          
          randomizeSides([c,b,a])
];
blankList = [ for (a = [0:zsides-1], b = [0:ysides-1], c = [0:xsides-1])
          
          [c,b,a]
];

function randomSign() = sign(rands(-1,1,1)[0]);
function randomDrift() = randomSign()*(rands(MinIntensity,MaxIntensity,1)[0]);

echo("random test",randomDrift());

function Xside(point) = ( point[1]==0 || point[1]==ysides-1);
function Yside(point) = ( point[0]==0 || point[0]==xsides-1);
function Zside(point) = ( point[2]==0 || point[2]==zsides-1);
function Xedge(point) = ( Xside(point) && Zside(point));
function Yedge(point) = ( Yside(point) && Zside(point));
function Zedge(point) = ( Xside(point) && Yside(point));          
function corner(point) = (Xside(point)&&Yside(point)&&Zside(point));
function edge(point) =  (( (Xside(point) && Yside(point)) ||
                          (Xside(point) && Zside(point)) ||
                          (Yside(point) && Zside(point)) ));


//if on x side, randomize x,z
//if on y side, randomize y,z
//if on z side, randomize x,y
//if on inside, randomize x,y,z
    //This means:
// randomize x, if on x side, z side, or inside
// randomize y, if on y side, z side, or inside
// randomize z, if on x side, y side, or inside
function randomizeSides(point) = [
          //randomize x component;
          int(!Yside(point))*rands(-MaxIntensity,MaxIntensity,1)[0]+point[0],
          //randomize the y part;
          int(!Xside(point))*rands(-MaxIntensity,MaxIntensity,1)[0]+point[1],
          //randomize the z part;
          int(!Zside(point))*rands(-MaxIntensity,MaxIntensity,1)[0]+point[2]];
          
//function randomizeSides(point) = (i=);
function int(booleanInput) = [for(i=[0:1]) if((booleanInput==false && i==0)||(booleanInput==true && i==1))i][0];
ifValue=int(true);
echo("random",rands(-MaxIntensity,MaxIntensity,1)[0]);

  
   
/*function XZside(point) = (( point[0]==0 || point[0]==sideLength-1) && 
                          ( point[1]==0 || point[1]==sideLength-1));
function YZside(point) = (( point[1]==0 || point[1]==sideLength-1) && 
                          ( point[2]==0 || point[2]==sideLength-1));
          */
function inside(point) = (  point[0]!=0 && point[0]!=xsides-1 &&
                            point[1]!=0 && point[1]!=ysides-1 &&
                            point[2]!=0 && point[2]!=zsides-1 );


//for testing layouts

/*for(j=[0:xsides*ysides+xsides]){
    translate(list2[j]*scale)
    cube([5,5,5]);
}*/


  
  


//Find the points that a cube can be started from
startSpots=[for(i=[0:len(blankList)-1])
    if((blankList[i][0]!=xsides-1)&&
       (blankList[i][1]!=ysides-1)&&
       (blankList[i][2]!=zsides-1))
    
    i];
    echo("startSpots",startSpots);
    //0,1,3,4,9,10,12,13,27
  






//for each point that a cube can start from
for(i=[0:len(startSpots)-1]){

    
    //the point that the given cube starts on
    a=startSpots[i];
    
    echo("a = ",a);
    //the points used to make that cube
    g = [   a,
            a+1,
            a+xsides+1,
            a+xsides,
            a+xsides*ysides,
            a+xsides*ysides+1,
            a+xsides*ysides+xsides+1,
            a+xsides*ysides+xsides];
    
    /*for(j=[0:len(g)-1]){
    translate(list2[g[j]]*scale)
    cube([5,5,5]);
}*/
  
    //the faces based on those points;
    CubeFaces = [
        [g[0],g[1],g[2],g[3]],  // bottom
        [g[4],g[5],g[1],g[0]],  // front
        [g[7],g[6],g[5],g[4]],  // top
        [g[5],g[6],g[2],g[1]],  // right
        [g[6],g[7],g[3],g[2]],  // back
        [g[7],g[4],g[0],g[3]]]; // left
    
    
        translate(list2[a]*seperation)
        polyhedron( list2*scale, CubeFaces );
    
    
    
}

