# **ANGEL**
ANGEL is a shell script designed for collecting various information from Android devices.

## **Testing in a Virtual Environment** <br/><br/>
To test ANGEL in a virtual environment, follow these steps:

### **1. Set Environment variable for adb**
![run](https://github.com/S3xyG4y/ANGEL/assets/55012702/11663704-1c85-41bb-986d-8a6f93b704e0)<br/>
press keyboard's "windows key" button and "r" button will pops up "run.exe" type sysdml.cpl<br/><br/>
![sysdm cpl image](https://github.com/S3xyG4y/ANGEL/assets/55012702/8c49a506-a5c6-4190-8c72-d874d68ef50e)<br/>
you can see system properties then get to the Advance tab<br/><br/>
![image](https://github.com/S3xyG4y/ANGEL/assets/55012702/68f73d4f-a4dd-405a-b4d4-b11e58586cee)<br/>
when you reached advanced tab press Environment Variables<br/><br/>
![sysdmcpl path](https://github.com/S3xyG4y/ANGEL/assets/55012702/643bb842-592c-4b8f-8040-e4d4def2ba08)<br/>
now select System variables's Path<br/><br/>
![image](https://github.com/S3xyG4y/ANGEL/assets/55012702/9ba154a5-e19f-4552-8a63-8967f6c5387a)<br/>
add your adb path ex) "C:\Users\yourusername\AppData\Local\Android\Sdk\platform-tools"<br/>
if you followed all step described above run adb on cmd if your terminal already executed exit that terminal then retry it<br/><br/>
### **2-1) Using Nox Player**
1) **Enable Root Access:** Ensure that the option to get Root privilege is enabled in Nox Player.<br/><br/>
![Nox-Root](https://github.com/S3xyG4y/ANGEL/assets/55012702/5655ff56-375b-4202-b507-c6d5375cbd2a)<br/>
2) **Connect Your Nox Player:** Establish a connection with your Nox player.<br/><br/>
![adb connect](https://github.com/S3xyG4y/ANGEL/assets/55012702/e9dd43ce-59ea-4fd8-9fb2-5640bb4d8401)<br/>
3) **Execute Shell:** Access the shell with root privileges.<br/><br/>
![shell access](https://github.com/S3xyG4y/ANGEL/assets/55012702/23b243e6-aa76-48f6-a033-9aa610b6065a)<br/>
### **2-2) Using Android Studio**
As shown above, you can access the shell with root access.

### **3. Check Your Environment's Architecture**
Determine the architecture of your environment.<br/>
![image](https://github.com/S3xyG4y/ANGEL/assets/55012702/2ff62415-eec0-49f4-a951-e988243087a4)<br/><br/>
```sh
getprop ro.product.cpu.abi
```
or
```sh
uname -m
```
For example, the output above indicates an x86 architecture.<br/>
### **4. Push the ANGEL Script**<br/>
![image](https://github.com/S3xyG4y/ANGEL/assets/55012702/2fb7ef9d-9d13-4a02-aaa8-e84c2e522cf3)<br/>
Push the ANGEL scripts and the Frida server to your environment. You can download the Frida server from following link: <br/> https://github.com/frida/frida/releases <br/>
### **5. Grant Permission**<br/>
![grant permission](https://github.com/S3xyG4y/ANGEL/assets/55012702/17bdbbc7-6103-4941-8814-4b1e0b9ba009)<br/><br/>

## **Disconnecting from the ADB Session:** <br/>
After completing your tasks using ADB, it's recommended to properly disconnect the session, especially when working with specific IP addresses and port numbers. To disconnect from an ADB session and if you want to ensure that all ADB processes are terminated and to reset the ADB server, use the following command:<br/><br/>
(Please note that the following command examples are based on the scenario where ADB was connected to a NOX Player. They demonstrate how to proceed with the disconnection in this specific context)<br/><br/>
![terminate](https://github.com/S3xyG4y/ANGEL/assets/55012702/fad4f679-f20b-4ef0-a5c9-a3be53ec9a74)<br/><br/>
```sh
adb disconnect 127.0.0.1:62001
```
and
```sh
shadb kill-server
```
**[*] Error handling**<br/><br/>
If you encounter issues where characters appear shattered after executing Android_main.sh, it may be due to the text type being CRLF instead of LF. In this case, you can convert the line endings using the following command: <br/><br/>
![sed](https://github.com/S3xyG4y/ANGEL/assets/55012702/cc9a3300-85ca-4f3f-bdee-7805685414ec)<br/><br/>
-command example-<br/>
```sh
sed -i 's/\r$//' [yourfilename]
```

(Detailed explanation is needed regarding the license and script)


## Contributing

Please read [CONTRIBUTING.md](https://github.com/S3xyG4y/ANGEL/blob/main/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.
