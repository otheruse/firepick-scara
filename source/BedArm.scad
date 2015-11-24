include <configuration.scad>

module Bedarm_mount12(bearingD = 21){
	
	bearingR = bearingD / 2;

	subcyl = sqrt(pow((bearingR+4.25),2)/2);

	difference(){
		cylinder(r=bearingR + 4.25,h=3*24,$fn=50);
		cylinder(d=bearingD, h=3*24);
		translate([bearingR+4.25,0,0])
			cylinder(r=subcyl,h=3*24,$fn=50);
		
		

	}
	rotate([0,0,-45])
		translate([bearingR+2.25,0,0])
			cylinder(r=2.25,h=3*24, $fn=50);
	rotate([0,0,45])
		translate([bearingR+2.25,0,0])
			cylinder(r=2.25,h=3*24, $fn=50);

	translate([0,0,6])
		difference(){
			rotate_extrude(convexity = 10)
				translate([bearingR, 0, 0])
					circle(r = .8, $fn = 100);
			translate([8,0,0])
				cube([bearingD*.66,bearingD*.66,2], center=true);
		}

	translate([0,0,44.5+6])
		difference(){
			rotate_extrude(convexity = 10)
				translate([bearingR, 0, 0])
					circle(r = .8, $fn = 100);
			translate([8,0,0])
				cube([bearingD*.66,bearingD*.66,2], center=true);
		}

}

module Bedarm(){

	
	difference(){
		union(){
			translate([0,100,2])
				cube([18,200,4],center=true);
			translate([0,100,3*24/2])
				cube([5,200,3*24],center=true);
			
			
			translate([-9,25,12])
				rotate([0,90,0])
					cylinder(r=12,h=18,$fn=50);
		}

		cylinder(r=11.5,h=100);
		translate([0,75,87.50])
			rotate([0,90,0])
				cylinder(r=65,h=20,center=true);
		translate([0,175,72.5])
			cube([20,200,100],center=true);

		translate([-10,25,12])
				rotate([0,90,0])
					cylinder(d=15.5, h=20);

		translate([-10,188,12])
				rotate([0,90,0])
					cylinder(d=15.5, h=20);
		
	}
	
	difference(){
		union(){
			translate([-9,188,12])
				rotate([0,90,0])
					cylinder(r=12,h=18,$fn=50);
			translate([0,194,12])
				cube([18,12,24],center=true);
		}
		
		translate([-10,188,12])
				rotate([0,90,0])
					cylinder(d=15.5, h=20);

	}
	
}

module BedArmLeft(bsize = 16){

	Bedarm_mount12(bsize);
	Bedarm();
	
}


module BedArmRight(bsize = 16){

	rotate([0,0,180])
		Bedarm_mount12(bsize);

	Bedarm();
	
}

//BedArmLeft();