//////////////////////////////////////////////////GoTalk Now Keyguard
//author: Tim Driskell
//date: 2/8/2016
/////////////////////////////////////////////////


//////////////user inputs////////////////////////
//Screen width of device
height =205;//desired width of the keyguard
//screen height of device
width = 128.5;//desired width of the keyguard
//thickness of keyguard. 3mm recommended
depth = 3;//keyguard thickness

field=4;//[1,2,4,9,16,25]

cols= field>3 ? sqrt(field): 1;//the number of cutouts in relation to the width of the device
rows = field>3 ? sqrt(field) : field;//the number of cutouts in relation to the length of the device



////////////////renderings///////////////////////
keyguard();
translate([width,0,0]){
difference(){
    cube([width/5.5,height,depth]);
    translate([0,height/16,-0.005])
    cube([0.8*width/5.5,0.875*height,depth+0.01]);
}
}
echo(cols);
echo(rows);
///////////////////modules///////////////////////
module keyguard(){
    difference(){
      cube([width,height,depth]);
        inserts();
    }
}
module inserts(){
    
if (field>4){
    cols= sqrt(field);//the number of cutouts in relation to the width of the device
    rows = sqrt(field);//the number of cutouts in relation to the length of the device
}
else {
    cols=field;
    rows=1;
}
    
echo(alpha);
    //alpha changes the size of cutouts. Size of cutout is inversely proportional to alpha
    alpha=1/8;
    //creates cutouts in x-direction
    for (i=[0:cols-1]){
    //creates cutouts in y-direction
        for (j=[0:rows-1]){
    //determines location of each cutout iterations
            translate([width/cols*i+width/(cols*(2*cols+0.25*pow((1/alpha),2))),height/rows*j+height/(rows*(2*rows+(rows*cols)+0.25*pow((1/alpha),2))),-0.005])
    //cutout size proportional to size of keyguard        
            cube([width*(cols/((cols+alpha*2)*(cols))),height*(rows/((rows)*(rows+alpha*2))),depth+0.01]);
            //changing alpha increases cutout size. 
        }
    }
}