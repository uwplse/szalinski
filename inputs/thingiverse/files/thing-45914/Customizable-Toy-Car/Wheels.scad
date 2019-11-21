//Choose from preset cars
Preset=1; //[0:Custom,1:1963 Impalla,2:Wagon,3:Hatchback,4:El Camino,5:Mini Cooper,6:Pickup,7:Jeep,8:Vintage Race Car]
//Select the hood style
HoodStyle=3; //[0:Impalla Wagon Hatchback El Camino,1:Mini Cooper,2:Pickup Jeep,3:Vintage Race Car]
//Select the body style
BodyStyle=0; //[0:Impalla Wagon Hatchback El Camino,1:Mini Cooper,2:Pickup Jeep,3:Vintage Race Car]
//Select the back end style
TrunkStyle=0; //[0:60s Impala,1:80s Wagon,2:80s Hatchback,3:El Camino,4:Mini Cooper,5:Pickup,6:Jeep,7:Vintage Race Car]
//(optional) Will not appear on pickup style backs
Spoiler=0; //[0:None,1:Small,2:Large,3:Dual Spoiler]
//(optional) US and UK affect which side of the hood the gun is on
Weapons=0; //[0:None,1:Dual Guns,2:Single Gun(US),3:Single Gun(UK)]
//(optional) Type of gun (intended for future expansion)
WType=1; // [1:Gattling Gun,2:50 Cal,3:Rocket]
//Size of Tires
Front_Wheel_Size=12; //[10:Small,12:Large,14:XLarge]
//Size of Tires
Rear_Wheel_Size=12; //[10:Small,12:Large,14:XLarge]
//Number of Spokes on the tire
No_Spokes=5; //[3,5,7]
//Length of body
Body=70; //[70:Short,90:Medium,100:Long]
//Select what to generate (Fully Assembled will look nice, but is not printable)
Print=0; //[0:Fully assembled,1:Single Build,2:Hub Caps Only,3:Body Only,4:Tire Rubber Only,5:Weapons Only,6:Spoiler Only]
// preview[view:south west]


