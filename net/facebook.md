https://www.facebook.com/peering

ASNs	AS32934 & AS63293

CIDRs are from uniq second column of "Advertisements that are fragments of the original RIR allocation (more specifics) originated by this AS.":

https://www.cidr-report.org/cgi-bin/as-report?as=AS63293&view=2.0

https://www.cidr-report.org/cgi-bin/as-report?as=AS32934&view=2.0

```
# awk '{print "ip route", $2, "%GW%";}' fb.nets | sort | uniq
ip route 102.132.96.0/19 %GW%
ip route 102.221.188.0/22 %GW%
ip route 129.134.0.0/16 %GW%
ip route 157.240.0.0/16 %GW%
ip route 173.252.64.0/18 %GW%
ip route 179.60.192.0/22 %GW%
ip route 185.60.216.0/22 %GW%
ip route 185.89.216.0/22 %GW%
ip route 31.13.64.0/18 %GW%
ip route 66.220.144.0/20 %GW%
ip route 69.171.224.0/19 %GW%
ip route 69.63.176.0/20 %GW%
```
WhatsApp is also on these networks :-) Have fun ;-)
