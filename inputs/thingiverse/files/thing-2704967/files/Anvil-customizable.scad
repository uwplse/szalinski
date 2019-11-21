// preview[view:east, tilt:top]

/* [Token Text] */
token_letters = "D"; // [D, AC, PM, VA, RA] 

//Only use this if you are not using the preset values above.
other = ""; // Other - Use this if you need a different set of letters

/* [Hidden] */
extra = .02;
twidth = 20;
bthickness = 6;
tthickness=2;
theight = 2;
is_other = 0;

letters = len(other)==0 ? token_letters : other;
is_other = len(other)==0 ? 0 : 1;

letterWidth = 5.3;

letterWidth = len(letters)==1 ? 5.9 : (len(letters)==2 ? 7.5 : 8.5);

module triangle(width, thickness, height){
  $fn=3;
    difference(){
    cylinder(d1=width, d2=width+1, h=height, center=true);
    cylinder(d=width-(thickness*2), height+extra);
    }
}
module bar(){
  translate([(twidth/2),0,0]){
    cube([tthickness/2,bthickness,theight],center=true);
  }
}

module cyl_cube(x_val,y_val,hei){
    
  $fn=4;
  translate([(twidth/2),0,0]){ 
    scale([x_val,y_val,hei]){
      rotate([0,0,-45]){
        cylinder(d1=1, d2=1.1, h=1, center=true);
      }
    }
  }
}

module anvil(){
for (i = [0:1:2]) {
  rotate([0,0,i*(360/3)]){
    //bar();
    cyl_cube(tthickness,bthickness,theight);
  }

}

triangle(twidth,tthickness, theight);
}

translate([3.5,0,0]){
  anvil();
}

translate([0,0,0]){    
  rotate([0,0,90]){
    resize([letterWidth,0,0], auto=true){//x=5.3 or y=6.7
      linear_extrude(height=1){
        text(letters, valign = "top", halign = "center", font = "PT Serif");
      }
    }
  }
}

