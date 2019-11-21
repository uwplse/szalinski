//The resolution of the curves. Higher values give smoother curves but may increase the model render time.
resolution = 50; //[50, 100, 200]
// wall thickness, for 0.4mm nozzle and extrusion width 0.48mm e.g. 3*0.48mm = 1.44mm
wall=1.44;
// thickness of the base top in mm
baseThickness=1.2;
//length of the base in mm
length = 50;//[25 : 300]
//width of the base in mm
width = 50;//[25 : 300]
//height of the base in mm
height = 4;
/*[ Magnets ] */
// magnet height in mm
magnetHeight=2;
// magnet diameter in mm
magnetDiameter=5;
// magnet distance from center to edge in percent
magnetDistance=70;//[0 : 100]

magnetCenter=1;//[0:false,1:true]
magnetN=1;//[0:false,1:true]
magnetNE=1;//[0:false,1:true]
magnetE=1;//[0:false,1:true]
magnetSE=1;//[0:false,1:true]
magnetS=1;//[0:false,1:true]
magnetSW=1;//[0:false,1:true]
magnetW=1;//[0:false,1:true]
magnetNW=1;//[0:false,1:true]
/* [Hidden] */
magnetNXY=[0,calc(width)];
magnetNEXY=[calcX(),calcY()];
magnetEXY=[calc(length),0];
magnetSEXY=[calcX(),-calcY()];
magnetSXY=[0,-calc(width)];
magnetSWXY=[-calcX(),-calcY()];
magnetWXY=[-calc(length),0];
magnetNWXY=[-calcX(),calcY()];


function calc(x)=x/2*magnetDistance/100;
function calcX()=(1/2)*sqrt(2)*(length/2)*magnetDistance/100;
function calcY()=(1/2)*sqrt(2)*(width/2)*magnetDistance/100;

$fn = resolution;

difference(){    
    union(){    
        difference(){
            base(length,width,height);
               
            difference(){
                base(length-2*wall,width-2*wall,height+0.01);
                
                linear_extrude(height=baseThickness)
                oval(length,width, solid="yes");
            }
        }
        magnets(true);
    }
    magnets(false);
}
module magnets(cut){
    
if(magnetCenter==1)
    magnet(0,0,cut);
if(magnetN==1)
    magnet(magnetNXY[0],magnetNXY[1],cut);
if(magnetNE==1)
    magnet(magnetNEXY[0],magnetNEXY[1],cut);
if(magnetE==1)
    magnet(magnetEXY[0],magnetEXY[1],cut);
if(magnetSE==1)
    magnet(magnetSEXY[0],magnetSEXY[1],cut);
if(magnetS==1)
    magnet(magnetSXY[0],magnetSXY[1],cut);
if(magnetSW==1)
    magnet(magnetSWXY[0],magnetSWXY[1],cut);
if(magnetW==1)
    magnet(magnetWXY[0],magnetWXY[1],cut);
if(magnetNW==1)
    magnet(magnetNWXY[0],magnetNWXY[1],cut);
}

module base(l,w,h){
    linear_extrude( height=h, scale=[l/(l-2.5),w/(w-2.5)] )
    oval(l-2.5,w-2.5, solid="yes", res=resolution*4);
}
module oval(length,width, solid, res=resolution) {
    difference(){        
        scale([1, width/length, 1]) 
        circle(r=(length)/2, $fn=res);
        if(solid=="no")
        scale([1, (width-wall*2)/(length-wall*2), 1]) 
        circle(r=(length-wall*2)/2, $fn=res);
    }
}

module magnet(x,y,cut) {
    if(cut){
    translate([x,y,baseThickness])
    linear_extrude( height=height-baseThickness)
        circle(r=magnetDiameter/2+wall); 
    }else{
    translate([x,y,height-magnetHeight])    
    linear_extrude( height=height)
        circle(r=magnetDiameter/2);
    }
}