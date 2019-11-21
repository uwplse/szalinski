//https://customizer.makerbot.com/docs#example

/*
Mesh for terrarium to separate substrate from gravel. 
Allows water to flow through, but not substrate
*/ 

/*[GLOBAL]*/
//length (x) of mesh
x = 100; 
//breath (y) of mesh
y = 100;
//thickness of mesh
thickness = 1;
//number of rows and columns
num = 30;
//mesh thickness
h = 0.3;
/*[SHAPE]*/
//round or rectangle
isRound =1; //[1:round,0:rectangle]

/*[HIDDEN]*/
//gaps between each row/column
xSpacing = (x-h)/num;
ySpacing = (y-h)/num;



echo(xSpacing);
echo(ySpacing);

 if(isRound >=1){
    difference(){
     linear_extrude(height=h)
        scale([1.0, y/x, 1.0])
            circle(d=x ); 
        
     linear_extrude(height=h)
        color("Red")
        offset(r=-thickness){
            scale([1.0, y/x ])
                circle(d=x );  
        }
   }
   intersection(){ 
        scale([1.0, y/x, 1.0])
           cylinder(d=x,height=h);
        mesh();
   }
 }else {
   mesh();
 }

module mesh(){
    translate ([-x/2, -y/2,0])
    for(i=[0:num]){
        yoffset = i*ySpacing;
        translate([0, yoffset,0]){
            xBar();
        }
        xoffset = i*xSpacing;
        translate([xoffset, 0,0]){
            yBar();
        }
    }
}
module xBar (){
    length =[x, thickness, h];
    cube(length);
}
module yBar (){
    length =[thickness, y, h];
    cube(length);
}