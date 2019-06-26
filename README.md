# grin-node
Dockerized node for the Grin cryptocurrency

# Launching node
docker run -it --name grin-node --expose 3413-3415 -p 3415 -v grin-node-data:/data grin-node
# Launching the a wallet container from the same image, assuming node container is running
docker run -it --name grin-wallet --network="container:grin-node" -v grin-node-data:/data --entrypoint "/bin/sh" grin-node

# copying wallet files & blockchain
docker cp grin-node:/data ./
