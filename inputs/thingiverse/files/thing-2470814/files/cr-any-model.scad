$fn = 32;

/* [Basic settings] */
// Number of columns (best is 1 or 2)
cols=3;
// Number of rows
rows=3;

// Holes enlargement
d=0.04;         // [0.02:0.02:0.2]

model = 1254; // [1254: LR44, 927: CR927, 1025: CR1025, 1130: CR1130, 1216: CR1216, 1220: CR1220, 1225: CR1225, 1616: CR1616, 1620: CR1620, 1632: CR1632, 2012: CR2012, 2016: CR2016, 2020: CR2020, 2025: CR2025, 2032: CR2032, 2040: CR2040, 2320: CR2320, 2325: CR2325, 2330: CR2330, 2335: BR2335, 2354: CR2354, 2412: CR2412, 2430: CR2430, 2450: CR2450, 2477: CR2477, 3032: CR3032]

// Base thickness
base_thick = 3;

// Battery hole depth (% of diameter)
bdepth = 40;          // [25:1:50]

// Interval between batteries
int=3;    // [2:1:5]

text_height=0.8;  // [0.8:0.05:2]

/* [Hidden] */
bthick = (model % 100)/10;
di = round(model/100);
bdiam = (di==9 || di==11 || di==12 || di==24) ? di+0.5 : di;
bscale = (bdiam < 20 ? 0.7 : 1) * 0.5;
depth = bdepth * bdiam / 100;

model_str= str("LR", model);
if (model == 1254) { model_str="LR44"; }


echo(str("Battery model : ", model_str));
echo(str("Size : ",bdiam, "x", bthick));

W = rows*(int+bthick);
L = cols*(int+bdiam);
H = base_thick + depth;
echo(str("W*L*H=",W,"x",L,"x",H,"mm"));

if (model==1254)
{
    container("LR44");
}
else if (model==2335)
{
    container("BR2335");
}
else
{
    container(str("CR", model));
}

module container(model_str)
{
    cube(text_height);
    difference()
    {
        base();
        holes();
        //cube([50,50,2*H-2], center=true);
        rotate([0,0,180])
        {
            translate([-W/2-int+1,L/2+1,3])
            rotate([90,0,-90])
            scale(bscale*text_height)
            linear_extrude(height=4)
            text(model_str, font="Liberation Sans:style=Bold");
        }    
    }
}

module base_spheres()
{
    translate([ W/2, L/2,0]) sphere(r=int);
    translate([-W/2, L/2,0]) sphere(r=int);
    translate([-W/2,-L/2,0]) sphere(r=int);
    translate([ W/2,-L/2,0]) sphere(r=int);
}

module base()
{
    hull()
    {
        translate([0,0,int]) base_spheres();
        translate([0,0,H-int]) base_spheres();
    }
}

module holes()
{
    sx = -(int+bthick)*(rows-1)/2;
    sy = -(int+bdiam)*(cols-1)/2;
    
    for(col = [0: 1: cols-1])
    {
        for(row = [0: 1: rows-1])
        {
            translate([sx+row*(int+bthick),sy+col*(int+bdiam),base_thick+bdiam/2])
            {
                rotate([90,0,90])
                cylinder(d=bdiam, h=bthick+d, center=true);
            }
            
            
        }
    }
}
