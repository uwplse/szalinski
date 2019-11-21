// Wobble (added to width, height and depth)
wobble = 2;
// Token width
width = 100;
// Token length
length = 100;
// Token stack depth
height = 19;
// The font you want to use
fontname = "Slabo 27px"; // [Slabo 27px,Oswald,Indie Flower,Yanone Kaffeesatz,Titillium Web,Arvo,Lobster,Fjalla One,Bree Serif,Muli,Pacifico,Anton,Maven Pro,Monda,Lobster Two,Bangers,Sigmar One,Courgette,Fugaz One,Patrick Hand,Viga,Fredoka One,Damion,Audiowide,Black Ops One,Montserrat Alternates,Jockey One,Lily Script One]
// Title 1
text1 = "Q5 - SALLES DES QUETES";
// Title 1 size
size1 = 8.8;
// Title 1 offset
offset1 = -1.4;
// Title 2
text2 = "";
// Title 2 size
size2 = 10;
// Title 2 offset
offset2 = 0;
// Space between characters
tspace = 1.1;
// Number of holes on the lid
holes = 0; // [0,1,4]
// Number of holes on the bottom part
bholes = 1; // [0,1,4]
// Style of opening
frontopening = 1; // [0:Top opening,1:Front+top opening]
// Print bottom or lid
print = 0; // [0:Bottom,1:Lid]
// Total reduction of the width of the lid (so that it fits)
topreduc = 0.1;


innerx = length + wobble;
innery = width + wobble;
innerz = height + wobble;
fonttype = str(fontname);

module bottom(topdiff=0){
if (frontopening==0){
if (text2=="") {
    #translate([innerx+9,innery/2+4,innerz/2+3.5+offset1]) rotate([90,0,90]) linear_extrude(height = 2, center = false, convexity = 10) text(text1,size1,font=fonttype,valign="center",halign="center",spacing=tspace);    
   
    
    } else {
    #translate([innerx+9,innery/2+4,innerz/2+3.5+6+offset1]) rotate([90,0,90]) linear_extrude(height = 2, center = false, convexity = 10) text(text1,size1,font=fonttype,valign="center",halign="center",spacing=tspace);            
    
#translate([innerx+9,innery/2+4,innerz/2-5+offset2]) rotate([90,0,90]) linear_extrude(height = 2, center = false, convexity = 10) text(text2,size2,font=fonttype,valign="center",halign="center",spacing=tspace); 
    }
}    
union(){
 /*   difference(){
        translate([6,2,innerz]) cylinder($fn=100,d=5,h=4.5);
        translate([6,-2,innerz]) cylinder($fn=100,d=5,h=4.5);
    }
    difference(){
        translate([6,8+innery,innerz]) cylinder($fn=100,d=5,h=4.5);
        translate([6,12+innery,innerz]) cylinder($fn=100,d=5,h=4.5);
    }
    */
    difference(){
        cube([innerx+10,innery+10+topdiff,innerz+5]);
        translate([5,5,1.2]) cube([innerx,innery-topdiff,innerz+1]);
        
         translate([5,5,1.2+innerz]) cube([innerx,innery-topdiff,innerz+1]);
        /*translate([5+innerx*0.15,5+innery*0.15,-1.2]) minkowski() {
        cube([innerx*0.7,innery*0.7-topdiff,innerz+1]);
        cylinder($fn=100,r=width/12,h=1);
    }*/
if (bholes==4){
        translate([5+innerx/10,5+innery/10,-0.1]) minkowski() {
            cube([innerx/3,innery/3,innerz]);
            cylinder($fn=100,h=1,d=width/20);
        }
        translate([5+innerx/10,5+innery/1.78,-0.1]) minkowski() {
            cube([innerx/3,innery/3,innerz]);
            cylinder($fn=100,h=1,d=width/20);
        }
        translate([5+innerx/1.78,5+innery/10,-0.1]) minkowski() {
            cube([innerx/3,innery/3,innerz]);
            cylinder($fn=100,h=1,d=width/20);
        }
        translate([5+innerx/1.78,5+innery/1.78,-0.1]) minkowski() {
            cube([innerx/3,innery/3,innerz]);
            cylinder($fn=100,h=1,d=width/20);
        }
    }
    if (bholes==1){   
        translate([5+innerx/10,5+innery/10,-0.1]) minkowski() {
            cube([innerx/1.2,innery/1.25,innerz]);
            cylinder($fn=100,h=1,d=width/20);
        }
    }
        hull(){    
        translate([3,3,innerz+2]) cube([innerx,innery-topdiff+4,1.6]);
        translate([6,6,innerz+4]) cube([innerx-6,innery-topdiff-2,1.6]);
        }
if (frontopening==1){        
        translate([5+innerx/1.2,-1,1.2]) rotate([0,-atan(innerx/(innerz*10)),0]) cube([innerx,innery+20-topdiff,innerx]);
        translate([5+innerx/1.2,-1,1.2]) cube([innerx,innery+20-topdiff,innerz*3]);
}
else
{
        //translate([5+innerx/1.2,-1,1.2]) rotate([0,-atan(innerx/(innerz*10)),0]) cube([innerx,innery+20-topdiff,innerz*3]);
        translate([innerx,-1,innerz+2]) cube([innerx,innery+20-topdiff,innerz*3]);
}
    }
    //translate([10,2.7,innerz-4]) cylinder(d=2,h=10,$fn=100);
    //translate([10,7.1+innery-topdiff,innerz-4]) cylinder(d=2,h=10,$fn=100);
    }
}


