// Cut nail to 21mm and sand the ends until shiny before inserting into hole

NailShaftDiameter = 3.4;			// Nail diameter
NailHeadHeight = 1.25;			// Nail head height

main();

module main()
{
	$fn = 360;
	AdapterFillGapLength = 20;			// How much longer the battery needs to be (cut the nail to this length + 1mm, including the head)
	AdapterBatteryOverlapLength = 20;	// How much of the battery is covered by the adapeter
	BatteryDiameter = 11.4; 			// E90/N battery diameter
	AdapterOuterDiameter = 14; 			// AA battery diameter
	Tolerance = 0.25;					// Extra space to add around the battery to be able to slide it in and out easily

	translate([0, 0, AdapterBatteryOverlapLength + AdapterFillGapLength - NailHeadHeight])
	rotate([180, 0, 0])
		difference()
		{
			// Main body
			cylinder(d = AdapterOuterDiameter, h = AdapterBatteryOverlapLength + AdapterFillGapLength - NailHeadHeight);

			// Battery hole
			cylinder(d = BatteryDiameter + Tolerance * 2, h = AdapterBatteryOverlapLength);

			// Electrode hole
			cylinder(d = NailShaftDiameter, h = AdapterBatteryOverlapLength + AdapterFillGapLength);
		}
}