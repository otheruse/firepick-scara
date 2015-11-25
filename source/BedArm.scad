include <configuration.scad>
include <shapes.scad>

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


module screwMount(thickness = 5, hex=true) {
    difference() {
            hull() {
            translate([-thickness,-(m3_nut_dia)/2-1.5,0])rotate([0,90,0])cylinder(d=m3_nut_dia+3, h=thickness);
            translate([-thickness/2,-0.5,0])cube(size=[thickness,1, m3_nut_dia+12], center=true);
        }
        // screw
        translate([-thickness,-(m3_nut_dia)/2-1.5,0])rotate([0,90,0])cylinder(d=m3_dia, h=thickness);
        //nut
        if (hex) {
            translate([-thickness,-(m3_nut_dia)/2-1.5,0])rotate([0,90,0])cylinder(d=m3_nut_dia, h=2, $fn=6);
        }
        else {
            translate([-thickness,-(m3_nut_dia)/2-1.5,0])rotate([0,90,0])cylinder(d=m3_nut_dia, h=2);
        }
    }
}

module BearingTube(bearing_od = 15, bearing_h=24, bearing_count=3, wall_thickness = 3) {
    ring_h = 2;
    mount_height = (bearing_h+ring_h)*bearing_count+ring_h;
    module lockRing(h=2){
        rotate_extrude()translate([bearing_od/2-1,1])trapezoid(top=h, base=0.5, h=1);
    }

    difference() {
        union() {
           // tube
            difference() {
                cylinder(d=bearing_od + 2*wall_thickness, h=mount_height);
                cylinder(d=bearing_od, h=mount_height);
                
            }
            // separators for bearings
            for (i=[0:1:3]) {
                translate([0,0,i*(bearing_h+ring_h)])lockRing(ring_h);
            }
            difference() {
                cylinder(d=bearing_od, h=1);
                cylinder(d=bearing_od-2, h=1);
                
            }
        }
        // slice half off
        translate([0,-bearing_od/2 - wall_thickness,-1])cube([bearing_od+2*wall_thickness, bearing_od+2*wall_thickness, mount_height+2]);
 
    }
    
}

module BearingMount(bearing_od = 15, bearing_h=24, hex = true) {
    wall_thickness = 3;
    mount_height = (bearing_h+2)*3+2;
    
    
    BearingTube(bearing_od = bearing_od, bearing_h = bearing_h, bearing_count = 3, wall_thickness = wall_thickness);
    translate([0,-bearing_od/2,15])screwMount();
    translate([0,-bearing_od/2,mount_height-15])screwMount();
    translate([0,bearing_od/2,15])mirror([0,1,0])screwMount();
    translate([0,bearing_od/2,mount_height-15])mirror([0,1,0])screwMount();
}

module BedArm() {
    rotate([0,0,-90])BearingMount();
    BedArmNoMount(20);
}

//$fs=0.5;
//$fa=3;
//BedArm();
