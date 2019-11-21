/* [Global] */

/* [Card] */
//How many cards would you like to hold?
card_number = 32;
//How long is your card?
card_length = 88;
//How wide is your card?
card_width = 57;
//How thick is your card?
card_thickness = 1;

/* [Box] */
wall_thickness = 2; //[2:1:10]
corner_style = "Rounded"; //[Rounded,Angled,None]

/* [Logo] */
logo_style = "None"; //[MakerBot Logo,Heart,Star,Draw Your Own,None]
logo_size = 20; //[1:1:50]
logo_depth = .1; //[.1:.1:1]

/* [Star] */
//This will only affect the "Star" logo style.
star_border_thickness = 15; //[0:1:50]

/* [Draw] */
//Draw your own logo using the canvas below. WARNING: This feature is experimental, and may be a big buggy!
draw_a_logo =  [[[-30.607849,-48.473831],[-38.714745,-48.950043],[-40.559818,-48.486679],[-42.201851,-47.493645],[-47.306175,-42.282654],[-50.067959,-38.508476],[-47.496841,-39.749046],[-46.892071,-39.806171],[-46.653542,-39.556297],[-49.260830,-36.213120],[-49.681732,-34.902710],[-49.585598,-33.782043],[-49.138451,-33.165283],[-48.672112,-33.207165],[-46.200596,-35.658916],[-47.279457,-33.120216],[-47.321926,-32.230251],[-46.990898,-31.375122],[-45.878410,-30.094749],[-43.224831,-28.013985],[-42.217957,-27.615326],[-41.118553,-27.667067],[-40.805717,-27.398746],[-40.440659,-25.661360],[-39.173859,-13.378041],[-37.786060,-6.545761],[-36.585690,-3.203835],[-34.921036,-0.177278],[-32.697136,2.334522],[-31.352158,3.341671],[-28.276741,4.879042],[-24.862782,5.878342],[-21.320715,6.457005],[-16.227745,6.793123],[-6.193724,6.651176],[-3.917368,6.182596],[1.149520,4.628635],[3.496422,4.354591],[5.367534,4.861082],[8.187830,6.665401],[10.588829,7.390333],[11.411912,7.954811],[11.835903,9.095350],[12.399237,12.947439],[13.889902,16.162262],[13.933737,17.683546],[13.316607,19.065596],[11.898010,21.208532],[6.859921,27.302176],[5.617778,29.462534],[5.115950,31.361303],[3.388903,42.964180],[3.273381,46.066513],[3.726890,48.114418],[4.978456,49.315399],[7.242655,49.967201],[8.609360,50.079552],[9.707384,49.859634],[11.739238,48.611275],[14.175842,46.044868],[16.663437,42.226387],[17.125431,47.022690],[17.457367,48.010414],[17.989151,48.348061],[19.181324,47.905319],[24.528868,44.299988],[25.586594,43.349907],[26.602041,41.795021],[27.508392,39.332878],[29.795576,26.542974],[30.282230,24.476656],[31.117352,22.414083],[31.720629,21.625368],[32.642006,21.057058],[35.131134,20.683912],[36.914520,20.059973],[39.043831,18.184668],[42.450657,14.071085],[46.617176,8.405781],[48.564854,5.175398],[49.817593,2.084951],[50.067959,0.425432],[49.656380,-0.983798],[48.150597,-2.837172],[45.817619,-4.786176],[42.303886,-6.914544],[36.506889,-8.046309],[35.342590,-8.523187],[34.626579,-9.248261],[34.336266,-10.490269],[34.565552,-12.031119],[35.052368,-13.404231],[37.089733,-17.042198],[37.317879,-18.115067],[37.155357,-19.071182],[35.604301,-21.320902],[33.913990,-23.043991],[33.883816,-28.314064],[33.082306,-30.108660],[31.550901,-32.176041],[30.204401,-33.504837],[26.342428,-35.397213],[25.570063,-36.226906],[25.784672,-37.377975],[26.657942,-38.691196],[35.016315,-47.244415],[36.307613,-48.865204],[36.517559,-49.673759],[35.642605,-50.079552],[30.526541,-50.070801],[27.432796,-49.786285],[24.770382,-49.194931],[21.059244,-47.649162],[13.547039,-43.090836],[12.276370,-42.541962],[10.688703,-42.258522],[3.786492,-43.914528],[2.470330,-44.603432],[2.196272,-45.124454],[2.270218,-46.117500],[3.513528,-49.225983],[3.376098,-49.617065],[2.794866,-49.836327],[-5.766325,-50.020004],[-18.879635,-49.768524],[-25.214447,-49.130280],[-29.151905,-47.714996],[-30.600498,-48.472359]],[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127]]]; //[draw_polygon:100x100]

