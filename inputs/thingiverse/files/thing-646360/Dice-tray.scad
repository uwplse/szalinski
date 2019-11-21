//The design style of the tray
trayStyle = 1; // [0:Straight w/ rounded edge,1:Chamfer]

//The kind of lock to use with the lid
lockStyle = 1; // [0:None, 1:Slide lock, 2:Strap lock]

trayHeight = 30;
trayWidth = 100;
trayDepth = 150;

cornerRadius = 25;
//Rounded edge and Chamfer size
smoothRadius = 5;
wallThickness = 2;
bottomThickness = 3;

lidThickness = 3;
matThickness = 1;

// Which part would you like to preview?
part = "all"; // [tray:Tray Only,lid:Lid Only,mat:Mat Only, all:All parts]


/* [Hidden] */
lidInTrayHeight = 2;

lockWidth = 15;
lockThickness = 4;
lockWallDistance = 1;
lockPadding = 0.2;
lockTrayOverlap = 4;
lockCornerCut = 3;
lockStrapSize = 2;

pad = 0.1;	// Padding
margin = 0.3;
smooth = 100;	// Number of facets of rounding cylinder


print_parts();

module print_parts() {
	if (part == "tray") {
		createTray();
	} else if (part == "lid") {
		createLid();
	} else if (part == "mat") {
		createMat();
	} else{
		createTray();
		createLid();
		color("black", a=1.0){
			createMat();
		}
	}
}


module createMat(){
	difference(){
		translate([-(getWidth()-(wallThickness+smoothRadius+margin)*2)/2,-(getDepth()-(wallThickness+smoothRadius+margin)*2)/2,bottomThickness+margin]){
			cube(size = [getWidth()-(2*(wallThickness+smoothRadius+margin)), getDepth()-(2*(wallThickness+smoothRadius+margin)), matThickness]);
		}

		union(){
			createLidcorner([max(((trayWidth/2-margin)-cornerRadius), 0),max(((trayDepth/2-margin)-cornerRadius),0),bottomThickness+margin], matThickness, cornerRadius-wallThickness-smoothRadius);

			mirror(0,0,0) createLidcorner([max(((trayWidth/2-margin)-cornerRadius), 0),max(((trayDepth/2-margin)-cornerRadius),0),bottomThickness+margin], matThickness, cornerRadius-wallThickness-smoothRadius);

			rotate(180,0,0){
				createLidcorner([max(((trayWidth/2-margin)-cornerRadius), 0),max(((trayDepth/2-margin)-cornerRadius),0),bottomThickness+margin], matThickness, cornerRadius-wallThickness-smoothRadius);

				mirror(0,0,0) createLidcorner([max(((trayWidth/2-margin)-cornerRadius), 0),max(((trayDepth/2-margin)-cornerRadius),0),bottomThickness+margin], matThickness, cornerRadius-wallThickness-smoothRadius);
			}
		}
	}
}

