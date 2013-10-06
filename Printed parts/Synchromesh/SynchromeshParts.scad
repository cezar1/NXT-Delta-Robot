
translate([15,15,4]) SynchromeshPulleyModifiedPinch(grooves=15, pitch=3.81);
translate([15,-15,4]) SynchromeshPulleyModified(grooves=15, pitch=3.81);
translate([-15,0,3.5]) SynchromeshIdler();

/*
 * A parametric pulley for synchromesh cable.
 *
 * Slightly fudged values, but prints nicely!
 */
module SynchromeshPulleyModified(grooves=15, pitch=3.81)
{
	radius = (grooves*pitch)/(2*3.14159)+1.5;

	difference() 
	{
		union()
		{
			cylinder(h=8, r=radius, center=true);
		}

		cylinder(h=20, r=2.64, center=true);

		rotate_extrude(convexity = 10, $fn = 100)
			translate([radius, 0, 0])
				square([3.2,1.6],center=true);

		for (i = [0 : grooves])
		{
			rotate([0,0,i*(360/grooves)]) translate([radius-1,0,0]) rotate([-180/pitch,0,0])
				cube([4,1.1, 4.8],center=true);
		}
	}
}

/*
 * Uses a pinch clamping nut on the outside.
 */
module SynchromeshPulleyModifiedPinch(grooves=15, pitch=3.81)
{
	radius = (grooves*pitch)/(2*3.14159)+1.5;

	difference() 
	{
		union()
		{
			cylinder(h=7, r=radius, center=true);

			translate([0,0,8])
				cylinder(h=16, r=5.8, center=true);
			translate([0,0,8])
				cube([6.5,radius*2-1.2,16], center=true);
		}

		// center hole
		cylinder(h=60, r=2.9, center=true);

		// slot for pinch
		translate([0,0,10.6])
			cube([1.5,24,14], center=true);
		translate([0,7.5,9.5]) rotate([0,90,0])
			cylinder(h=40, r=1.8, center=true);
		translate([0,-7.5,9.5]) rotate([0,90,0])
			cylinder(h=40, r=1.8, center=true);

		// groove
		rotate_extrude(convexity = 10, $fn = 100)
			translate([radius, 0, 0])
				square([3.2,1.6],center=true);

		for (i = [0 : grooves])
		{
			rotate([0,0,i*(360/grooves)]) translate([radius-1,0,0]) rotate([-180/pitch,0,0])
				cube([4,1.1, 4.8],center=true);
		}
	}
}

/*
 * Idler for 608Z ball bearings.
 */
module SynchromeshIdler()
{
	difference() 
	{
		union()
		{
			cylinder(h=7, r=16.5, center=true);
		}

		cylinder(h=9, r=11.25, center=true);

		rotate_extrude(convexity = 10, $fn = 100)
			translate([16.5, 0, 0])
			circle(r = 1.5, $fn = 50);
	}
}

/*
 * Model of the cable itself.
 */
module SynchromeshCable(length=2, pitch=3.81)
{
	union()
	{
		translate([0,0,length/2])
			cylinder(h=length, r=0.42, center=true, $fn = 100);
		linear_extrude(height = length, center = false, convexity = 10, twist = -360*(length/pitch), $fn = 50)
			translate([.715, 0, 0])
			circle(r = 0.63/2);
	}
}

