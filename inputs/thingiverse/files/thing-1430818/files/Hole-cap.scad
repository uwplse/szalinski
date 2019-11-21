//External Diameter (equal to the diameter of the hole where you'll insert this cap)
Diameter=32; // [1:100]

//Teeth protruding
TeethExt=1; // [0.1:0.1:10]

//How much teeth?
TeethExtCount=8; // [0:36]

//Thickness of the cylinder's perimeter that will be in the hole
Thickness=2; // [0.1:0.1:10]

//Height of the part that will be inserted in the hole
Height=10; // [0.1:0.1:100]

/* [Hidden] */
//Segments number in circles
Segments=144;

translate([0,0,Height+Diameter/16])
rotate([180,0,0])
union(){
    linear_extrude(height=Height, convexity=10)
    difference(){
        intersection(){
            union(){
                circle($fn=Segments,d=Diameter-TeethExt);
                for(r=[0:360/TeethExtCount:360])
                    rotate(a=r, v=[0,0,1])
                        square(size=[Diameter/24, Diameter*1.5], center=true);
                
            }
            circle($fn=Segments,d=Diameter);
        }
        circle($fn=Segments,d=Diameter-Thickness-TeethExt);
    }
    translate([0,0,Height])
        cylinder($fn=Segments,h=Diameter/16, d1=Diameter+Diameter/5, d2=Diameter+Diameter/16);
}