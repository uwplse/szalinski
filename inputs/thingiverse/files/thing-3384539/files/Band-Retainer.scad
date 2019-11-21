//Dr_C Watch Band Retainer



//Watch Band Width
Watchband_width=24;

//Watch Band Thickness (Should be both arms measured thickness)
Watchband_Thickness=5;

//Desired Length of retainer
Retainer_Length=8;

//Retainer Thickness (Recommend multiple of Nozzle Thickness)
Retainer_Thickness = 1.6;

//Tolerance (Measured gap on all sides)
Retainer_Tolerance = 0.1;

//Rounded Edges
Rounded = true;
$fn=50;

if (Rounded==true)
    {
    difference () {
        minkowski (){cube ([Watchband_width+Retainer_Thickness+ (2*Retainer_Tolerance), Watchband_Thickness+Retainer_Thickness+ (2*Retainer_Tolerance), Retainer_Length-1],center = true);
        cylinder (r=Retainer_Thickness/2,h=1, center = true);
        }
        cube ([Watchband_width+ (2*Retainer_Tolerance), Watchband_Thickness + (2*Retainer_Tolerance), Retainer_Length*2],center = true);
}
}
else
{
    difference () {
        cube ([Watchband_width+(2*Retainer_Thickness)+ (2*Retainer_Tolerance), Watchband_Thickness+(2*Retainer_Thickness)+ (2*Retainer_Tolerance), Retainer_Length],center = true);
        cube ([Watchband_width+ (2*Retainer_Tolerance), Watchband_Thickness+ (2*Retainer_Tolerance), Retainer_Length],center = true);
    }
}
    