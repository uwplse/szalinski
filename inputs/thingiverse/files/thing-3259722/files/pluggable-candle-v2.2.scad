sidelength=60;
height=55;
//text1=["Wesołych","Świąt"]; //polish
//text1=["Счастливого","Рождества"]; //russian
// text1=["Merry", "Christmas"]; //english
// text1=["Joyeux", "Noël"]; //french
// text1=["Feliz", "Navidad"]; //castellano
text1=["frohe","Weihnachten"]; //german
text2=["einen","guten", "Rutsch"];
text3=["ein gutes", "neues Jahr",];
text4=["viel Glück", "&", "Gesundheit"];
// textsize for text1, text2, text3, text4
textsize=[6.5,7.5,7.5,6.5];
// font for text1, text2, text3, text4
font=["Pacifico","Pacifico","Pacifico","Pacifico"]; // [Arial,Gloria Hallelujah, Pacifico, Courgette, Permanent Marker, Domine:Domine bold, Ultra, Bevan, Corben:Corben bold, Coustard:Coustard bold]
// print text or rest?
what_to_print="rest";//[text,rest]


//less important parameters
borderthickness=2;
borderwidth=4;
windowthicknes=0.4;
fontthickness=0.2;
bottomheight=3;
clearance=0.15;
linespacingfactor=1.5;
$fn=20;

//calculations
alltext=[text1,text2,text3,text4];
framewide=sidelength-borderthickness;
frameheight=height-bottomheight;
windowwide=framewide-borderwidth*2;
windowheight=frameheight-2*borderwidth;
bottomsidelength=sidelength;

//printing
if (what_to_print == "rest"){
  bottom(bottomsidelength,bottomheight,framewide,borderthickness);
  for (i=[0:1:3]){
    rotate ([0,0,i*90]){
      //translate([borderthickness/2,sidelength/2,bottomheight]){
      translate([borderthickness/2,sidelength/2+5,0]){
        rotate([0,0,0]){
          difference(){
            frame(framewide,frameheight,windowwide,windowheight,borderthickness,borderwidth,windowthicknes,i);
            maketext(frameheight,i);
          }
        }
      }
    }
  }
}else{
  for (i=[0:1:3]){
    rotate ([0,0,i*90]){
      translate([borderthickness/2,sidelength/2+5,0]){
        maketext(frameheight,i);
      }
    }
  }
}

// Modules

module bottom(sl,bh,fw,bt){
  difference(){
    translate([0,0,bh/2])cube([sl,sl,bh],center=true);
    for (i=[0:90:359]){
      rotate ([0,0,i]){
        translate([-fw*0.3+bt/2,sl/2-bt/2-1,bh])sphere(r=bt/2,$fn=30);
        translate([fw*0.3+bt/2,sl/2-bt,bh])rotate([0,0,90])rotate([0,90,0])puzzle(borderthickness+clearance,clearance);
        translate([-3,sl/2-bt-3,-0.01])cube([6,bt+3+0.1,1]);
        translate([-3,sl/2-bt-3,-0.01])cube([6,2,10]);
      }
    }
    translate([0,0,1])cylinder(r=21,h=5);
  }
}

module frame(fw,fh,ww,wh,bt,bw,wt,i){
  difference(){
    translate([-fw/2,0,0])cube([fw,fh,bt]);
    translate([-fw/2+bw,bw,wt])cube([ww,wh,bt]);
    translate([-fw/2,fh/3,-0.01])puzzle(borderthickness+0.02,clearance);
    translate([-fw/2,fh/3*2,-0.01])puzzle(borderthickness+0.02,clearance);
    translate([-fw/2-0.01,fh-2-clearance/2,-0.01])rotate([90,0,0])linear_extrude(height=2+clearance)polygon([[0,0],[0.6+clearance,0],[0,0.6+clearance]]);
  }
  translate([fw/2,fh/3,bt])rotate([0,-90,0])puzzle(borderthickness+0.02,0);
  translate([fw/2,fh/3*2,bt])rotate([0,-90,0])puzzle(borderthickness+0.02,0);
  color("red")translate([fw/2,fh-2,bt])rotate([90,0,0])linear_extrude(height=2)polygon([[-0.8,0],[0,0],[0,0.8]]);
  translate([fw/2-bw,0,bt])cube([bw-bt,fh,1]);
  translate([-fw*0.3,0,bt/2+1])sphere(r=bt/2,$fn=30);
  translate([fw*0.3,0,0])rotate([0,0,-90])puzzle(borderthickness,0);
}

module maketext(fh,i){
  translate([0,(len(alltext[i])*textsize[i]/2)+fh/2,0])multiLine(alltext[i], textsize[i], fontthickness, font[i]);
}

module puzzle(bt,cl,$fn=30){
  rotate([0,0,-90]){
    linear_extrude(height = bt, convexity = 10, slices = 20, scale = 1.0){
      offset(r=cl){
        difference(){
          movement=0.58;
          union(){
            hull(){
              translate([-1,2])circle(1);
              translate([1,2])circle(1);
            }
            translate([-1.5,-1])square([3,3]);
          }
          translate([-1.65,movement])circle(movement);
          translate([1.65,movement])circle(movement);
         }
      }
    }
  }
}


module multiLine(lines, tsize, thickness, fonttitel){
  mirror([1,0,0]){
    color("red")linear_extrude(height = thickness) {
      union(){
        for (i = [0 : len(lines)-1])
          translate([0 , -i * (tsize * linespacingfactor), 0 ]) text(lines[i], font = fonttitel, size = tsize, direction = "ltr",  spacing = 1, valign = "center", halign = "center");
      }
    }
  }
}
