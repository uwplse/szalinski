//Tube joint with screen support

//CUSTOMIZER VARIABLES

/* [Shape] */

//Polyhedron
shape = 4; // [1:Tetrahedron, 2:Octahedron, 3:Cube, 4:Dodecahedron, 5:Icosahedron]

//Number of tubes to be made
number_of_tubes = 5; // [1,2,3,4,5]

//Prearranged thin support
support    = 0; //[0:false,1:true]


/* [Size] */

//Tube radius
tuberadius = 4.95; //10 mmΦ Al tube

//Tube depth
depth      = 30.0;//差し込み深さ

//Overall thickness
thick      = 2.0;

//Clearance
gap        = 0.2; 

/* [Magnet Size] */

//Radius of the magnet to hold the screen
magrad = 3.1;

//Thickness of the magnet
magthick = 3.2;

/* [Others] */

taper       = 1.0;
tabheight  = 7.0;
tabthick   = 3;
boltheaddiam = 7.0;
boltdiam = 2.7;
natdiam = 5.0;
natdig = 1.0;




index = (shape==2)?4:(shape==5)?5:3;
cornerangle = (shape==4)?108:(shape==3)?90:60;

//index = 3;     //n-gon
tubes = (number_of_tubes>index)?index:number_of_tubes;//number of tubes

rotangle = 360 / index;

//cornerangle = 108; //for dodecahedron
corner2 = (180-cornerangle) / 2;

edgetilt = asin(sin(cornerangle/2)/sin(rotangle/2));
echo(edgetilt);
facetilt = atan2(cos(edgetilt),sin(cornerangle/2)/tan(rotangle/2));
echo(facetilt);

//さやとチューブのすきま。あまり大きくすると、しめつけ時の変形が大きくなって割れるかも。

slitangle = 360*gap/(tuberadius+gap)+2;
//ギャップの大きさはすきまから自動的に決まる。(すこしおおきめにすべきか。)
//echo(slitangle);
outerradius = tuberadius + thick + gap;//さやの外半径。
slit       = sin(slitangle/2)*2*outerradius;
//echo("Bolt length:",tabthick*2+slit);

//magnet

e1  = (outerradius+gap) / tan(cornerangle/2);
pillar0 = e1 * tan(edgetilt) - outerradius;
pillar = ( pillar0 < 3 ) ? 3 : pillar0;

//distance to the center of the tube from the origin
centeroffset = outerradius + pillar;

//楕円柱。
module ubar(radius,length,thick){
  cylinder(r=radius,h=thick,center=true);
  translate([0,length,0])
  cylinder(r=radius,h=thick,center=true);
  translate([-radius,0,-thick/2])
  cube([radius*2,length,thick]);
}


//パイ
module pie(r,h,angle){
  intersection(){
    cylinder(r=r,h=h);
    intersection(){
      translate([-r-0.1,-r-0.1,-0.1])
        cube([2*r+0.2,r+0.1,h+0.2]);
      rotate([0,0,angle])
        translate([-r-0.1,0,-0.1])
          cube([2*r+0.2,r+0.1,h+0.2]);
    }
  }
}


//トーラス
module torus(ri,ro)
{
	rotate_extrude(convexity = 10)
	translate([ro, 0, 0])
	circle(r = ri, $fn = 40);
}


//slitted, tapered tube
module tube(r,h,thick,slit=0,taper=0)
{
    inner = r - thick;
    delta = 0.03;
    difference(){
        cylinder(r=r,h=h);
        union(){
            translate([0,0,-delta]){
                cylinder(r=inner, h=depth+2*delta);
                cylinder(r1=inner+taper,r2=inner,h=taper);
                translate([0,0,h-taper+2*delta]){
                    cylinder(r1=inner,r2=inner+taper,h=taper);
                }
                translate([-slit/2,0,0]){
                    cube([slit,r+0.1,h+2*delta]); 
                }
            }
        }
    }
}



//台形
module trapezoid(width_base, width_top,height,thickness) {

  linear_extrude(height = thickness) polygon(points=[[0,0],[width_base,0],[width_base-(width_base-width_top)/2,height],[(width_base-width_top)/2,height]], paths=[[0,1,2,3]]); 
  
}


//さや1つ。
module sleeve(){
    tube(r=outerradius,h=depth, thick=thick, slit=slit, taper=taper);
    
    translate([0,tuberadius+gap,taper]){
        translate([-tabthick-slit/2,0,0]){
            mirror([1,0,-1]){
                trapezoid(depth-taper*2,depth-taper*2-tabheight*0.5,tabheight,tabthick);
            }
        }
        translate([+slit/2,0,0]){
            mirror([1,0,-1]){
                trapezoid(depth-taper*2,depth-taper*2-tabheight*0.5,tabheight,tabthick);
            }
        }
    }
    //leg
    
