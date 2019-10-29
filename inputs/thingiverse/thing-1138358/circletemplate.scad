
unit="first";  // [first:mm,second:inch] 


//outer diameter is 20mm more
innerDiametermm=0; //[0:180]


//outer diameter is 1 inch more
innerDiameterinch=0; //[0:7]
//1/16 inch
innerDiameter16stinch=0; //[0:15]

makePart();

module makePart(){
    if(unit=="first"){
        smm(innerDiametermm);
    }
    else{
        sinch(innerDiameterinch,innerDiameter16stinch);
    }
}



module smm(d){
    difference(){
        cylinder(1,d/2+10,d/2+10,$fn=50);
        translate([0,0,-1])
         cylinder(3,d/2,d/2,$fn=50);
        
        }
        
    for(i=[0:15:345])
    rotate(a=i,v=[0,0,1])    
    translate([-0.5,d/2+1,0.99])   
    cube([1,8,1]);
}

module sinch(da,db){
    difference(){
        cylinder(1,(da+db/16)*25.4/2+12.7,(da+db/16)*25.4/2+12.7,$fn=50);
        translate([0,0,-1])
         cylinder(3,(da+db/16)*25.4/2,(da+db/16)*24.4/2,$fn=50);
        
        }
        
    for(i=[0:15:345])
    rotate(a=i,v=[0,0,1])    
    translate([-0.5,(da+db/16)*25.4/2+1,0.99])   
    cube([1,10,1]);
}

