m=0.4; //fit margin
db=43; //ball diameter

//In the text below, replace >your folder< with the location of the STL-files. !!!NB Use FORWARD SLASHES in de directory name!!!

difference()
{
    color("Blue")
    union()
    {
    translate([0,0,0.01])
    rotate([180,0,0])
    resize([db+7,db+7,db/2+2.01])
    import(">your folder</files/item_0002601_Cap 8 40x40_2.stl", convexity=3);
    //translate([0,0,1])
    //rotate([180,0,0])
    resize([db+7,db+7,10])
    import(">your folder</files/item_0002601_Cap 8 40x40_2.stl", convexity=3);
    };
    
    color("Green")
    translate([0,0,10])
    #rotate([90,0,0])
    import(">your folder</files/item_0002633_Profile 8 40x40 light_L=20_1.stl", convexity=3);
    
    translate([m,0,10])
    rotate([90,0,0])
    import(">your folder</files/item_0002633_Profile 8 40x40 light_L=20_1.stl", convexity=3);
    
    translate([-m,0,10])
    rotate([90,0,0])
    import(">your folder</files/item_0002633_Profile 8 40x40 light_L=20_1.stl", convexity=3);
    
    translate([0,m,10])
    rotate([90,0,0])
    import(">your folder</files/item_0002633_Profile 8 40x40 light_L=20_1.stl", convexity=3);
    
    translate([0,-m,10])
    rotate([90,0,0])
    import(">your folder</files/item_0002633_Profile 8 40x40 light_L=20_1.stl", convexity=3);
    
    color("Yellow")
    #translate([0,0,-db/2-1])
    sphere(d=db, center=true, $fn=360);
    
};