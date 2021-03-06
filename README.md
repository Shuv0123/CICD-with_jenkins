# CICD-with_jenkins

![](images/CICD.png)

## What is Continuous integration (CI) Continuous Delivery (CD) and Continuous Deployment (CDE)?

- CI/CD is a method used to frequently deliver apps to customers by introducing automation into the stages of app development. It is considered the backbone of DevOps practices and automation.

## Continuous integration (CI)

- In Continuous integration (CI) developers commits and is practice that involves developers making small changes and checks to their code. Developers merge code to main branch multiple times a day and there is an automated build and test process which gives instant feedback.
    - faster software builds
    - customer satisfaction by deploying on time
    - small code changes make fault isolation simpler and quicker
    - improve software build
- Before when developers used to create apps, they would work long extensive periods, before they committed their codes. However this practice caused a lot of problem when it came to merging, which is called a merge hell. To avoid this now developers have adopted the CI method.

![](images/CI_jenkins.png)

## Continuous Delivery (CD)
- Continuous delivery (CD) is an extension of continuous integration. It makes sure you can release new changes to your customers quickly as it automates the release process so you can deploy the application at any time by just clicking a button. In continuous Delivery the deployment is completed manually.

## Continuous Deployment (CDE)
- CDE we go one step further than continuous delivery by deploying to our customers after every development change. There is no human intervention in CDE, unlike continuous delivery, no button has to be pressed to deploy the application. Only a failed test will prevent a new change being deployed to production.

## CD VS CDE
- Continuous integration forms a part of both continuous delivery and continuous deployment.

- In continuous delivery the deployment is done manually and in continuous deployment it happens automatically.

## Webhook?


# master vs agent
one master multiple agent
agent test code 
master schedule job

## What is Jenkins? 

- Jenkins is an open source automation server. It helps automate the parts of software development related to building, testing, and deploying, facilitating continuous integration and continuous delivery.


### Secure connection between GitHub and Localhost
- First step in a jenkins pipeline is to make it end to end secure
- Create a ssh connection from our localhost to GitHub (ssh -secure shell)
- Generate new ssh key pair on our localhost
- Deploy the public key to GitHub account 
- Test the ssh connection

### Secure connection between jenkins and github
- Generate new ssh key pair on our localhost
- Deploy the public key to GitHub repo (repo -> settings -> deploy keys -> add the public key)
- Deploy the private key to jenkins

## .pub and private keys (SSH keys) SET-UP
- Open GitBash as an admin
- cd .ssh
- Enter ssh-keygen -t rsa -b 4096 -C "your GitHub Email"
   - The following prompt "Enter a file in which to save the key (/Users/you/.ssh/id_rsa):" Enter file name
   - No passphrase - hit enter
- Access the public key - "cat eng110_shuvo.pub" -and copy the key
- Go on GitHub and click on your profile 
- Scroll down to settings 
- On the left CLick on SSH and GPG keys
- Press on new SSH key paste the content of your eng110_shuvo.pub file

## Connect GitHub repository to Jenkins
- Open GitBash as an admin
- cd .ssh
- Enter ssh-keygen -t rsa -b 4096 -C "your GitHub Email"
   - The following prompt "Enter a file in which to save the key (/Users/you/.ssh/id_rsa):" Enter file name
   - No passphrase - hit enter
- Go to github repository
- Click on 'Settings'
   - 'Deploy key'
   - 'Add key'
   - Paste the private key
- On Jenkins, create a build.
- Tick Discard old builds. Max # of builds to keep = 3.
- GitHub project - use the http link NOT ssh.
- Tick restrict where this project can be run.
- For Label Expression, type in sparta-ubuntu-node (might need to press backspace and fiddle around with it until it recognises the label).
- For Source Code Management, choose Git.
- For Repository URL, choose the repository's SSH link.
- Run this command on the private key generated: clip < ~/.ssh/eng110_cicd_shuvo.
- Credientials: add a new key.
- Choose SSH Keys. Give it the same name as your private key (for example eng110_cicd_shuvo).
- Paste the private key's contents into the box.
- Make sure it is */main and not */master
- Tick Provide Node & npm bin/ folder to PATH
- Go to build - execute shell
- Type in these commands - make sure the path to your app folder is right:
   - cd app
   - npm install
   - npm test

