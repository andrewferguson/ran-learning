#!/bin/bash
set -e

# srsRAN + ZMQ install instructions from: https://docs.srsran.com/projects/project/en/latest/user_manuals/source/installation.html#manual-installation-build

# Build the RAN
cd ~/
sudo apt update
sudo apt-get install -y cmake make gcc g++ pkg-config libfftw3-dev libmbedtls-dev libsctp-dev libyaml-cpp-dev libgtest-dev ccache libbackward-cpp-dev libzmq3-dev
git clone https://github.com/srsran/srsRAN_Project.git
cd srsRAN_Project
mkdir build
cd build
cmake ../ -DENABLE_EXPORT=ON -DENABLE_ZEROMQ=ON
make -j`nproc`

# Build the UE
cd ~/
sudo apt-get install -y build-essential cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev
git clone https://github.com/srsRAN/srsRAN_4G.git
cd srsRAN_4G
mkdir build
cd build
cmake ../
make -j`nproc`

# Run the core
sudo apt install -y docker-compose-v2 docker.io
cd ~/srsRAN_Project/docker/open5gs/
sudo docker compose up --detach --build 5gc

# Networking stuff
sudo ip netns add ue1
sudo ip ro add 10.45.0.0/16 via 10.53.1.2

# Script for running the gNB
cat > $HOME/run_gnb.sh<< EOF
#!/bin/bash
cd ~/srsRAN_Project/build/apps/gnb
sudo ./gnb -c /local/repository/config/gnb_zmq.yaml
EOF

# Script for running the UE
cat > $HOME/run_ue.sh<< EOF
#!/bin/bash
cd ~/srsRAN_4G/build/srsue/src/
sudo ./srsue /local/repository/config/ue_zmq.conf
EOF

# Script for uplink traffic test
cat > $HOME/uplink.sh<< EOF
#!/bin/bash
sudo ip netns exec ue1 ping 10.45.1.1
EOF

# Script for downlink traffic test
cat > $HOME/downlink.sh<< EOF
#!/bin/bash
# Downlink needs an additional route setup
if ! sudo ip netns exec ue1 ip route list default | grep "" &> /dev/null ; then
  sudo ip netns exec ue1 ip route add default via 10.45.1.1 dev tun_srsue
fi
ping 10.45.1.2
EOF

# Make all the scripts executable
chmod +x $HOME/*.sh

# Note that external (WAN) traffic doesn't work
# But that isn't really a problem for us