/* [Hidden] */

//The thickness of the border around the inside of the box which locks into the top piece.
border_thickness = wall_thickness/2; //[1:1:5]


/* [Upload] */ //IF YOU PUT THIS BACK IN, REMEMBER TO ADD IT TO LOGO_STYLE
// Upload a 100x100 pixel image (images will be automatically stretched to fit). Simple, high contrast images like logos work best.
//upload_image = "testimage_invert.dat"; // [image_surface:100x100]

inner_length = ceil(card_length); //Card is 89.22mm
inner_width = ceil(card_width) + (border_thickness * 2); //Card is 51.10mm
inner_height = ((card_thickness * 1.2) * card_number) + (border_thickness * 2); //Card is .5mm
frontcut1_length = inner_length / 6;
frontcut1_width = inner_width / 1.1;
frontcut2_length = inner_length / 3.5;
frontcut2_width = inner_width / 1.5;
frontcut3_length = inner_length / 2.5;
frontcut3_width = inner_width / 2.5;
top_height = (inner_length + wall_thickness) / 4;
top_fit = 4;
logo_xy = logo_size * (inner_width / 26);
MBM_height = 60;
MBM_thickness = 1;
MBM_radius = MBM_height/5.5;
function lookup_rez(wall_thickness) = floor(lookup(wall_thickness,[[2,10],[10,20]]));
e = .001; //epsilon
es = .5;  //extra space for the top part

rotate([90,90,0]){
    TopFinal();
    BottomFinal();
}

/* Modules */

