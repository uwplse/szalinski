//Size of the actual cube
Size = 25; 		    //[3:100]
//Border thickness
BorderThicc = 1.5;  //[0.5:0.1:10]
//Border Height     
BorderHigh = 5;     //[2:0.1:10]
//Bottom thickness
Bottom = 1.4;       //[0.5:0.1:10]

//Fixed Resolution
$fa=5+0;
$fs=0.5+0;

//Actual code
difference(){
    cube([Size+BorderThicc*2,Size+BorderThicc*2,BorderHigh], true);
    cube([Size,Size,Size], true);
}
cube([Size,Size,Bottom], true);


