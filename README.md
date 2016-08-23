#SumoKube  ![Alt text](/sumokube_small.jpg?raw=true "SumoKube") 
Sumo Logic daemon set for Kubernetes

## Get started
There are a few different moving parts in the configuration.  First, you need to go to Sumo Logic and generate some credentials.  Click on your name in the upper right hand corner, then select Preferences.  Click on the + next to My Access Keys and add a key.  You get shown this once, so save it in LastPass or someplace secure.   

Next, you need to add your credentials to the sumokube.yaml file where the xxxxx's are.  You'll notice that the image in there is jsingerdumars/sumokube:latest which will work, but you can also create your own image with the included Dockerfile.  

## Installing the daemon set in your cluster (and a few tweaks)
We assume at this point you have an up and running Kubernetes cluster and that /var/log/containers setup with symlinks to logs under /var/lib/docker/containers.  Before installing the daemon set, there are a few things you might want to customize.  First, it is configured to run in the default namespace, and you may prefer to put it in its own.  Just change the line in the sumokube.yaml file.  Another change you might want to make is adjusting the category name in the sumo-sources.json so it is specific to the cluster you are working with.  Now, if you do this, you'll need to build your own Docker image specific to that cluster.  Lastly, you can make the service account name different too.  But whatever you choose needs to be consistent between the two yaml files.  

Step one: build the service account  
```kubectl create -f sumokube-service.yaml```

Step two: install the daemon set  
```kubectl create -f sumokube.yaml```  

You're done.  Now data should be flowing to your Sumo Logic account.  

## Viewing data in Sumo
You can search for data with the string ```_source=kubernetes```. You can see what collectors are configured by selecting _Collection_ from the _Manage_ menu.  You'll notice that each node has a collector, and that the name is unique.  When nodes are added or destroyed, you should periodically delete defunct collectors.  Be very careful deleting these because there's no undo!  
