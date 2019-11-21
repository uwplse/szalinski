
intersection(){
        union(){ 
difference() {
cube (10,center=true);// the bigger the model you want, the bigger the frame will be. take the highest number and add to it 10 (if Z/x/y=100, make the box 110 or bigger for thicker walls). 
$fn=300;

cylinder (h=9, r=01, center=false);//h=the holes langht, make it as the model sise.
import("mold_test.stl", center=true);}        }//import the .stl file you want
        translate([-50,0,0])//cange betwin -50 and 50 to get the scond side of the mold.
                cube([100,200,200], center=true);
}

           
       
