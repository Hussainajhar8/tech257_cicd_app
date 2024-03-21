# Jenkins Setup Guide
### Jenkins Diagram
![alt text](img/image-5.png)
#### Creating a Basic Job

1. Go to Jenkins and log in using your credentials.
2. Click on "New Item" to create a new job.
3. Select "Freestyle project" and click "OK".
   ![alt text](img/image.png)

#### Configuring Job Setting

1. Under the "General" section, select "Discard old builds".
2. Set "Max # of builds to keep" to 3 to manage server resources efficiently.
   ![alt text](img/image-1.png)

#### Defining Build Steps

1. In the "Build" section, select "Execute shell" from the drop-down menu.
2. Add the commands you want the job to run.

#### Running the Job

1. Save the job configuration.
2. Click on "Build Now" to execute the job.
3. To view the status and output of the build:
   - Go to the build history.
   - Click on the specific build.
   - Select "Console Output".
  ![alt text](img/image-2.png)

#### Connecting Jobs

1. Upon successful execution, create another job with different commands.
2. Connect the jobs by:
   - Clicking on "Add post-build action".
   - Selecting "Build other projects".
   - Choose the build you want to trigger upon the success of the former.
![alt text](img/image-3.png)
(This will run the "tech257-ajhar-testing-timezone" job upon successful build of this job.)

## Setting up Continuous Integration (CI) with Jenkins

#### Creating a CI Job

1. Create a new freestyle project in Jenkins.

#### Configuring Job Settings

1. In the "General" section, select "GitHub Project".
2. Insert the HTTPS git URL into the "Project URL".
   ![alt text](img/image-9.png)

#### Specifying Execution Environment

1. In the "Office 365 Connector" section, select "Restrict where this project can be run".
2. Choose "sparta-ubuntu-node" as the Label Expression to designate the agent node for running tests.
![alt text](img/image-11.png)

#### Configuring Source Code Management

1. In the "Source Code Management" section, select "Git".
2. Insert the SSH repo URL and secret key for Jenkins to use during CI when we push changes to the main branch.
   ![alt text](img/image-12.png)

#### Setting Build Triggers

1. In the "Build Triggers" section, select "GitHub hook trigger for GITScm polling".
   ![alt text](img/image-13.png)

#### Defining Build Steps

1. Enter the build script for executing tests.
2. Save the configuration.
   ![alt text](img/image-14.png)

#### Testing the CI Job

1. Execute a "Build Now" to ensure the tests are successful.
   ![alt text](img/image-15.png)

#### Adding Webhook to GitHub Repo

1. In the GitHub repository settings, navigate to "Webhooks".
2. In the "Payload URL" field, paste your Jenkins environment URL followed by "/github-webhook/".
3. Select "application/json" as the content type and leave the "Secret" field empty.
4. Choose "Just the push event" to trigger the pipeline when code is pushed.
5. Click on "Update/Create webhook" to save the changes.
   ![alt text](img/image-16.png)

#### Testing the CI Pipeline

1. Push the changes from your local machine to the GitHub repository.
2. Observe Jenkins running a build job for the changes pushed.
3. Successful execution indicates the successful setup of CI.

## Setting up CI Merge Job

#### Creating a Development Branch

1. Create a new branch called "dev".
   ![alt text](img/image-20.png)

#### Modifying CI Job Configuration

1. In the existing CI job, change the branch from "main" to "dev" in the configuration settings.
   ![alt text](img/image-21.png)

#### Creating CI Merge Job

1. Create a new freestyle project for the CI merge job.
2. Configure the job similar to the previous CI job.
3. Insert the project URL.
   ![alt text](img/image-22.png)

#### Specifying Execution Environment

1. Configure the `sparta_ubuntu_node` to run the CI merge job.

#### Configuring Source Code Management

1. Use the same source code management settings as the previous job.
2. Ensure it is configured to pull code from the "main" branch.
   ![alt text](img/image-23.png)

#### Defining Build Steps

1. Add a post-build script to merge the "dev" branch into the "main" branch.
   ![alt text](img/image-24.png)

#### Triggering Merge Job

1. Configure the CI job to trigger the merge job upon successful build.
   ![alt text](img/image-25.png)

#### Confirmation of Pipeline Functionality

After testing, it has been confirmed that the pipeline is functional and operational.
![alt text](img/image-27.png)

## Deploying the Application

To deploy the application, follow these steps:

1. **Create EC2 Instance:**
   - Launch a new EC2 instance on AWS.
     ![alt text](img/image-4.png)

2. **Set Up Jenkins Job:**
   - Create a new Jenkins job and insert the GitHub project URL.
     ![alt text](img/image-6.png)
   - Configure the source code management, providing the private key for accessing our repository.
     ![alt text](img/image-7.png)

3. **Configure Build Environment:**
   - Set up an SSH agent in the build environment.
   - Provide the PEM file for Jenkins to access the EC2 instance.
     ![alt text](img/image-8.png)

4. **Build Process:**
   - In the build section, add commands for Jenkins to set up an Nginx server on the EC2 instance.
     ![alt text](img/image-10.png)

5. **Verify Deployment:**
   - After the build process, access the IP address of the EC2 instance to ensure that the default webpage is displayed.
     ![alt text](img/image-17.png)

## Setting Up Application on Port 3000

To configure our application to run on port 3000, follow these steps:

1. **Update Application and Environment:**
   - Ensure that the latest version of the application and environment folder is available on our VM.
   - Use the `rsync` command in the "ajhar-cd" job script in Jenkins to synchronize the folders.
   ![alt text](img/image-18.png)

2. **SSH into EC2 Instance:**
   - Use SSH to connect to the EC2 instance:
     ```bash
     ssh -i "tech257.pem" ubuntu@ec2-18-201-139-145.eu-west-1.compute.amazonaws.com
     ```

3. **Navigate to Script Folder:**
   - Change directory to the script folder, set permissions, and execute the script:
     ```bash
     cd environment/app
     chmod +x provision.sh
     ./provision.sh
     ```
     ![alt text](img/image-19.png)

4. **Install Dependencies and Start Application:**
   - After the script execution, navigate to the app folder install npm dependencies then start npm:
     ```bash
     cd ~/app
     npm install
     npm start
     ```
     ![alt text](img/image-29.png)

6. **Access Application:**
   - Verify that the application is accessible at port 3000.
   ![alt text](img/image-30.png)

7. **Automate with Jenkins:**
   - Once the manual process is confirmed to work, integrate these steps into our Jenkins shell script.
   ![alt text](img/image-31.png)