module top(topdiff=0){
if (frontopening==1){
if (text2=="") {
    #translate([innerx+9,innery/2+4,innerz/2+3.5+offset1]) rotate([90,0,90]) linear_extrude(height = 2, center = false, convexity = 10) text(text1,size1,font=fonttype,valign="center",halign="center",spacing=tspace);    
    } else {
    #translate([innerx+9,innery/2+4,innerz/2+3.5+6+offset1]) rotate([90,0,90]) linear_extrude(height = 2, center = false, convexity = 10) text(text1,size1,font=fonttype,valign="center",halign="center",spacing=tspace);            
    
#translate([innerx+9,innery/2+4,innerz/2-5+offset2]) rotate([90,0,90]) linear_extrude(height = 2, center = false, convexity = 10) text(text2,size2,font=fonttype,valign="center",halign="center",spacing=tspace); 
    }
}
    
    
    
    difference() {
        union(){
            intersection(){
                translate([0,0,innerz+2]) cube([innerx+10,innery+10-topdiff,1.2]);
    translate([3,3+topreduc/2,innerz+2]) cube([innerx+5,innery+4-topreduc,1.2]);
            }
            difference(){
                intersection(){
if (frontopening==1)
{
                    translate([0,0,1.4]) cube([innerx+10,innery+10+topdiff,innerz+1.8]);
}
else
{
    difference()
    {
        translate([0,0,1.4]) cube([innerx+10,innery+10+topdiff,innerz+1.4+2.2]);
        translate([5,5,1.2+innerz]) cube([innerx,innery-topdiff,innerz+1]);
    }
}
                        union(){
if (frontopening==1){
                            translate([5+innerx/1.2,-1,1.2]) rotate([0,-atan(innerx/(innerz*10)),0]) cube([innerx,innery+20-topdiff,innerz*3]);
    translate([5+innerx/1.2,-1,1.2]) cube([innerx,innery+20-topdiff,innerz*3]);
}
else
{
    translate([innerx,-1,innerz+2]) cube([innerx,innery+20-topdiff,innerz*3]);
}
                            
                        }
                }
    translate([5,5,1.2]) cube([innerx,innery-topdiff,innerz+1]);
            }
        }
if (holes==4){        
        translate([5+innerx/10,5+innery/10,0]) minkowski() {
            cube([innerx/3,innery/3,innerz+10]);
            cylinder($fn=100,h=1,d=width/20);
        }
        translate([5+innerx/10,5+innery/1.78,0]) minkowski() {
            cube([innerx/3,innery/3,innerz+10]);
            cylinder($fn=100,h=1,d=width/20);
        }
        translate([5+innerx/1.78,5+innery/10,0]) minkowski() {
            cube([innerx/3,innery/3,innerz+10]);
            cylinder($fn=100,h=1,d=width/20);
        }
        translate([5+innerx/1.78,5+innery/1.78,0]) minkowski() {
            cube([innerx/3,innery/3,innerz+10]);
            cylinder($fn=100,h=1,d=width/20);
        }
    }
    if (holes==1){   
        translate([5+innerx/10,5+innery/10,0]) minkowski() {
            cube([innerx/1.2,innery/1.25,innerz+10]);
            cylinder($fn=100,h=1,d=width/20);
        }
    }
        //translate([0,0,0]) bottom();
        //translate([0,0.2,0]) bottom(0.4);
        translate([-2,-5.2+topreduc/2,innerz-4]) rotate([0,0,-10]) cube([10,10,10]);
    translate([0,innery+5.3-topreduc/2,innerz-4]) rotate([0,0,10]) cube([10,10,10]);
    }
}
if (print==1){
if (frontopening==0){
translate([100,0,0]) top();
}
else
{
    translate([100,0,0]) rotate([0,180,0]) top();
}
}
else
{
bottom();
}
if (print=="p"){
    bottom();
    translate([0,0,0]) top();
}
if (print=="po"){
    bottom();
    translate([50,0,0]) top();
}