module TIRE(radius,width,res) {
  difference(){
    intersection(){
      cylinder(r=radius,h=width,$fn=res*0.8,center=true);
      sphere(radius,center=true,$fn=res);
    }
    union(){
      cylinder(r=(radius*0.75),h=width+1,$fn=res,center=true);
      cylinder(r=(radius*.8),h=width*.8,$fn=res,center=true);
    }
  }
}
module HUBS(radius,width,res,spokes,axe,side){
  r1=radius*.75;
  r2=radius*.77;
  union(){
    difference(){
      union(){
        //center hub
        translate([0,0,width/4]){cylinder(r=radius/4,h=width/2,center=true,$fn=res);}
        //spokes
		difference(){
			translate([0,0,(width/2)*.9]){
			  for (i=[0:spokes])
			  {
				rotate(i*360/(spokes+1),[0,0,1])
				hull(){
				  //inner part of hull
				  cube([1,1,1],center=true);
				  //rotate and place outer part (direction based on settings)
				  intersection(){
					if (side=="L"){
					  translate([0,r1,-.5]){rotate([0,15,0]){cube([4,1,.5],center=true);}}
					} else {
					  translate([0,r1,-.5]){rotate([0,-15,0]){cube([4,1,.5],center=true);}}
					}
					cylinder(r=radius*.75,h=width,center=true);
				  }
				}
			  }
			}
			translate([0,0,(width/2)]) cylinder(r=radius,h=1);
		}
      }
      //Hole for axel
      cylinder(r=axe,h=width+1,center=true,$fn=res);
    }
    //outer race of hub
    difference(){
      hull(){
        //slopped part to ensure tight fit
        cylinder(r=r1,h=width,center=true,$fn=res);
        cylinder(r=r2,h=width-1,center=true,$fn=res);
      }
      //cut out center part of hub
      cylinder(r=r1*.9,h=width+1,center=true,$fn=res);
    }
  }
}
module Axel(WheelBase){
	res1=50;
	difference(){
		union(){
			//main axel
			rotate([90,0,0]) cylinder(r=1,h=WheelBase,$fn=res1);
			//Joint Clips
			sphere(r=1.25,$fn=res1);
			translate([0,4.5,0]) sphere(r=1.25,$fn=res1);
			translate([0,4.5,0]) rotate([90,0,0]) cylinder(r=.9,h=5,$fn=res1);
			translate([0,-WheelBase,0]) {
				sphere(r=1.25,$fn=res1);
				translate([0,-4.5,0]) sphere(r=1.25,$fn=res1);
				translate([0,-4.5,0]) rotate([-90,0,0]) cylinder(r=.9,h=5,$fn=res1);
			}
		}
		union(){
			translate([0,5,0])cube([.7,10,10],center=true);
			translate([0,-WheelBase-5,0])cube([.7,10,10],center=true);
			translate([-50,-60,-2]) cube([100,100,1.1]);
			translate([-50,-60,.9]) cube([100,100,1]);
		}
	}
}
module PrintHood(Body_Length,WheelBase,Style,Tires){
	res1=50;
	res2=100;
	res3=25;
	module HeadLight1(){ //Impala Headlights
		difference(){
			sphere(r=5,$fn=res1);
			translate([-3.5,-10,-10])cube([10,20,20]);
		}
		translate([-4,0,0]) rotate([0,90,0]) hull(){
			cylinder(r=4,h=2,$fn=res1);
			translate([5,0,0])cylinder(r=4,h=2);
		}
	}
	module Style0(){ //Impala style hood (for impala, wagon and old hatchback)
	difference(){
		union(){
			//Hood
			translate([-35,0,15]) rotate([0,-1,0]){
				difference(){
					union(){
						cube([55,WheelBase,4]);
						translate([5.4,0,0]) rotate([0,45,0]) cube([10,WheelBase,5]);
					}
					union(){
						translate([12,WheelBase/2,5]) rotate([2,0,0]) cube([80,WheelBase*1.5,3],center=true);
						translate([12,WheelBase/2,5]) rotate([-2,0,0]) cube([80,WheelBase*1.5,3],center=true);
						translate([-1,WheelBase/2,0]) rotate([0,0,5]) cube([10,WheelBase*1.5,20], center=true);
						translate([-1,WheelBase/2,0]) rotate([0,0,-5]) cube([10,WheelBase*1.5,20], center=true);
						translate([20,WheelBase/2,5]) rotate([2,-5,0]) cube([80,WheelBase*1.5,3],center=true);
						translate([20,WheelBase/2,5]) rotate([-2,-5,0]) cube([80,WheelBase*1.5,3],center=true);
						//#color("grey") translate([15,WheelBase-12,22]) rotate([0,-90,0]) rotate([0,0,90]) PrintWeapon(0);
					}
				}
			}
			//Body of front
			difference(){
				union(){
					//Slightly Flared Sides (driver)
					translate([-30,-(WheelBase/2)+1.5,4]) rotate([0,90,0]){
						intersection(){
							intersection(){
								cylinder(r=30,h=80,$fn=res2);
								translate([0,50,0]) cylinder(r=30,h=80,$fn=res2);
							}
							translate([2,0,0]) rotate([0,-5,0]) intersection(){
								cylinder(r=30,h=80,$fn=res2);
								translate([0,50,0]) cylinder(r=30,h=80,$fn=res2);
							
							}
						}
					}
					//Passenger Side
					translate([-30,(WheelBase/2)+1.5,4]) rotate([0,90,0])
						intersection(){
							intersection(){
								cylinder(r=30,h=80,$fn=res2);
								translate([0,50,0]) cylinder(r=30,h=80,$fn=res2);
							}
							translate([2,0,0]) rotate([0,-5,0]) intersection(){
								cylinder(r=30,h=80,$fn=res2);
								translate([0,50,0]) cylinder(r=30,h=80,$fn=res2);
							}
						}
					//fill in center
					translate([-29,0,-4]) rotate([0,-1.5,0]) cube([80,WheelBase,20]);
				}
				//Even front and bottom
				union(){
					//Even front bottom, and back
					translate([-50,-20,-20]) cube([100,100,20]);
					translate([-38,-20,-4]) rotate([0,-2,0]) cube([10,100,50]);
					translate([20,-20,-15])cube([60,100,50]);
					//profile for grill and lights
					rotate([0,-2,0]) union(){
						translate([-33,WheelBase/2,11.75]) rotate([0,0,1]) cube([10,WheelBase*.95,8],center=true);
						translate([-33,WheelBase/2,11.75]) rotate([0,0,-1]) cube([10,WheelBase*.95,8],center=true);
					}
					//Wheel Wells
					//driver side
					translate([0,5,0]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
					translate([0,5,-4]) rotate([90,0,0]) cylinder(r=Tires+3,h=14,$fn=res1);
					//passenger side
					translate([0,2+WheelBase,0]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
					translate([0,9+WheelBase,-4]) rotate([90,0,0]) cylinder(r=Tires+3,h=14,$fn=res1);
					
				}
			}
			//Add Bumper
			translate([-31,-7.5,0]) cube([10,WheelBase+15,5]);
			//add lights
			translate([-24.75,2,10]) HeadLight1();
			translate([-24.75,10,10]) HeadLight1();
			translate([-24.75,WheelBase-2,10]) HeadLight1();
			translate([-24.75,WheelBase-10,10]) HeadLight1();
		}
		if (Weapons==1) { //position Double Guns
			color("grey") translate([15,-5,18]) rotate([0,-90,0]) rotate([0,0,20]) PrintWeapon(0);
			color("grey") translate([15,WheelBase+5,18]) rotate([0,-90,0]) rotate([0,0,160]) PrintWeapon(0);
		} else if (Weapons==2) { //position Single Gun (US)
			color("grey") translate([15,WheelBase-12,22]) rotate([0,-90,0]) rotate([0,0,90]) PrintWeapon(0);
		} else if (Weapons==3) { //Position Single Gun (UK)
			color("grey") translate([15,12,22]) rotate([0,-90,0]) rotate([0,0,90]) PrintWeapon(0);
		}
	}
		//print Weapons
		if (Weapons==1 && Print==0) { //position Double Guns
			color("grey") translate([15,-5,18]) rotate([0,-90,0]) rotate([0,0,20]) PrintWeapon(WType);
			color("grey") translate([15,WheelBase+5,18]) rotate([0,-90,0]) rotate([0,0,160]) PrintWeapon(WType);
		} else if (Weapons==2 && Print==0) { //position Single Gun (US)
			color("grey") translate([15,WheelBase-12,22]) rotate([0,-90,0]) rotate([0,0,90]) PrintWeapon(WType);
		} else if (Weapons==3 && Print==0) { //Position Single Gun (UK)
			color("grey") translate([15,12,22]) rotate([0,-90,0]) rotate([0,0,90]) PrintWeapon(WType);
		}
	}
	module Style1(){ //Mini Cooper Hood
		difference(){
			union(){
				rotate([-90,0,0]) cylinder(r=Tires+3,h=WheelBase,$fn=res1);
				//driver Side
				color("Black") translate([0,.5,.90]) scale([1,.5,1]) sphere(r=Tires+3,$fn=res1);
				translate([-5,2,8]) rotate([0,86,0]) scale([1,.5,1]) {
					cylinder(r=10,h=25,$fn=res1);
					sphere(r=10,$fn=res1);
					translate([0,-10,0]) cube([10,20,30]);
					rotate([0,90,0]) cylinder(r=10,h=10,$fn=res1);
				}
				//Passenger Side
				color("Black") translate([0,WheelBase-.5,.90]) scale([1,.5,1]) sphere(r=Tires+3,$fn=res1);
				translate([-5,WheelBase-2,8]) rotate([0,86,0]) scale([1,.5,1]) {
					cylinder(r=10,h=25,$fn=res1);
					sphere(r=10,$fn=res1);
					translate([0,-10,0]) cube([10,20,30]);
					rotate([0,90,0]) cylinder(r=10,h=10,$fn=res1);
				}
				//front bumper
				translate([-Tires,0,2]) sphere(r=5,$fn=res1);
				translate([-Tires,WheelBase,2]) sphere(r=5,$fn=res1);
				translate([-Tires,0,2]) rotate([-90,0,0]) cylinder(r=5,h=WheelBase,$fn=res1);
				//hood
				translate([-3.5,WheelBase,6]) rotate([90,0,0]) cylinder(r=10,h=WheelBase,$fn=res1);
				translate([-3.5,1.5,6]) rotate([0,-9,0]) cube([30,WheelBase-3,10]);
				//fill in underside
				translate([0,0,0]) cube([20,WheelBase,10]);
			}
			//remove Wheel
			//Wheel Wells
			//driver side
			translate([0,5,.90]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
			translate([0,5,.9]) rotate([90,0,0]) cylinder(r=Tires-1,h=14,$fn=res1);
			//passenger side
			translate([0,2+WheelBase,.9]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
			translate([0,9+WheelBase,.9]) rotate([90,0,0]) cylinder(r=Tires-1,h=14,$fn=res1);
			//Clean Bottom
			translate([-30,-10,-30]) cube([100,100,30]);
			//Clean Back edge
			translate([19.5,-15,-10])cube([50,WheelBase+30,50]);
		if (Weapons==1) { //position Double Guns
			color("grey") translate([15,-3,20]) rotate([0,-90,0]) rotate([0,0,35]) PrintWeapon(0);
			color("grey") translate([15,WheelBase+3,20]) rotate([0,-90,0]) rotate([0,0,180-35]) PrintWeapon(0);
		} else if (Weapons==2) { //position Single Gun (US)
			color("grey") translate([15,WheelBase-12,22]) rotate([0,-90,0]) rotate([0,0,90]) PrintWeapon(0);
		} else if (Weapons==3) { //Position Single Gun (UK)
			color("grey") translate([15,12,22]) rotate([0,-90,0]) rotate([0,0,90]) PrintWeapon(0);
		}
	}
		//print Weapons
		if (Weapons==1 && Print==0) { //position Double Guns
			color("grey") translate([15,-3,20]) rotate([0,-90,0]) rotate([0,0,35]) PrintWeapon(WType);
			color("grey") translate([15,WheelBase+3,20]) rotate([0,-90,0]) rotate([0,0,180-35]) PrintWeapon(WType);
		} else if (Weapons==2 && Print==0) { //position Single Gun (US)
			color("grey") translate([15,WheelBase-12,22]) rotate([0,-90,0]) rotate([0,0,90]) PrintWeapon(WType);
		} else if (Weapons==3 && Print==0) { //Position Single Gun (UK)
			color("grey") translate([15,12,22]) rotate([0,-90,0]) rotate([0,0,90]) PrintWeapon(WType);
		}
	}
	module Style2(){ //80s era Ford pickup or minivan
		difference(){
			//basic shape
			union(){
				//Hood, flat with center bump (sloped at very front)
				difference(){
					translate([-20,0,20]) rotate([0,-2,0]) cube([50,WheelBase,5]);
					union(){
						translate([-23,-1,24]) rotate([0,-2,-2]) cube([52,WheelBase/3,5]);
						translate([-23,-1,22]) rotate([15,-2,-2]) cube([52,WheelBase/3,5]);
						translate([-23,(2*WheelBase)/3+1,24]) rotate([0,-2,2]) cube([52,WheelBase/3,5]);
						translate([-23,(2*WheelBase)/3+1,26.5]) rotate([-15,-2,2]) cube([52,WheelBase/3,5]);
						translate([-25,-1,25]) rotate([0,-2,0]) cube([53,WheelBase,5]);
						translate([-23,-1,23]) rotate([0,-6,-2]) cube([52,WheelBase/3,5]);
						translate([-23,(2*WheelBase)/3+1,23]) rotate([0,-6,2]) cube([52,WheelBase/3,5]);
						translate([-25,-1,24]) rotate([0,-6,0]) cube([53,WheelBase,5]);
					}
				}
				//Driver side verticle with slight flare at wheel well
					//hull(){
						translate([0,0,2]) rotate([90,0,0]) cylinder(r1=Tires+5,r2=Tires+3,h=4,$fn=res1);
						//translate([0,0,-5]) rotate([90,0,0]) cylinder(r1=Tires+5,r2=Tires+3,h=4,$fn=res1);
					//}
				//pasenger side
					//hull(){
						translate([0,WheelBase+4,2]) rotate([90,0,0]) cylinder(r2=Tires+5,r1=Tires+3,h=4,$fn=res1);
						//translate([0,WheelBase+4,-5]) rotate([90,0,0]) cylinder(r2=Tires+5,r1=Tires+3,h=4,$fn=res1);
					//}
				//headlights and grill
				difference(){
					translate([-19.25,0,-3]) rotate([0,-2,0])cube([5,WheelBase,25]);
					union(){
						translate([-24,2,13]) cube([5,10,6]);
						translate([-24,WheelBase-12,13]) cube([5,10,6]);
						translate([-24,2,9]) cube([5,10,3]);
						translate([-24,WheelBase-12,9]) cube([5,10,3]);
						translate([-20.5,WheelBase/2,18]) cube([3,10,2],center=true);
						translate([-20.5,WheelBase/2,14]) cube([3,10,2],center=true);
						translate([-20.5,WheelBase/2,10]) cube([3,10,2],center=true);
						translate([-20.5,WheelBase/2-10,18]) cube([3,6,2],center=true);
						translate([-20.5,WheelBase/2-10,14]) cube([3,6,2],center=true);
						translate([-20.5,WheelBase/2-10,10]) cube([3,6,2],center=true);
						translate([-20.5,WheelBase/2+10,18]) cube([3,6,2],center=true);
						translate([-20.5,WheelBase/2+10,14]) cube([3,6,2],center=true);
						translate([-20.5,WheelBase/2+10,10]) cube([3,6,2],center=true);
						
					}
				}
				//fill in underside
				translate([-18,0,-1]) cube([50,WheelBase,23]);
				//bumper
				translate([-20,-2,2]) scale([.2,.2,1]) sphere(r=5,$fn=res1);
				translate([-20,WheelBase+2,2]) scale([.2,.2,1]) sphere(r=5,$fn=res1);
				translate([-20,-2,2]) scale([.2,1,1]) rotate([-90,0,0]) cylinder(r=5,h=WheelBase+4,$fn=res1);
				translate([-20,-2,2]) scale([1,.2,1]) rotate([0,90,0]) cylinder(r=5,h=7,$fn=res1);
				translate([-20,WheelBase+2,2]) scale([1,.2,1]) rotate([0,90,0]) cylinder(r=5,h=7,$fn=res1);
				translate([-20,-2,-3]) cube([7,WheelBase+4,10]);
				
			}
			//cleanup edges
			union(){
				//Wheel Wells
				//driver side
				hull(){
					translate([0,5,.90]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
					translate([0,5,2]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
				}
				hull(){
					translate([0,5,.9]) rotate([90,0,0]) cylinder(r=Tires+1,h=14,$fn=res1);
					translate([0,5,2]) rotate([90,0,0]) cylinder(r=Tires+1,h=14,$fn=res1);
				}
				//passenger side
				hull(){
					translate([0,2+WheelBase,.9]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
					translate([0,2+WheelBase,2])  rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
				}
				hull(){
					translate([0,9+WheelBase,.9]) rotate([90,0,0]) cylinder(r=Tires+1,h=14,$fn=res1);
					translate([0,9+WheelBase,2])  rotate([90,0,0]) cylinder(r=Tires+1,h=14,$fn=res1);
				}
				//Clean Bottom
				translate([-30,-10,-30]) cube([100,100,30]);
				//clea back
				translate([19.25,-10,-1]) cube([100,100,100]);
			}
		if (Weapons==1) { //position Double Guns
			color("grey") translate([15,0,27.25]) rotate([0,-90,0]) rotate([0,0,72]) PrintWeapon(0);
			color("grey") translate([15,WheelBase,27.25]) rotate([0,-90,0]) rotate([0,0,180-72]) PrintWeapon(0);
		} else if (Weapons==2) { //position Single Gun (US)
			color("grey") translate([15,WheelBase-12,28.5]) rotate([0,-90,0]) rotate([0,0,90]) PrintWeapon(0);
		} else if (Weapons==3) { //Position Single Gun (UK)
			color("grey") translate([15,12,28.5]) rotate([0,-90,0]) rotate([0,0,90]) PrintWeapon(0);
		}
	}
		//print Weapons
		if (Weapons==1 && Print==0) { //position Double Guns
			color("grey") translate([15,0,27.25]) rotate([0,-90,0]) rotate([0,0,72]) PrintWeapon(WType);
			color("grey") translate([15,WheelBase,27.25]) rotate([0,-90,0]) rotate([0,0,180-72]) PrintWeapon(WType);
		} else if (Weapons==2 && Print==0) { //position Single Gun (US)
			color("grey") translate([15,WheelBase-12,28.5]) rotate([0,-90,0]) rotate([0,0,90]) PrintWeapon(WType);
		} else if (Weapons==3 && Print==0) { //Position Single Gun (UK)
			color("grey") translate([15,12,28.5]) rotate([0,-90,0]) rotate([0,0,90]) PrintWeapon(WType);
		}
	}
	module Style3(){ //Vintage Race Car
		difference(){
			//basic shape
			union(){
				translate([20,WheelBase/2,-1]) rotate([0,-92,0]) hull(){
					translate([9,5,0]) cylinder(r1=10,r2=5,h=50,$fn=res1);
					translate([9,-5,0]) cylinder(r1=10,r2=5,h=50,$fn=res1);
				}
				//extra wheel framing (driver)
				translate([0,4,.90]) rotate([-90,0,30]) cylinder(r=1,h=18.5,$fn=res1);
				translate([0,4,.90]) rotate([-90,0,-30]) cylinder(r=1,h=18.5,$fn=res1);
				translate([0,4,.90]) rotate([-60,0,30]) cylinder(r=1,h=18.5,$fn=res1);
				translate([0,4,.90]) rotate([-60,0,-30]) cylinder(r=1,h=18.5,$fn=res1);
				//passenger side
				translate([0,WheelBase-4,.90]) rotate([90,0,30]) cylinder(r=1,h=18.5,$fn=res1);
				translate([0,WheelBase-4,.90]) rotate([90,0,-30]) cylinder(r=1,h=18.5,$fn=res1);
				translate([0,WheelBase-4,.90]) rotate([60,0,30]) cylinder(r=1,h=18.5,$fn=res1);
				translate([0,WheelBase-4,.90]) rotate([60,0,-30]) cylinder(r=1,h=18.5,$fn=res1);
			}
			//cut away
			union(){
				//underbody
				translate([-100,-50,-20]) cube([200,200,20]);
				//front cutout
				hull(){
					translate([-32,WheelBase/2+5,6]) sphere(r=4,$fn=res3);
					translate([-32,WheelBase/2-5,6]) sphere(r=4,$fn=res3);
				}
			}
		if (Weapons==1) { //position Double Guns
			color("grey") translate([15,12,16]) rotate([0,-90,0]) rotate([0,0,45]) PrintWeapon(0);
			color("grey") translate([15,WheelBase-12,16]) rotate([0,-90,0]) rotate([0,0,180-45]) PrintWeapon(0);
		} else if (Weapons==2) { //position Single Gun (US)
			color("grey") translate([15,WheelBase-12,16]) rotate([0,-90,0]) rotate([0,0,180-45]) PrintWeapon(0);
		} else if (Weapons==3) { //Position Single Gun (UK)
			color("grey") translate([15,12,16]) rotate([0,-90,0]) rotate([0,0,45]) PrintWeapon(0);
		}
	}
		//print Weapons
		if (Weapons==1 && Print==0) { //position Double Guns
			color("grey") translate([15,12,16]) rotate([0,-90,0]) rotate([0,0,45]) PrintWeapon(WType);
			color("grey") translate([15,WheelBase-12,16]) rotate([0,-90,0]) rotate([0,0,180-45]) PrintWeapon(WType);
		} else if (Weapons==2 && Print==0) { //position Single Gun (US)
			color("grey") translate([15,WheelBase-12,16]) rotate([0,-90,0]) rotate([0,0,180-45]) PrintWeapon(WType);
		} else if (Weapons==3 && Print==0) { //Position Single Gun (UK)
			color("grey") translate([15,12,16]) rotate([0,-90,0]) rotate([0,0,45]) PrintWeapon(WType);
		}
	}
	//Create Axel (does not change for different cars
	translate([0,WheelBase-2.5,.9]) Axel(WheelBase-5);
	
	if ((Style==0 && Preset==0) || Preset ==1 ||Preset==2 ||Preset==3 ||Preset==4){ //Classic car
		Style0();
	} else if ((Style==1 && Preset==0) || Preset==5){ //mini cooper
		Style1();
	} else if ((Style==2 && Preset==0) || Preset==6 || Preset==7) { //pickup truck
		Style2();
	} else if ((Style==3 && Preset==0) || Preset==8){
		Style3();
	}
}
module PrintBody(Body_Length,WheelBase,Style) {
	res1=50;
	res2=100;
	res3=25;
	module Style0(){ //Old Style Car
	//Side Profile (flared) Passenger Side
		difference(){
			hull(){
				translate([0,1.5,4]) rotate([0,90,0]){
					intersection(){
					cylinder(r=30,h=Body_Length-40,$fn=res2);
					translate([0,50,0]) cylinder(r=30,h=Body_Length-40,$fn=res2);
					translate([-3.5,0,0])cylinder(r=30,h=Body_Length-40,$fn=res2);
					}
				}
				//Side Profile (flared) Driver Side
				translate([0,-WheelBase+1.5,4]) rotate([0,90,0]){
					intersection(){
					cylinder(r=30,h=Body_Length-40,$fn=res2);
					translate([0,50,0]) cylinder(r=30,h=Body_Length-40,$fn=res2);
					translate([-3.5,50,0])cylinder(r=30,h=Body_Length-40,$fn=res2);
					}
				}
			}
			translate([-Body_Length,-WheelBase,-20]) cube([Body_Length*2,WheelBase*2,20]);
		}
		//Windows
		//Front frame
		translate([6,-WheelBase/2+3.25,20]) hull(){ 
				scale([2,1,1]) cylinder(r=3,h=1,$fn=res3);
				translate([10,0,10]) scale([2,1,1]) cylinder(r=2,h=1,$fn=res3);
		}
		translate([6,WheelBase/2-3.25,20]) hull(){ 
				scale([2,1,1]) cylinder(r=3,h=1,$fn=res3);
				translate([10,0,10]) scale([2,1,1]) cylinder(r=2,h=1,$fn=res3);
		}
		//Windows and upper frame
		difference(){
			union(){
				difference() {
					union(){
						//sideframe
						translate([36,-WheelBase/2+2,20]) scale([2,1,1]) cylinder(r1=2,r2=1,h=11,$fn=res3);
						translate([36,WheelBase/2-2,20]) scale([2,1,1]) cylinder(r1=2,r2=1,h=11,$fn=res3);
						//front windshield
						translate([2,-WheelBase/2+2,20]) rotate([0,47,0]) cube([13,WheelBase-4,20]);
						//side windshields
						translate([15,-WheelBase/2+2,20]) cube([Body_Length-50,WheelBase-4,12]);
					}
					union(){
						translate([0,-50,31]) cube([100,100,10]);
						
					}
				}
				//roof
				translate([20,-WheelBase/2+3,31])
				hull(){
						hull(){
							scale([4,1,1]) sphere(r=2,$fn=res3);
							translate([Body_Length,0,0]) sphere(r=2,$fn=res3);
						}
						translate([0,WheelBase-6,0]) hull(){
							scale([4,1,1])sphere(r=2,$fn=res3);
							translate([Body_Length,0,0]) sphere(r=2,$fn=res3);
						}
					}
			}
			translate([Body_Length-39,-50,0]) cube([100,100,100]);
		}
	}
	module Style1(){ //Mini Cooper
		difference(){
			union(){
				translate([-1,-WheelBase/2+2,9.5]) rotate([0,90,0]) scale([1,.5,1]) cylinder(r=10,h=Body_Length-30,$fn=res1);
				translate([-1,WheelBase/2-2,9.5]) rotate([0,90,0]) scale([1,.5,1]) cylinder(r=10,h=Body_Length-30,$fn=res1);
				translate([-1,-WheelBase/2-3,-1]) cube([Body_Length-30,WheelBase+6,11]);
				//Windscreens
				minkowski(){
					difference(){
						intersection(){
							translate([93,0,-20]) rotate([0,20,0]) cylinder(r=100,h=40,$fn=res2);
							translate([30,-1,20]) rotate([10,0,0]) cube([Body_Length,WheelBase+2,50],center=true);
							translate([30,1,20]) rotate([-10,0,0]) cube([Body_Length,WheelBase+2,50],center=true);
						}
						translate([0,-WheelBase/2,32]) cube([Body_Length,WheelBase,30]);
					}
					sphere(r=.75);
				}
				//fill in infront of window
				translate([0,-(WheelBase/2)+1.5,-1]) cube([10,WheelBase-3,20.5]);
			}
			//Cleanup
			union(){
				//cleanup bottom
				translate([-10,-50,-10]) cube([100,100,10]);
				//cleanup back
				translate([Body_Length-39.5,-50,-2]) cube([100,100,100]);
				//Cleanup front
				translate([-5,-50,-1]) cube([5,100,30]);
			}
		}
	}
	module Style2(){ //Pickup and SUV
		difference(){
			union(){
				//main part of body
				difference(){
					translate([0,-WheelBase/2,-1]) cube([Body_Length-30,WheelBase,27]);
					union(){
						translate([-1,-WheelBase/2,3]) rotate([0,90,0]) scale([1,.5,1]) cylinder(r=2,h=Body_Length,$fn=res1);
						translate([-1,WheelBase/2,3]) rotate([0,90,0]) scale([1,.5,1]) cylinder(r=2,h=Body_Length,$fn=res1);
					}
				}
				//frame for windows
				difference(){
					union(){
						translate([2,-WheelBase/2+1,23]) rotate([0,30,0]) cylinder(r=1,h=25,$fn=res1);
						translate([9,-WheelBase/2+1,23]) cylinder(r=1,h=12,$fn=res1);
						translate([2,WheelBase/2-1,23]) rotate([0,30,0]) cylinder(r=1,h=25,$fn=res1);
						translate([9,WheelBase/2-1,23]) cylinder(r=1,h=12,$fn=res1);
						translate([29,-WheelBase/2+1,23]) cylinder(r=.9,h=25,$fn=res1);
						translate([29,WheelBase/2-1,23]) cylinder(r=1,h=25,$fn=res1);
						translate([Body_Length-41,-WheelBase/2+1,23]) cylinder(r=1,h=25,$fn=res1);
						translate([Body_Length-41,WheelBase/2-1,23]) cylinder(r=1,h=25,$fn=res1);
					}
					translate([5,-WheelBase/2-1,41]) cube([Body_Length-40,WheelBase+5,20]);
				}
				//roof
				translate([12.25,-WheelBase/2+1,40]) cube([Body_Length-40-7.5,WheelBase-2,2]);
				//frame around roof
				translate([12.25,-WheelBase/2+1,41]) sphere(r=1,$fn=res3);
				translate([12.25,WheelBase/2-1,41]) sphere(r=1,$fn=res3);
				translate([12.25,-WheelBase/2+1,41]) rotate([-90,0,0]) cylinder(r=1,h=WheelBase-2,$fn=res1);
				translate([12.25,-WheelBase/2+1,41]) rotate([0,90,0]) cylinder(r=1,h=Body_Length-40-7.5,$fn=res1);
				translate([Body_Length-41,WheelBase/2-1,41]) rotate([90,0,0]) cylinder(r=1,h=WheelBase-2,$fn=res1);
				translate([Body_Length-38,WheelBase/2-1,41]) rotate([0,-90,0]) cylinder(r=1,h=Body_Length-40-10.5,$fn=res1);
				//windows
				//front
				translate([1.5,-WheelBase/2+.5,23]) rotate([0,30,0]) cube([10,WheelBase-1,21]);
				translate([12,-WheelBase/2+.5,23]) cube([Body_Length-40,WheelBase-1,18]);
			}
			union(){
				//Clean Bottom
				translate([-10,-50,-30]) cube([100,100,30]);
				//Clean Back
				translate([Body_Length-40,-50,-1]) cube([100,100,100]);
			}
		}
	}
	module Style3(){
		difference(){
			//body shape
			union(){
				translate([-.25,0,-1]) rotate([0,90,0]) {
					translate([-9,5,0]) cylinder(r=9.9,h=Body_Length-30,$fn=res1);
					translate([-9,-5,0]) cylinder(r=9.9,h=Body_Length-30,$fn=res1);
				}
				translate([0,-5,0]) cube([Body_Length-30,10,18]);
				difference(){
					translate([10,0,15]) sphere(r=10,$fn=res1);
					translate([14,0,15]) sphere(r=12,$fn=res1);
				}
			}
			//cut away parts
			union(){
				//bottom floor
				translate([-50,-50,-50]) cube([200,200,50]);
				//drive cockpit
				translate([10,0,15]) cylinder(r=7,h=3.25,$fn=res1);
				translate([23,0,15]) cylinder(r=7,h=5,$fn=res1);
				translate([10,-7,15]) cube([14,14,5]);
				//cut back
				translate([Body_Length-40,-50,-10]) cube([50,200,200]);
			}
		}
	}
	if ((Style==0 && Preset==0) || Preset==1 || Preset==2|| Preset==3||Preset==4){
		Style0();
	} else if ((Style==1 && Preset==0) || Preset==5){
		Style1();
	} else if ((Style==2 && Preset==0) || Preset==6 || Preset==7){
		Style2();
	} else if ((Style==3 && Preset==0) || Preset==8){
		Style3();
	}
}
module PrintTrunk(WheelBase,Style,Tires){
	res1=50;
	res2=100;
	res3=25;
	module SpoilerMount(){
		translate([0,-1,0]) cube([12,2,5]);
		rotate([0,90,0]) translate([0,0,-5.25]) cylinder(r=1.51,h=15,$fn=res1);
		translate([4.75,0,0]) rotate([0,90,0]) cylinder(r=1.76,h=20,$fn=res1);
	}
	module Flare1(Length){
		rotate([0,90,0]){
			intersection(){
				cylinder(r=30,h=Length,$fn=res2);
				translate([0,50,0]) cylinder(r=30,h=Length,$fn=res2);
				translate([-3.5,0,0])cylinder(r=30,h=Length,$fn=res2);
				translate([-3.5,50,0])cylinder(r=30,h=Length,$fn=res2);
			}
		}
	}
	module Style0(){ //Impala
			difference(){
			union(){
				//Side Profiles
				translate([-22,WheelBase/2,0]) union(){
					//Side Profile (flared) Passenger Side
					union(){
						translate([0,1.5,4]) Flare1(59);
						translate([42,1.5,13]) intersection(){
							rotate([0,40,0]) Flare1(30);
							rotate([0,-40,0]) Flare1(30);
							translate([0,0,-9]) Flare1(30);
						}
					}
					//Side Profile (flared) Driver Side
					translate([0,-WheelBase+1.5,4]) Flare1(59);
						translate([42,-WheelBase+1.5,13]) intersection(){
							rotate([0,40,0]) Flare1(30);
							rotate([0,-40,0]) Flare1(30);
							translate([0,0,-9]) Flare1(30);
						}
				}
				//roof and windows
				translate([-22,3,31]) union(){
					hull(){
						hull(){
							scale([4,1,1]) sphere(r=2,$fn=res3);
							translate([7,0,0]) scale([6,1,1]) sphere(r=2,$fn=res3);
						}
						translate([0,WheelBase-6,0]) hull(){
							scale([4,1,1]) sphere(r=2,$fn=res3);
							translate([7,0,0]) scale([6,1,1]) sphere(r=2,$fn=res3);
						}
					}
					hull(){
						translate([7,0,0]) scale([6,1,1]) cylinder(r=2,h=.25,$fn=res3);
						translate([26,0,-13]) scale([2,1,1]) cylinder(r=2,h=.25,$fn=res3);
					}
					hull(){
						translate([7,WheelBase-6,0]) scale([6,1,1]) cylinder(r=2,h=.25,$fn=res3);
						translate([26,WheelBase-6,-13]) scale([2,1,1]) cylinder(r=2,h=.25,$fn=res3);
					}
				}
				//windows
				difference(){
					translate([-22,2,16]) cube([30,WheelBase-4,15]);
					translate([15,0,10]) rotate([0,-45,0]) cube([30,WheelBase,35]);
				}
				//fillin body
				translate([-22,0,0]) cube([30,WheelBase,20.5]);
				translate([7,0,15.5]) rotate([0,4,0]) cube([30,WheelBase,5]);
				translate([33.75,(WheelBase/2)-(WheelBase/8),10.6]) rotate([0,-30,0]) cube([7,WheelBase/4,5]);
				//fill in empty space
				cube([37,WheelBase,16]);
				//Add Bumper
				translate([31,-7.5,0]) cube([10,WheelBase+15,5]);
				//Add lights
				translate([33,5,10]) sphere(r=5,$fn=res1);
				translate([33,15,10]) sphere(r=5,$fn=res1);
				translate([33,WheelBase-5,10]) sphere(r=5,$fn=res1);
				translate([33,WheelBase-15,10]) sphere(r=5,$fn=res1);
				
			}
			union(){
				//cleanup bottom
				translate([-50,-25,-30]) cube([100,100,30]);
				//Cut out WheelWells
				//driver side
				translate([0,5,0]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
				translate([0,5,-4]) rotate([90,0,0]) cylinder(r=Tires+3,h=14,$fn=res1);
				//passenger side
				translate([0,2+WheelBase,0]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
				translate([0,9+WheelBase,-4]) rotate([90,0,0]) cylinder(r=Tires+3,h=14,$fn=res1);
				//Cleanup connecting Edge
				translate([-51,-10,-10]) cube([30,100,100]);
				if (Spoiler!=0) { //print mounting hole for spoiler
					translate([31,WheelBase/2,15.75]) SpoilerMount();
				}
			}
		}
		if (Print==0 && Spoiler!=0){
			translate([37,WheelBase/2,20.75]) PrintSpoiler(WheelBase,Spoiler);
		}
	}
	module Style1(){ //wagon
		difference(){
			union(){
				//Side Profiles
				translate([-21,WheelBase/2,0]) union(){
					//Side Profile (flared) Passenger Side
					intersection(){
						translate([0,1.5,4]) Flare1(60);
						translate([9,0,0]) intersection(){
							rotate([-90,0,0]) cylinder(r=50,h=WheelBase+10,$fn=res2);
							translate([-50,0,0])cube([150,50,30]);
						}
					}
					//Side Profile (flared) Driver Side
					intersection(){
						translate([0,-WheelBase+1.5,4]) Flare1(60);
							translate([9,-WheelBase/2-10,0]) intersection(){
								rotate([-90,0,0]) cylinder(r=50,h=WheelBase+10,$fn=res1);
								translate([-50,0,0])cube([150,50,30]);
							}
					}
				}
				//roof and windows
				translate([-21,3,31]) union(){
					//roof
					hull(){
						hull(){
							scale([4,1,1]) sphere(r=2,$fn=res3);
							translate([32,0,0]) scale([6,1,1]) sphere(r=2,$fn=res3);
						}
						translate([0,WheelBase-6,0]) hull(){
							scale([4,1,1]) sphere(r=2,$fn=res3);
							translate([32,0,0]) scale([6,1,1]) sphere(r=2,$fn=res3);
						}
					}
					//downward sweep
					difference(){
						union(){
							hull(){
								translate([32,0,0]) scale([6,1,1]) cylinder(r=2,h=.25,$fn=res3);
								translate([52,0,-13]) scale([2,1,1]) cylinder(r=2,h=.25,$fn=res3);
							}
							hull(){
								translate([32,WheelBase-6,0]) scale([6,1,1]) cylinder(r=2,h=.25,$fn=res3);
								translate([52,WheelBase-6,-13]) scale([2,1,1]) cylinder(r=2,h=.25,$fn=res3);
							}
						}
						translate([55,-2,-15]) cube([10,WheelBase,50]);
					}
					//back door support
					translate([13,WheelBase-5,-11]) scale([2,1,1]) cylinder(r1=2,r2=1,h=11,$fn=res3);
					translate([13,-1,-11]) scale([2,1,1]) cylinder(r1=2,r2=1,h=11,$fn=res3);
				}
				//windows
				difference(){
					translate([-21,2,16]) cube([60,WheelBase-4,15]);
					translate([40,0,10]) rotate([0,-45,0]) cube([30,WheelBase,35]);
				}
				//fillin body
				intersection(){
					translate([-22,0,-1]) cube([60,WheelBase,21.5]);
					//cut back profile
					translate([-12,0,0]) intersection(){
						rotate([-90,0,0]) cylinder(r=50,h=WheelBase+10,$fn=res2);
						translate([-50,0,0]) cube([150,WheelBase,30]);
					}
				}
				//Add Bumper
				translate([31,-7.5,0]) cube([10,WheelBase+15,5]);
			}
			//cleanup bottom
			translate([-50,-25,-30]) cube([100,100,30]);
			//Cut out WheelWells
			//driver side
			translate([0,5,0]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
			translate([0,5,-4]) rotate([90,0,0]) cylinder(r=Tires+3,h=14,$fn=res1);
			//passenger side
			translate([0,2+WheelBase,0]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
			translate([0,9+WheelBase,-4]) rotate([90,0,0]) cylinder(r=Tires+3,h=14,$fn=res1);
			//Cleanup connecting Edge
			translate([-51,-10,-10]) cube([30,100,100]);
			if (Spoiler!=0){ //Spoilers Selected
				translate([16,WheelBase/2,28]) SpoilerMount();
			}
		}
		if (Print==0 && Spoiler!=0){
			translate([22,WheelBase/2,33]) PrintSpoiler(WheelBase,Spoiler);
		}
	}
	module Style2(){ //hatchback
		difference(){
			union(){
				//Side Profiles
				translate([-21,WheelBase/2,0]) union(){
					//Side Profile (flared) Passenger Side
					intersection(){
						translate([0,1.5,4]) Flare1(60);
						translate([-9,0,0]) intersection(){
							rotate([-90,0,0]) cylinder(r=50,h=WheelBase+10,$fn=res2);
							translate([-50,0,0])cube([150,50,30]);
						}
					}
					//Side Profile (flared) Driver Side
					intersection(){
						translate([0,-WheelBase+1.5,4]) Flare1(60);
							translate([-9,-WheelBase/2-10,0]) intersection(){
								rotate([-90,0,0]) cylinder(r=50,h=WheelBase+10,$fn=res1);
								translate([-50,0,0])cube([150,50,30]);
							}
					}
				}
				//roof and windows
				translate([-21,3,31]) union(){
					//roof
					hull(){
						hull(){
							scale([4,1,1]) sphere(r=2,$fn=res3);
							translate([16,0,0]) scale([6,1,1]) sphere(r=2,$fn=res3);
						}
						translate([0,WheelBase-6,0]) hull(){
							scale([4,1,1]) sphere(r=2,$fn=res3);
							translate([16,0,0]) scale([6,1,1]) sphere(r=2,$fn=res3);
						}
					}
					//downward sweep
					difference(){
						union(){
							hull(){
								translate([16,0,0]) scale([6,1,1]) cylinder(r=2,h=.25,$fn=res3);
								translate([34,0,-13]) scale([2,1,1]) cylinder(r=2,h=.25,$fn=res3);
							}
							hull(){
								translate([16,WheelBase-6,0]) scale([6,1,1]) cylinder(r=2,h=.25,$fn=res3);
								translate([34,WheelBase-6,-13]) scale([2,1,1]) cylinder(r=2,h=.25,$fn=res3);
							}
						}
						translate([37,-2,-15]) cube([10,WheelBase,50]);
					}
				}
				//windows
				difference(){
					translate([-21,2,16]) cube([40,WheelBase-4,15]);
					translate([22,0,10]) rotate([0,-38,0]) cube([30,WheelBase,35]);
				}
				//fillin body
				intersection(){
					translate([-22,0,-1]) cube([60,WheelBase,21.5]);
					//cut back profile
					translate([-30,0,0]) intersection(){
						rotate([-90,0,0]) cylinder(r=50,h=WheelBase+10,$fn=res2);
						translate([-50,0,0]) cube([150,WheelBase,30]);
					}
				}
				//Add Bumper
				translate([13,-7.5,0]) cube([10,WheelBase+15,5]);
			}
			//cleanup bottom
			translate([-50,-25,-30]) cube([100,100,30]);
			//Cut out WheelWells
			//driver side
			translate([0,5,0]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
			translate([0,5,-4]) rotate([90,0,0]) cylinder(r=Tires+3,h=14,$fn=res1);
			//passenger side
			translate([0,2+WheelBase,0]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
			translate([0,9+WheelBase,-4]) rotate([90,0,0]) cylinder(r=Tires+3,h=14,$fn=res1);
			//Cleanup connecting Edge
			translate([-51,-10,-10]) cube([30,100,100]);
		if (Spoiler!=0){ //Spoilers Selected
				translate([-1,WheelBase/2,28]) SpoilerMount();
			}
		}
		if (Print==0 && Spoiler!=0){
			translate([5,WheelBase/2,33]) PrintSpoiler(WheelBase,Spoiler);
		}
	}
	module Style3(){ //El Camino
			difference(){
			union(){
				//Side Profiles
				translate([-21,WheelBase/2,0]) union(){
					//Side Profile (flared) Passenger Side
					intersection(){
						translate([0,1.5,4]) Flare1(60);
						translate([9,0,0]) intersection(){
							rotate([-90,0,0]) cylinder(r=50,h=WheelBase+10,$fn=res2);
							translate([-50,0,0])cube([150,50,30]);
						}
					}
					//Side Profile (flared) Driver Side
					intersection(){
						translate([0,-WheelBase+1.5,4]) Flare1(60);
							translate([9,-WheelBase/2-10,0]) intersection(){
								rotate([-90,0,0]) cylinder(r=50,h=WheelBase+10,$fn=res1);
								translate([-50,0,0])cube([150,50,30]);
							}
					}
				}
				//back sweep
				translate([-5,3.5,10]) rotate([0,-45,0]) scale([2,1,1]) {
					cylinder(r=3,h=30,$fn=res1);
					translate([-6,-3,0]) cube([6,6,30]);
				}
				translate([-5,WheelBase-3.5,10]) rotate([0,-45,0]) scale([2,1,1]) {
					cylinder(r=3,h=30,$fn=res1);
					translate([-6,-3,0]) cube([6,6,30]);
				}
				//fillin body
				intersection(){
					translate([-22,0,-1]) cube([60,WheelBase,21.5]);
					//cut back profile
					translate([-12,0,0]) intersection(){
						rotate([-90,0,0]) cylinder(r=50,h=WheelBase+10,$fn=res2);
						translate([-50,0,0]) cube([150,WheelBase,30]);
					}
				}
				//Add Bumper
				translate([31,-7.5,0]) cube([10,WheelBase+15,5]);
			}
			//cleanup bottom
			translate([-50,-25,-30]) cube([100,100,30]);
			//Cut out WheelWells
			//driver side
			translate([0,5,0]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
			translate([0,5,-4]) rotate([90,0,0]) cylinder(r=Tires+3,h=14,$fn=res1);
			//passenger side
			translate([0,2+WheelBase,0]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
			translate([0,9+WheelBase,-4]) rotate([90,0,0]) cylinder(r=Tires+3,h=14,$fn=res1);
			//Cleanup connecting Edge
			translate([-51,-10,-10]) cube([30,100,100]);
			//clean up top
			translate([-50,-10,32.5]) cube([100,100,10]);
			//cut out trunk
			difference(){
				translate([-8,2,10]) cube([40,WheelBase-4,15]);
				union(){
					rotate([-90,0,0]) cylinder(r=Tires+3,h=7,$fn=res1);
					translate([0,WheelBase,0]) rotate([90,0,0]) cylinder(r=Tires+3,h=7,$fn=res1);
				}
			}
		if (Spoiler!=0){ //Spoilers Selected
				translate([30,WheelBase/2,16]) SpoilerMount();
			}
		}
		if (Print==0 && Spoiler!=0){
			translate([36,WheelBase/2,21]) PrintSpoiler(WheelBase,Spoiler);
		}
	}
	module Style4() { //Mini Cooper
		difference(){
			union(){
				//driver side flare
				translate([-22,2,9.5]) rotate([0,90,0]) scale([1,.5,1]) cylinder(r=10,h=50,$fn=res1);
				//passenger side flare
				translate([-22,WheelBase-2,9.5]) rotate([0,90,0]) scale([1,.5,1]) cylinder(r=10,h=50,$fn=res1);
				//bottom half of car fill in
				translate([-22,-3,-1]) cube([50,WheelBase+6,11]);
				//Wheel cover (driver)
				color("Black") translate([0,.5,.90]) scale([1,.5,1]) sphere(r=Tires+3,$fn=res1);
				//Wheel cover (passenger)
				color("Black") translate([0,WheelBase-.5,.90]) scale([1,.5,1]) sphere(r=Tires+3,$fn=res1);
				//Windscreens
				minkowski(){
					translate([0,WheelBase/2,0]) difference(){
						intersection(){
							//translate([93,0,-20]) rotate([0,20,0]) cylinder(r=100,h=40,$fn=res2);
							translate([0,-1,20]) rotate([10,0,0]) cube([50,WheelBase+2,50],center=true);
							translate([0,1,20]) rotate([-10,0,0]) cube([50,WheelBase+2,50],center=true);
						}
						translate([-30,-WheelBase/2,32]) cube([80,WheelBase,30]);
					}
					sphere(r=.75);
				}
			}
			//Cleanup
			union(){
				//cleanup front edge
				translate([-41,-10,-10]) cube([20,100,100]);
				//cleanup bottom
				translate([-30,-10,-20]) cube([100,100,20]);
				//Wheel Wells
				//driver side
				translate([0,5,.90]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
				translate([0,5,.9]) rotate([90,0,0]) cylinder(r=Tires-1,h=14,$fn=res1);
				//passenger side
				translate([0,2+WheelBase,.9]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
				translate([0,9+WheelBase,.9]) rotate([90,0,0]) cylinder(r=Tires-1,h=14,$fn=res1);
				//back end
				translate([-75,WheelBase+10,7]) difference(){
					translate([0,-101,0]) cube([200,100,50]);
					rotate([90,0,0]) cylinder(r=90,h=150,$fn=res2);
					
				}
				//back bumper
				translate([-73,WheelBase+10,-1]) difference(){
					translate([0,-101,0]) cube([200,100,50]);
					rotate([90,0,0]) cylinder(r=90,h=150,$fn=res2);
					
				}
				translate([-67,WheelBase+10,-22]) rotate([0,-20,0]) difference(){
					translate([0,-101,0]) cube([200,100,50]);
					rotate([90,0,0]) cylinder(r=90,h=150,$fn=res2);
					
				}
				if (Spoiler!=0){ //Spoilers Selected
					translate([0,WheelBase/2,28]) SpoilerMount();
				}
			}
		}
		//rear spoiler
		difference(){
			translate([4.5,WheelBase/2,27.75]) scale([.1,1,1]) cylinder(r=WheelBase/2-3,h=5,$fn=res1);
			if (Spoiler!=0){ //Spoilers Selected
				translate([0,WheelBase/2,28]) SpoilerMount();
			}
		}
		if (Print==0 && Spoiler!=0){
			translate([6,WheelBase/2,33]) PrintSpoiler(WheelBase,Spoiler);
		}
	}
	module Style5() { //Full Truck
		difference(){
			union(){
				//Driver side wheel wells
				translate([0,0,2]) rotate([90,0,0]) cylinder(r1=Tires+5,r2=Tires+3,h=4,$fn=res1);
				translate([0,0,2]) rotate([-90,0,0]) cylinder(r=Tires+5,h=8,$fn=res1);
				//pasenger side Wheel wells
				translate([0,WheelBase+4,2]) rotate([90,0,0]) cylinder(r2=Tires+5,r1=Tires+3,h=4,$fn=res1);
				translate([0,WheelBase,2]) rotate([90,0,0]) cylinder(r=Tires+5,h=8,$fn=res1);
				//Bed Frame
				difference(){
					translate([-20,0,-1]) cube([60,WheelBase,27]);
					translate([-18,3,10]) cube([54,WheelBase-6,19]);
				}
				translate([-21.5,3,-1]) cube([2.5,WheelBase-6,24]);
				//rear fender
				//bumper
				translate([43,-2,2]) scale([.2,.2,1]) sphere(r=5,$fn=res1);
				translate([43,WheelBase+2,2]) scale([.2,.2,1]) sphere(r=5,$fn=res1);
				translate([36,-2,2]) scale([.2,.2,1]) sphere(r=5,$fn=res1);
				translate([36,WheelBase+2,2]) scale([.2,.2,1]) sphere(r=5,$fn=res1);
				translate([36,-2,2]) scale([.2,1,1]) rotate([-90,0,0]) cylinder(r=5,h=WheelBase+4,$fn=res1);
				translate([43,-2,2]) scale([.2,1,1]) rotate([-90,0,0]) cylinder(r=5,h=WheelBase+4,$fn=res1);
				translate([43,-2,2]) scale([1,.2,1]) rotate([0,-90,0]) cylinder(r=5,h=7,$fn=res1);
				translate([43,WheelBase+2,2]) scale([1,.2,1]) rotate([0,-90,0]) cylinder(r=5,h=7,$fn=res1);
				translate([36,-2,-3]) cube([7,WheelBase+4,10]);
				//trailer hitch
				translate([47,WheelBase/2,-1]) cylinder(r=3,h=3,$fn=res3);
				translate([40,WheelBase/2-3,-1]) cube([7,6,3]);
				translate([47,WheelBase/2,3]) sphere(r=1.75,$fn=res1);
			}
			union(){
				//clean bottom
				translate([-50,-50,-50]) cube([150,200,50]);
				//Wheel Wells
				//driver side
				hull(){
					translate([0,5,.90]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
					translate([0,5,2]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
				}
				hull(){
					translate([0,5,.9]) rotate([90,0,0]) cylinder(r=Tires+1,h=14,$fn=res1);
					translate([0,5,2]) rotate([90,0,0]) cylinder(r=Tires+1,h=14,$fn=res1);
				}
				//passenger side
				hull(){
					translate([0,2+WheelBase,.9]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
					translate([0,2+WheelBase,2])  rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
				}
				hull(){
					translate([0,9+WheelBase,.9]) rotate([90,0,0]) cylinder(r=Tires+1,h=14,$fn=res1);
					translate([0,9+WheelBase,2])  rotate([90,0,0]) cylinder(r=Tires+1,h=14,$fn=res1);
				}
				//back corners
				translate([38,WheelBase-2,7]) difference(){
					cube([3,3,50]);
					translate([0,0,-1]) cylinder(r=2,h=50,$fn=res3);
				}
				translate([38,2,7]) difference(){
					translate([0,-3,0]) cube([3,3,50]);
					translate([0,0,-1]) cylinder(r=2,h=50,$fn=res3);
				}
				translate([39.5,WheelBase/2-6,7.5]) cube([3,12,5.5]);
			}
			if (Spoiler!=0){ //Spoilers Selected
				translate([34,WheelBase/2,21.5]) SpoilerMount();
			}
		}
		if (Print==0 && Spoiler!=0){
			translate([40,WheelBase/2,26.5]) PrintSpoiler(WheelBase,Spoiler);
		}
	}
	module Style6(){ //Older Jeep
	difference(){
			union(){
				//Driver side wheel wells
				translate([0,0,2]) rotate([90,0,0]) cylinder(r1=Tires+5,r2=Tires+3,h=4,$fn=res1);
				//pasenger side Wheel wells
				translate([0,WheelBase+4,2]) rotate([90,0,0]) cylinder(r2=Tires+5,r1=Tires+3,h=4,$fn=res1);
				//Bed Frame
				translate([-21.5,0,-1]) cube([45,WheelBase,27]);
				//rear fender
				//bumper
				translate([27,-2,2]) scale([.2,.2,1]) sphere(r=5,$fn=res1);
				translate([27,WheelBase+2,2]) scale([.2,.2,1]) sphere(r=5,$fn=res1);
				translate([20,-2,2]) scale([.2,.2,1]) sphere(r=5,$fn=res1);
				translate([20,WheelBase+2,2]) scale([.2,.2,1]) sphere(r=5,$fn=res1);
				translate([20,-2,2]) scale([.2,1,1]) rotate([-90,0,0]) cylinder(r=5,h=WheelBase+4,$fn=res1);
				translate([27,-2,2]) scale([.2,1,1]) rotate([-90,0,0]) cylinder(r=5,h=WheelBase+4,$fn=res1);
				translate([27,-2,2]) scale([1,.2,1]) rotate([0,-90,0]) cylinder(r=5,h=7,$fn=res1);
				translate([27,WheelBase+2,2]) scale([1,.2,1]) rotate([0,-90,0]) cylinder(r=5,h=7,$fn=res1);
				translate([20,-2,-3]) cube([7,WheelBase+4,10]);
				//trailer hitch
				translate([31,WheelBase/2,-1]) cylinder(r=3,h=3,$fn=res3);
				translate([24,WheelBase/2-3,-1]) cube([7,6,3]);
				translate([31,WheelBase/2,3]) sphere(r=1.75,$fn=res1);
				//roof/window support
				difference(){
					union(){
						translate([0,1,23]) cylinder(r=.9,h=25,$fn=res1);
						translate([0,WheelBase-1,23]) cylinder(r=.9,h=25,$fn=res1);
						translate([22.5,WheelBase-1,24]) rotate([0,-15,0]) cylinder(r=.9,h=25,$fn=res1);
						translate([22.5,1,24]) rotate([0,-15,0]) cylinder(r=.9,h=25,$fn=res1);
					}
					translate([-45,-25,41]) cube([150,150,20]);
				}
				//roof
				translate([-21,1,40]) cube([39,WheelBase-2,2]);
				translate([18,1,41]) sphere(r=1,$fn=res2);
				translate([18,WheelBase-1,41]) sphere(r=1,$fn=res2);
				translate([18,1,41]) rotate([-90,0,0]) cylinder(r=1,h=WheelBase-2,$fn=res1);
				translate([18,1,41]) rotate([0,-90,0]) cylinder(r=1,h=39,$fn=res1);
				translate([18,WheelBase-1,41]) rotate([0,-90,0]) cylinder(r=1,h=39,$fn=res1);
				//windows
				//front
				translate([13,.5,23]) rotate([0,-15,0]) cube([10,WheelBase-1,16]);
				translate([-22,.5,23]) cube([40,WheelBase-1,18]);
			}
			union(){
				//clean bottom
				translate([-50,-50,-50]) cube([150,200,50]);
				//Wheel Wells
				//driver side
				hull(){
					translate([0,5,.90]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
					translate([0,5,2]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
				}
				hull(){
					translate([0,5,.9]) rotate([90,0,0]) cylinder(r=Tires+1,h=14,$fn=res1);
					translate([0,5,2]) rotate([90,0,0]) cylinder(r=Tires+1,h=14,$fn=res1);
				}
				//passenger side
				hull(){
					translate([0,2+WheelBase,.9]) rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
					translate([0,2+WheelBase,2])  rotate([90,0,0]) cylinder(r=Tires+2,h=7,$fn=res1);
				}
				hull(){
					translate([0,9+WheelBase,.9]) rotate([90,0,0]) cylinder(r=Tires+1,h=14,$fn=res1);
					translate([0,9+WheelBase,2])  rotate([90,0,0]) cylinder(r=Tires+1,h=14,$fn=res1);
				}
				//licence plate
				translate([23,WheelBase/2-6,7.5]) cube([3,12,5.5]);
				//Clean front
				translate([-23,-10,-10]) cube([1.75,100,100]);
			}
		if (Spoiler!=0){ //Spoilers Selected
				translate([12,WheelBase/2,37.75]) SpoilerMount();
			}
		}
		if (Print==0 && Spoiler!=0){
			translate([18,WheelBase/2,42.75]) PrintSpoiler(WheelBase,Spoiler);
		}
	}
	module Style7(){ //vintage Racecar
		difference(){
			//main body shape
			union(){
			translate([-21.5,WheelBase/2,-1]) rotate([0,90,0]) {
					translate([-9,5,0]) cylinder(r=9.9,h=35,$fn=res1);
					translate([-9,-5,0]) cylinder(r=9.9,h=35,$fn=res1);
				}
				translate([-21.5,WheelBase/2-5,0]) cube([35,10,18]);
				//extra wheel framing (driver)
				translate([0,4,.90]) rotate([-90,0,30]) cylinder(r=1,h=18.5,$fn=res1);
				translate([0,4,.90]) rotate([-90,0,-30]) cylinder(r=1,h=18.5,$fn=res1);
				translate([0,4,.90]) rotate([-60,0,30]) cylinder(r=1,h=18.5,$fn=res1);
				translate([0,4,.90]) rotate([-60,0,-30]) cylinder(r=1,h=18.5,$fn=res1);
				//passenger side
				translate([0,WheelBase-4,.90]) rotate([90,0,30]) cylinder(r=1,h=18.5,$fn=res1);
				translate([0,WheelBase-4,.90]) rotate([90,0,-30]) cylinder(r=1,h=18.5,$fn=res1);
				translate([0,WheelBase-4,.90]) rotate([60,0,30]) cylinder(r=1,h=18.5,$fn=res1);
				translate([0,WheelBase-4,.90]) rotate([60,0,-30]) cylinder(r=1,h=18.5,$fn=res1);
				//wind guard behind head
				translate([-17,WheelBase/2,-25]) difference(){
					scale([1,.2,1]) sphere(r=50,$fn=res1);
					union(){
						translate([-50,-10,0]) cube([50,20,70]);
						translate([-60,-10,-60]) cube([120,20,102]);
					}
				}
			}
			//cut away areas
			union(){
				translate([-50,-50,-50]) cube([200,200,50]);
			}
		if (Spoiler!=0){ //Spoilers Selected
				translate([7.4,WheelBase/2,13.5]) SpoilerMount();
			}
		}
		if (Print==0 && Spoiler!=0){
			translate([13.5,WheelBase/2,18.5]) PrintSpoiler(WheelBase,Spoiler);
		}
	}
	
	//create rear axel
	translate([0,WheelBase-2.5,.9]) Axel(WheelBase-5);
	//if Classic Impala Chosen (Style = 0)
	if ((Style==0 && Preset==0) || Preset==1){
		Style0();
	} else if ((Style==1 && Preset==0) || Preset==2) { //(Wagon)
		Style1();
	} else if ((Style==2 && Preset==0) || Preset==3) { //Hatchback
		Style2();
	} else if ((Style==3 && Preset==0) || Preset==4) { //El Camino
		Style3();
	} else if ((Style==4 && Preset==0) || Preset==5) { //Mini Cooper
		Style4();
	} else if ((Style==5 && Preset==0) || Preset==6){ //Full Truck
		Style5();
	} else if ((Style==6 && Preset==0) || Preset==7){
		Style6();
	} else if((Style==7 && Preset==0) || Preset==8){
		Style7();
	}
}
module PrintSpoiler(WheelBase,Style){
	res1=50;
	res2=100;
	res3=25;

	module Style1(){ //small (low profile)
		translate([-6,-WheelBase/2,0]) union(){
			difference(){
				cube([6,WheelBase,4]);
				union(){
					translate([1,3,6]) rotate([-90,0,0]) cylinder(r=5,h=WheelBase-6,$fn=res1);
					translate([-1,-1,0]) rotate([0,-35,0]) cube([10,WheelBase+2,10]);
				}
			}
			//Spoiler Mount
			translate([-5,WheelBase/2,-5]) rotate([0,90,0]) cylinder(r=1.5,h=11,$fn=res1);
			translate([0,WheelBase/2-1,-5]) cube([6,2,5]);
			translate([5,WheelBase/2,-5]) rotate([0,90,0]) cylinder(r=1.75,h=1,$fn=res1);
		}
	}
	module Style2(){ //larger Spoiler
		translate([-6,-WheelBase/2,0]){
			translate([0,WheelBase/2-1,-5]) cube([6,2,10]);
			//spoiler
			difference(){
				union(){
					translate([-3,0,3]) rotate([0,-10,0]) cube([10,WheelBase,2]);

				}
				translate([-4,-1,0]) rotate([0,-2,0]) cube([13,WheelBase+2,4]);
				translate([6,-20,-20]) cube([100,100,100]);
				
			}
			difference(){
				union(){			
					//side wing
					translate([2,1,6])  rotate([90,-15,0]) scale([1,.75,1]) cylinder(r=6,h=1,$fn=res1);
					//side wing
					translate([2,WheelBase,6])  rotate([90,-15,0]) scale([1,.75,1]) cylinder(r=6,h=1,$fn=res1);
				}
				translate([6,-20,-20]) cube([100,100,100]);
			}
				
			//spoiler mount
			translate([-5,WheelBase/2,-5]) rotate([0,90,0]) cylinder(r=1.5,h=11,$fn=res1);
			translate([0,WheelBase/2-1,-5]) cube([6,2,5]);
			translate([5,WheelBase/2,-5]) rotate([0,90,0]) cylinder(r=1.75,h=1,$fn=res1);
		}
	}
	module Style3(){ //Dual larger Spoiler
		translate([-6,-WheelBase/2,0]){
			translate([0,WheelBase/2-1,-5]) cube([6,2,10]);
			//spoiler
			difference(){
				union(){
					translate([-3,0,3]) rotate([0,-10,0]) cube([10,WheelBase,2]);
				}
				translate([-4,-1,0]) rotate([0,-2,0]) cube([13,WheelBase+2,4]);
				translate([6,-20,-20]) cube([100,100,100]);
			}
			translate([0,0,6]) difference(){
				union(){
					translate([-3,0,3]) rotate([0,-10,0]) cube([10,WheelBase,2]);
				}
				translate([-4,-1,0]) rotate([0,-2,0]) cube([13,WheelBase+2,4]);
				translate([6,-20,-20]) cube([100,100,100]);
			}
			difference(){
				union(){			
					//side wing
					hull(){
						translate([2,1,6])  rotate([90,-15,0]) scale([1,.75,1]) cylinder(r=6,h=1,$fn=res1);
						translate([2,1,12])  rotate([90,-15,0]) scale([1,.75,1]) cylinder(r=6,h=1,$fn=res1);
					}
					//side wing
					hull(){
						translate([2,WheelBase,6])  rotate([90,-15,0]) scale([1,.75,1]) cylinder(r=6,h=1,$fn=res1);
						translate([2,WheelBase,12])  rotate([90,-15,0]) scale([1,.75,1]) cylinder(r=6,h=1,$fn=res1);
					}
				}
				translate([6,-20,-20]) cube([100,100,100]);
			}
			//spoiler mount
			translate([-5,WheelBase/2,-5]) rotate([0,90,0]) cylinder(r=1.5,h=11,$fn=res1);
			translate([0,WheelBase/2-1,-5]) cube([6,2,5]);
			translate([5,WheelBase/2,-5]) rotate([0,90,0]) cylinder(r=1.75,h=1,$fn=res1);
		}
	}
	if (Style==1){
		Style1();
	} else if (Style==2){
		Style2();
	} else if (Style==3){
		Style3();
	}
}
module PrintWeapon(Style){
	res1=50;
	res2=100;
	res3=25;
	
	module Weapon1(){
		cylinder(r=3,h=6,$fn=10);
		translate([0,0,20]) cylinder(r1=1,r2=3,h=6,$fn=10);
		translate([0,0,26]) cylinder(r=3,h=1,$fn=10);
		cylinder(r=1,h=30,$fn=res3);
		for (x=[1:10]){
			rotate([0,0,(360/10)*x]) translate([1.25,0,0]) cylinder(r=1,h=30,$fn=res3);
		}
		translate([-.75,0,0]) cube([1.5,5,10]);
	}
	module Weapon2(){ //50 Cal
		translate([-.75,0,0]) cube([1.5,5,10]);
		translate([-2.5,-1.5,0]) cube ([5,4,10]);
		translate([0,.5,0]){cylinder(r=.75,h=30,$fn=res3);
		hull(){
			translate([0,0,25]) cylinder(r=.75,h=.1,$fn=res3);
			translate([-1.5,-1,27]) cube([3,2,3]);
		}}
	}
	module Weapon3(){ //Rocket
		translate([-.75,0,0]) cube([1.5,5,10]);
		translate([0,-1.5,0]){
		cylinder(r1=2.75,r2=3,h=11,$fn=res3);
		translate([0,0,11]) cylinder(r=3,h=10,$fn=res3);
		translate([0,0,21]) cylinder(r1=3,r2=2.5,h=5,$fn=res3);
		translate([0,0,26]) cylinder(r1=2.5,r2=.25,h=4,$fn=res3);
		rotate([0,0,45]) translate([-.25,0,0]) cube([.5,5.5,6]);
		rotate([0,0,135]) translate([-.25,0,0]) cube([.5,5.5,6]);
		rotate([0,0,215]) translate([-.25,0,0]) cube([.5,5.5,6]);
		rotate([0,0,315]) translate([-.25,0,0]) cube([.5,5.5,6]);
		}
	}
	module Weapon0(){ //Mounting blank
		translate([-.8,0,-.5]) cube([1.6,5.1,11]);
	}
	if (Style==0){
		Weapon0();
	} else if (Style==1){
		Weapon1();
	} else if (Style==2){
		Weapon2();
	} else if (Style==3){
		Weapon3();
	}
}
module Assembled(){
	translate([0,-Wheel_Base/2-1.5,-.9]) PrintHood(Body,Wheel_Base+3,HoodStyle,Front_Wheel_Size);
	translate([19,0,-0.9]) PrintBody(Body,Wheel_Base+3,BodyStyle);
	translate([Body,-Wheel_Base/2-1.5,-0.9]) PrintTrunk(Wheel_Base+3,TrunkStyle,Rear_Wheel_Size);
	//Show Wheels
	translate([0,-Wheel_Base/2,0]){
	//Wheel 1 - Driver Front 
	  color("DimGrey") rotate([90,0,0]) TIRE(Front_Wheel_Size,5,resolution);
	  rotate([90,0,0]) HUBS(Front_Wheel_Size,4.7,resolution,No_Spokes-1,1,"L");

	//Wheel 2 - Driver Rear
	  translate([Body,0,0]){
		rotate([90,0,0]) {
			color("DimGrey") TIRE(Rear_Wheel_Size,5,resolution);
			HUBS(Rear_Wheel_Size,4.7,resolution,No_Spokes-1,1,"L");
		}
	  }
	//Wheel 3&4 - Pasenger Side
	  translate([0,Wheel_Base,0]){
		//Wheel 3 - Pasenger Front
		rotate([90,0,180]){
			color("DimGrey") TIRE(Front_Wheel_Size,5,resolution);
			HUBS(Front_Wheel_Size,4.7,resolution,No_Spokes-1,1,"R");
		}
		//Wheel 4 - Passenger Rear
		translate([Body,0,0]){
			rotate([90,0,180]) {
				color("DimGrey") TIRE(Rear_Wheel_Size,5,resolution);
				HUBS(Rear_Wheel_Size,4.7,resolution,No_Spokes-1,1,"L");
			}
		}
	  }
	 }
}
module Parts(){
	//print body
	union(){
		translate([0,-Wheel_Base/2-1.5,]) PrintHood(Body,Wheel_Base+3,HoodStyle,Front_Wheel_Size);
		translate([19,0,0]) PrintBody(Body,Wheel_Base+3,BodyStyle);
		translate([Body,-Wheel_Base/2-1.5,0]) PrintTrunk(Wheel_Base+3,TrunkStyle,Rear_Wheel_Size);
	}
	//print Wheels (Left)
	translate([0,-Wheel_Base,4.7/2]) rotate([180,0,0]) HUBS(Front_Wheel_Size,4.7,resolution,No_Spokes-1,1,"L");
	translate([-Front_Wheel_Size*2,-Wheel_Base,2.5]) rotate([180,0,0]) TIRE(Front_Wheel_Size,5,resolution);
	translate([Body,-Wheel_Base,4.7/2]) rotate([180,0,0]) HUBS(Rear_Wheel_Size,4.7,resolution,No_Spokes-1,1,"L");
	translate([Body-(Rear_Wheel_Size*2),-Wheel_Base,2.5]) rotate([180,0,0]) TIRE(Rear_Wheel_Size,5,resolution);
	//Print Wheels (Right)
	translate([0,Wheel_Base,4.7/2]) rotate([180,0,0]) HUBS(Front_Wheel_Size,4.7,resolution,No_Spokes-1,1,"R");
	translate([-Front_Wheel_Size*2,Wheel_Base,2.5]) rotate([180,0,0]) TIRE(Front_Wheel_Size,5,resolution);
	translate([Body,Wheel_Base,4.7/2]) rotate([180,0,0]) HUBS(Rear_Wheel_Size,4.7,resolution,No_Spokes-1,1,"R");
	translate([Body-(Rear_Wheel_Size*2),Wheel_Base,2.5]) rotate([180,0,0]) TIRE(Rear_Wheel_Size,5,resolution);
	//print spoiler
	translate([Body+60,0,0]) rotate([0,90,0])PrintSpoiler(Wheel_Base,Spoiler);
	//print Weapons
	translate([-50,0,0]) rotate([0,0,90]) WeaponsOnly();
}
module TiresOnly(){
	translate([0,0,2.5]) rotate([180,0,0]) TIRE(Front_Wheel_Size,5,resolution);
	translate([0,40,2.5]) rotate([180,0,0]) TIRE(Rear_Wheel_Size,5,resolution);
	translate([40,0,2.5]) rotate([180,0,0]) TIRE(Front_Wheel_Size,5,resolution);
	translate([40,40,2.5]) rotate([180,0,0]) TIRE(Rear_Wheel_Size,5,resolution);
}
module HubsOnly(){
	translate([0,-30,4.7/2]) rotate([180,0,0]) HUBS(Front_Wheel_Size,4.7,resolution,No_Spokes-1,1,"L");
	translate([30,-30,4.7/2]) rotate([180,0,0]) HUBS(Rear_Wheel_Size,4.7,resolution,No_Spokes-1,1,"L");
	//Print Wheels (Right)
	translate([0,0,4.7/2]) rotate([180,0,0]) HUBS(Front_Wheel_Size,4.7,resolution,No_Spokes-1,1,"R");
	translate([30,0,4.7/2]) rotate([180,0,0]) HUBS(Rear_Wheel_Size,4.7,resolution,No_Spokes-1,1,"R");
}
module BodyOnly(){
//print body
	union(){
		translate([0,-Wheel_Base/2-1.5,]) PrintHood(Body,Wheel_Base+3,HoodStyle,Front_Wheel_Size);
		translate([19,0,0]) PrintBody(Body,Wheel_Base+3,BodyStyle);
		translate([Body,-Wheel_Base/2-1.5,0]) PrintTrunk(Wheel_Base+3,TrunkStyle,Rear_Wheel_Size);
	}
	//print spoiler
	translate([Body+60,0,0]) PrintSpoiler(Wheel_Base,Spoiler);
}
module WeaponsOnly(){
	
	if(Weapons == 1){
		PrintWeapon(WType);
		translate([10,0,0]) PrintWeapon(WType);
	} else if (Weapons == 2 || Weapons==3){
		PrintWeapon(WType);
	}
}
resolution=50;
Wheel_Base=50;
//Option to show assembled parts (for the purpose of making model)
if (Print==0){
	Assembled();
} else if (Print==1) {  //All 1 print color
	Parts();
} else if (Print==2) { //Print color 1 (hub caps)
	HubsOnly();
} else if (Print==3) { //Print color 2 (Car body)
	BodyOnly();
}else if (Print==4) { //Print color 3 (tires)
	TiresOnly();
} else if (Print==5){
	WeaponsOnly();
} else if (Print==6){
	rotate([0,90,0]) PrintSpoiler(Wheel_Base,Spoiler);
}
