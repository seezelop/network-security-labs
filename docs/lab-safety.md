# Lab Safety

All experiments in this repository are performed in isolated virtual laboratory environments.

## Safety Principles

- Do not connect experimental Layer 2 topologies to the physical LAN.
- Do not attach the physical host interface to laboratory bridges.
- Keep experimental traffic inside containers, namespaces, veth interfaces and virtual switches.
- Do not apply experimental nftables rules to the Ubuntu host.
- Use a dedicated firewall container for firewall and NAT experiments.
- Avoid uncontrolled broadcast storms or unlimited traffic generation.
- Stop experiments if they cause unexpected host resource consumption.

## Evidence Sanitization

Before publishing screenshots, logs, configurations or other evidence:

- Remove credentials, passwords and tokens.
- Remove personal information.
- Remove corporate or production information.
- Remove unnecessary hostnames and usernames.
- Remove unnecessary private IP addresses.
- Remove personal filesystem paths.
- Review screenshots before committing them.