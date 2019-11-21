
part = "ViewAssy"; // [ViewAssy:Assy,Holder:Holder,Bracket1:Bracket1,Bracket2:Bracket2]

/* [Basic] */
width = 150;
depth = 30;
height = 30;
hold_target=35;

/* [Thikness] */
thikness = 3;   //  [1:15]
Brackt_thikness =3;   //  [2:15]

/* [Bracket] */
bracket_connect_h_ratio = 42; //[10:100]
bracket_connect_h = height*bracket_connect_h_ratio/100.0;
over_h = 20;        //  [0:200]
hold_h=20;     //  [1:1000]

/* [Bracket width] */
// White : Sigle , Red : Cannot Travel
b_width_ratio = 25;   //  [10:100]
b_width = ((width-depth)/2-Brackt_thikness)*b_width_ratio/100;
b_x_offset_max =  (width-depth)/2-Brackt_thikness-b_width;

// White : Sigle ,Red : Cannot Bridge
b_x_offset_rate = 45 ;  // [0:100]
b_x_offset = b_x_offset_max  * b_x_offset_rate/100.0 ;

//Printer Setting
BridgeLengthMax = 40;

/* [Other] */
Clearance=0.5;   
MinAngle = 2;     // [1:10]

/* [Hidden] */
bxm = -Clearance;
bx0 = 0;
bx1 = Brackt_thikness ;
bx2 = bx1 + Brackt_thikness + Clearance;
bx3 = bx2 + Brackt_thikness ;
bx4 = bx3 + hold_target;
bx5 = bx4 + Brackt_thikness ;

bh0 = height;
bh1 = height-bracket_connect_h;
bh2 = bh1-Brackt_thikness;
bh3 = bh0 + over_h + Brackt_thikness;
bh4 = bh0 + over_h;
bh5 = bh4 - hold_h;

bh6 = bh1 - ( bh0 - bh2 );

module bracketBase(width){
    linear_extrude(height = width,  convexity = 10)
    polygon(points=[
      [bh0,bx0],   // 0
      [bh0,bx1],   // 1
      [bh1,bx1],   // 2
      [bh1,bx2],   // 3 
      [bh3,bx2],   // 4 
      [bh3,bx5],   // 5
      [bh5,bx5],   // 6
      [bh5,bx4],   // 7
      [bh4,bx4],   // 8
      [bh4,bx3],   // 9
      [bh2,bx3],   //10
      [bh2,bx0],   //11
      ]);
}


module bracket(){
  translate([-b_x_offset/*+Clearance/2*/,depth/2-Clearance/2,0])
  color("Yellow")
  rotate(270,[0,1,0])
  bracketBase(b_width);
}

module sideHolder (){
  render()difference(){
    union(){
      translate([(width-depth)/2,0,-thikness])
      cylinder(r=depth/2+thikness,h=height+thikness,,$fa=MinAngle);
      translate([(width-depth)/4,0,(height+thikness)/2-thikness])
        cube([(width-depth)/2,depth+thikness*2,height+thikness],center=true);

      translate([0,0,-thikness])
        linear_extrude(height = height+thikness,  convexity = 10)
        polygon(points=[
          [0,depth/2+thikness],[0,depth/2+Brackt_thikness*2],
          [ (width-depth)/2-thikness,depth/2+Brackt_thikness*2],
          [ (width-depth)/2,depth/2+thikness]]);
      
    }

    union(){
      translate([(width-depth)/2,0,0])cylinder(r=depth/2,h=height+1,$fa=MinAngle);
      translate([0,0,height/2+1])cube([width-depth,depth,height+2],center=true);
      
      translate([0,0,0])
        linear_extrude(height = height+1,  convexity = 10)
      polygon(points=[
        [-1,depth/2-0.1],[-1,depth/2+Brackt_thikness],
        [(width-depth)/2-Brackt_thikness*1   ,depth/2+Brackt_thikness],
        [(width-depth)/2-Brackt_thikness*0.5 ,depth/2-0.1]]);
      
      translate([b_width+b_x_offset+Clearance/2,depth/2,0])
      rotate(270,[0,1,0])
        linear_extrude(height = b_width+Clearance,  convexity = 10)
        polygon(points=[
          [bh1,bxm],
          [bh1,bx2],
          [bh6,bx2],
          [bh6,bxm]
          ]);

    }
  }
}

module holder(){
  union(){
    sideHolder();
    mirror(180,[0,0,1])sideHolder();
  }
}

module newcolor()
{
  if(b_width > BridgeLengthMax){
    color("Red") children(); 
  }else if(b_x_offset_rate==0 || b_width_ratio==100){
    if(b_width*2 > BridgeLengthMax){
      color("Red") children(); 
    }else{
     color("LemonChiffon") children(); 
    }
  }else{
    color("GreenYellow") children(); 
  }
}

module print_part() {
  if (part == "ViewAssy") {
    color("Aquamarine")holder();
    newcolor()
      bracket();
    mirror(180,[0,0,1])
      newcolor()
      bracket();
  }else if (part == "Holder") {
    holder();
  }else if(b_x_offset_rate==0 || b_width_ratio==100){ 
    if (part == "Bracket1") {
      bracketBase(b_width*2);
    } else if(part == "Bracket2") {
      linear_extrude(height = 1,  convexity = 10)
      text("Bracket2 is nothing."); 
    }
  }else{
    if (part == "Bracket1") {
      bracketBase(b_width);
    } else if(part == "Bracket2") {
      bracketBase(b_width);
    }
  }
}

print_part();
