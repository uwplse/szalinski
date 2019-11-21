//  original drawing by dybde - 6mm
// reworked by Paxy
// reworked by Pierrevedel : male or female shape, triangle or square or rectangle shape, shape parameter is now edge lenght and larger head

// preview[view:south east, tilt:top diagonal]
/*Customizer Variables*/
// Gender of the imprint
imprintGender=0;//[0:Female,1:Male]
// Shape of the imprint
imprintShape=4.5;//[3:Triangle,4:Square,4.5:Rectangle]
// Lenght of the imprint edge. BACKLASH : add 1-2mm for female, substrack 1-2mm for male 
imprintEdgeLenght=12;//[1:0.5:50]
// Only for RECTANGLE. Lenght of the imprint small edge. BACKLASH : add 1-2mm for female, substrack 1-2mm for male 
imprintSmallEdgeLenght=8;//[1:0.5:50]
// Only for FEMALE key. Outer diameter of the blade. BACKLASH : substrack 1-2mm.
bladeOuterDiameter=17;//[1:0.5:50]
// Lenght of blade
bladeLenght=20;//[1:1:80]
// Only for FEMALE key. Deepness of imprint
imprintDepth=5;//[1:1:80]
// Lenght of the head
headLenght=10;//[5:1:20]
// Width of the head
headWidth=30;//[15:5:50]


/* [Hidden] */
$fn=50;
headThickness=6;
// to prevent null thickness
x=0.1;
//Z coordinate of the ring hole
ringZ=bladeOuterDiameter/2+headLenght+headWidth/2-headThickness/2;

//imprint shape with i for lenght; with i for z offset, j for imprint lenght and k for y offset  
module imprint(i,j,k){
    scale([rectangleRescale(imprintShape),1,1])translate([0,k,i]) rotate ([0, 0, imprintRotation(imprintShape)])cylinder(r=imprintRadius(imprintShape),h=j,$fn=floor(imprintShape));
};
// 2 spheres belonging to both head and blabe
module headBladeJointElement(){
    translate([0,headWidth/2,bladeOuterDiameter/2]) sphere(r=headThickness/2,center=true);
};
module headBladeJoint(){
    headBladeJointElement();
    mirror([0,1,0]) headBladeJointElement();
};
//flat to insert ring
module RingFlatElement(){
    translate([headThickness/2,0,0])
    translate([0,0,ringZ+headThickness/2])
    rotate ([0, 90, 0])
    cylinder(r=headThickness,h=headThickness/2, center=true);
};
module RingFlat(){
    RingFlatElement();
    mirror([1,0,0]) RingFlatElement();
};
//radius of the tesselated cylinder; with i for number of imprint side 
function imprintRadius(i)=
    (i==3) ? imprintEdgeLenght/(2*sin(60)) : imprintEdgeLenght*sqrt(2)/2;
//rotation of the imprint to line up with the head; with i for number of imprint side 
function imprintRotation(i)=
    (i==3) ? 30 : 45;
//offset to center male triangle imprint
function triangleOffsetY(i)=
    (i==3) ? (2*imprintRadius(imprintShape)-imprintEdgeLenght*cos(30))/2 : 0;
//rescale for rectangle
function rectangleRescale(i)=
    (i>4) ? imprintSmallEdgeLenght/imprintEdgeLenght : 1;
    
rotate ([0, 180, 0])
union(){
//blade
    ///female
    if (imprintGender==0){
        difference() {
            union() {    
                translate([0,0,-bladeLenght-bladeOuterDiameter/2])
                    cylinder(r=bladeOuterDiameter/2,h=bladeLenght+bladeOuterDiameter/2);
                //transition between blade and head
                hull() {
                    sphere(r=bladeOuterDiameter/2,center=true);	
                    headBladeJoint();
                    }
            }
            imprint(-bladeLenght-bladeOuterDiameter/2-x,imprintDepth,0);
        }
            
    ///male
    }else {
        union(){
            imprint(-bladeLenght+x,bladeLenght,triangleOffsetY(imprintShape));
            //transition between blade and head
            hull() {
                //null thick imprint to fit with the blade
                imprint(0,x,triangleOffsetY(imprintShape)); 
                headBladeJoint();
            }
        }
    }
//head
    difference() {
        hull() {
            headBladeJoint(); 
            //torus
            translate([0,0,bladeOuterDiameter/2+headLenght])
            rotate ([0, 90, 0])
            //cut half of torus
            difference() {
                rotate_extrude(angle = 90, convexity = 2) translate([headWidth/2,0,0])circle(r=headThickness/2, center=true);
                translate([(headWidth+headThickness+x)/2,0,0])cube(headWidth+headThickness+x, center=true);
            }
        }
        union(){
            RingFlat();
            //ring hole
            translate([0,0,ringZ]) rotate([0, 90, 0])
        cylinder(r=headThickness/2,h=headThickness, center=true);    
        }
    }
}