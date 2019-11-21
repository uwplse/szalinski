$fn = 100;

// set up your coins in the following format:
// [value, diameter]
$coin1Cent = [0.01, 16.3];
$coin2Cent = [0.02, 18.8];
$coin5Cent = [0.05, 21.2];
$coinThickness = 1.7;
$currencySymbol = "€";

// set up your cluster configuration in the following format
// [$coin, $coin, $coin, ...]
$stacks = [$coin1Cent, $coin1Cent, $coin2Cent, $coin2Cent, $coin5Cent];

// set up dimensions
$clusterDiameter = 60;
$coinsInStack = 30;

// set up your printer 
$nozzleSize = 0.4;
$gap = $nozzleSize * 3;

// other parameters
$bottomThickness = $nozzleSize * 3;
$clusterHeight = $coinThickness * $coinsInStack + $bottomThickness * 2;

// --- init

$stacksInCluster = len($stacks);
function getRowValue(coins, i=0, sum=0) = 
    i < len(coins) ? sum + getRowValue(coins, i + 1, coins[i][0]) : sum;
function getBiggestCoinDiameter(coins, i=0, diameter=0) =
    i < len(coins) ? 
        max(diameter, getBiggestCoinDiameter(coins, i + 1, coins[i][1])) : diameter;
$totalValue = getRowValue($stacks) * $coinsInStack;
$biggestCoinDiameter = getBiggestCoinDiameter($stacks);
echo(str("Total value: ", $totalValue, $currencySymbol));

// --- cluster

difference() {
    cylinder(d=$clusterDiameter, h=$clusterHeight);
    for($i=[0:$stacksInCluster-1]) {
        $coinDiameter = $stacks[$i][1];
        rotate(a=$i*360/$stacksInCluster, v=[0, 0, 1])
            translate([$clusterDiameter/2 - $coinDiameter/2 + $gap, 0, $bottomThickness])
                cylinder(d=$coinDiameter + $gap, h=$clusterHeight);
    }
    cylinder(d=$clusterDiameter - $biggestCoinDiameter*2 - $gap*4, h=$clusterHeight);
}

// --- cap

translate([$clusterDiameter*1.2, 0, 0])
    difference() {
        cylinder(d=$clusterDiameter + $bottomThickness*2 + $nozzleSize*2, h=$bottomThickness + $coinThickness*3);
        translate([0, 0, $bottomThickness]) 
            cylinder(d=$clusterDiameter + $nozzleSize*2, h=$coinThickness*3);
        linear_extrude($bottomThickness) mirror(0, 0, 1)
            text(str($totalValue, $currencySymbol), size=$clusterDiameter/4, halign="center", valign="center");
    }
