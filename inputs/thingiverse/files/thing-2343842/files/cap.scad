/* [Body] */
out_diam_small=24; // [5:1:200]
out_diam_large=27; // [5:1:200]
out_height=2; // [1:0.5:10]
in_diam_small=16.75; // [5:0.25:100]
in_diam_large=19.25; // [5:0.25:100]
in_height=6; // [1:1:100]
in_count=3; // [0:1:10]

/* [Font] */
image_text="";
image_font =0; // [0:Roboto,1:Arial,2:FontAwesome]
image_size =15; // [0:1:100]

/* [Multistl] */
part = 0; // [0:Body,1:Image,2:Body+Image]


/* [Hidden] */
color_1 = part==0||part==2;
color_2 = part==1||part==2;

fonts = [
  "Roboto:style=Black",
  "Arial:style=Bold",
  "FontAwesome:style=Regular"
];

image_f = fonts[image_font];

epsilon = 0.01;

$fn=50;
i_d_l=max(5,in_diam_large);
i_d_s=min(i_d_l,in_diam_small);
o_h=max(1,out_height);
o_d_l=max(i_d_l,out_diam_large);
o_d_s=min(o_d_l,out_diam_small);
z=(i_d_l-i_d_s)*cos(45);
i_h=max(2*z,in_height);
i_s=min(image_size,o_d_s-o_d_s/3);

module body(){
  color("yellow"){   
    cylinder(r1=o_d_s/2,r2=o_d_l/2,h=o_h+epsilon);
    for(i = [0:in_count-1]){
      translate([0,0,o_h+i*i_h+z])
      cylinder(r1=i_d_l/2,r2=i_d_s/2,h=i_h-z+epsilon);
      translate([0,0,o_h+i*i_h])
      cylinder(r1=i_d_s/2,r2=i_d_l/2,h=z+epsilon);
    }
  }
}

module image(){
  
  color("red"){
    translate([0,0,-epsilon])
    linear_extrude(height=o_h/2+epsilon)
    rotate([180,0,0])
    text(text=image_text, size=i_s,font=image_f, halign="center", , valign="center");
  }
}

module color_1(){
  difference(){
    body();
    image();
  }
}

module color_2(){
  intersection(){
    body();
    image();
  }
}

module cap(){
  if(color_1)
    color_1();
  if(color_2)
    color_2();
}

cap();