module createLid(){
	if(trayStyle == 0){
		difference(){
			translate([-(getWidth())/2,-(getDepth())/2,trayHeight+margin]){
				cube(size = [(getWidth()), (getDepth()), lidThickness]);
			}

			union(){
				createLidcorner([max(((getWidth()/2)-cornerRadius), 0),max(((getDepth()/2)-cornerRadius),0),trayHeight+margin], lidThickness, cornerRadius);
				mirror(0,0,0) createLidcorner([max(((getWidth()/2)-cornerRadius), 0),max(((getDepth()/2)-cornerRadius),0),trayHeight+margin], lidThickness, cornerRadius);

				rotate(180,0,0){
					createLidcorner([max(((getWidth()/2)-cornerRadius), 0),max(((getDepth()/2)-cornerRadius),0),trayHeight+margin], lidThickness, cornerRadius);
					mirror(0,0,0) createLidcorner([max(((getWidth()/2)-cornerRadius), 0),max(((getDepth()/2)-cornerRadius),0),trayHeight+margin], lidThickness, cornerRadius);
				}
			}
		}
		if(lockStyle != 1){
		difference(){
			translate([-(getWidth()-wallThickness*2-margin*2)/2,-(getDepth()-wallThickness*2-margin*2)/2,trayHeight-lidInTrayHeight+margin]){
				cube(size = [getWidth() - wallThickness*2 - margin*2, getDepth() - wallThickness*2 -margin*2, lidInTrayHeight]);
			}

			union(){
				createLidcorner([max(((trayWidth/2)-cornerRadius- margin), 0),max(((trayDepth/2)-cornerRadius- margin), 0),trayHeight-lidInTrayHeight+margin], lidInTrayHeight, cornerRadius-lidInTrayHeight);
				mirror(0,0,0) createLidcorner([max(((trayWidth/2)-cornerRadius-margin),0), max(((trayDepth/2)-cornerRadius- margin),0), trayHeight-lidInTrayHeight+margin], lidInTrayHeight, cornerRadius-lidInTrayHeight);
				rotate(180,0,0){
					createLidcorner([max(((trayWidth/2)-cornerRadius- margin),0) ,max(((trayDepth/2)-cornerRadius- margin),0) ,trayHeight-lidInTrayHeight+margin], lidInTrayHeight, cornerRadius-lidInTrayHeight);
					mirror(0,0,0) createLidcorner([max(((trayWidth/2)-cornerRadius- margin),0) ,max(((trayDepth/2)-cornerRadius- margin),0) ,trayHeight-lidInTrayHeight+margin], lidInTrayHeight, cornerRadius-lidInTrayHeight);
				}
			}
}
		}
	}else if(trayStyle == 1){
		difference(){
			translate([-getWidth()/2,-getDepth()/2,trayHeight+margin]){
				cube(size = [getWidth(), getDepth(), lidThickness]);
			}

			union(){
				createLidcorner([max(((trayWidth/2)-cornerRadius), 0),max(((trayDepth/2)-cornerRadius),0),trayHeight+margin], lidThickness, cornerRadius);
				mirror(0,0,0) createLidcorner([max(((trayWidth/2)-cornerRadius), 0),max(((trayDepth/2)-cornerRadius),0),trayHeight+margin], lidThickness, cornerRadius);

				rotate(180,0,0){
					createLidcorner([max(((trayWidth/2)-cornerRadius), 0),max(((trayDepth/2)-cornerRadius),0),trayHeight+margin], lidThickness, cornerRadius);
					mirror(0,0,0) createLidcorner([max(((trayWidth/2)-cornerRadius), 0),max(((trayDepth/2)-cornerRadius),0),trayHeight+margin], lidThickness, cornerRadius);
				}
			}
		}
	}

	createLidLocks();
}

module createLidcorner(pos, lidHeight, radius){
	translate([pos[0], pos[1], pos[2]-pad]){
		difference(){
			cube(size = [radius+pad, radius+pad, lidHeight+pad*2]);
			cylinder(lidHeight+pad*2, r=radius, center=false, $fn=smooth);
		}
	}
}

module createLidLocks(){
if(lockStyle == 0){
}else if(lockStyle == 1){
	if((cornerRadius*2) >= max(trayWidth, trayDepth)){
		echo("Round tray");
	}else if(trayWidth <= trayDepth){
		translate([trayWidth/2,-(lockWidth/2+lockThickness+lockPadding),trayHeight+margin]){
			createStraightLock();
		}
		mirror([1,0,0]){
			translate([trayWidth/2,-(lockWidth/2+lockThickness+lockPadding),trayHeight+margin]){
				createStraightLock();
			}
		}
		rotate(a=90, v=[0,0,1]){
			translate([trayDepth/2,-(lockWidth/2+lockThickness+lockPadding),trayHeight+margin]){
				createStraightLock();
			}
		}
	}else{
		translate([trayWidth/2,-(lockWidth/2+lockThickness+lockPadding),trayHeight+margin]){
			createStraightLock();
		}
		translate([(lockWidth/2+lockThickness+lockPadding),trayDepth/2,trayHeight+margin]){
			rotate(a=90, v=[0,0,1]){
				createStraightLock();
			}
		}
		mirror([0,1,0]){
			translate([(lockWidth/2+lockThickness+lockPadding),trayDepth/2,trayHeight+margin]){
				rotate(a=90, v=[0,0,1]){
					createStraightLock();
				}
			}
		}
	}
}else if(lockStyle == 2){
	if(getWidth() <= getDepth()){
		rotate(a=90, v=[0,0,1]){
			translate([-(lockThickness+lockWidth/2),(getDepth()/4)-(lockThickness*2+lockWidth)/2,trayHeight+lidThickness+margin]){
				createStrapLock();
			}
			mirror([0,1,0]){
				translate([-(lockThickness+lockWidth/2),(getDepth()/4)-(lockThickness*2+lockWidth)/2,trayHeight+lidThickness+margin]){
					createStrapLock();
				}
			}
		}
	}else{
		translate([-(lockThickness+lockWidth/2),(getDepth()/4)-(lockThickness*2+lockWidth)/2,trayHeight+lidThickness+margin]){
			createStrapLock();
		}
		mirror([0,1,0]){
			translate([-(lockThickness+lockWidth/2),(getDepth()/4)-(lockThickness*2+lockWidth)/2,trayHeight+lidThickness+margin]){
				createStrapLock();
			}
		}
	}
}
}