## Webhook set-up between GitHub and Jenkins
A webhook is kinda like an API but instead of being triggered by request, it's triggered by events events/actions. APIs are used so that two apps can communicate with each other. Whereas, Webhooks are used to transfer data between two programs as soon as aparticular event takes place.
- On Jenkins select `Configure` for your build
- Under `Build Triggers`, select `GitHub hook trigger for GITScm polling`
- On Github, in your repository select `settings`
- Select `Webhook` from the menu on the left side
- Select `Add new`
- Enter the payload URL eg. `http://ipaddress:port/github-webhook/`
- Select `application/json` from the drop down menu
- Check `Send me everything`
- Test webhook by pushing a commit to your GitHub repository. This should automatically trigger the Jenkins job to run

# CI Task

![](images/continuous_integration.png)

## Job 1

- Click on `Create new build`
- Name the build
- Check `Discard old builds` and choose `3` as the `Max # of builds to keep`
- Check `GitHub project` and paste your repository's URL HTTPS format
- Check `Restrict where this project can be run` (sparta-ubuntu-node)
- Check `Git.` Link your GitHub repository again (SSH format)
- Choose the right `private key` to unlock the repository's `public key`
- Choose `*/dev` in branch
- Select `GithHub hook trigger`
- Select `Provide Node & npm bin/ folder to PATH.\`
- Go to Build, and choose `Execute shell`, set up with these commands:
    - `cd app`
    - `npm install`
    - `npm test`
- For Post-build Actions, choose Job 2 in Build other projects (which will be created next)
- Click `save`

## Job 2 

- Click on `Create new build`
- Name the build
- Select the `GitHub settings` again and `Discard old builds`
- For branch, choose `*/dev` because we are working in the dev branch
- Select `Additional Behaviours`
   - add `origin` for `Name of repository`
   - add `main` as Branch to merge to
- select `Post-Build Actions` and name it `Job 3`
- In `Post-Build-Actions` select `Git Publisher`
   - tick `Push only if build succeeds and Merge results`
- Click `save`

## Job 3

- Click on `Create new build`
- Name the build
- Check `Discard old builds` and choose `3` as the `Max # of builds to keep`
- Check `GitHub project` and paste your repository's URL HTTPS format
- Check `Restrict where this project can be run` (sparta-ubuntu-node)
- Check `Git.` Link your GitHub repository again (SSH format)
- Choose the right `private key` to unlock the repository's `public key`
- Choose `*/main` in branch
- SSH Agent: choose the private key to unlock the EC2 instance's public key.



Now we need to by pass the key asking stage with below command:
`ssh -A -o "StrictHostKeyChecking=no" ubuntu@ec2-ip << EOF`
- copy the the code
- run your provision.sh to install node with required dependencies for app instance - same goes for db instance (ensure to double check if node and db are actively running)
- create an env to connect to db
- navigate to app folder
- kill any existing pm2 process just in case
- launch the app
nohup node app.js > /dev/null 2>&1 & - use this command to run node app in the background
- To debug ssh into your ec2 and run the above commands

- Run these commands under Execute shell:

```bash
    
EOF

# ssh into ec2
# update upgrade, run the provisioning script or install nginx to test
# scp to copy data from github to ec2
ssh -A -o "StrictHostKeyChecking=no" ubuntu@54.246.60.105 << EOF
#export DB_HOST=mongodb://54.75.96.210:27017/posts
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo systemctl restart nginx
sudo systemctl enable nginx
scp -
cd app/app/
sudo chmod +x provision.sh
sudo /.provision.sh
cd app
npm install
npm start
```
- SPin an EC2 instance and use these security group:

![](images/security_group.png)


```bash
rsync -avz -e "ssh -o StrictHostKeyChecking=no" app ubuntu@ec2-52-50-217-189.eu-west-1.compute.amazonaws.com:~/.
ssh -A -o "StrictHostKeyChecking=no" ubuntu@52.50.217.189 << EOF
     
     sudo apt-get update -y
     sudo apt-get upgrade -y
     sudo apt-get install nginx -y
     sudo systemctl restart nginx
     sudo systemctl enable nginx
EOF
```

