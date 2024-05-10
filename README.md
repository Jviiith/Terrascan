## Terrascan Overview

* To scan a single file (**bash**): 
  - terrascan scan -f Terrascan/main.tf

* To scan an entire directory (**bash**):
   - terrascan scan -d ./Terrascan

### Terrascan Custom Policy

There are 3 json files that have been created in 'terrascan_custom_policy' folder under the 'Terrascan' folder. A policy file, Rego policy document & configuration file 

* terrascan scan --policy-path ./Terrascan/terrascan_custom_policy

> Notice:  --policy-path points to the directory where our custom rego policies live. 

