# Installing Airflow Without Docker

Installing Airflow without using Docker requires WSL, as well as an ubuntu distro.

I followed the instructions on [this website](https://www.astronomer.io/guides/airflow-wsl/) as well as the [official Airflow Quick-Start guide](https://airflow.apache.org/docs/apache-airflow/stable/start.html), but I did run into a few errors along the way.

## Step by step install guide

> N.B. at any point if something doesn't work as intended, try completely restarting Ubuntu by going into powershell and running `wsl --shutdown`, then reopening Ubuntu

1. Installing WSL is as easy as opening a PowerShell terminal as administrator and typing `wsl --install`. If WSL help text appears, WSL is already installed and nothing else needs to be done.
2. The Ubuntu distribution for WSL can be downloaded from the Microsoft Store - just search for 'Ubuntu' and it's the first option.
3. Open Ubuntu (either from the store or by searching for it in the start menu) and follow the set up instructions. Make sure to rememebr your username and password; you will need it for running a lot of commands during this process.
4. In Ubuntu, run `sudo apt update && sudo apt upgrade` to make sure everything is up to date.
5. If you want to check that everything is correct so far, you can run `pwd`, and you should see `/home/<user_name>`. You can also type `ls -a` and you should see a file called `.bashrc` - This is used for changing environment variables and is necessary for running Airflow!
6. In order to access your Windows files easily in WSL, type `sudo nano /etc/wsl.conf` which will open a text editor in the terminal. Add or change the following lines:

   ```console
   [automount]
   root = /
   options = "metadata"
   ```

7. Hit `ctrl + s` and `ctrl + x` to save and exit the text editor.
8. Now, if we type `ls /`, we should be able to see a directory called `c` that contains our `C:/` drive!
9. Confirm you have python installed by typing `python3 --version`.
10. Install pip by running `sudo apt update` and `sudo apt install python3-pip`.
11. To check pip has installed correctly, run `pip3 --version`.
12. Now it's time to actually install Airflow! Run `export AIRFLOW_HOME=/c/Users/<user_name>/airflow`. Note that `<user_name>` here refers to your Windows username, in most peoples' case it will be firstnamelastname.
13. Run `nano ~/.bashrc`. This should open up the text editor. Here we are going to add the same line as above, so that the top of this file should look like this:

   ```console
   # ~/.bashrc: executed by bash(1) for non-login shells.
   # see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
   # for examples

   export AIRFLOW_HOME=/c/Users/<user_name>/airflow
   ```

14. Hit `ctrl + s` and `ctrl + x` to save and exit the text editor.
15. Run `AIRFLOW_VERSION=2.4.0`.
16. Run `python3 --version`. Remember what this says!
17. Run `PYTHON_VERSION=X.X` Where X is the beginning of your python version. In my case, `python3 --version` returned `3.10.4`, so I'm running `PYTHON_VERSION=3.10`.
18. Run `CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"`.
19. Finally, run `pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"`. This should install Airflow! If it errors, the likely reason is the constraints URL. Following the URL and replacing `${AIRFLOW_VERSION}` with 2.4.0, and `${PYTHON_VERSION}` with your major python distribution (in my case 3.10), you should get a json that looks like [this](https://raw.githubusercontent.com/apache/airflow/constraints-2.4.0/constraints-3.10.txt).

## Step by step guide to run Airflow

1. In your Ubuntu terminal, running `airflow standalone` should start all of the necessary components of Airflow.
2. After this command runs, you should see something that looks like this ![Airflow login details](images/airflow-login.png)
3. Copy this password! You will need it to sign in to Airflow!
4. Short side note here - To stop Airflow running, I've found that just spamming `ctrl + c` in the Ubuntu window works well...
5. With Airflow running, in your web browser visit `localhost:8080`. Login with the details provided in the terminal and congrats, you've set up an Airflow instance!