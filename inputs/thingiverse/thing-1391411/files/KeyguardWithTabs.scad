//////////////////////////////////////////////////KeyguardWithTabs
//author: Tim Driskell
//date: 12/10/2015
/////////////////////////////////////////////////


//////////////user inputs////////////////////////

height =157.15;//desired length of the keyguard
width = 120.65;//desired width of the keyguard
depth = 5;//keyguard thickness
cols= 2;//the number of cutouts in relation to the width of the device
rows = 2;//the number of cutouts in relation to the length of the device
tab_length = 12.5; //thickness of attachment tabs.


////////////////renderings///////////////////////
keyguard();


///////////////////modules///////////////////////
module keyguard(){
    difference(){
      cube([width,height,depth]);
        inserts();
    }
    tabs();
}
module inserts(){
    //alpha changes the size of cutouts. Size of cutout is inversely proportional to alpha
    alpha=0.25;
    //creates cutouts in x-direction
    for (i=[0:cols-1]){
    //creates cutouts in y-direction
        for (j=[0:rows-1]){
    //determines location of each cutout iterations
            translate([width/cols*i+width/(cols*(2*cols+0.75*pow((1/alpha),2))),height/rows*j+height/(rows*(2*rows+0.75*pow((1/alpha),2))),-0.01])
    //cutout size proportional to size of keyguard        
            cube([width*(cols/((cols+alpha)*(cols))),height*(rows/((rows)*(rows+alpha))),depth+0.02]);
            //changing alpha increases cutout size. 
        }
    }
}

module tabs() {
    translate([-tab_length,0,0])
    cube([tab_length,height,2.54]);
    translate([width,0,0])
    cube([tab_length,height,2.54]);
}