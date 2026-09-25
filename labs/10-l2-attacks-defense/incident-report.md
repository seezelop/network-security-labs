# LAB 10 – Incident Response Report

## 1. Preparation

### Scenario

A small Layer 2 network was created to simulate an enterprise access network and investigate unauthorized ARP advertisements.

### Assets

- `r01` – legitimate router / default gateway  – `10.40.10.1`
- `victim01` – monitored endpoint – `10.40.10.10`
- `attacker01` – controlled test endpoint – `10.40.10.50`
- `sw01` – Layer 2 switch

### Objective

Establish a legitimate ARP baseline before introducing controlled ARP spoofing activity.

The baseline will be used to identify changes in the IP-to-MAC association of the gateway during the incident.

## 2. Detection

During network monitoring, `victim01` received unsolicited ARP replies claiming that the legitimate gateway IP `10.40.10.1` was associated with a different MAC address.

The legitimate baseline was:

`10.40.10.1 → aa:c1:ab:db:8e:8c`

The suspicious ARP advertisements claimed:

`10.40.10.1 → aa:c1:ab:f9:ff:a5`

The second MAC address belongs to `attacker01`.

Packet capture confirmed repeated ARP replies advertising the false association.

After the advertisements were received, the neighbor table on `victim01` changed to the attacker's MAC address, confirming successful ARP cache poisoning.

## 3. Analysis

Packet analysis confirmed that the ARP poisoning affected the actual traffic path.

Although `victim01` continued sending traffic to the Layer 3 destination `10.40.10.1`, the Ethernet frames were addressed to the MAC address of `attacker01`.

Observed traffic path:

`victim01 → attacker01 → r01`

The packet capture showed:

- Source IP: `10.40.10.10`
- Destination IP: `10.40.10.1`
- Initial Layer 2 destination: MAC address of `attacker01`
- Forwarded Layer 2 destination: legitimate MAC address of `r01`

The TTL decreased from 64 to 63 when the traffic was forwarded by `attacker01`, confirming that the unauthorized endpoint was acting as an intermediary.

Connectivity remained operational during the incident, demonstrating that successful ARP poisoning does not necessarily cause an obvious outage.

This behavior is consistent with a potential Man-in-the-Middle condition in which traffic can be redirected through an unauthorized system.

## 4. Containment

The suspicious endpoint was isolated at the Layer 2 access switch.

The Open vSwitch port connected to `attacker01` was administratively disabled.

This stopped the unauthorized endpoint from continuing to send forged ARP advertisements while preserving the container for further investigation.

Containment action:

`attacker port → DOWN`

After isolation, `attacker01` could no longer communicate with the legitimate gateway.

## 5. Eradication

After isolating the suspicious endpoint, the poisoned ARP entry was removed from `victim01`.

The compromised association:

`10.40.10.1 → attacker01 MAC`

was deleted from the neighbor table.

A new legitimate ARP resolution was then triggered, restoring:

`10.40.10.1 → r01 MAC`

This removed the malicious Layer 2 state introduced during the incident.

## 6. Recovery

The legitimate gateway association was restored on `victim01`.

Validation confirmed:

- `10.40.10.1` was again associated with the legitimate MAC address of `r01`.
- Connectivity between `victim01` and the gateway was restored.
- `attacker01` remained isolated from the Layer 2 network.
- Traffic from `victim01` no longer traversed the unauthorized endpoint.

The network returned to its expected operational state while the suspicious endpoint remained contained.

## 7. Lessons Learned

The incident demonstrated that ARP spoofing can modify a host's IP-to-MAC association and redirect traffic through an unauthorized endpoint without necessarily causing an obvious connectivity outage.

Recommended Layer 2 defensive controls include:

- DHCP Snooping to build trusted IP-to-MAC-to-port bindings.
- Dynamic ARP Inspection (DAI) to validate ARP traffic received on untrusted access ports.
- ARP ACLs for environments containing statically addressed endpoints.
- Access-port monitoring and rapid isolation of suspicious endpoints.
- Baseline monitoring for unexpected gateway MAC address changes.

A Cisco Packet Tracer topology was used to configure DHCP Snooping and Dynamic ARP Inspection on VLAN 10.

DHCP Snooping successfully learned the legitimate binding for `victim01`, and DAI was shown as enabled and active.

However, Packet Tracer 9.0.1 did not enforce the expected DAI forwarding behavior in this scenario: ARP inspection counters remained at zero and the statically configured rogue endpoint continued resolving the gateway successfully.

Therefore, the Cisco portion of this lab demonstrates the enterprise control configuration, while the actual ARP spoofing, traffic redirection, containment and recovery were validated in the Containerlab/Linux environment.

On physical Cisco platforms that implement DAI, ARP packets received on untrusted ports are validated against trusted bindings and invalid packets are discarded.