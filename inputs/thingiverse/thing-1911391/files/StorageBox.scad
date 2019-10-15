
/*///////////////////////////////////////////////////////////////
              -     By Miguel Ángel Vílchez López     -
              -          http://matronica.eu          -
              -     OpenScad Parametric StorageBox    -
              -           GNU-GPLv3 License           -
/////////////////////////////////////////////////////////////////

02/12/2016 - Initial programing
06/12/2016 - Finish first version

////////////////////////////////// - Info - //////////////////////////////////

// Parametric StorageBox, you can configure the numbers of holes for storing ..
// USBs, SDs, uSDs & another big box.

// If you make any modification, please share it.

// Any comment or suggestion to mangel@matronica.eu

////////////////////////////////////////////////////////////////////


////////////////////////////////// - StorageBox parameters - //////////////////////////////////

/* [USB parameters] */

// - Número de USBs - USBs number
number_usbs = 6;//[0:20] 
// - Número de columnas del USBs - USBs columns number
number_columns_usbs = 2;//[1:5]

/* [SD parameters] */

// - Número de SDs - SDs number
number_sds = 10;//[0:20]
// - Número de columnas del SDs - SDs columns number
number_columns_sds = 2;//[1:5]

/* [uSD parameters] */

// - Número de uSDs - uSDs number
number_usds = 16;//[0:40]
// - Número de columnas del uSDs - uSDs columns number
number_columns_usds = 2;//[1:5]

/* [Order] */

// - Orden de los agujeros - Holes order ( remember to remove if you put 0 on any number )
order=["sd","usd","usb"];

/* [Multiuse hole parameters] */

// - Tamaño del Agujero multiuso( en mm ) - Multiuse hole height( in mm )
multiuse_hole_height = 10;
// - Dimensión de los márgenes del agujero multiuso( en mm ) - Dimension of margin for the multiuse hole( in mm )
margins_dimension = 2;

////////////////////////////////// - Calculations - //////////////////////////////////

// Get the length on the X axis
function getsdlenX() = 24.3*number_columns_sds+number_columns_sds+1;
function getusdlenX() = 11.5*number_columns_usds+number_columns_usds+1;
function getusblenX() = 12.2*number_columns_usbs+number_columns_usbs+1;

// Get the length on the Z axis
function getsdlenY() = (3*ceil(number_sds/number_columns_sds))+1;
function getusblenY() = (6*ceil(number_usbs/number_columns_usbs))+1;
function getusdlenY() = (2*ceil(number_usds/number_columns_usds))+1;

// Max length on the Z axis
function max_z() = ((number_sds > 0) ? 26 : ((number_usbs > 0) ? 16 : ((number_usds > 0) ? 13 : 0) ) );

// Max length on the Y axis
max_y = quicksort([getsdlenY(),getusblenY(),getusdlenY()])[0];

////////////////////////////////// - Function sort - //////////////////////////////////

// input : list of numbers
// output : sorted list of numbers
function quicksort(arr) = !(len(arr)>0) ? [] : let(
    pivot   = arr[floor(len(arr)/2)],
    lesser  = [ for (y = arr) if (y  < pivot) y ],
    equal   = [ for (y = arr) if (y == pivot) y ],
    greater = [ for (y = arr) if (y  > pivot) y ]
) concat(
    quicksort(greater), equal, quicksort(lesser)
);

////////////////////////////////// - Module generate multiuse hole - //////////////////////////////////

module hole()
{

};

////////////////////////////////// - Module generate SD hole - //////////////////////////////////

module sd(initial_x=0,initial_y=0,initial_z=0)
{

};

////////////////////////////////// - Module generate uSD hole - //////////////////////////////////

module usd(initial_x=0,initial_y=0,initial_z=0)
{

};

////////////////////////////////// - Module generate USB hole - //////////////////////////////////

module usb(initial_x=0,initial_y=0,initial_z=0)
{

};

////////////////////////////////// - Module build all - //////////////////////////////////

