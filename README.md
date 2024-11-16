# Simple-Perforce-Discord-Integration
Simple bash script Perforce Discord integration. Easy to implement for AWS Perforce servers.  

This integration uses deliberately only bash and only commands available on most UNIX and Linux systems, in order to avoid doing any additional setup on P4 servers. This makes it especially helpful if using an AWS P4 server.  

Includes character escaping for common cases like quotes and newlines.  


Resulting Discord notification should look like this:

![2024-11-16 10_26_48-#perforce _  - Discord](https://github.com/user-attachments/assets/b46ab9a7-895e-4035-9b3a-e12ffdd30fbd)

## Setup
1. Create a webhook in your Discord channel. Right click the channel > Edit Channel > Integrations > Webhooks > New webhook
2. Copy the webhook URL to where it says ```"YOUR WEBHOOK HERE"``` in the bash script
3. Save the bash script somewhere in your P4 Depot, note the file
4. (You must have Superuser permissions to do this.) In a terminal, while logged into the needed p4 session, do
   ```
   p4 triggers
   ```
  
5. At the end of the file, add
   ```
   submit_webhook change-commit "bash %//depot//<PATH RELATIVE TO DEPOT TO THE SHELLSCRIPT>% %changelist% %user%"
   ```
6. Save and exit.

## Sources  

Setup basics and advanced techniques: https://blog.sweettastebuds.com/posts/integrating-discord-with-perforce/  

Escape strings for json: https://stackoverflow.com/questions/10053678/escaping-characters-in-bash-for-json