module TopFinal(){
    translate([0,0,(inner_height + (wall_thickness * 2)) + 10]){
        rotate([0,180,0]){
            difference(){
                TopLocked();
                translate([0,0,((inner_height/2) + wall_thickness + (wall_thickness/4)) - logo_depth + e]){
                    if(logo_style == "MakerBot Logo"){
                        MakerbotLogo();
                    }
                    if(logo_style == "Heart"){
                        HeartLogo();
                    }
                    if(logo_style == "Star"){
                        StarLogo();
                    }
                    if(logo_style == "Upload An Image"){
                        UploadedLogo();
                    }
                    if(logo_style == "Draw Your Own"){
                        DrawnLogo();
                    }
                }
            }
        }
    }
}
module BottomFinal(){
    difference(){
        BottomLocked();
        translate([0,0,((inner_height/2) + wall_thickness + (wall_thickness/4)) - logo_depth + e]){
            if(logo_style == "MakerBot Logo"){
                MakerbotLogo();
            }
            if(logo_style == "Heart"){
                HeartLogo();
            }
            if(logo_style == "Star"){
                StarLogo();
            }
            if(logo_style == "Upload An Image"){
                UploadedLogo();
            }
            if(logo_style == "Draw Your Own"){
                DrawnLogo();
            }
        }
    }
}
module HeartLogo(){
    resize([logo_xy,logo_xy,wall_thickness/2]){
        translate([1.5,0,0]){
            rotate([0,0,135]){
                linear_extrude(height = 1, center = true){
                    square([20,20], center = true);
                    translate([0, 10, 0]){
                        circle(r = 10);
                    }
                    translate([10, 0, 0]){
                        circle(r = 10);
                    }
                }
            }
        }
    }
}
module DrawnLogo(){
    scale([logo_xy/100,logo_xy/100,wall_thickness/2]){
        rotate([0,0,90]){
            linear_extrude(height = 1, center = true){
                polygon(points = draw_a_logo[0], paths = draw_a_logo[1], center = true);
            }
        }
    }
}
//module UploadedLogo(){
//    resize([logo_xy,logo_xy,wall_thickness/2]){
//        translate([0,0,-.25]){
//            difference(){
//                surface(file = upload_image, center = true);
//                translate([0,0,-.5]){
//                    cube([100,100,1],center = true);
//                }
//            }
//        }
//    }
//}
module StarLogo(){
    resize([logo_xy,logo_xy,wall_thickness/2]){
        difference(){
            cylinder($fn = 3, r = 50, h = 1, center = true);
            cylinder($fn = 3, r = 50 - star_border_thickness, h = 1, center = true);
        }
        rotate([0,0,180]){
            difference(){
                cylinder($fn = 3, r = 50, h = 1, center = true);
                cylinder($fn = 3, r = 50 - star_border_thickness, h = 1, center = true);
            }
        }
    }
}
module MakerbotLogo(){
	resize([logo_xy,logo_xy,wall_thickness/2]){
        rotate([0,0,90]){
            translate([-1.25*MBM_radius,1.5*MBM_radius,-MBM_thickness/2]){
                translate([0,MBM_radius * 0.2,]){
                    difference(){
                        cylinder(r=MBM_radius,h = MBM_thickness, $fn=20);
                        translate([0,-1*MBM_radius,0]){
                            cube([MBM_radius,MBM_radius,MBM_thickness]);
                        }
                    }
                }
                translate([2.5*MBM_radius,MBM_radius * 0.2,0]){
                    difference(){
                        cylinder(r=MBM_radius,h = MBM_thickness, $fn=20);
                        translate([-1*MBM_radius,-1*MBM_radius,0]){
                            cube([MBM_radius,MBM_radius,MBM_thickness]);
                        }
                    }
                }
                translate([-1*MBM_radius,0,0]){
                    translate([0,-3.5*MBM_radius,0]){
                        cube([MBM_radius,3.75*MBM_radius,MBM_thickness]);
                    }
                    translate([MBM_radius/2,-3.5*MBM_radius,0]){
                        cylinder(r=MBM_radius/2,h=MBM_thickness, $fn=20);
                    }
                }
                translate([0.75*MBM_radius,0,0]){
                    translate([0,-3.5*MBM_radius,0]){
                        cube([MBM_radius,3.75*MBM_radius,MBM_thickness]);
                    }
                    translate([MBM_radius/2,-3.5*MBM_radius,0]){
                        cylinder(r=MBM_radius/2,h=MBM_thickness, $fn=20);
                    }
                }
                translate([2.5*MBM_radius,0,0]){
                    translate([0,-3.5*MBM_radius,0]){
                        cube([MBM_radius,3.75*MBM_radius,MBM_thickness]);
                    }
                    translate([MBM_radius/2,-3.5*MBM_radius,0]){
                        cylinder(r=MBM_radius/2,h=MBM_thickness, $fn=20);
                    }
                }
                translate([0,MBM_radius * 0.2,0]){
                    cube([2.5*MBM_radius,MBM_radius,MBM_thickness]);
                }
            }
            difference(){
                cylinder(r = MBM_radius * 4.6, h = MBM_thickness, center = true, $fn = 80);
                cylinder(r = MBM_radius * 3.8, h = MBM_thickness + e, center = true, $fn = 80);
            }
        }
    }
}
module BottomLocked(){
    BottomRaw();
    translate([-inner_length/2.5,-inner_width/2,0]){
        difference(){
            sphere($fn = lookup_rez(wall_thickness), r = wall_thickness/2);
            translate([0,wall_thickness/2,0]){
                cube([wall_thickness + e,wall_thickness + e,wall_thickness + e], center = true);
            }
        }
    }
    translate([-inner_length/2.5,inner_width/2,0]){
        difference(){
            sphere($fn = lookup_rez(wall_thickness), r = wall_thickness/2);
            translate([0,-wall_thickness/2,0]){
                cube([wall_thickness + e,wall_thickness + e,wall_thickness + e], center = true);
            }
        }
    }
}
module TopLocked(){
    difference(){
        TopRaw();
        union(){
            translate([-inner_length/2.5,-inner_width/1.98,0]){
//                if((border_thickness - wall_thickness) >= 3){
//                    sphere($fn = 20, r = inner_height/8 - ((border_thickness - wall_thickness)/3));
//                } else {
//                    sphere($fn = 20, r = inner_height/8);
//                }
                sphere($fn = lookup_rez(wall_thickness), r = wall_thickness);
            }
            translate([-inner_length/2.5,inner_width/1.98,0]){
//                if((border_thickness - wall_thickness) >= 3){
//                    sphere($fn = 20, r = inner_height/8 - ((border_thickness - wall_thickness)/3));
//                } else {
//                    sphere($fn = 20, r = inner_height/8);
//                }
                sphere($fn = lookup_rez(wall_thickness), r = wall_thickness);
            }
        }
    }
}
module Border(){
    //Front secton, stepped
    translate([0,0,(inner_height/2) - (border_thickness/2)]){
        linear_extrude(height = border_thickness, center = true){
            difference(){
                square([inner_length,inner_width], center = true);
                translate([-inner_length/2,0,0]){
                    square([frontcut1_length,frontcut1_width], center = true);
                }
                translate([-inner_length/2,0,0]){
                    square([frontcut2_length,frontcut2_width], center = true);
                }
                translate([-inner_length/2,0,0]){
                    square([frontcut3_length,frontcut3_width], center = true);
                }
            }
        }
    }
    //Back section
    translate([0,0,-(inner_height/2) + (border_thickness/2)]){
        linear_extrude(height = border_thickness, center = true){
            square([inner_length,inner_width], center = true);
        }
    }
    //Left section
    translate([0,-(inner_width/2) + (border_thickness/2),0]){
        rotate([90,0,0]){
            linear_extrude(height = border_thickness, center = true){
                square([inner_length,inner_height], center = true);
            }
        }
    }
    //Right section
    translate([0,(inner_width/2) - (border_thickness/2),0]){
        rotate([90,0,0]){
            linear_extrude(height = border_thickness, center = true){
                square([inner_length,inner_height], center = true);
            }
        }
    }
}

