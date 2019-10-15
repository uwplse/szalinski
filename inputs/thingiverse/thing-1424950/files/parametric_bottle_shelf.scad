// Sizes

insideLength=150;
insideWidth =150;
insideHeight= 90;
wallThick=3;

// Options

Opening = 1; //[0:makes a cage with no opening, 1:open side along the length, 2:open at one end 
             // 3:open at both sides, 4:open at both ends]   

/*[Hidden]*/
holeDia = 24; //this is optimum and shouldn't be changed

// calculated variables

outsideLength=insideLength + (wallThick*2);
outsideWidth=insideWidth + (wallThick*2);
outsideHeight=insideHeight+wallThick;

holeSpacing = holeDia+(wallThick*2);

numberOfHolesLong=floor(insideLength/holeSpacing);
numberOfHolesWide=floor(insideWidth/holeSpacing);
numberOfHolesTall=floor(insideHeight/holeSpacing);

xoffset = (insideLength-(numberOfHolesLong*holeSpacing)+(wallThick*2))/2; // used to make holes
yoffset = (insideWidth -(numberOfHolesWide*holeSpacing)+(wallThick*2))/2; //symetrical side to side 
zoffset = (outsideHeight -(numberOfHolesTall*holeSpacing)+wallThick)/2;

istart = holeSpacing/2+xoffset; // start position of first hole i=x axis
jstart = holeSpacing/2+yoffset; // j= y axis
kstart = holeSpacing/2+zoffset; // k=z axis

step = holeSpacing; 

imax = insideLength-wallThick; 
jmax = insideWidth-wallThick;
kmax = insideHeight-wallThick;



shelf(); // This only gets called once so needn't have been a module

if (Opening!=1 && Opening!=3) // only add first x side if Opening is not 1 or 3
xside();

if (Opening!=3) // only add second x side if Opening is not 3
translate ([0,outsideWidth-wallThick,0])
xside();

if (Opening!=2 && Opening!=4) // only add first y side if Opening is not 2 or 4
yside();

if (Opening!=4) // only add second y side if Opening is not 4
translate ([outsideLength-wallThick,0,0])
yside();



module shelf(){
difference(){
cube ([outsideLength, outsideWidth, wallThick]);
for (i=[istart:step:imax]){
    for (j=[jstart:step:jmax]){
        translate ([i,j,-1])
        cylinder (d=holeDia, h=wallThick+2);

            }// end of i
        }// end of j
    }// end of difference

} // end of module shelf


module xside(){
  
difference(){
cube ([outsideLength,wallThick,outsideHeight]);  
   for (i=[istart:step:imax]){
    for (k=[kstart:step:kmax]){
           translate ([i,wallThick+1,k])
           rotate ([90,0,0])
           cylinder (d=holeDia, h=outsideWidth+2);

            }// end of i
        }// end of k
    
    
    
}// end of difference  
    
        
}// end of module xside 
    

module yside(){
  
difference(){
cube ([wallThick,outsideWidth,outsideHeight]);  
   for (j=[jstart:step:jmax]){
    for (k=[kstart:step:kmax]){
           translate ([-1,j,k])
           rotate ([0,90,0])
           cylinder (d=holeDia, h=outsideLength+2);

            }// end of i
        }// end of k
    
    
    
}// end of difference  
    
        
}// end of module yside 
    