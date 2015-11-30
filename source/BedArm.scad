include <configuration.scad>
include <shapes.scad>
include <BearingMount.scad>

module BedArmNoMount(mount_space = 21){

	
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

		cylinder(d=mount_space,h=100);
//        #translate([0,-mount_dia/2,0])cube([mount_dia,mount_dia,100]);
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


module BedArm(bearing_diameter = 15, bearing_length = 24) {
    rotate([0,0,-90])BearingMount(bearing_od = bearing_diameter, bearing_h = bearing_length);
    BedArmNoMount(20);
}


//$fs=0.5;
//$fa=3;
//BedArm(bearing_diameter = 15, bearing_length = 24);
