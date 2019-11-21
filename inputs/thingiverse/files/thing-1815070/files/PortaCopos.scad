/* [SIZE CONFIGURATION] */
// External Size
size1=80;
// Internal Size
size2=60;
/* [TEXT DECORATION] */
text1= "Caroline";
offset1=-8;
text2= "Vicente";
offset2=-1;
/* [HIDDEN] */

$fn=50;

difference(){
    
    union(){
    
        cylinder(h=2,d=size1,$fn=6);
        rotate(a=[0,0,30])
                cylinder(h=2,d=size1,$fn=6);
        cylinder(h=2.4,d=size2);        
    }    
    translate([-16+offset1,0,2])
        linear_extrude(height=1)
            text(text1);
    
    translate([-20+offset2,-15,2])
        linear_extrude(height=1)
            text(text2);
    
}