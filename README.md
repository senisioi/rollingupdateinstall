![Logo](logo.png)

# The OCCS rollingupdate tool install script

### Usage: <pre>sh create_stacks.sh admin-host-adress bearer haproxy-server-address</pre>
<ul>
<li>admin-host-adress is the OCCS admin node IP address or name</li>
<li>API token/bearer is the OCCS admin token / bearer</li>
<li>haproxy-server-address is the worked node IP address or name where the HAproxy Docker lives in as part of the stack</li>
</uL>

### API token / bearer can be found in OCCS here:
![Logo](bearer.png)


## Architecture

![Logo](installer1.png)

Rollingupdate tool installer creates two Dockers, the sample dockernode app stack for testing that runs in port 80 and the rollingupdate tool running in port 1000 that enables doing rolling updates visually against the OCCS instance and the sample application.

Rollingupdate tool uses both OCCS REST and the HAProxy socket in volume /tmp using the netcat ('nc') tool (A in the picture below). 

Rollingupdate tool can be used to do scaling in/out and rolling updates for any app stack that contain the HAproxy (B in the picture below). Sample config of the Oracle OCCS HAproxy <a href="https://github.com/mikarinneoracle/docker-images/blob/master/ContainerCloud/images/haproxy/haproxy.cfg.template_orig">here</a>.

It is also recommended the application uses sessions for session infinity and that HAproxy is configured properly to use them. The Dockers installed here use Node.js default sessions. Source code for the sample app <a href="https://github.com/mikarinneoracle/dockernode-app">here</a>. 

![Logo](installer.png)
