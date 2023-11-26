# ANGEL
ANGEL is a shell script designed for collecting various information from Android devices.

##**Testing in a Virtual Environment**##<br/><br/>
To test ANGEL in a virtual environment, follow these steps:

1. Using Nox Player
1. Enable Root Access: Ensure that the option to get Root privilege is enabled in Nox Player.<br/><br/>

![Nox-Root](https://github.com/S3xyG4y/ANGEL/assets/55012702/5655ff56-375b-4202-b507-c6d5375cbd2a)<br/>

2. Connect Your Nox Player: Establish a connection with your Nox player.<br/><br/>
![adb connect](https://github.com/S3xyG4y/ANGEL/assets/55012702/e9dd43ce-59ea-4fd8-9fb2-5640bb4d8401)<br/>

3. Execute Shell: Access the shell with root privileges.<br/><br/>
![shell access](https://github.com/S3xyG4y/ANGEL/assets/55012702/23b243e6-aa76-48f6-a033-9aa610b6065a)<br/>

As shown above, you can access the shell with root access.

2. Check Your Environment's Architecture
Determine the architecture of your environment.<br/><br/>
![image](https://github.com/S3xyG4y/ANGEL/assets/55012702/2ff62415-eec0-49f4-a951-e988243087a4)<br/>
For example, the output above indicates an x86 architecture.<br/>
3. Push the ANGEL Script<br/><br/>
![image](https://github.com/S3xyG4y/ANGEL/assets/55012702/2fb7ef9d-9d13-4a02-aaa8-e84c2e522cf3)<br/>
Push the ANGEL scripts and the Frida server to your environment. You can download the Frida server from https://github.com/frida/frida/releases <br/>
4. Grant Permission<br/>
![grant permission](https://github.com/S3xyG4y/ANGEL/assets/55012702/17bdbbc7-6103-4941-8814-4b1e0b9ba009)<br/>
[*] Error handling - If you encounter issues where characters appear shattered after executing Android_main.sh, it may be due to the text type being CRLF instead of LF. In this case, you can convert the line endings using the following command: <br/>
![sed](https://github.com/S3xyG4y/ANGEL/assets/55012702/cc9a3300-85ca-4f3f-bdee-7805685414ec)<br/>
-command example-<br/>
sed -i 's/\r$//' [yourfilename]<br/>

(Detailed explanation is needed regarding the license and script)


