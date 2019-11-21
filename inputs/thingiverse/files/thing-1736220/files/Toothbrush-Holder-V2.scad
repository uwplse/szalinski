/*
// dgazineu@gmail.com (Douglas Gazineu)
// Rev1: 2016-08-25 :: Initial Release
// Rev2: 2016-11-10 :: Added Floss holders
//
*/

/* [General Options] */
// Number of Toothbrushes
Toothbrush_Number=4; //[1:6]
Toothbrush_Separation=20; //[15:30]
Toothbrush_NeckSize=7.5; //[5,6.5,7,7.5,8,8.5,9,9.5,10]
Distance_FromMirror=29; //[15:45]
Wall_Size = 3; //[2,2.5,3,3.5,4]
Floss = "y"; // [y:Yes, n:No]
Floss_Left = 2; //[0:6]
Floss_Right = 2; //[0:6]
Floss_Width = 4; //[2.5,3,4,5]
Floss_Distance = 6;//[2:8]
Floss_Depth = 10;//[6:12]

module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}

module holder(){
    $fn= 20;
    Holder_Width = Toothbrush_Separation*(Toothbrush_Number+(2/3))+2*Wall_Size;
    Holder_Depth = Distance_FromMirror + 13;
    Holder_Height = (3*Distance_FromMirror/5) + 10;
    Round_Corners = 2*Holder_Depth/5;

   difference(){
        union(){
            prism(Wall_Size,Distance_FromMirror,Holder_Height);
            hull(){
                translate([0,Round_Corners/2,0]) cube([Holder_Depth,Holder_Width-Round_Corners,Wall_Size]);
                cube([1,Holder_Width,Wall_Size]);
                translate([Holder_Depth-Round_Corners/2,Round_Corners/2,0]) cylinder( h = Wall_Size, r = Round_Corners/2);
                translate([Holder_Depth-Round_Corners/2,Holder_Width-Round_Corners/2,0]) cylinder( h = Wall_Size, r = Round_Corners/2);
            }
            cube([Wall_Size,Holder_Width,Holder_Height]);
            translate ([0,Holder_Width-Wall_Size,0]) prism(Wall_Size,Distance_FromMirror,Holder_Height);
            intersection(){
                hull(){
                    translate([0,Round_Corners/2,0]) cube([Holder_Depth,Holder_Width-Round_Corners,3*Wall_Size]);
                    cube([1,Holder_Width,3*Wall_Size]);
                    translate([Holder_Depth-Round_Corners/2,Round_Corners/2,0]) cylinder( h = Wall_Size, r = Round_Corners/2);
                    translate([Holder_Depth-Round_Corners/2,Holder_Width-Round_Corners/2,0]) cylinder( h = Wall_Size, r = Round_Corners/2);
                }
                rotate([0,0,180]) translate ([-Holder_Depth,0,0]) mirror([0,1,0]) prism(Holder_Width,Distance_FromMirror,1.6*Wall_Size);
            }
        if ( Floss == "y"){
        
            difference(){
            hull(){
              translate([Holder_Depth-Round_Corners/2,0,0])
              if (Floss_Right > 0){
                 translate([0,-(Floss_Width+Floss_Distance)*Floss_Right,0]) cylinder( h = Wall_Size, r = Round_Corners/2);
              }
              else {
                 translate([0,Round_Corners/2,0]) cylinder( h = Wall_Size, r = Round_Corners/2);
              } 

              translate([Holder_Depth-Round_Corners/2,Holder_Width,0])
              if (Floss_Left > 0){
                 translate([0,(Floss_Width+Floss_Distance)*Floss_Left,0]) cylinder( h = Wall_Size, r = Round_Corners/2);
              }
              else {
                 translate([0,-Round_Corners/2,0]) cylinder( h = Wall_Size, r = Round_Corners/2);
              }
             }
            union(){
               if (Floss_Right > 0){ 
                 for (a =[1:Floss_Right]) {
                  translate([Holder_Depth-((Round_Corners/2)+(Floss_Depth/2)), -(Floss_Width+Floss_Distance)*a, -Wall_Size/2]) cube([Floss_Depth,Floss_Width,Wall_Size*2]);
                 } 
               }
                if (Floss_Left > 0){ 
                 for (b =[1:Floss_Left]) {
                  translate([Holder_Depth-((Round_Corners/2)+(Floss_Depth/2)), Holder_Width+(Floss_Width+Floss_Distance)*b-(Floss_Distance/2),-Wall_Size/2])   cube([Floss_Depth,Floss_Width,Wall_Size*2]);
                 } 
               }
             }
           }
          }
        }
        union(){
            for (a = [1:Toothbrush_Number]){
                translate ([Distance_FromMirror,Wall_Size+((a-2/3)*Toothbrush_Separation)+(Toothbrush_Separation/2),-0.1]) cylinder( h = 3*Wall_Size, r = Toothbrush_NeckSize/2);
                translate ([Distance_FromMirror,Wall_Size+((a-2/3)*Toothbrush_Separation)+(Toothbrush_Separation/2)-Toothbrush_NeckSize/2,-0.1]) cube([16,Toothbrush_NeckSize,3*Wall_Size]);
            }
        }
    }
}

module view(){
   mirror([0,1,0]) holder();
}

view();
