// <Sopak's Hinge Leaf> (c) by <Kamil Sopko>
// 
// <Sopak's Hinge Leaf> is licensed under a
// Creative Commons Attribution-ShareAlike 4.0 Unported License.
// 
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.

// this was inspired by http://www.thingiverse.com/thing:39137
// purpose of this is  customizer, more rigidity and easy print

/* [Dimensions] */

//height of one leaf ( 3 leafs  make 45 mm by default)
height=15;  // [10:100]
//minimum with of wall
width=4;    // [2:40]
//lenght of one leaf from center of hinge (real size is +width+hingeD/2)
lenght=60;  // [15:200]
//inner diameter for screw
hingeD=4.5; // [1:20]
//number  of screws
numberOfScrews=3;   // [2:10]
//diameter of screws
screwD=4;   // [2:10]
//ofset of first hole
firstHoleOffset=15;   // [10:100]

/* [Visibility] */

//number of leafes in cols
printCols=1;   // [1:5]
//number of leafes in rows
printRows=3;   // [1:5]
//spacing in print setup
printSpacing=3;   // [1:10]
//show print by default, if true show serup of 3 hinges
showSetup="no";     // [yes,no]
//add pin for force lockink instead of hole
hingeWithPinLock= "no"; // [yes,no]
//if hingeWithPinLock, chose side
hingeWithPinLockTop="no"; // [yes,no]
//quality
$fn=100;



module leaf(){
    difference(){
        union(){
            linear_extrude(height=height){
                difference(){
                    union(){
                        hull(){
                            circle(d=hingeD+2*width);
                            translate([lenght,hingeD/2+width/2])circle(d=width);
                        }                }
                    if(hingeWithPinLock=="no"){                    
                        circle(d=hingeD);
                    }
                }
            }
    
            if(hingeWithPinLock=="yes"){                    
                if(hingeWithPinLockTop=="yes"){
                    translate([0,0,height])sphere(d=hingeD-(hingeD/100*10));
                }else{
                    translate([0,0,0])sphere(d=hingeD-(hingeD/100*10));
                }
            }

        }
        stepSize=(lenght-firstHoleOffset)/numberOfScrews;
        stepSize2=stepSize+(stepSize/numberOfScrews);
        for(i=[firstHoleOffset:stepSize2:lenght]){
            translate([i,hingeD/2+width+1,height/2])rotate([90,0,0])cylinder(d=screwD,h=hingeD+2*width+2);
        }
        
        hull(){
            for(i=[firstHoleOffset:stepSize2:lenght]){
                translate([i,width/2,height/2])rotate([90,0,0])cylinder(d1=screwD,d2=height+width/2,h=hingeD/2+width+width/2);
            }
        }
    }
}
module print(rotateX=0){    
    for(row=[0:printRows-1]){
        for(col=[0:printCols-1]){
            translate([col*(width+hingeD/2+lenght+printSpacing),row*(hingeD+width*2+printSpacing),0])rotate([rotateX,0,0])leaf();
        }
    }
}


if(showSetup=="yes"){
    translate([-hingeD/2-width,-hingeD/2-width,height/2]){
        translate([0,0,-height*2])leaf();
        translate([0,0,0])rotate([180,0,90])leaf();
        translate([0,0,0])leaf();
    }
}else{    
    if(hingeWithPinLock=="yes" && hingeWithPinLockTop=="no"){
        translate([0,0,height])print(rotateX=180);
    }else{
        print();
    }
}
