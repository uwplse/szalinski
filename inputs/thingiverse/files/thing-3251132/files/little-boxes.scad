// little boxes - with handle, tag, separators and lid
// version 0.0.3
// by pixelhaufen
// is licensed under CC BY-SA 3.0 -> https://creativecommons.org/licenses/by-sa/3.0/

//------------------------------------------------------------------
// User Inputs

// create a seperate model for box, lid and separator
type = "box"; // [box,lid,separator]

/* [box] */
box_tag = "yes"; // [yes,no]
box_handle = "yes"; // [yes,no]
separators = 2; //[0:1:3]

/* [size] */
// without lid
width = 50; //[30:200]
// without lid, tag or handle
lenght = 70; //[12:200]
// without lid
height = 35; //[20:200]
// prints best with a multiple of the nozzle diameter
shell = 0.8; //[0.2:0.05:1.5]

/* [experimental] */
stackable = "no"; // [yes,no]

/*[Hidden]*/
$fn=60;

//------------------------------------------------------------------
// Main

if (type=="box")
{
    box([width,lenght,height],shell);
    if(box_tag=="yes")
    {
        tag(width,height,shell);
    }
    if(box_handle=="yes")
    {
        handle(width,shell);
    }
    separator_handle(width,lenght,height,shell,separators);
    
    if(stackable=="yes")
    {
        stackable(width,lenght,height);
    }
}
else if(type=="lid")
{
    lid([width,lenght,3],shell,stackable);
}
else if(type=="separator")
{
    separator(width,height,shell);
}

//------------------------------------------------------------------
// Modules

module separator(width,height,shell)
{
    cube([width-2*shell-0.2,height-shell-2,1]);
}

module stackable(width,lenght,height)
{
    translate([width, lenght/4, height-2])
        rotate([90, 0, 90])
            prism(lenght/2,3,1+shell);
    translate([0, lenght*3/4, height-2])
        rotate([90, 0, -90])
            prism(lenght/2,3,1+shell);
    translate([width*3/4, lenght, height-2])
        rotate([90, 0, 180])
            prism(width/2,3,1+shell);
}

module separator_handle(width,lenght,height,shell,separators)
{
    separators_lenght=lenght/(separators+1);
    if(separators > 0)
    {
        for (i = [1:separators])
        {
            separator_handle_create(width,separators_lenght*i,height,shell,separators);
        }
    }
}

module separator_handle_create(width,lenght,height,shell,separators)
{   
    translate([width-shell, lenght-0.6-3, 0])
        rotate([0, -90, 0])
            prism(height-2,3,3);
    translate([width-3-shell, lenght+0.6, 0])
        rotate([-90, -90, 0])
            prism(height-2,3,3);
    translate([3+shell, lenght-0.6, 0])
        rotate([90, -90, 0])
            prism(height-2,3,3);
    translate([shell, lenght+0.6+3, 0])
        rotate([180, -90, 0])
            prism(height-2,3,3);
}

module tag(width,height,shell)
{
    difference()
    {
        union()
        {
            translate([4, 0, height-15])
                rotate([90, 0, 0])
                    prism(width-8,3,1+shell);
            translate([4, -1-shell, height-12])
                cube([width-8, 1+shell, 10], center=false);
        }
        
        translate([4+shell, -1, height-12])
            cube([width-8-shell*2, 1, 11], center=false);
        translate([7, -2.5, height-10])
            cube([width-14, 2, 10], center=false);
    }
}

module handle(width,shell)
{
    translate([9, -5*shell, 0])
        cube([width-18, 5*shell, 2*shell], center=false);

    translate([9, -5*shell, 2*shell])
        cube([width-18, shell, shell], center=false);

    translate([9, -5*shell+shell, 3*shell])
        rotate([-90, 0, 0])
            prism(width-18,shell,1);
}

module prism(lenght, width, height)
{
    polyhedron
    (
        points=[[0, 0, 0], [lenght, 0, 0], [lenght, width, 0], [0, width, 0], [0, width, height], [lenght, width, height]],
        faces=[[0, 1, 2, 3], [5, 4, 3, 2], [0, 4, 5, 1], [0, 3, 4], [5, 2, 1]]
    );
}

module lid(size,shell,stackable,radius=5)
{
    translate([shell, shell, shell])
    {
        difference()
        {
            translate([-1*shell, -1*shell, -shell])
                main_box([size[0]+shell*2,size[1]+shell*2,size[2]],radius);
            
            union()
            {
                main_box([size[0],size[1],size[2]],radius-shell);
                if(stackable=="yes")
                {
                    translate([size[0]/4-0.1, -1.5*shell, -shell-0.1])
                        cube([size[0]/2+0.2, shell*2, size[2]+0.2], center=false);
                    translate([size[0]/4-0.1, -0.5*shell+size[1], -shell-0.1])
                        cube([size[0]/2+0.2, shell*2, size[2]+0.2], center=false);
                    translate([-1.5*shell, size[1]/4-0.1, -shell-0.1])
                        cube([shell*2, size[1]/2+0.2, size[2]+0.2], center=false);
                    translate([-0.5*shell+size[0], size[1]/4-0.1, -shell-0.1])
                        cube([shell*2, size[1]/2+0.2, size[2]+0.2], center=false);
                }
            }
        }
        difference()
        {
            translate([shell+0.2, shell+0.2, 0])
                main_box([size[0]-shell*2-0.2*2,size[1]-shell*2-0.2*2,shell/2],radius-2*shell);
            
            translate([2*shell+0.2, 2*shell+0.2, 0])
                main_box([size[0]-shell*4-0.2*2,size[1]-shell*4-0.2*2,shell],radius-3*shell);
        }
    }
}

module box(size,shell,radius=4)
{
    difference()
    {
        main_box(size,radius);
        
        translate([shell, shell, shell])
            main_box([size[0]-shell*2,size[1]-shell*2,size[2]],radius-1);
    }
}

module main_box(size,radius=3)
{
    hull()
    {
        translate([radius, radius, 0])
            cylinder(r1=radius, r2=radius, h=size[2], center=false);
        translate([size[0]-radius, radius, 0])
            cylinder(r1=radius, r2=radius, h=size[2], center=false);
        translate([radius, size[1]-radius, 0])
            cylinder(r1=radius, r2=radius, h=size[2], center=false);
        translate([size[0]-radius, size[1]-radius, 0])
            cylinder(r1=radius, r2=radius, h=size[2], center=false);
    }
}
