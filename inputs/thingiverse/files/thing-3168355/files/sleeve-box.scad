echo(version=version());

// Which part do you need? (Both, Sleeve, Box)
Selector="BOTH"; //["BOTH","SLEEVE","BOX"]
// Hex Pattern? (Off, On)
Hex_On="Off"; //["Off","On"]

// Overall Width
Width=60; //[25:150]
// Overall Depth
Depth=50; //[25:150]
// Overall Height
Height=25;  //[20:75]

/* Sleeve Settings */
//Sleeve Wall Thickness
Sleeve_Wall=1.25; // 1.25
//Overall Difference Between Box and Sleeve
Sleeve_Gap=0.8; // 0.8

/* Box Settings */
//Box Wall Thickness
Box_Wall=2;
//Box Floor Thickness
Floor=1; // 1.00
//Horizontal Inside Corners
Scoop_Radius=17; // 17.00
//Vertical Inside Corners
V_Radius=4; // 4.00
//Chamfers on Sliding Corners
Chamfer=1.65; // 1.65

/* Pin Measurements */
//Pin Diameter
P_Dia=8;
//Pin Inset from end of box
P_Inset=7; 
// Offset creating retention bump
P_Offset=4;

/* Pattern Measurements */
// Flat side of hex for Hex Pattern
Hex_Size=3.5;
//Minimum Distance From Edge to Hex
Border=1;


//Box
if(Selector!="SLEEVE"){
  translate([0,0,Height/2-Sleeve_Wall-Sleeve_Gap/2])
  box();
};

//Sleeve
if(Selector!="BOX"){
  color("cyan"){
    translate([0,Depth/2+Height/2+5,Depth/2])
    rotate([90,0,0])
    sleeve();  
  };
};  
    
//box module
module box(Width_Box=Width-Sleeve_Wall*2-Sleeve_Gap,Depth_Box=Depth,Height_Box=Height-Sleeve_Wall*2-Sleeve_Gap){
  //box body
  union(){
    difference(){
      difference(){
        cube([Width_Box,Depth_Box,Height_Box], center=true);
        translate([0,0,Floor]){
          cube([Width_Box-2*Box_Wall,Depth_Box-2*Box_Wall,Height_Box-Floor], center=true);
        };
      //corner chamfers
      Corner_Remove(Width_Box,Height_Box,Depth+1);
      };
    };
    //pin
    mirror([1,0,0]){
      Pin(P_Dia,P_Inset,Width_Box/2);  
    };
    Pin(P_Dia,P_Inset,Width_Box/2);  
    //Corners
    translate([0,0,-Height_Box+Floor+Scoop_Radius]){
      Scoop_Corner(Width_Box-2*Box_Wall,Depth_Box-2*Box_Wall,Height_Box);
      mirror([1,0,0]){
        Scoop_Corner(Width_Box-2*Box_Wall,Depth_Box-2*Box_Wall,Height_Box);
      };
      rotate([0,0,90]){
        Scoop_Corner(Depth_Box-2*Box_Wall,Width_Box-2*Box_Wall,Height_Box);
        mirror([1,0,0]){
          Scoop_Corner(Depth_Box-2*Box_Wall,Width_Box-2*Box_Wall,Height_Box);
        };
      };    
    };
    V_Corner(Width_Box-2*Box_Wall,Depth_Box-2*Box_Wall,Height_Box);
    mirror([1,0,0]){
      V_Corner(Width_Box-2*Box_Wall,Depth_Box-2*Box_Wall,Height_Box);
    };
    
    mirror([0,1,0]){   
      V_Corner(Width_Box-2*Box_Wall,Depth_Box-2*Box_Wall,Height_Box);
      mirror([1,0,0]){
        V_Corner(Width_Box-2*Box_Wall,Depth_Box-2*Box_Wall,Height_Box);
      };
    };
  
    
    
  };
};

module Corner_Remove(Width_cr,Height_cr,Depth_cr){
  rotate([90,0,0]){
    linear_extrude(height=Depth_cr, center=true){       
      difference(){
        union(){
          Rotate_Square(Width_cr/2,Height_cr/2);
          Rotate_Square(Width_cr/2,-Height_cr/2);
          Rotate_Square(-Width_cr/2,-Height_cr/2);
          Rotate_Square(-Width_cr/2,Height_cr/2);
        };
      };
    };
  };
};

