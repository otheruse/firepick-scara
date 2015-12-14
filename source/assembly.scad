include <configuration.scad>
include <platform.scad>
include <motorMount.scad>
include <driveWheel.scad>
include <ZMount.scad>
include <pipeSupport.scad>

module assembly() {
    // base 
    render()linear_extrude(3)base();
    // motor mounts
    color([0.7,0,0,1])render()for (i=[1,-1]) {
        translate([i*(rodspacing/2-10),-60, 4])rotate([90+i*45,-90,0])MotorMount(Height=60+i*10);
    }
    // Zmount 
    color([0,0,0.5,1])render()translate([0,0,3])ZMountBottom(rodspacing = rodspacing, rodsize = rod_diameter, thickness = 3);
    color([0,0.5,0,1])render() {
        // drive wheel
        translate([0,0,60])rotate([0,180,0])beltWheelRod(75);
        // drive wheel
        translate([0,0,70])beltWheelTube(75);
    }
    color([0.7,0.7,0.7,1])render() {
        // long support 
        for (i=[-150,150]) {
            translate([i,0,3])pipeSupportLong();
        }
        // short support
        for (i=[-140,140]) {
            translate([i,160,3])pipeSupportShort();
        }
    }
}

$fs = 0.2;
$fa = 2;

assembly();