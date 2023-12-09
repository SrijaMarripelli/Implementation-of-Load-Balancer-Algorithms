# ******Least Connections Algorithm*******

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
 
# Create four main nodes
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

# Creating sub-nodes for the above nodes
set subTotalNodes 9

for {set i 0} {$i < $subTotalNodes} {incr i} {
set sn$i [$ns node]
}

# Create links between the nodes and sub-nodes

# For node 1
$ns duplex-link $n1 $sn0 2Mb 100ms DropTail
$ns duplex-link $n1 $sn1 2Mb 100ms DropTail
$ns duplex-link $n1 $sn2 2Mb 100ms DropTail

# For node 2
$ns duplex-link $n2 $sn3 2Mb 100ms DropTail
$ns duplex-link $n2 $sn4 2Mb 100ms DropTail

# For node 3
$ns duplex-link $n3 $sn5 2Mb 100ms DropTail	
$ns duplex-link $n3 $sn6 2Mb 100ms DropTail
$ns duplex-link $n3 $sn7 2Mb 100ms DropTail
$ns duplex-link $n3 $sn8 2Mb 100ms DropTail

# Node positions for sub-nodes

# For node 1 sub-nodes
$ns duplex-link-op $n1 $sn0 orient left
$ns duplex-link-op $n1 $sn1 orient up
$ns duplex-link-op $n1 $sn2 orient right

# For node 2 sub-nodes
$ns duplex-link-op $n2 $sn3 orient left
$ns duplex-link-op $n2 $sn4 orient down

# For node 3 sub-nodes
$ns duplex-link-op $n3 $sn5 orient up
$ns duplex-link-op $n3 $sn6 orient left
$ns duplex-link-op $n3 $sn7 orient down
$ns duplex-link-op $n3 $sn8 orient right

#=================Data Transfer between Nodes===================

#=========================Node 2=================

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
$ns at 1.0 "$ftp start"

# data packet generation ending time
$ns at 6.0 "$ftp stop"

#===================Node 1======================

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
$ns at 6.0 "$ftp start"

# data packet generation ending time
$ns at 11.0 "$ftp stop"

#=========================Node 3=================

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
