//height of the intended battery
iHeight = 73.5;
//width of the intended battery
iWidth = 62;
// depth of the intended battery
depth = 4.2;
//height of the unintended battery
uHeight = 69;
//width of the unintended battery
uWidth = 50.8;

difference(){
    
    cube([iWidth,iHeight,depth], 2);
    cube([uWidth,uHeight,depth], 0);
    
}