module createStrapLock(){
difference(){
	difference(){
		translate([0, 0, -pad]){
			cube(size = [lockThickness*2+lockWidth, lockThickness*3, lockThickness+lockStrapSize+pad], center = false);
		}
		
		translate([lockThickness, -pad, -pad]){
			cube(size = [lockWidth, lockThickness*3+pad*2, lockStrapSize+pad], center = false);
		}
	}
	mirror([0,1,0]){
		rotate(a= 90, v=[1,0,0]){
			linear_extrude(height = lockThickness*3+pad, center = false, convexity = 10){
				polygon(points=[[0, lockStrapSize], [lockThickness, lockThickness+lockStrapSize+pad], [0, lockThickness+lockStrapSize+pad]]);
			}
		}
	}
	rotate(a= 90, v=[1,0,0]){
		rotate(a= 90, v=[0,1,0]){
			linear_extrude(height = lockThickness*2+lockWidth+pad, center = false, convexity = 10){
				polygon(points=[[-pad, lockThickness], [lockThickness, lockThickness+lockStrapSize+pad], [-pad, lockThickness+lockStrapSize+pad]]);
			}
		}
	}
	translate([lockThickness*2+lockWidth+pad,0,0]){
		mirror([1,0,0]){
			mirror([0,1,0]){
				rotate(a= 90, v=[1,0,0]){
					linear_extrude(height = lockThickness*3+pad, center = false, convexity = 10){
						polygon(points=[[0, lockStrapSize], [lockThickness, lockThickness+lockStrapSize+pad], [0, lockThickness+lockStrapSize+pad]]);
					}
				}
			}
		}
		translate([0,lockThickness*3+pad,0]){
			rotate(a= 90, v=[1,0,0]){
				rotate(a= 270, v=[0,1,0]){
					linear_extrude(height = lockThickness*2+lockWidth+pad, center = false, convexity = 10){
						polygon(points=[[-pad, lockThickness], [lockThickness, lockThickness+lockStrapSize+pad], [-pad, lockThickness+lockStrapSize+pad]]);
					}
				}
			}
		}
	}
}
}


module createStraightLock(){
	linear_extrude(height = lidThickness, center = false, convexity = 10){
		polygon(points=[[-lockThickness*2,0],[0,0], [lockThickness+lockWallDistance,lockThickness+lockWallDistance],[lockThickness+lockWallDistance,lockWidth+lockThickness+lockWallDistance], [0,lockWidth+(lockThickness+lockWallDistance)*2], [-lockThickness*2,lockWidth+(lockThickness+lockWallDistance)*2]]);
	}

	translate([0,lockThickness+lockWallDistance,0]){
		rotate(a=270, v=[1,0,0]){
			linear_extrude(height = lockWidth, center = false, convexity = 10){
				polygon(points=[[lockWallDistance,-pad], [lockThickness+lockWallDistance,-pad],[lockThickness+lockWallDistance,trayHeight+lockPadding+lockWallDistance+lockThickness-lockCornerCut],[lockThickness+lockWallDistance-lockCornerCut,trayHeight+lockPadding+lockWallDistance+lockThickness], [-lockTrayOverlap-lockWallDistance,trayHeight+lockPadding+lockThickness], [-lockTrayOverlap-lockWallDistance,trayHeight+lockPadding], [-lockTrayOverlap,trayHeight+lockPadding],[lockWallDistance,trayHeight+lockPadding]]);
			}
		}
	}
}

module createTray(){
union(){
createSides();
	createCorner([-max(((trayWidth/2)-cornerRadius), 0), max(((trayDepth/2)-cornerRadius),0)]);
	
	roundInner();
	mirror(0,0,0) createCorner([-max(((trayWidth/2)-cornerRadius), 0), max(((trayDepth/2)-cornerRadius),0)]);
		
	rotate(180,0,0){
createSides();
		createCorner([-max(((trayWidth/2)-cornerRadius), 0), max(((trayDepth/2)-cornerRadius),0)]);
		
		roundInner();
		mirror(0,0,0) createCorner([-max(((trayWidth/2)-cornerRadius), 0), max(((trayDepth/2)-cornerRadius),0)]);
	}
}
}


