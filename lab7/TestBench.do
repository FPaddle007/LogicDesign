onerror {resume}
radix define States {
    "3'd0" "Init",
    "3'd1" "LoadX",
    "3'd2" "AddX",
    "3'd3" "MoreX",
    "3'd4" "LoadTotal",
    "3'd5" "DisplayTotal",
    "3'd6" "Clear",
    -default unsigned
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TestBench/CR/Adder/W
add wave -noupdate /TestBench/Clock
add wave -noupdate -radix States /TestBench/QState
add wave -noupdate /TestBench/A
add wave -noupdate /TestBench/T
add wave -noupdate /TestBench/C
add wave -noupdate -radix unsigned /TestBench/X
add wave -noupdate -group {DP Commands} /TestBench/CR/A_LD
add wave -noupdate -group {DP Commands} /TestBench/CR/S_CLR
add wave -noupdate -group {DP Commands} /TestBench/CR/S_LD
add wave -noupdate -group {DP Commands} /TestBench/CR/T_CLR
add wave -noupdate -group {DP Commands} /TestBench/CR/T_LD
add wave -noupdate -radix unsigned /TestBench/CR/AREG
add wave -noupdate -radix unsigned /TestBench/CR/SREG
add wave -noupdate -radix unsigned /TestBench/CR/TREG
add wave -noupdate -radix unsigned /TestBench/Total
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2200 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 215
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {10500 ps}