module build(pass=0,now_x=0)
{
    if (pass < len(order))
    {
        if (order[pass] == "sd")
        {
            // generate SDs
            initial_x = now_x;
            initial_y = 0;
            initial_z = max_z()-26;
//            sd(now_x,0,max_z()-26);
            // More than 0 SDs
            if (number_sds > 0)
            {
                // 1 Column
                if (number_columns_sds <= 1)
                {
                    difference()
                    {
                        translate ([initial_x,initial_y,initial_z])
                        cube([26.3,(3*number_sds)+1,26],false);
                        for (a = [0:1:(number_sds-1)]) 
                            translate ([1+initial_x,(a*3)+1+initial_y,1.01+initial_z]) 
                            cube([24.3,2.2,25],false);
                    }
                }
                // More columns
                else
                {
                    difference()
                    {
                        translate ([initial_x,initial_y,initial_z])
                        cube([(25.3*number_columns_sds)+1,(3*ceil(number_sds/number_columns_sds))+1,26],false);
                        for (col = [0:1:number_columns_sds-1])
                        {
                            // The rest
                            if (col != number_columns_sds-1)
                            {
                                for (a = [0:1:(ceil(number_sds/number_columns_sds)-1)]) 
                                {
                                    translate ([(25.3*col)+1+initial_x,(a*3)+1+initial_y,1.01+initial_z])
                                    cube([24.3,2.2,25],false);
                                }
                            }
                            else
                            {
                                for (a = [0:1:(ceil(number_sds/number_columns_sds)-(number_sds%number_columns_sds)-1)]) 
                                {
                                    translate ([(25.3*col)+1+initial_x,(a*3)+1+initial_y,1.01+initial_z]) 
                                    cube([24.3,2.2,25],false);
                                }
                            }
                        }
                    }
                }
            }
            
            // fill the rest on Z axis
            translate([now_x,getsdlenY(),0]) 
                cube([getsdlenX(),max_y-getsdlenY(),max_z()]);
            build(pass+1,now_x+getsdlenX());    // recursive pass on order vector
        }
        if (order[pass] == "usd")
        {
                        // generate uSDs
            initial_x = now_x;
            initial_y = 0;
            initial_z = max_z()-13;
//            usd(now_x,0,max_z()-13);
                if (number_usds > 0)
    {
        // 1 Column
        if (number_columns_usds <= 1)
        {
            difference()
            {
                translate ([initial_x,initial_y,initial_z])
                cube([13.5,(2*number_usds)+1,13],false);
                for (a = [0:1:(number_usds-1)]) 
                    translate ([1+initial_x,(a*2)+1+initial_y,1.01+initial_z]) 
                    cube([11.5,0.9,12],false);
            }
        }
         // More columns
        else
        {
            difference()
            {
                translate ([initial_x,initial_y,initial_z])
                cube([(12.5*number_columns_usds)+1,(2*ceil(number_usds/number_columns_usds))+1,13],false);
                for (col = [0:1:number_columns_usds-1])
                {
                    // The rest
                    if (col != number_columns_usds-1)
                    {
                        for (a = [0:1:(ceil(number_usds/number_columns_usds)-1)]) 
                        {
                            translate ([(12.5*col)+1+initial_x,(a*2)+1+initial_y,1.01+initial_z])
                            cube([11.5,0.9,12],false);
                        }
                    }
                    else
                    {
                        for (a = [0:1:(ceil(number_usds/number_columns_usds)-(number_usds%number_columns_usds)-1)]) 
                        {
                            translate ([(12.5*col)+1+initial_x,(a*2)+1+initial_y,1.01+initial_z]) 
                            cube([11.5,0.9,12],false);
                        }
                    }
                }
            }
        }
    }
            // fill the rest on Z axis
            translate ([now_x,0,0]) 
                cube([getusdlenX(),getusdlenY(),max_z()-13]);
            translate([now_x,getusdlenY(),0]) 
                cube([getusdlenX(),max_y-getusdlenY(),max_z()]);
            build(pass+1,now_x+getusdlenX());    // recursive pass on order vector
        }
        if (order[pass] == "usb")
        {
                        // generate USBs
            initial_x = now_x;
            initial_y = 0;
            initial_z = max_z()-16;
         //   usb(now_x,0,max_z()-16);
    if (number_usbs > 0)
    {
        // 1 Column
        if (number_columns_usbs <= 1)
        {
            difference()
            {
                translate ([initial_x,initial_y,initial_z])
                cube([14.2,(6*number_usbs)+1,16],false);
                for (a = [0:1:(number_usbs-1)]) 
                    translate ([1+initial_x,(a*6)+1+initial_y,1.01+initial_z]) 
                    cube([12.2,4.5,15],false);
            }
        }
         // More columns
        else
        {
            difference()
            {
                translate ([initial_x,initial_y,initial_z])
                cube([(13.2*number_columns_usbs)+1,(6*ceil(number_usbs/number_columns_usbs))+1,16],false);
                for (col = [0:1:number_columns_usbs-1])
                {
                    // The rest
                    if (col != number_columns_usbs-1)
                    {
                        for (a = [0:1:(ceil(number_usbs/number_columns_usbs)-1)]) 
                        {
                            translate ([(13.2*col)+1+initial_x,(a*6)+1+initial_y,1.01+initial_z])
                            cube([12.2,4.5,15],false);
                        }
                    }
                    else
                    {
                        for (a = [0:1:(ceil(number_usbs/number_columns_usbs)-(number_usbs%number_columns_usbs)-1)]) 
                        {
                            translate ([(13.2*col)+1+initial_x,(a*6)+1+initial_y,1.01+initial_z]) 
                            cube([12.2,4.5,15],false);
                        }
                    }
                }
            }
        }
    }
            // fill the rest on Z axis
            translate ([now_x,0,0]) 
                cube([getusblenX(),getusblenY(),max_z()-16]);
            translate([now_x,getusblenY(),0]) 
                cube([getusblenX(),max_y-getusblenY(),max_z()]);
            build(pass+1,now_x+getusblenX());    // recursive pass on order vector
        }
    }
    else
    {
    max_x = getsdlenX()+getusdlenX()+getusblenX();
    difference()
    {
        max_x = getsdlenX()+getusdlenX()+getusblenX();
        translate([0,max_y,0]) cube([max_x,max_y+multiuse_hole_height,max_z()]);
        translate([margins_dimension,max_y+margins_dimension,1]) cube([max_x-margins_dimension*2,max_y+multiuse_hole_height-margins_dimension*2,max_z()+0.01]);
    }
    }
};

////////////////////////////////// - Building - //////////////////////////////////

build(0,0);