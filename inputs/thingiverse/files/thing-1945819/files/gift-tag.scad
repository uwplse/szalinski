height = 30;
width = 100;
depth = 5;
holeOffset = 10;
$fn = 32;


size = 12;
textDepth = 1;
nameFont = "Liberation Sans:style= Italic";
adverbFont = "Liberation Sans:style= Italic";
name = "Neobonde";
adverb = "From:";



module tag(){

  textHeight = size+size/8 + size/2;

  marginB = (height/2-textHeight/2);
  marginL = width/20;

  echo(textHeight);
  echo(height);
  echo(marginB);
  color([0.2,0.2,0.2])translate([marginL,marginB,depth])union(){
    translate([0,size+size/8,textDepth/2])linear_extrude(textDepth)text(adverb, size = size/2,font = adverbFont);
    translate([0,0,textDepth/2])linear_extrude(textDepth)text(name, size, font = nameFont);
  }

  color([0.2,0.2,0.2])translate([marginL,marginB/3,depth])cube([width-(height/1.5),size/12,textDepth]);
  color([0.2,0.2,0.2])translate([marginL,height-(marginB/3)-size/12,depth])cube([width-(height/1.5),size/12,textDepth]);


  color([0.9,0,0])difference(){
    cube([width,height,depth]);
    translate([width,0,0])rotate(45)cube(height/2,center = true);
    translate([width,height,0])rotate(45)cube(height/2,center = true);
    translate([width-holeOffset,height/2,-1])cylinder(h = depth+2, r=height/10);
  }
}


tag();
