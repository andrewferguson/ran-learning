# Adapted from the small-lan profile

# Import the Portal object.
import geni.portal as portal
# Import the ProtoGENI library.
import geni.rspec.pg as pg
# Emulab specific extensions.
import geni.rspec.emulab as emulab

# Create a portal context, needed to defined parameters
pc = portal.Context()

# Create a Request object to start building the RSpec.
request = pc.makeRequestRSpec()

# Pick your OS.
os_image = 'urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU24-64-STD'

# Optional physical type for all nodes.
pc.defineParameter("phystype",  "Optional physical node type",
                   portal.ParameterType.NODETYPE, "",
                   longDescription="Pick a single physical node type (pc3000,d710,etc) " +
                   "instead of letting the resource mapper choose for you.")

# Retrieve the values the user specifies during instantiation.
params = pc.bindParameters()

# Check parameter validity.
if params.phystype != "":
    tokens = params.phystype.split(",")
    if len(tokens) != 1:
        pc.reportError(portal.ParameterError("Only a single type is allowed", ["phystype"]))

pc.verifyParameters()

# Create link/lan.
lan = request.LAN()

# Create a node and add it to the request
node = request.RawPC("srsRAN")
node.disk_image = os_image
# Add to lan
iface = node.addInterface("eth1")
lan.addInterface(iface)
# Optional hardware type.
if params.phystype != "":
    node.hardware_type = params.phystype

# Run the srsRAN setup script
node.addService(pg.Execute(shell="bash", command="/local/repository/scripts/setup_srsran.sh"))

# Print the RSpec to the enclosing page.
pc.printRequestRSpec(request)