module Rotate_Square(Offset_X,Offset_Y){
  translate([Offset_X,Offset_Y,0]){
    rotate([0,0,45]){
      square(sqrt(2*Chamfer*Chamfer),center=true);
    };
  };    
};
module Pin(Dia,Inset,Offset){
  translate([Offset,Depth/2-Inset,0]){
    intersection(){
      rotate([0,90,0]){
        rotate_extrude(convexity = 30){
          polygon([[0,0],[Dia/2,0],[Dia/2-.5,(Width/2-Offset)],[0,(Width/2-Offset)]],[[0,1,2,3]]);
        };
      };
      rotate([0,0,270]){
        linear_extrude(height=Height, center=true){
          polygon([[-Dia/2,0],[Dia/2,0],[Dia/2-tan(50)*(Width/2-Offset),(Width/2-Offset)],[-(Dia/2-tan(50)*(Width/2-Offset)),(Width/2-Offset)]],[[0,1,2,3]]);  
        };
      };
    };
  };
};
module Scoop_Corner(S_Depth,S_Width,S_Height){
  translate([S_Depth/2-Scoop_Radius,0,S_Height/2]){
    rotate([-90,0,0]){
      linear_extrude(height=S_Width, center=true){
        difference(){
          square(Scoop_Radius);
          circle(Scoop_Radius);
        };
      };
    };
  };
};

module V_Corner(S_Depth,S_Width,S_Height){
  translate([S_Depth/2-V_Radius,S_Width/2-V_Radius,0]){
    rotate([0,0,0]){
      linear_extrude(height=S_Height, center=true){
        difference(){
          square(V_Radius);
          circle(V_Radius);
        };
      };
    };
  };
};

//Sleeve Module
module sleeve(){
  difference(){
    translate([0,Depth/2,0]){
      rotate([90,0,0]){
        difference(){
          union(){
            linear_extrude(height=Depth){
              difference(){
                square([Width,Height],center=true);
                square([Width-2*Sleeve_Wall,Height-2*Sleeve_Wall],center=true);
              };
            };
            //Corner Chamfers
            rotate([90,0,0]){
              translate([0,Depth/2,0]){
                intersection(){  
                  Corner_Remove(Width-2*Sleeve_Wall,Height-2*Sleeve_Wall,Depth);
                  cube([Width,Depth,Height],center=true);
                };  
              };
            };
          };
          
          Sleeve_Notch(P_Dia,P_Inset,P_Offset); //Diameter, Inset, Offset
        };
      };
    };
    if (Hex_On=="On"){
      Pattern_Placement(X_Hex=floor((Width-2*Border-1.732*Hex_Size)/((1.732*Hex_Size+1))),Y_Hex=floor(((Depth-2*Border-2*Hex_Size)/(cos(30)*(Hex_Size*1.732+1))/2)));
    };
  };
};

module Sleeve_Notch(Dia,Inset,Offset){
  translate([(Width+1)/2,0,Depth/2]){
    rotate([0,-90,0]){ 
      linear_extrude(height=Width+1){
        union(){
          translate([Depth/2-Inset,0,0]){
            circle(d=Dia,center=true);
          };
          translate([-(Depth/2-Inset),0,0]){
            circle(d=Dia,center=true);
          };
          translate([-(Depth/2-Inset-Offset),0,0]){
            circle(d=Dia,center=true);
          };
          translate([Offset/2,0,0]){
            square([Depth-2*Inset-Offset,Dia],center=true);
          };
        };
      };
    };
  };
};

module Pattern_Placement(){
  translate([0,0,0]){
    translate([-(X_Hex*(Hex_Size*1.732+1)/2),-((Y_Hex*2)*(cos(30)*(Hex_Size*1.732+1)))/2,0]){     
      Hex_Pattern(X_Hex,Y_Hex);
      translate([cos(60)*(Hex_Size*1.732+1),sin(60)*(Hex_Size*1.732+1),0]){
        Hex_Pattern(X_Hex-1,Y_Hex-1);
      };
    };
  };
};


module Hex_Pattern(Pattern_W,Pattern_D){
  union(){
    translate([0,0,0]){  
   // translate([0,0,0]){  
      for(X_Count=[0:Pattern_W]){
        for(Y_Count=[0:Pattern_D]){
          translate([X_Count*(Hex_Size*1.732+1),Y_Count*2*(sin(60)*(Hex_Size*1.732+1)),0]){
            Hex_Indent(Hex_Size);
            
          };
        };
      };
    };
  };
};    

module Hex_Indent(Dia){
  H_Depth=.5;
  rotate([0,0,90]){
    translate([0,0,Height/2-H_Depth]){
      difference(){
        linear_extrude(height=1){
          angles=[ for (i = [0:5]) i*(360/6) ];
 	      coords=[ for (th=angles) [Dia*cos(th), Dia*sin(th)] ];
          polygon(coords);
        };
        for(i=[0:5]){
          rotate([0,0,i*60]){  
            translate([0,1.732/2*Dia-H_Depth,0]){
              rotate([0,-90,0]){
                linear_extrude(height=2*Dia,center=true){
                  polygon([[0,0],[H_Depth,H_Depth],[0-.5,H_Depth+.5]]);
                };
              };
            };
          };
        };
      };
    };
  };    
};    
