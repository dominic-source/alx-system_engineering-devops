**Here is writeup of a postmortem**

### Issue Summary:
From 6:00 am to 12:16 pm, GMT+1, January 14 2020 requests to the server at the facility resulted in a 500-response error message. No department in the facility was able to function normally because they depended on the network from the server. The staff experienced difficulty and time wastage trying to reload their web browsers. 100% of the departments in the facility could not use the system. The root cause was the power outage at the server room which resulted from an inverter that became faulty as a result of a thunderstorm from the prior day.


### Timeline:
- 8:20 am: a staff received a 500-response error after sending
- a request.
- 8:22 am: staff sends complaints to the support engineer who addresses and investigates the issue.
- 8:25 am: the server room was investigated, and it was found to be down on power.
- 8:27 am: the server was powered on but it didn’t come on and the inverter was investigated and found to be problematic.
- 8:30 am: the issue was escalated to Tier 2 support and inverter vendors.
- 12:16 pm: the inverter vendor retrieved the inverter and replaced it with a new one.

 
### Root cause and resolution:
- At 8:22 am GMT+1, the staff gave a call to the support engineer who investigated and quickly escalated the issue. By 8:30 am the inverter was investigated and was found to have issues turning on. Since there was a heavy thunderstorm the previous day, it was speculated that the inverter was overloaded with electrical discharges from the lightning.
- At 8:35 am, we attempted to restart the inverted and it came back on but went off again. The Tier 2 engineers invited the inverter vendor for a quick replacement and at 12:16 pm, the inverter was replaced and the issue was resolved.
- We passed the information to all the departments that the server is now accessible and by 1 pm 70% of the facility began to use the system while the other 30% started using it by 8:00 am the next day.


### Corrective and preventative measures:
In the last 2 days, we have conducted an internal review of the downtime. The following are the actions we are taking to address the underlying issue and to help prevent reoccurrence and improve staff experience of the system:
- Replacing the inverter with another functional inverter.
- Sending the faulty inverter for repairs and following it up.
- Ensuring that the inverters in all other departments are properly earthed.
- Encouraging staff to always report issues immediately after they are noticed.
- Developing a better workflow for inviting the vendors to ensure they arrive on time.


