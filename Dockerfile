FROM sumologic/collector
ADD sumo-sources.json /etc/sumo-sources.json
ENTRYPOINT ["/bin/bash", "run.sh"]
