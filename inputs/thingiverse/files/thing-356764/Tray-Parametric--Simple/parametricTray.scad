// preview[view:south, tilt:top]

/* [Global] */
// in mm
tray_width = 76;
// in mm
tray_height = 60;
// in mm
wall_thickness = 1.5;
// in mm
floor_thickness = 3;
// in mm
tray_depth = 40;

//How much higher is the height at the top? in mm. 
offset_height = 20;
//How much wider is the width at the top? in mm
offset_width = 50;

/* [Hidden] */
// ignore variable values
//layer1
topLeft = [0, 0, 0];//0//[hidden]
topMiddle = [0, tray_width / 2, 0];//1//[hidden]
topRight = [0, tray_width, 0];//2//[hidden]
middleRight = [tray_height / 2,tray_width, 0];//3//[hidden]
bottomRight = [tray_height, tray_width,0];//4//[hidden]
bottomMiddle = [tray_height, tray_width / 2, 0];//5//[hidden]
bottomLeft = [tray_height, 0, 0];//6//[hidden]
middleLeft = [tray_height / 2, 0, 0];//7//[hidden]


//layer2//[hidden]
l2TopLeft = [0 - offset_height / 2, 0 - offset_width / 2, tray_depth];//8//[hidden]
l2TopRight = [0 - offset_height / 2, tray_width + offset_width / 2, tray_depth];//9//[hidden]
l2BottomRight = [tray_height + offset_height / 2, tray_width + offset_width / 2,tray_depth];//10//[hidden]
l2BottomLeft = [tray_height + offset_height / 2, 0 - offset_width / 2, tray_depth];//11//[hidden]

//top

tl = 0;//[hidden]
tr = 1;//[hidden]
br = 2;//[hidden]
bl = 3;//[hidden]
l2tl = 4;//[hidden]
l2tr = 5;//[hidden]
l2br = 6;//[hidden]
l2bl = 7;//[hidden]
offset = 1.5;


module tray(offset, bottomOffset){ 
  
  
      
  polyhedron(
  //
  //
  
  points=[
    [topLeft[0] + offset,       topLeft[1] + offset,        topLeft[2] + bottomOffset],
    [topRight[0] + offset,      topRight[1] - offset,       topRight[2] + bottomOffset], 
    [bottomRight[0] - offset,   bottomRight[1]  - offset,   bottomRight[2] + bottomOffset],
    [bottomLeft[0] - offset,     bottomLeft[1] + offset,     bottomLeft[2] + bottomOffset],
    [l2TopLeft[0] + offset,     l2TopLeft[1] + offset,      l2TopLeft[2] + bottomOffset],
    [l2TopRight[0] + offset,    l2TopRight[1] - offset,     l2TopRight[2] + bottomOffset],
    [l2BottomRight[0] - offset, l2BottomRight[1] - offset,  l2BottomRight[2] + bottomOffset],
    [l2BottomLeft[0] - offset,  l2BottomLeft[1] + offset,   l2BottomLeft[2] + bottomOffset]],
     
  triangles = [
    [tl,bl,tr], [br,tr,bl],   //base
    [tl,tr, l2tr, l2tl], //top wall
    [l2br, l2tr, tr, br],//right wall
    [l2br, br, bl, l2bl],//bottom wall
    [l2tl, l2bl, bl, tl],//left wall
    [l2tr, l2br, l2tl], [l2br, l2bl, l2tl]//top
 ]);
}
difference(){

  tray(0,0.1);
  tray(wall_thickness, floor_thickness);
};