    translate([tabthick/2,-tuberadius-gap-taper,0]){
    rotate([0,0,180]){
                cube([tabthick,pillar+thick-taper,depth]);
    }
    }

    if ( support ){
        translate([-tabthick,tuberadius+gap-0.2+tabheight,tabheight*0.25+taper])
            cube([6,0.2,depth-taper*2-tabheight*0.5]);
    }
}


module dig1(){
    translate([0,outerradius+tabheight/2-2, depth/2]){
        rotate([180,90,0]){
            bolt(tabthick*2+slit);
        }
    }
}


module tube1(){
    rotate([0,0,180]){
        difference(){
            sleeve();
            dig1();
        }
    }
    if ( support ){
        translate([0,0,depth-0.2]){
            cylinder(r=outerradius,h=0.2);
        }
    }
}





large=100;
module shell(){
  rotate(tetrangle/2,[-1,+1,0])
  union(){
    rotate([0,0,180-15])
      translate([0,0,-large/2])
        cube([large,large,large]);
    rotate([0,0,180+15])
      translate([0,0,-large/2])
        cube([large,large,large]);
  }
}


module tipcone()
{
    h     = depth * cos(edgetilt);
    r     = depth * sin(edgetilt);
    hplus = thick / cos(facetilt);
    rplus = hplus/h*r;
    rotate([0,0,rotangle/2]){
        intersection(){
            difference(){
                translate([0,0,-hplus-0.02]){
                    cylinder(r1=0,r2=(r+rplus), h=h+hplus, $fn=index);

                }
                cylinder(r1=0,r2=r, h=h, $fn=index);
                
            }
            cylinder(r=r+thick/cos(rotangle/2), h=3*h, $fn=index,center=true);
        }
    }
}

module tipcone_with_magnet(){
    h     = depth * cos(edgetilt);
    r     = depth * sin(edgetilt);
    echo("H",h);
    difference(){
        union(){
            for(i=[0:0]){
                rotate([0,0,i*rotangle]){
                    translate([h/tan(facetilt)*2/3,0,h*2/3]){
                        sphere(r=magrad+thick);
                    }
                }
            }
            tipcone();
        }
        rotate([0,0,rotangle/2]){
            cylinder(r1=0,r2=r*2, h=h*2, $fn=index);
        }
        for(i=[0:0]){
            rotate([0,0,i*rotangle]){
                translate([h/tan(facetilt)*2/3,0,h*2/3]){
                    rotate([0,180-facetilt])
                        translate([0,0,-0.01]){
                            cylinder(r=magrad,h=magthick);
                            cylinder(r=1,h=10);//pinhole
                        }
                }
            }
        }
    }
}



//外形
module outershell(){
    for(i=[0:tubes-1]){
        angle = rotangle*(i-0.5)+90;
        rotate(angle,[0,0,1]){
            rotate([edgetilt,0,]){
                translate([0,-centeroffset,0]){
                    tube1();
                }
            }//rotate
        }//rotate
    }//for
    last = (tubes==index) ? tubes-1 : tubes-2;
    for(i=[0:last]){
        angle = rotangle*i;
        rotate(angle,[0,0,1]){
            //partial tip cone
            intersection(){
                tipcone_with_magnet();
                translate([-0.02,0,-10]){
                    linear_extrude(depth+20){
                        polygon(points=[[depth*2*cos(rotangle/2),depth*2*sin(rotangle/2)],[0,0],[depth*2*cos(-rotangle/2),depth*2*sin(-rotangle/2)]], paths=[[0,1,2]]);
                    }
                }
            }
        }//rotate
    }//for
}//module




//ボルト
module bolt(len){
  translate([0,0,-len/2]){
    //axis
    cylinder(r=boltdiam/2, h=len);
    //nat
    translate([0,0,-3])//excess 3mm
      cylinder(r=natdiam/2, h=natdig+3,$fn=6);
    translate([0,0,len-natdig])
      cylinder(r=boltheaddiam/2, h=natdig+10);
  }
}

//ボルトの下半分。
module bolttail(len){
  difference(){
    bolt(len);
    translate([0,0,+0.5])
      cylinder(r=10,h=len*3);
  }
}


//ボルトの上半分
module bolthead(len){
  difference(){
    bolt(len);
    translate([0,0,-0.5])
      rotate([180,0,0])
        cylinder(r=10,h=len*3);
  }
}






//掘り抜く部分。
module dig(){
    sphere(r=1);//center marker
}



//掘りぬいたあとでつけくわえる部分。
module additional(){
}

module body(){
  difference(){
    outershell();
    dig();
  }
  //additional();
}

$fn=50;
rotate([180,0,0]){
            body();
}