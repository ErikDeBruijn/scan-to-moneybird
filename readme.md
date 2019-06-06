What is the purpose of Scan-to-moneybird?
=========================================

Make paying bills as frictionless as possible.

It's a very basic system that can be used to monitor a folder and when a file is found in this folder it will be uploaded as a generic document to a Moneybird financial administration. From there it can be further analysed and you can make the corresponding payments, etc.

I use it to scan documents straight into to Moneybird.

How does it work?
=================

1. Automator monitors the designated folder
1. scan.rb is ran with the file as parameter
1. The upload is performed by scan.rb by running a rest call.
1. scan.rb moves your scanned file into a folder you configured.

Setup
=====

1. Create your Moneybird token, only document access is needed. You should create a token per administration.
1. Find your administration in the URL of Moneybird.
1. Create a `.env` file called `.foobar.env` if you company is named Foo Bar. Include at least these variables:
```
MONEYBIRD_TOKEN=c94747b2c470434747b2b2c447b2c4a6a043de47b2c4a6a91cc
MONEYBIRD_ADMINISTRATION=123123123123123123
FINISHED_PATH="/path/to/Documents/uploaded_to_moneybird"
```
1. Ensure this the `FINISHED_PATH` path exists.
1. Mac OS X comes with Automator, which has a special "Folder Action" when you choose File --> New. You can select a folder and when a file is stored in it, it will run things for you. Create a new folder action in this way.
1. From `Utilities`, add a shell script. Set it up so it passes input as a parameter and make it use `bash`.
1. cd /path/to/scan-to-moneybird/
1. `bundle`
1. I use a script as follows, copy and paste this into the box and modify to reflect your setup:
```
cd /path/to/scan-to-moneybird/
export PATH=/Users/username/.rbenv/shims:/Users/username/.rbenv/bin:/usr/local/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/username/.rvm/bin

for f in "$@"
do
  echo $f
  echo "-------- " >> output.log
  date "+DATE: %Y-%m-%d%nTIME: %H:%M:%S" >> output.log
  /path/to/scan-to-moneybird/scan.rb foobar $f | tee -a output.log
done
```
1. Save the automator workflow.
1. Test it by dropping a PDF into the folder. It should disappear. For debugging purposes, you can look in `/path/to/scan-to-moneybird/` to figure out what happened if it doesn't show up.

Contributing
============

Please be gentile, I wrote this as quickly as I could!

Contributions are welcome. Feel free to submit a Pull Request through github! I hope this is helpful to you.