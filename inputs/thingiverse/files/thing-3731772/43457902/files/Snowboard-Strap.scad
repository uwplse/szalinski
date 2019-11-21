$fn=100;

//overall thikness of strap at toothed section
strapT=4.25;  

//how heigh the support section is below strap tooth section
notchDepth=2.5; 

//height of jaggy section
toothH=strapT-notchDepth; 

// pitch of teeth 
toothW=5; 

//strap width
strapW=23.75; 

//how long the tooth section is on the strap
toothL=150;  

//the narrow part of last tooth
endW=20;  

//the last tooth lenght at end of strap
endL=10;  

//how far the center distance of end tab to start of strap
screwOffset=25;  

//outer radius of end tab
tabR=26.46/2; 

//height of end tab
tabH=6; 

//face height of washer on end tab
washerT=1.9; 

//radius of washer
washerR=19.4/2; 

//size of hole on end strap
holeR=11/2;  


module tooth(){
hull(){
translate([toothW,0,0]) cube([.01,strapW,notchDepth]);
cube([.01,strapW,strapT]);
}
}


module teeth(){
//generate teeth
    for(i = [toothW:toothW:toothL]) {
    translate([i-toothW,-strapW/2,0])
        tooth();  
    }
}


module toothEnd(){
union(){
hull(){
translate([toothL,-strapW/2,0]) cube([.1,strapW,strapT]);
translate([toothL+endL,-endW/2,0]) cube([.1,endW,.1]);
}
teeth();
}
}

module solidTab(){
hull(){
translate([0,-strapW/2,0]) cube([.1,strapW,strapT]);
translate([-screwOffset,0,0]) cylinder(r=tabR,h=tabH);
}
}

module cutFace(){
difference(){
solidTab();
translate([-screwOffset,0,-1]) cylinder(r=washerR,h=tabH+5); //washer face

}
}

module strapEnd(){
intersection(){
solidTab();
translate([-screwOffset,0,0]){
rotate_extrude(convexity = 10)
translate([holeR+tabH-washerT, 0, 0])
circle(r = (tabH-washerT));
}
}
cutFace();
}

module wholeStrap(){
    toothEnd();
    strapEnd();
}

wholeStrap();





