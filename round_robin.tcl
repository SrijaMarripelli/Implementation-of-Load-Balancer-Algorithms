# *******Round-Robin Scheduling Algorithm********

# Create a simulator object
set ns [new Simulator]

# Create trace objects
set nt [open out.tr w]
$ns trace-all $nt
 
# Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf
 
# Define a 'finish' procedure
proc finish {} {
    global ns nf
    $ns flush-trace
     
    # Close the NAM trace file
    close $nf
     
    # Execute NAM on the trace file
    exec nam out.nam &
    exit 0
}

#===================Creating Network=============================
 
# Create four nodes
set totalNodes 4

for {set i 0} {$i < $totalNodes} {incr i} {
set n$i [$ns node]
}
 
# Create links between the nodes
$ns duplex-link $n0 $n1 2Mb 100ms DropTail
$ns duplex-link $n0 $n2 2Mb 100ms DropTail
$ns duplex-link $n0 $n3 2Mb 100ms DropTail

# Give node position (for NAM)
$ns duplex-link-op $n0 $n1 orient up
$ns duplex-link-op $n0 $n2 orient left-down
$ns duplex-link-op $n0 $n3 orient right-down
 
#=================Data Transfer between Nodes===================

# Defining a transport agent for sending
set tcp [new Agent/TCP]

# Attaching transport agent to sender node
$ns attach-agent $n0 $tcp

# Defining a transport agent for receiving
set sink [new Agent/TCPSink]

# Attaching transport agent to receiver node
$ns attach-agent $n1 $sink

#Connecting sending and receiving transport agents
$ns connect $tcp $sink

#Defining Application instance
set ftp [new Application/FTP]

# Attaching transport agent to application agent
$ftp attach-agent $tcp

# data packet generation starting time
$ns at 1.0 "$ftp start"

# data packet generation ending time
$ns at 6.0 "$ftp stop"

#=========================

# Defining a transport agent for sending
set tcp [new Agent/TCP]

# Attaching transport agent to sender node
$ns attach-agent $n0 $tcp

# Defining a transport agent for receiving
set sink [new Agent/TCPSink]

# Attaching transport agent to receiver node
$ns attach-agent $n2 $sink

#Connecting sending and receiving transport agents
$ns connect $tcp $sink

#Defining Application instance
set ftp [new Application/FTP]

# Attaching transport agent to application agent
$ftp attach-agent $tcp

# data packet generation starting time
$ns at 6.0 "$ftp start"

# data packet generation ending time
$ns at 11.0 "$ftp stop"

#=========================

# Defining a transport agent for sending
set tcp [new Agent/TCP]

# Attaching transport agent to sender node
$ns attach-agent $n0 $tcp

# Defining a transport agent for receiving
set sink [new Agent/TCPSink]

# Attaching transport agent to receiver node
$ns attach-agent $n3 $sink

#Connecting sending and receiving transport agents
$ns connect $tcp $sink

#Defining Application instance
set ftp [new Application/FTP]

# Attaching transport agent to application agent
$ftp attach-agent $tcp

# data packet generation starting time
$ns at 11.0 "$ftp start"

# data packet generation ending time
$ns at 16.0 "$ftp stop"

#================================================================
 
# Call the finish procedure after
# 20 seconds of simulation time
$ns at 20.0 "finish"

# Run the simulation
$ns run





