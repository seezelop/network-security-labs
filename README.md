# Network Security Labs

Practical networking and network security laboratory series focused on building, observing, securing, and troubleshooting reproducible network environments.

The project combines networking fundamentals with defensive cybersecurity practices using Linux-based virtual networks and real protocol analysis.

## Objectives

- Build reproducible network topologies.
- Analyze Ethernet, ARP, ICMP, IPv4, IPv6 and network services.
- Configure switching, VLANs, routing and OSPF.
- Implement segmentation, NAT and stateful firewall policies.
- Analyze network traffic with tcpdump and Wireshark.
- Practice Layer 2 security and management-plane hardening.
- Troubleshoot network failures using packet and system evidence.
- Validate an integrated enterprise network security architecture.

## Technologies

- Linux
- Docker
- Containerlab
- FRRouting
- Open vSwitch
- nftables
- tcpdump
- Wireshark
- Python
- Cisco Packet Tracer

## Labs

01. Reproducible Network Lab Environment
02. Ethernet, MAC, ARP and ICMP
03. IPv4, Subnetting, VLSM and IPv6
04. Switching, MAC Tables, VLANs and 802.1Q
05. Layer 2 Resilience: RSTP, LACP and LLDP
06. Routing Fundamentals and Inter-VLAN Routing
07. OSPF: Dynamic Routing and Routing Security
08. DHCP, DNS and NTP
09. NAT, Stateful Firewall and Network Policy
10. Layer 2 Attacks and Defensive Controls
11. Management Plane Hardening and AAA
12. Network Troubleshooting
13. Enterprise Network Security Validation

## Evidence Methodology

Each laboratory aims to provide four types of technical evidence:

- **State:** internal device or system state.
- **Packet:** observed network traffic.
- **Behavior:** functional endpoint result.
- **Negative Evidence:** expected traffic or behavior that intentionally fails.

## Security and Sanitization

All published evidence is reviewed before being committed.

Credentials, tokens, personal information, real environment identifiers, unnecessary private addressing, sensitive paths and other nonessential data are excluded or sanitized.


## Running the Labs

The laboratories are designed to be reproducible with Docker and Containerlab.

Some labs also use Open vSwitch bridges created directly on the Linux host. When required, the lab directory contains setup and cleanup scripts.

### 1. Enter the lab directory

Example:

`cd labs/09-firewall-nat-policy`

Replace the directory with the lab you want to run.

### 2. Prepare external resources when required

Labs using Open vSwitch may require the bridges to be created before deploying the Containerlab topology.

Example:

`./scripts/setup-ovs.sh`

Not every lab requires this step.

### 3. Deploy the topology

Each laboratory contains its own Containerlab topology file.

Example:

`sudo containerlab deploy -t lab09.clab.yml`

For another lab, replace the topology filename accordingly.

### 4. Verify the deployment

Containerlab topology status:

`sudo containerlab inspect -t lab09.clab.yml`

Docker containers can also be checked with:

`docker ps --filter name=clab-lab09`

All expected nodes should be running before starting the tests.

### 5. Inspect network configuration

Useful commands for validating individual nodes include:

`docker exec <container-name> ip addr`

`docker exec <container-name> ip route`

`docker exec <container-name> ping -c 3 <destination-ip>`

For example:

`docker exec clab-lab09-client01 ping -c 3 10.30.20.10`

These commands help verify interface addressing, routing decisions and basic connectivity.

### 6. Capture and analyze traffic

Many labs use `tcpdump` to observe protocols directly.

Example:

`docker exec <container-name> tcpdump -ni <interface>`

Filters can be added depending on the protocol being investigated.

Examples:

`tcpdump -ni eth1 icmp`

`tcpdump -ni eth1 'tcp port 443'`

`tcpdump -ni eth1 'udp port 67 or udp port 68'`

Packet captures and screenshots used as portfolio evidence are stored inside each lab's `evidence/` directory.

### 7. Validate the experiment

Each lab includes specific positive and negative tests.

Typical validation includes:

- Confirming expected connectivity.
- Verifying routing decisions.
- Testing permitted and denied services.
- Inspecting protocol traffic.
- Reviewing firewall or routing state.
- Introducing controlled failures and troubleshooting them.

The exact validation depends on the objective of each laboratory.

### 8. Destroy the topology

When the lab is complete:

`sudo containerlab destroy -t lab09.clab.yml`

Replace the topology filename with the corresponding lab.

### 9. Remove external Open vSwitch resources

If the lab created Open vSwitch bridges outside Containerlab:

`./scripts/cleanup-ovs.sh`

This step is not required for labs that do not use external OVS bridges.

---

## Typical Workflow

The general workflow used throughout the repository is:

**Prepare → Deploy → Verify → Generate Traffic → Capture → Analyze → Troubleshoot → Destroy**

For labs using Open vSwitch:

**OVS Setup → Containerlab Deploy → Validation → Containerlab Destroy → OVS Cleanup**

This workflow keeps each experiment isolated and makes the environment reproducible for future testing.