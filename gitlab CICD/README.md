## Runner Notes
1. Get token and url from gitlab url > settings > CICD > runners.
2. Register with the command ```docker run --rm -it -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register```.
3. Input required values.
4. Chooese executor.
5. Disable the shared runners for the project if you want to run tag specific execution. 
6. Update the the **gitlab-ci.yml** file as required.
7. Run the runner. 
```
docker run -d  --name gitlab-runner --restart always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  gitlab/gitlab-runner:latest
```
``` -v /var/run/docker.sock:/var/run/docker.sock``` volume is mounted to use host docker if docker executor was chosen.  ```-v /srv/gitlab-runner/config:/etc/gitlab-runner``` is mounted so that the runner config file is stored in the host in ```/srv/gitlab-runner/config``` directory.
