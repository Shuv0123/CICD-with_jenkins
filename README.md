# CICD-with_jenkins
## What is Continuous integration (CI) Continuous Delivery (CD) and Continuous Deployment (CDE)?

- CI/CD is a method used to frequently deliver apps to customers by introducing automation into the stages of app development. It is considered the backbone of DevOps practices and automation.

## Continuous integration (CI)
- Continuous integration (CI) is practice that involves developers making small changes and checks to their code. Developers merge code to main branch multiple times a day and there is an automated build and test process which gives instant feedback.
    - faster software builds
    - customer satisfaction by deploying on time
    - small code changes make fault isolation simpler and quicker
    - improve software build

## Continuous Delivery (CD)
- Continuous delivery (CD) is an extension of continuous integration. It makes sure you can release new changes to your customers quickly as it automates the release process so you can deploy the application at any time by just clicking a button. In continuous Delivery the deployment is completed manually.

## Continuous Deployment (CDE)
- CDE we go one step further than continuous delivery by deploying to our customers after every development change. There is no human intervention in CDE, unlike continuous delivery, no button has to be pressed to deploy the application. Only a failed test will prevent a new change being deployed to production.

## CD VS CDE
- Continuous integration forms a part of both continuous delivery and continuous deployment.

- In continuous delivery the deployment is done manually and in continuous deployment it happens automatically.

## What is Jenkins? 

- Jenkins is an open source automation server. It helps automate the parts of software development related to building, testing, and deploying, facilitating continuous integration and continuous delivery.

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
## Add key to private key to repository
- From Github make your way to the repository that you want to deploy a key with
- Click on 'Settings'
   - 'Deploy key'
   - 'Add key'
   - Paste the private key

## Connect GitHub repository to Jenkins
