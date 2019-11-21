// Takuya Yamaguchi

// ignore variable values
//$fn=48;

//custermizing data

// number of tooth
nt =12;

//shaft diameter		
sd =8;

//gear diameter		
gd=15;

// fringe thickness		
ggdt=1.5;	

// gear hight
gh=18;

//number of fringe		
nf=0;	//[0,1,2]

//tooth shape	
$fn=12; //[4,5,6,7,8,12]

//Dcut yes or no
Dcut="yes";//[yes,no]

// ignore variable values
gpr=gd*3.14159/4/nt/(1+3.141592/nt/2);	//gear tooth r
gmr=gpr*1.077; 							// gear gap r
ggd=gd+4; 									// fringe diameter
dh=gh; 										//Dcut hight
off= 360/nt/2;  							// tooth offset

module pgear()

	union(){
	translate([0, 0, 0]) {
		difference() {
         union(){  //gear & fringe
		  translate([0, 0, 0]) cylinder(h = gh, r =gd/2-gpr,$fn=48); //gear
      if (nf == 1){
          translate([0, 0, gh-ggdt])cylinder(h = ggdt, r= ggd/2,$fn=96); //fringe
      				}
      if (nf == 2){
         translate([0, 0, gh-ggdt])cylinder(h = ggdt, r= ggd/2,$fn=96); //fringe
         translate([0, 0, 0])cylinder(h = ggdt, r= ggd/2,$fn=96); //fringe
                   }
                 }
translate([0, 0, -0.5])  // shaft 
			cylinder(h = gh+2.5, r= sd/2,$fn=48);

		for (i = [0:(nt-1)]) { 		//gear gap
			echo(360*i/nt, sin(360*i/nt)*(gd/2-gpr), cos(360*i/nt)*(gd/2-gpr));
			translate([sin(360*i/nt)*(gd/2-gpr), cos(360*i/nt)*(gd/2-gpr), ggdt*nf*(nf-1)*0.5])
				rotate([0,0,90*(1-2/$fn)-360*i/nt-($fn-1)*off]) cylinder(h = gh-ggdt*nf, r=gmr);
		                      }
     							}
		for (i = [0:(nt-1)]) {  // Gear tooth
			echo(360*i/nt+off, sin(360*i/nt+off)*(gd/2-gpr), cos(360*i/nt+off)*(gd/2-gpr));
			translate([sin(360*i/nt+off)*(gd/2-gpr), cos(360*i/nt+off)*(gd/2-gpr), 0 ])
				rotate([0,0,90*(1-2/$fn)-360*i/nt-$fn*off]) cylinder(h = gh, r=gpr);
		                      }
                }


 			
	 // Dcut
 if (Dcut== "yes"){
         translate([-(sd/2.1), 0, gh/2]) cube([sd/5,sd*0.8,dh], center = true); // Dcut
       }
}

pgear();
