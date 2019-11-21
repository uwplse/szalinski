use <write.scad>

startHeight=14;
endHeight=26;
stepLength=10;
guageWidth=10;
radius=0.5;
text="WWW.TORCHRACING.CO.UK";
fn=50;
font="Letters.dxf";

difference(){
    for(currentHeight=[startHeight:endHeight])
    {
        x=currentHeight-startHeight;
        render(){
            difference(){
            // Make height section
            translate([stepLength*x,0,0]) cube([stepLength,guageWidth,currentHeight],centre=false);
            
            // Radius top left edge of step    
            difference(){
              translate([(stepLength*x)-radius,-1,currentHeight+radius]) rotate(a=-90,v=[1,0,0]) cube([2*radius,2*radius,guageWidth+2]);
              translate([(stepLength*x)+radius,-1.5,currentHeight-radius]) rotate(a=-90,v=[1,0,0]) cylinder($fn=fn, h=guageWidth+3, r=radius, center=false);
            }
            
            // Radius top rght edge of step
            if(currentHeight==endHeight)
            {
              difference(){
                translate([(stepLength*x)+stepLength-radius,-1,currentHeight+radius]) rotate(a=-90,v=[1,0,0]) cube([2*radius,2*radius,guageWidth+2]);
                translate([(stepLength*x)+stepLength-radius,-1.5,currentHeight-radius]) rotate(a=-90,v=[1,0,0]) cylinder($fn=fn, h=guageWidth+3, r=radius, center=false);
              }
            }
            
            // Impress height text
            color([0,1,1])
            writecube(str(currentHeight),where=[(stepLength*x)+(stepLength/2),0,currentHeight - 3], size=[stepLength,0,currentHeight], face="front", t=2, h=3, font=font);
            color([0,1,1])
            writecube(str(currentHeight),where=[(stepLength*x)+(stepLength/2),guageWidth,currentHeight - 3], size=[stepLength,0,currentHeight], face="back", t=2, h=3, font=font);
            }    
        }
    }

    // Add text along bottom
    guageLength=(endHeight-startHeight)*stepLength;
    textLength=len(text);
    color([0,1,1])
    writecube(text,where=[guageLength-(textLength)-10,0,4], size=[guageLength-(textLength),0,0], face="front", t=2, h=5, font=font);
    color([0,1,1])
    writecube(text,where=[guageLength-(textLength)-10,10,4], size=[guageLength-(textLength),0,endHeight], face="back", t=2, h=5, font=font);

}