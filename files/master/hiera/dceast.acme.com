---
ntp::servers:
  - "ntpwest1.acme.com"
  - "ntpwest2.acme.com"
  - "ntpwest3.acme.com"