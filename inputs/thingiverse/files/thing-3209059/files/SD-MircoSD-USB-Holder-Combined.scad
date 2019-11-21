// SD Mirco-SD USB Holder Combined

row = 3;
col = 1;
TYPE_FRONT="NONE"; //["NONE", "TEXT","CYLINDER"]
Text = "DEMO";
Font = "Liberation Sans";
TextGap = 1;
tol = 0;

/* [Hidden] */

single_y = tol + 30;
single_x = tol + 15;
Holder_height = tol + 10;
thick = tol + 2;
TxtThick = tol + 3;

SD_d  = tol + 3;
SD_x  = tol + 23;
SD_y  = tol + 3;

MSD_d = tol + 2;
MSD_x = tol + 11;
MSD_y = tol + 1;
MSD_thick = tol + 2;

USB_x = tol + 13;
USB_y = tol + 5;

TXT_y = tol + 10;

$fn = 40;

module single_block()
{
    //SD
    translate([0,0,thick])
        #cube(size = [SD_y,SD_x,Holder_height], center = true);
    translate([0,SD_x/2,thick])
        #cylinder(h=Holder_height, d=SD_d, center=true);
    translate([0,-SD_x/2,thick])
        #cylinder(h=Holder_height, d=SD_d, center=true);
    
    //USB
    translate([0,0,thick])
        #cube(size = [USB_y, USB_x,Holder_height], center = true);
    
    //MSD
    for (ty =[0,USB_x/2+MSD_thick, -USB_x/2-MSD_thick])
    {
        translate([0,ty,thick])
            #cube(size = [MSD_x, MSD_y,Holder_height], center = true);
        translate([MSD_x/2,ty,thick])
            #cylinder(h=Holder_height, d=MSD_d, center=true);
        translate([-MSD_x/2,ty,thick])
            #cylinder(h=Holder_height, d=MSD_d, center=true);
    }
}

difference()
{
    union()
    {
        cube(size = [single_x*row,single_y*col,Holder_height], center = true);
        // Front
        if (TYPE_FRONT == "CYLINDER")
        {
            rotate([0,90,0])
             translate([0,-single_y*col/2,0])
              cylinder(h=single_x*row, d=Holder_height, center=true);
        }
        if (TYPE_FRONT == "TEXT")
        {
            translate([-single_x*row/2,-single_y*col/2 - TXT_y,-Holder_height/2])
            {
             difference()
             {   
              cube([single_x*row,TXT_y,Holder_height]);
               rotate([45,0,0])
                #cube([single_x*row,TXT_y+Holder_height,Holder_height]);
             }
            }
            
            color("blue")
            translate([0,-single_y*col/2 - TXT_y + TxtThick,-Holder_height/2])
            rotate([45,0,0])
              linear_extrude(height = TxtThick + (TextGap-1))
               text(text = Text, font = Font, size = 10, halign = "center");
        }
    }
    
    for (trans_col =[-single_y*(col-1)/2: single_y: single_y*(col-1)/2])
        for (trans_row =[-single_x*(row-1)/2: single_x: single_x*(row-1)/2])
        {
            translate([trans_row,trans_col,0])
                single_block();
        }
}




// END