module createCorner(pos){
	if(cornerRadius > 0){
		difference(){
			if(trayStyle == 0){
				difference() {
					translate([pos[0],pos[1],0]){
						cylinder(trayHeight, r=cornerRadius, center=false, $fn=smooth);
					}
					translate([pos[0],pos[1],bottomThickness]){ 
						cylinder(trayHeight, r = cornerRadius-wallThickness, center=false, $fn=smooth);
					}
				}
		
				translate([pos[0] , pos[1] , bottomThickness]){
					difference() {
						rotate_extrude(convexity=10,  $fn = smooth){
							translate([cornerRadius-wallThickness-smoothRadius+pad, -pad , 0]){
								square(size=[smoothRadius+pad,smoothRadius+pad], center = false);
							}
						}

						rotate_extrude(convexity=10,  $fn = smooth){
							translate([cornerRadius-wallThickness-smoothRadius,smoothRadius,0]){
								circle(r=smoothRadius, $fn=smooth);
							}
						}
					}
				}
			}else if(trayStyle == 1){
				translate([pos[0],pos[1],0]){
					rotate(0,90,0){
						rotate_extrude(convexity=10,  $fn = smooth){
							polygon(points=[[0,0], [cornerRadius,0], [cornerRadius,trayHeight],[cornerRadius-wallThickness,trayHeight],[cornerRadius-wallThickness-smoothRadius,bottomThickness], [0, bottomThickness]]);
						}
					}
				}
			}
			translate([pos[0],pos[1],0]){
				linear_extrude(height = trayHeight, center = false, convexity = 10) {
					polygon(points=[[0,0],[0,cornerRadius],[cornerRadius,cornerRadius],[cornerRadius,-cornerRadius],[-cornerRadius,-cornerRadius],[-cornerRadius,0]]);
				}
			}
		}
	}
}

module createSides(){
union(){
	if(trayStyle == 0){
		translate([-(trayWidth-(cornerRadius*2))/2, trayDepth/2-wallThickness ,0]){
			cube(size = [trayWidth-(cornerRadius*2), wallThickness, trayHeight], center = false);
		}
		
		
		translate([trayWidth/2-wallThickness, -(trayDepth-(cornerRadius*2))/2 ,0]){
			cube(size = [wallThickness, trayDepth-(cornerRadius*2), trayHeight], center = false);
		}
		
translate([0, -(trayDepth-(cornerRadius*2)+pad)/2 ,0]){
			cube(size = [trayWidth/2-wallThickness+pad, trayDepth-(cornerRadius*2)+pad*2, bottomThickness], center = false);
	}
	}else if(trayStyle == 1){
union(){
		translate([-(trayWidth-(cornerRadius*2))/2,trayDepth/2-wallThickness-smoothRadius,0]){
			rotate([0,0,90]){
				rotate([90,0,0]){
					linear_extrude(height = trayWidth-(cornerRadius*2), center = false, convexity = 10){ 
						polygon(points=[[0,bottomThickness-pad],[wallThickness+smoothRadius,bottomThickness-pad],[wallThickness+smoothRadius,trayHeight],[smoothRadius,trayHeight]]);
					}
				}
			}
		}

translate([(trayWidth-(cornerRadius*2))/2,(trayDepth-(cornerRadius*2)+pad)/2,0]){
				rotate([90,0,0]){
					linear_extrude(height = trayDepth-(cornerRadius*2)+pad*2, center = false, convexity = 10){ 
						polygon(points=[[-pad,0],[cornerRadius,0],[cornerRadius,trayHeight],[cornerRadius-wallThickness,trayHeight],[cornerRadius-wallThickness-smoothRadius,bottomThickness], [-pad,bottomThickness]]);
					}
				}
		}
	}
}
	translate([-(trayWidth-(cornerRadius*2))/2, -pad ,0]){
			cube(size = [trayWidth-(cornerRadius*2),trayDepth/2+pad, bottomThickness], center = false);
	}
}
}

module roundInner(){
	if(trayStyle == 0){
		difference() {
			translate([-(trayWidth-(cornerRadius*2))/2, trayDepth/2-wallThickness-smoothRadius+pad ,bottomThickness-pad]){
				cube(size = [trayWidth-(cornerRadius*2), smoothRadius+pad, smoothRadius+pad], center = false);
			}
		
			translate([-(trayWidth-(cornerRadius*2))/2-(pad/2), trayDepth/2-wallThickness-smoothRadius, smoothRadius+bottomThickness]){
				rotate([0,90,0]){
					cylinder(r = smoothRadius, h = (trayWidth-(cornerRadius*2))+pad, center = false, $fn=smooth);
				}
			}
		}

		difference() {
			translate([trayWidth/2-wallThickness-smoothRadius+pad, -(trayDepth-(cornerRadius*2))/2, bottomThickness-pad]){
				cube(size = [smoothRadius+pad, trayDepth-(cornerRadius*2), smoothRadius+pad], center = false);
			}
		
			translate([trayWidth/2-wallThickness-smoothRadius, ((trayDepth-(cornerRadius*2))+pad)/2, smoothRadius+bottomThickness]){
				rotate([90,0,0]){
					cylinder(r = smoothRadius, h = (trayDepth-(cornerRadius*2))+pad, center = false, $fn=smooth);
				}
			}
		}
	}	
}

function getWidth() = max(trayWidth, cornerRadius*2);
function getDepth() = max(trayDepth, cornerRadius*2);