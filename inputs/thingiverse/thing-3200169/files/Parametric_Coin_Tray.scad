// Parametric Coin Holder for Euro Cents
// https://www.thingiverse.com/thing:3200169
// V2 by Bikecyclist https://www.thingiverse.com/Bikecyclist/
// V1 by Bikecyclist https://www.thingiverse.com/Bikecyclist/


// Number of facets for rendering
$fn = 64;

// Largest coin value (0: 50 Ct, 1: 20 Ct, 2: 5 Ct, 3: 10 Ct, 4: 2 Ct, 5: 1 Ct)
coin0 = 0;

// Smallest coin value (0: 50 Ct, 1: 20 Ct, 2: 5 Ct, 3: 10 Ct, 4: 2 Ct, 5: 1 Ct)
coinx = 5;

// Maximum Height of the coin stacks in the coin holder (should be >= 5)
h_max = 10;

//Tolerance added to Coin Diameter to ensure coins can slide in and out
tol_d = 0.9;

//Tolerance added to Coin Thickness to ensure coins actually fit
tol_h = 0.1;

//Minimum Wall Thickness around and between the coin recesses
flesh = 1.5;

//Small distance to ensure proper meshing
epsilon = 0.01;

module dummy ()
{
}

//[Value of Coin, Coin Diameter, Coin Thickness]
// Can be replaced by different matrix for different currencies
// Should be sorted by Coin Diameter
coins = 
[
    [50, 24.3, 2.4],
    [20, 22.3, 2.2],
    [ 5, 21.3, 1.7],
    [10, 19.8, 2.0],
    [ 2, 18.8, 1.7],
    [ 1, 16.3, 1.6],
];


coin_holder (coin0, coinx, h_max);

module coin_holder (n0, nx, h)
{
    rotate ([180, 0, 0])
        intersection ()
        {
            union ()
            {
                difference ()
                {
                    translate ([0, (calclen (n0, nx))/2, 0])
                        ccube ([coins [n0][1] + tol_d + 2 * flesh, calclen (n0, nx), h_max + flesh]);
                    
                    translate ([0, (coins [n0][1] + tol_d + 2 * flesh)/2, -epsilon])
                        addcoin (n0, nx);
                    
                    translate ([0, (calclen (n0, nx))/2 + epsilon, -epsilon])
                        ccube ([1, calclen (n0, nx) + 2 * epsilon, 5]);
                }
                
                translate ([0, (coins [n0][1] + tol_d + 2 * flesh)/2, +epsilon])
                        addridges (n0, nx);
            }
            
            translate ([0, (coins [n0][1] + tol_d + 2 * flesh)/2, 0])
                hull ()
                    for (i = [0,1])
                        translate ([0, i * (calclen (n0, nx) - (calclen (n0, n0) + calclen (nx, nx))/2), -1])
                            cylinder (d = coins [i==0?n0:nx][1] + tol_d + 2 * flesh, h = h_max + 1 + flesh);
        }
}

function calclen (i, ix) = 
    (i <= ix)?
        coins [i][1] + tol_d + flesh + calclen (i + 1, ix)
        :flesh;

module addcoin (i, ix)
{
    if (i <= ix)
    {
        stack = floor (h_max / coins [i][2] + tol_h);
        
        cylinder (d = coins [i][1] + tol_d, h = stack * (coins [i][2] + tol_h));
        
        cylinder (d = coins [i][1] - 2, h = 2 * h_max);
        
        translate ([0, calclen (i + 1, i + 1) - flesh/2, 0])
            addcoin (i + 1, ix, coins [i + 1])
                children ();
    }
}

module addridges (i, ix)
{
    if (i <= ix)
    {
        for (j = [-1, 1])
            translate ([j* ((coins [i][1] + tol_d + 2 * flesh - 1.5))/2, 0, -1])
                rcube ([3, coins [i][1] + tol_d + 4 * flesh, 1]);
        
        translate ([0, coins [i + 1][1] + tol_d + 2 * flesh, 0])
            addridges (i + 1, ix, coins [i + 1])
                children ();
    }
}


module coin_tray (coin)
{
    echo (coin [0]);
    d_coin = coin [1];
    h_coin = coin [2];

    offset = 2;

    n_coins = 50;

    l_interval = 5 * (h_coin + tol_h);

    w_cube = d_coin + 2 * flesh + 2 * offset;
    l_cube = n_coins/5 * l_interval + 2 * flesh;
    h_cube = d_coin/2;

    intersection ()
    {
        difference ()
        {
            translate ([0, l_cube/2, 0])
                hull ()
                {
                    translate ([0, 0, flesh])
                        ccube ([w_cube, l_cube, h_cube]);
                    
                    linear_extrude (epsilon)
                        offset (w_cube/4)
                            square ([w_cube/2, l_cube - w_cube/2], center = true);
                }

            translate ([0, flesh - (h_coin + tol_h)/2, flesh])
                for (i = [0:n_coins/10 - 1], j = [0:1], k = [1:5])
                    translate ([(2 * j - 1) * offset, (2 * i + j) * l_interval + k * l_interval/5, (d_coin + tol_d)/2])
                        rotate ([90, 0, 0])
                            cylinder (d = d_coin + tol_d, h = h_coin + tol_h + epsilon, center = true);
        }

        translate ([0, l_cube/2 + epsilon, h_cube])
            rotate ([90, 0, 0])
                cylinder (d = w_cube, h = l_cube + 2 * epsilon, center = true);
    }
}

module rcube (dim)
{
    hull ()
        for (i = [-1, 1])
            translate ([0, i * (dim [1]/2 - dim [0]/2), 0])
                cylinder (d = dim [0], h = dim [2]);
}

module ccube (dim)
{
    translate ([0, 0, dim[2]/2])
        cube ([dim [0], dim [1], dim [2]], center = true);
}
