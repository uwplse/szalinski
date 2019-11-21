//   Bottlelift by gaziel for pierrelesek, Alnoa
//modified for Brian 

//   how many bottle in 1 line ?
Bottle_X=4; 

//   how many line of beer ?
Bottle_Y=1; 

//   caliper time !
Magnet_diameter=20;

//   62 for a standart 33cl beer bottle
Bottle_Diameter=62;

//no Fu$%ing low temp 3 m scotch .. no problem !
Screw="yes";//["yes","no"]

//   useless is the beterway, heuresement que j'ai pas arondis les coins comme un telephone de la pomme
Brian_revelation=1/1;//["amagod","xptdr"]


Thinkness=2;


module OneBelgianBeerPlease(){
    difference(){
        cube([Bottle_Diameter,Bottle_Diameter,Thinkness]);
            if (Screw=="yes"){
                translate([(Bottle_Diameter/2)-Magnet_diameter+Thinkness*2,Bottle_Diameter/2,0])cylinder(r=2,h=Thinkness);
            }
        }
        if (Brian_revelation==1){
            translate([Bottle_Diameter/2,Bottle_Diameter/2,Thinkness*1.5]) cylinder(d=Thinkness ,h=Bottle_Diameter);
        }
        translate([Bottle_Diameter/2,Bottle_Diameter/2,Thinkness*1.5]){
            difference(){
                cylinder(d1=Magnet_diameter+Thinkness*2,d2=Magnet_diameter+Thinkness,h=Thinkness,center=true);
                cylinder(d=Magnet_diameter,h=Thinkness+1,center=true);

            }
        }
    
}

for(j=[0,Bottle_Y-1]){
        for (i=[0:Bottle_X-1]){
            translate([i*Bottle_Diameter,j*Bottle_Diameter,0])OneBelgianBeerPlease(); 
        }
    }
    
    