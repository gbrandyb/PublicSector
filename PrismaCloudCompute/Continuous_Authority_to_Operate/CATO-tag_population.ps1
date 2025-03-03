# CATO-tag_population.ps1
#
# This script uses the output CSV generated but the CATO-collection_query.ps1 script as input.
# An ATO Auditor makes the determination of what Tag they want to associate with each CVE.
# The CVS file is then used as input for this script to associate CVEs to Tags within the Console
#
# Prerequisites: 
#   1 - Create Tags within the Console that the vulnerabilities will be associated to. 
#   2 - Update the "Tag" column for every vulnerability with the Tag name in the CSV generated by the CATO-collection_query.ps1 script

# Logic: 
#   1 - Reads in the CSV supplied as command lime argument
#   2 - Associates CVEs to Tags
#
# Updates: 
#   20201022 - Works with v20.09 API and CSV output has been modified to work with bulk_tagger.py python script - https://github.com/twistlock/sample-code/blob/f01089aa7a0b00f025397618ebb3de97e60d70ba/computeAPI/cve_tags/bulk_tagger.py
#
# Requires: powershell v6 https://blogs.msdn.microsoft.com/powershell/2018/01/10/powershell-core-6-0-generally-available-ga-and-supported/
# Discalimer: Use of this script does not imply any rights to Palo Alto Networks products and/or services.
#
# Debugging: $debugpreference = "continue" at the powershell command prompt for detailed output of the script 

param($arg1)
if(!$arg1)
    {
    write-host "Please provide an input CSV"
    write-host "Usage: ./CATO-tag_population.ps1 <name csv input file>"
    exit
    }
else 
    {
    write-host "Importing $arg1"
    }

# variables
$tlconsole = "https://console-master-alonzo.gbrandyburg.demo.twistlock.com"
$i = 0

#import CSV file
$cves = Import-csv $arg1
$debug_output = "Number of CVEs importing " + $cves.length
write-debug $debug_output

# We will need credentials to connect so we will ask the user
$cred = Get-Credential

# go through the list and assign tags
foreach($cve in $cves)
    {
    $i++
    $debug_output = $cve.cve + "|" + $cve.packageName + "|" + $cve.tag
    write-debug $debug_output

    # build the json payload for the API call            
    $tag_post_payload = @{
    "id" = $cve.cve
    "packageName" = $cve.packageName
    }

    # convert to json
    $json_payload = $tag_post_payload| ConvertTo-Json -Depth 4 
    write-debug $json_payload

    # build the post URL
    $request = "$tlconsole/api/v1/tags/"+$cve.tag+"/vuln"
    write-debug $request
    $header = @{"Content-Type" = "application/json"}
    $return = Invoke-RestMethod $request -Authentication Basic -Credential $cred -AllowUnencryptedAuthentication -SkipCertificateCheck -Method "Post" -Header $header -Body $json_payload
    } # end of foreach input of each CVE

write-host "Associated $i CVEs to Tags"