```bash
ssh -A -o "StrictHostKeyChecking=no" ubuntu@52.208.45.1 << EOF
       sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
       echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
       sudo apt update -y
       sudo apt upgrade -y
       #sudo apt install mongodb-org -y
       sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20
       sudo systemctl start mongod
       sudo systemctl enable mongod
       #sudo rm /etc/mongod.conf
       #sudo cp /home/ubuntu/app/extra/mongod.config /etc/mongod.conf
       sudo chown ubuntu: /etc/.
       sed '24d' /etc/mongod.conf -i
       awk 'NR==24{print "  bindIp: 0.0.0.0"}7' /etc/mongod.conf > change && mv change /etc/mongod.conf
       sudo chown root: /etc/.
       sudo systemctl restart mongod
       sudo systemctl enable mongod
EOF


rsync -avz -e "ssh -o StrictHostKeyChecking=no" app ec2-54-170-166-130.eu-west-1.compute.amazonaws.com:~/.
ssh -A -o "StrictHostKeyChecking=no" ubuntu@54.170.166.130 << EOF
         sudo apt-get update -y
         sudo apt-get upgrade -y
         sudo apt-get install nginx -y
         sudo systemctl restart nginx 
         sudo systemctl enable nginx
         #sudo rm /etc/nginx/sites-available/default
         #sudo cp /home/ubuntu/app/extra/nginx.default /etc/nginx/sites-available/default
         #sudo systemctl reload nginx
         #sudo systemctl restart nginx
         #sudo systemctl enable nginx
         cd app
         sudo apt install software-properties-common -y
         curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
         sudo apt update -y
         sudo apt upgrade -y
         sudo apt install -y nodejs
         sudo apt update -y
         sudo apt upgrade -y
         export DB_HOST=mongodb://52.208.45.1:27017/posts
         #sudo echo "export DB_HOST=mongodb://34.248.61.128:27017/posts" >> ~/.profile
         #source ~/.bashrc
         #source ~/.profile
         sudo node seeds/seed.js
         npm install
         nohup node app.js > /tmp/logs 2>&1 &
EOF
```
with the command `rsync -avz -e "ssh -o StrictHostKeyChecking=no" app ec2-54-170-166-130.eu-west-1.compute.amazonaws.com:~/.` we do not need to specify the pem file because jenkins has already access. The rsync command takes the app folder from the GitHub repository and transfers it to the ec2 instance.

## Why do we need agent node, can't we run the test on the master node?
- This is because of the risk attached to it, if master node breaks due to the increase in load this would break the CICD pipeline. The master nodes has the coades to deploy things on the cloud. If the agent node breaks we still have the master node to facilitate the service. When a test pass, the agent node would notify the master node and it would accept the changes to then deliver them on aws. However, if the test fail, no acction will be taken by the master node and the feedback goes back to whiever wrote the test. everytime something does not work the feedback is sent back.

## Jenkins server set-up
Jenkin server with 1 master and 1 agent node:

- Given that private and public key exist already (eng119) otherwise create key pairs.
- resources used: 
   -  https://www.hostinger.co.uk/tutorials/how-to-install-jenkins-on-ubuntu/

### Create EC2 instance to host Jenkins
- create an EC2 instance on aws

- allow port 22, 80, and 8080 from anywhere IPv4

- SSH into the controller

- update & upgrade
- install java v11 `sudo apt-get install fontconfig openjdk-11-jre`
- `wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -`
- `sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'`
- `sudo apt-get update`
- `sudo apt-get install jenkins`
- copy admin password to set up jenkins `cat /var/lib/jenkins/secrets/initialAdminPassword`
- connect to http://<your_server_public_DNS>:8080
- paste admin password to set up jenkins
![](images/jenkins_unlock.png)

- isntall the plug ins you want

### setup agent node
- create an EC2 instance that is going to host the agent node 
- allow port 22, 80, and 8080 from anywhere IPv4

- SSH into the controller

- update & upgrade
- install java v11 `sudo apt-get install fontconfig openjdk-11-jre`
- Go back to the jenkin server `http://<your_server_public_DNS>:8080` 
- `add New Node`
- remote root directory: `/home/ubuntu`
- Host: <agent instance IP>

- choose key

- add new key
- Kind: `SSH Username with private key`
- Username: `ubuntu`
- Private Key: <enter directly>
- Host Key Verification Strategy: `Non verifying Verification Strategy`

- When running jobs, specify to run on agent nodes






