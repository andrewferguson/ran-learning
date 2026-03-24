# Project Idea for Gaining Experience with 5G RAN Stacks

## Background

The user is a PhD student working on **5G Core (5GC) architecture and
redesign**.\
They are applying for internships, including one focused on **AI-RAN**.

During an interview, the interviewer asked about experience with **RAN
stacks such as OpenAirInterface and srsRAN**.\
The user currently does **not have hands-on experience with these
stacks** and wants to complete a small project to:

-   Gain conceptual knowledge of the **Radio Access Network (RAN)**
-   Get practical exposure to **open-source RAN implementations**
-   Work with **both srsRAN and OpenAirInterface**
-   Complete the project in **3--4 weeks with a few hours per week**

------------------------------------------------------------------------

# Proposed Project

## Title

**End-to-End RAN Behavior Analysis and Control Hooks in Open-Source 5G
RAN Stacks**

### One-sentence description

Build a minimal 5G RAN using **srsRAN** and **OpenAirInterface**,
analyze MAC/RLC behavior under different traffic conditions, and
identify potential control hooks that could enable **AI-driven RAN
optimization**.

------------------------------------------------------------------------

# Project Goals

1.  Understand the **internal architecture of a gNB**
2.  Learn how **schedulers and buffers behave in real RAN
    implementations**
3.  Run **controlled experiments on RAN behavior**
4.  Identify **metrics and control points useful for AI-RAN systems**
5.  Repeat the same experiments using **two different RAN stacks**

------------------------------------------------------------------------

# Week-by-Week Plan

## Week 1 --- Conceptual Understanding and Setup

### Theory

Study the basic internal structure of the RAN stack:

-   PHY
-   MAC
-   RLC
-   PDCP
-   RRC

Key concepts: - MAC scheduling - RLC buffering - UE context handling -
Timing (frames, slots, TTIs)

### Practical Work

Deploy a minimal network using **srsRAN**:

Components: - gNB - UE (or simulator) - 5G Core (Open5GS or srsRAN core)

Goals: - Successful UE attach - Basic connectivity - Ping and iperf
traffic

Deliverables: - Diagram showing data flow through layers - Mapping logs
to protocol layers

------------------------------------------------------------------------

## Week 2 --- RAN Observation and Instrumentation

Enable detailed logging in the stack.

Focus on observing:

-   MAC scheduler decisions
-   RLC buffer occupancy
-   UE context updates
-   PRB allocation
-   MCS selection
-   Throughput per UE

### Experiments

Run traffic experiments such as:

1.  Single UE traffic
2.  Multiple UE traffic
3.  Bursty traffic vs steady traffic

Goal: Understand how schedulers behave under load.

Deliverable: Short experiment report explaining:

-   Scenario
-   Observed behavior
-   Explanation of results

------------------------------------------------------------------------

## Week 3 --- AI-RAN Perspective

Instead of implementing ML, identify **where AI could be applied**.

### Observable Metrics (State)

Examples:

-   CQI
-   MCS history
-   PRB utilization
-   HARQ retransmissions
-   RLC buffer depth
-   Throughput per UE

### Control Knobs (Actions)

Examples:

-   Scheduler policy
-   UE priority
-   Max MCS limits
-   Resource allocation weights
-   Buffer thresholds

### Mini Implementation

Implement a simple rule-based policy, for example:

-   Limit MCS if BLER becomes too high
-   Prioritize UEs with smaller buffers

Goal: Understand where an **AI agent would observe state and apply
control**.

Deliverable: Table mapping:

Metrics → Control decisions

------------------------------------------------------------------------

## Week 4 --- Repeat with OpenAirInterface

Reproduce the same workflow using **OpenAirInterface**.

Tasks:

-   Deploy OAI gNB
-   Run the same traffic experiments
-   Enable logging
-   Compare scheduler behavior

### Comparison Points

Compare:

-   Architecture
-   Logging capabilities
-   Scheduler implementation
-   Ease of modification
-   AI integration potential

Deliverable: Comparison table of:

srsRAN vs OpenAirInterface

------------------------------------------------------------------------

# Final Deliverables

By the end of the project:

### Repository

A small Git repository containing:

-   configuration files
-   experiment scripts
-   logging modifications

### Technical Report (5--7 pages)

Sections:

1.  RAN architecture overview
2.  Experiment methodology
3.  Observed behavior
4.  AI-RAN control opportunities
5.  Stack comparison

------------------------------------------------------------------------

# Key Learning Outcomes

This project will help develop:

-   Practical familiarity with **open-source RAN stacks**
-   Understanding of **MAC scheduling and RLC buffering**
-   Insight into **RAN observability**
-   Knowledge of **where AI could realistically be applied in RAN
    systems**

These insights are highly relevant for **AI-RAN internships and research
roles**.

------------------------------------------------------------------------

# Interview Talking Points

After completing this project you should be able to discuss:

-   Where scheduling decisions occur in a gNB
-   What metrics are available for RAN optimization
-   Why RAN control loops are difficult (latency, timing)
-   Differences between **srsRAN and OpenAirInterface**
-   Where AI-based optimization could realistically be inserted