module BottomRaw(){
    intersection(){
        difference(){
            linear_extrude(height = inner_height + (wall_thickness * 2), center = true){
                if(corner_style == "Rounded"){
                    offset($fn = 20, r = wall_thickness){
                        square([inner_length,inner_width], center = true);
                    }
                }
                if(corner_style == "Angled"){
                    offset($fn = 20, delta = wall_thickness, chamfer = true){
                        square([inner_length,inner_width], center = true);
                    }
                }
                if(corner_style == "None"){
                    offset($fn = 20, delta = wall_thickness){
                        square([inner_length,inner_width], center = true);
                    }
                }
            }
            InnerBoxFull();
        }
        translate([top_height,0,0]){
            cube([inner_length + (e * 2),inner_width + (wall_thickness * 2) + (e * 2),inner_height + (wall_thickness * 2) + (e * 2)], center = true);
        }
    }
    Border();
}
module TopRaw(){
    difference(){
        difference(){
            linear_extrude(height = inner_height + (wall_thickness * 2), center = true){
                if(corner_style == "Rounded"){
                    offset($fn = 20, r = wall_thickness){
                        square([inner_length,inner_width], center = true);
                    }
                }
                if(corner_style == "Angled"){
                    offset($fn = 20, delta = wall_thickness, chamfer = true){
                        square([inner_length,inner_width], center = true);
                    }
                }
                if(corner_style == "None"){
                    offset($fn = 20, delta = wall_thickness){
                        square([inner_length,inner_width], center = true);
                    }
                }
            }
            resize([inner_length + (wall_thickness / top_fit),inner_width + (wall_thickness / top_fit) + es, inner_height + (wall_thickness / top_fit) + es]){
                InnerBoxFull();
            }
        }
        translate([top_height,0,0]){
            cube([inner_length + (e * 2),inner_width + (wall_thickness * 2) + (e * 2),inner_height + (wall_thickness * 2) + (e * 2)], center = true);
        }
    }
}
module InnerBoxFull(){
    linear_extrude(height = inner_height, center = true){
        square([inner_length,inner_width], center = true);
    }
}