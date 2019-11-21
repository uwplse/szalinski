/***********************************************************************
Name ......... : pcBayDrawer.scad
Description....: 5.25" PC Bay Drawer
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/07/10
Licence ...... : GPL
***********************************************************************/
//Part Display Options 
part = 1;//[0:All, 1:drawer, 2: Pc mount]

//Dimensions measured from Antec 300 PC Case
//width of drawer mount bracket
x=146;
//length of drawer mount bracket[50:5:150]
y=80;
//height of drawer mount bracket
z=42;  

//thickness of drawer mount walls
mountWallThickness = 4; 
//Add tolerance to bin dimensions so it slides easily into the mount
drawerTolerance = 1;

//Dimensions of Drawer
//Width of drawer
width = x-mountWallThickness-drawerTolerance;
//Height of Drawer
height = z-mountWallThickness-drawerTolerance;
//Length of Drawer
length = y-mountWallThickness-drawerTolerance;
//specify thickness of drawer walls
wallThickness = 2; 

//mounting screws to connect the drawer mount to ATX case
//diameter of mounting screw
mountScrewDiameter = 2.75; 
//depth of mounting screw
mountScrewLength = 5; 
//number of screws to add to the drawer mount bracket
mountHoles = 2; 

//Tab Option
tabOption = 3; //[0:tab, 1:handle, 2:knob, 3: half circle hole, 4: No Tab / Handle]
//Thickness of Tab/ handle
tabThickness = 5;
//Radius of Tab / handle
tabRadius = 30;
//Depth of tab/ handle
tabDepth = 10;
// knob diameter if tabOption == 2
knobDiameter = 20; 
// hole diameter if tabOption == 3
holeDiameter = 20;
// Drawer Face Option 
drawerFaceOption = 0; //[0:No pattern on drawer face, 1:pattern on drawer face]
//spacing for front face pattern
frontSpacing = 5;
//diameter of front face pattern
frontDesignDiameter = 2;
//depth of front face pattern
frontDesignDepth = 2;



//Drawer for PC Case
module pcBayDrawer()
{
    union()
    {
    difference()
    {
    translate([0,0,-height*0.5]){
    cube(size = [width, length, height], center = true);
    }
    
    translate([0,0,-(height-wallThickness)*0.5]){
    cube(size = [width-wallThickness, length-wallThickness, height], center = true);
    }
    
    if(drawerFaceOption ==1)
    {
    for (j = [-height:frontSpacing:height]){
    for (i = [-width:frontSpacing:width])
    {
    
    translate([i,length*0.5+0.5, -2+j])
    {
    rotate([90,0,0])
    {
    cylinder(h = frontDesignDepth, r = frontDesignDiameter*0.5, center = true);
    }
    }
    }
    }
    }
    // hole option
    if (tabOption ==3)
    {
        translate([0,length*0.5, -height*0.5])
        {
        rotate([90, 90, 0])
        {
        
        difference(){
        cylinder(h = wallThickness*2, r = holeDiameter*0.5, center = true);
        
        translate([holeDiameter*0.5, 0, 0]){
        cube(size = [holeDiameter, holeDiameter, wallThickness*2], center = true);
        }
        
        }
        }
        }
        }
    }
    
    
    
    // Drawer Tab Option
    if (tabOption ==0){
    translate([0, length*0.5+tabDepth*0.5, -height*0.5])
    {
    union()
    {    
    cube(size = [tabDepth*2,tabDepth,tabThickness], center = true);
    
    translate([0,tabDepth*0.5,0]){  
    cylinder(h=tabThickness, r=tabDepth, center = true);
    }
    }
    }
    }
    
    //Drawer Handle Option
    if (tabOption == 1)
    {
       
       translate([0,length*0.5,-height*0.5])
       { 
        
       difference(){
       cylinder(h = tabDepth, r = tabRadius, center = true);
           
       cylinder(h = tabDepth, r = tabRadius-tabThickness, center = true);
       
        
       translate([0,-tabRadius*0.5,0])
       {
       cube(size = [tabRadius*2, tabRadius, tabDepth], center = true); 
       }
        }
    }
        
    }
    
    
    //Drawer Knob Option
    if (tabOption ==2)
    {
        
        
        translate([0,length*0.5+tabDepth*0.5,-height*0.5])
        {
        rotate([-90,0,0])
        {
        hull(){
        cylinder(h = tabDepth, r=knobDiameter*0.5, center = true);
        
        translate([0,0,tabDepth]){
        cylinder(h = tabDepth, r=knobDiameter*0.5+5, center = true);
        }
        }
        }
        }
        
        
        }
    
    
    }
    
    
}
//Mount for PC Case
module pcBayMount()
{
    difference()
    {
    cube(size = [x, y, z], center = true);
    translate([0,(y-length)*0.5,0]){
    cube(size = [x-mountWallThickness, y-mountWallThickness, z-mountWallThickness], center = true);
    }
    
    
    
    mountHoleSpacing = (y-20) / mountHoles;
    echo(mountHoleSpacing);
    
    //for(i = [(-y*0.5 + 10):mountHoleSpacing:(y*0.5-10)])
    for(i = [-mountHoles:1:mountHoles])    
    {
    
    translate([x*0.5-mountScrewLength*0.5, i*mountHoleSpacing, -height*0.25]){
    rotate([0,90,0]){
    cylinder(h=mountScrewLength, r = mountScrewDiameter*0.5, center = true);
    }
    }
    
    translate([x*0.5-mountScrewLength*0.5, i*mountHoleSpacing, height*0.25]){
    rotate([0,90,0]){
    cylinder(h=mountScrewLength, r = mountScrewDiameter*0.5, center = true);
    }
    }
    
    
    translate([-x*0.5+mountScrewLength*0.5, i*mountHoleSpacing, -height*0.25]){
    rotate([0,90,0]){
    cylinder(h=mountScrewLength, r = mountScrewDiameter*0.5, center = true);
    }
    }
    
    translate([-x*0.5+mountScrewLength*0.5, i*mountHoleSpacing, height*0.25]){
    rotate([0,90,0]){
    cylinder(h=mountScrewLength, r = mountScrewDiameter*0.5, center = true);
    }
    }
    
    }
    }
    
    
    
}


// Display Drawer and Mount
if (part == 0){

$fn = 60;
color("green")
translate([0,0,height*0.5]){
pcBayDrawer();
}



%pcBayMount();
}

// Display Drawer
if (part == 1)
{
    $fn = 60;
color("green")
//translate([0,20,height*0.5])
rotate([0,0,180])   
    {
pcBayDrawer();
}
}
// Display Mount
if (part == 2)
{
  $fn = 60;
  pcBayMount();  
}