//Basic definition:
//Higher number = more faces = smoother model = slower processing.
$fn=50; 

//Case definition: 6.5x55 Swedish Mauser
//Base diameter of casing/rim 
d0=12.2; 

//Case scaling to allow oversized/fired cases
casescaling=1.01; 

//Block definition:
//Total number of cases you want
noOfCases=3;
//No of rows in the Y direction.
Rows=1;  
//Thickness of material outside hole
rim=3;  


//Total height of the lid.
height=50; 
//Lid thickness
lidthickness=2;
//Wall hickness
wallthickness=1.2;   
//Chamfer distance of the outside edge 0=no chamfer.
outerchamfer=1;

module corner(xpos,ypos,height,cornerradius,outerchamfer){
    translate([xpos,ypos,0])
    difference(){
      cylinder(h=height,r=cornerradius);
      translate([0,0,height])
         rotate_extrude(convexity=10)
             translate([cornerradius,0,0])
                circle(outerchamfer,$fn=4);  
    }   
}

function offset(rows)=(rows>1)?0:xoffset/2;

casesperrow=noOfCases/Rows; //No of cases in X direction. 

holediameter=d0*casescaling;
xoffset=holediameter+rim;
yoffset=xoffset*0.866;//Sqrt(3)/2=cos(30deg)
cornerradius=holediameter/2+rim;

x=xoffset*(casesperrow-0.5)+holediameter+2*rim-2*cornerradius;
y=yoffset*(Rows-1)+holediameter+2*rim-2*cornerradius;
rotate([180,0,0])
difference(){
    hull()
    translate([cornerradius,cornerradius,0]){
        corner(0,0,height,cornerradius+wallthickness,outerchamfer);
        corner(0,y,height,cornerradius+wallthickness,outerchamfer);
        corner(x-offset(Rows),0,height,cornerradius+wallthickness,outerchamfer);
        corner(x-offset(Rows),y,height,cornerradius+wallthickness,outerchamfer);
    }
    hull()
    translate([cornerradius,cornerradius,-lidthickness]){
        corner(0,0,height,cornerradius,outerchamfer);
        corner(0,y,height,cornerradius,outerchamfer);
        corner(x-offset(Rows),0,height,cornerradius,outerchamfer);
        corner(x-offset(Rows),y,height,cornerradius,outerchamfer);
    }
 
}

